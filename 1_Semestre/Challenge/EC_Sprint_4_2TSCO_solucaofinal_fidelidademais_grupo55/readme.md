# README - Projeto Fidelidade+

## 📄 Visão Geral

O projeto **Fidelidade+** foi desenvolvido como parte do desafio Enterprise Challenge FIAP + IBM. A proposta visa resolver problemas reais enfrentados por empresas do varejo, com foco na **fidelização de clientes**, **análise de dados** e **automatização de processos** usando ferramentas de engenharia de dados e machine learning.

Problemas abordados:

* Baixa taxa de recompra
* Desempenho irregular de vendedores
* Precificação ineficiente por região
* Estoque com produtos de baixa saída
* Falta de estrutura nos dados e dificuldade de análise

Solução proposta:

* Migração dos dados para nuvem
* Automatização com Python, Airflow e Zapier
* Análises com Metabase e Jupyter
* Modelos de churn prediction, clustering e recomendação

---

## 📁 Estrutura de Pastas e Arquivos

```
fidelidademais_grupo55/
├── dados/
│   ├── exemplo_dados_vendas_eletrodomesticos.csv
│   ├── exemplo_dados_vendas_eletrodomesticos.xlsx
│   
├── notebooks/
│   ├── tratamento_dados.ipynb
│   ├── vendas_sem_referencia.ipynb
│   ├── churn_prediction.ipynb
│   ├── customer_segmentation.ipynb
│   
├── scripts/
│   ├── ia.py
│   ├── kmeans.py
│   
├── apresentacao/
│   ├── EC_Sprint_4_1TSC_solucaofinal_fidelidademais_grupo55.pptx
│   ├── video_pitch.mp4 *(ou link público)*
│   
├── planilha/
│   └── Informacoes_Finais_Projeto_Integrantes.xlsx
│
└── README.md
```

---

## ⚙️ Instruções de Execução

> **Requisitos**: Python 3.10+, bibliotecas: `pandas`, `sklearn`, `catboost`, `matplotlib`, `seaborn`, `joblib`, `fastapi` (simulado).

### 1. Tratamento de Dados

Execute o notebook `notebooks/tratamento_dados.ipynb` para realizar o carregamento e limpeza dos dados.

### 2. Análise de Vendas e Segmentação

Rode os notebooks `vendas_sem_referencia.ipynb` e `customer_segmentation.ipynb` para visualizar insights de comportamento e clusters de clientes com K-means.

### 3. Predição de Churn

O notebook `churn_prediction.ipynb` realiza o treinamento de um modelo de classificação com CatBoost para prever clientes propensos a sair.

### 4. Scripts Python

* `ia.py`: funções auxiliares e processamento de dados
* `kmeans.py`: execução do modelo de segmentação

> Os notebooks salvam modelos com `joblib`, que podem ser usados em APIs simuladas localmente via FastAPI.

### 5. Dashboards e Visualizações

Os dashboards foram projetados para o **Metabase**. Prints estão disponíveis nos slides da apresentação.

---

## 📊 Observações sobre a Implementação

* A **arquitetura proposta** contempla o uso de Amazon RDS, Airflow, FastAPI e Metabase.
* A instância do **PostgreSQL foi provisionada com sucesso na AWS RDS**, e a estrutura do banco foi validada conforme o modelo apresentado no projeto.
* Por limitação de tempo, outras partes como o deploy completo do Airflow e FastAPI não foram implementadas em nuvem, mas toda a lógica foi testada localmente.
* As automações (como notificações e execuções programadas) foram simuladas em ambiente local, respeitando a arquitetura proposta.

---

## 👨‍💼 Equipe

* André Luiz Sazana Waleczki (Responsável) - RM 559685
* Henrique Caproni Siqueira - RM 560105
* Renan Thiago Aviz e Silva - RM 560849
* Thiago Evangelista Dias - RM 559403

---

## 🌟 Agradecimentos

Agradecemos à FIAP e à IBM pela oportunidade de aplicar nossos conhecimentos em um desafio real. A experiência foi enriquecedora e desafiadora, e reforça nosso compromisso com a evolução profissional na área de dados.

---
