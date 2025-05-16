from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime
from sqlalchemy import create_engine
from sklearn.cluster import KMeans
import pandas as pd
import psycopg2
import joblib
import io

# Configuração do banco
DB_CONFIG = {
    "host": "fidelidademaisibm.cb4g0aguevt3.us-east-2.rds.amazonaws.com",
    "database": "ibm",
    "user": "thiago",
    "password": "ibmteste",
    "port": 5432
}

def get_sqlalchemy_engine():
    return create_engine(
        f"postgresql://{DB_CONFIG['user']}:{DB_CONFIG['password']}@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
    )

def atualizar_rfm():
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()

    cursor.execute("""
    INSERT INTO ibm_rfm (
        cd_cliente,
        dias_desde_primeira_compra,
        frequencia_compras,
        valor_total_compras,
        ticket_medio,
        qtd_produtos_distintos,
        media_itens_por_compra
    )
    WITH dados_base AS (
        SELECT 
            nf.cd_cliente,
            MIN(nf.dt_emissao) AS primeira_compra,
            MAX(nf.dt_emissao) AS ultima_compra,
            COUNT(DISTINCT nf.nr_nota) AS frequencia_compras,
            COUNT(DISTINCT i.cd_produto) AS qtd_produtos_distintos,
            SUM(i.qtd_itens)::FLOAT / COUNT(DISTINCT nf.nr_nota) AS media_itens_por_compra,
            SUM(i.vl_unitario * i.qtd_itens) AS valor_total_compras,
            AVG(i.vl_unitario * i.qtd_itens) AS ticket_medio
        FROM nota_fiscal nf
        JOIN ibm_itens i ON nf.nr_nota = i.nr_nota
        GROUP BY nf.cd_cliente
    )
    SELECT
        cd_cliente,
        DATE_PART('day', CURRENT_DATE - primeira_compra)::INTEGER,
        frequencia_compras,
        valor_total_compras,
        ticket_medio,
        qtd_produtos_distintos,
        media_itens_por_compra
    FROM dados_base
    ON CONFLICT (cd_cliente) DO UPDATE SET
        dias_desde_primeira_compra = EXCLUDED.dias_desde_primeira_compra,
        frequencia_compras = EXCLUDED.frequencia_compras,
        valor_total_compras = EXCLUDED.valor_total_compras,
        ticket_medio = EXCLUDED.ticket_medio,
        qtd_produtos_distintos = EXCLUDED.qtd_produtos_distintos,
        media_itens_por_compra = EXCLUDED.media_itens_por_compra,
        data_execucao = CURRENT_DATE;
    """)

def atualizar_modelos():
    # Carregando modelo do banco
    conn = psycopg2.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute("""
        SELECT modelo FROM modelos_ml
        WHERE nome_modelo = %s AND versao = %s
    """, ("catboost_churn", "v1"))
    modelo_bytes = cursor.fetchone()[0]
    modelo = joblib.load(io.BytesIO(modelo_bytes))
    cursor.close()
    conn.close()

    # Carregando scaler salvo
    scaler = joblib.load('/usr/local/airflow/dags/scaler_churn.pkl')

    # Lendo dados
    engine = get_sqlalchemy_engine()
    df = pd.read_sql("SELECT * FROM ibm_rfm", engine)

    # Garantindo que os dados tenham as features corretas
    features = [
        'dias_desde_primeira_compra',
        'frequencia_compras',
        'valor_total_compras',
        'ticket_medio',
        'qtd_produtos_distintos',
        'media_itens_por_compra'
    ]
    X_predict = df[features].copy()
    X_scaled = scaler.transform(X_predict)

    # Prevendo churn
    df['churn_prob'] = modelo.predict_proba(X_scaled)[:, 1]

    # Clusterização com KMeans
    kmeans = KMeans(n_clusters=3, random_state=42)
    df['cluster'] = kmeans.fit_predict(X_scaled)

    # Salvando resultado
    df.to_sql('clientes_segmentados', engine, if_exists='replace', index=False)

# Configuração da DAG

dag = DAG(
    'atualizacao_semanal',
    schedule_interval='@weekly',
    start_date=datetime(2023, 1, 1),
    catchup=False
)

t1 = PythonOperator(task_id='atualizar_rfm', python_callable=atualizar_rfm, dag=dag)
t2 = PythonOperator(task_id='atualizar_modelos', python_callable=atualizar_modelos, dag=dag)

t1 >> t2
