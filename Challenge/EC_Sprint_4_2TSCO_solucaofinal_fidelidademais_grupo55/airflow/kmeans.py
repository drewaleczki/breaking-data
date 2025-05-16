# customer_segmentation.py
import psycopg2
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import joblib
from sqlalchemy import create_engine
import io
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.email_operator import EmailOperator
from datetime import datetime, timedelta


# Função para atualizar a tabela RFM via SQL
def atualizar_rfm():
    conn = psycopg2.connect(
        host="fidelidademaisibm.cb4g0aguevt3.us-east-2.rds.amazonaws.com",
        database="ibm",
        user="thiago",
        password="ibmteste",
        port=5432
    )
    cursor = conn.cursor()
    cursor.execute(open("/caminho/para/seu_script_rfm.sql", "r").read())
    conn.commit()
    cursor.close()
    conn.close()

# Função para rodar o modelo de churn prediction
def atualizar_modelo_churn():
    conn = psycopg2.connect(
        host="fidelidademaisibm.cb4g0aguevt3.us-east-2.rds.amazonaws.com",
        database="ibm",
        user="thiago",
        password="ibmteste",
        port=5432
    )
    cursor = conn.cursor()
    cursor.execute("""
        SELECT modelo FROM modelos_ml
        WHERE nome_modelo = %s AND versao = %s
    """, ("catboost_churn", "v1"))
    
    modelo_bytes = cursor.fetchone()[0]
    modelo = joblib.load(io.BytesIO(modelo_bytes))
    
    df = pd.read_sql("SELECT * FROM dados_clientes_rfm", conn)
    predicoes = modelo.predict_proba(df)[:, 1]
    
    # Atualizando resultados no banco
    for idx, prob in enumerate(predicoes):
        cursor.execute("""
            UPDATE clientes SET prob_churn = %s WHERE id_cliente = %s
        """, (float(prob), df.iloc[idx]["id_cliente"]))
    
    conn.commit()
    cursor.close()
    conn.close()

# Função para rodar o modelo de clustering
def atualizar_clusterizacao():
    conn = psycopg2.connect(
        host="fidelidademaisibm.cb4g0aguevt3.us-east-2.rds.amazonaws.com",
        database="ibm",
        user="thiago",
        password="ibmteste",
        port=5432
    )
    cursor = conn.cursor()
    cursor.execute("""
        SELECT modelo FROM modelos_ml
        WHERE nome_modelo = %s AND versao = %s
    """, ("kmeans_segmentacao", "v1"))
    
    modelo_bytes = cursor.fetchone()[0]
    modelo = joblib.load(io.BytesIO(modelo_bytes))
    
    df = pd.read_sql("SELECT * FROM dados_clientes_clusterizacao", conn)
    clusters = modelo.predict(df)
    
    for idx, grupo in enumerate(clusters):
        cursor.execute("""
            UPDATE clientes SET cluster = %s WHERE id_cliente = %s
        """, (int(grupo), df.iloc[idx]["id_cliente"]))

    conn.commit()
    cursor.close()
    conn.close()

# Configuração da DAG
default_args = {
    'owner': 'grupo55',
    'depends_on_past': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2023, 1, 1),
}

dag = DAG(
    'pipeline_fidelidade_semanal',
    default_args=default_args,
    schedule_interval='@weekly',
    catchup=False
)

# Definindo as tarefas
t1 = PythonOperator(task_id='atualizar_rfm', python_callable=atualizar_rfm, dag=dag)
t2 = PythonOperator(task_id='atualizar_modelo_churn', python_callable=atualizar_modelo_churn, dag=dag)
t3 = PythonOperator(task_id='atualizar_clusterizacao', python_callable=atualizar_clusterizacao, dag=dag)

# Exemplo de notificação (ajuste os parâmetros conforme necessário)
t4 = EmailOperator(
    task_id='notificar_time',
    to='sua-equipe@example.com',
    subject='Pipeline semanal executado com sucesso',
    html_content='Todas as tarefas foram concluídas com sucesso!',
    dag=dag
)

# Definindo a ordem de execução
t1 >> [t2, t3] >> t4