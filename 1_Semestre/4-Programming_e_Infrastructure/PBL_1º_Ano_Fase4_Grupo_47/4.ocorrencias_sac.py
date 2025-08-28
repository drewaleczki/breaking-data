import pandas as pd
import matplotlib.pyplot as plt

# Lendo os dados do arquivo CSV usando ',' como delimitador
file_path = 'ocorrencias_sac.csv'
data = pd.read_csv(file_path, delimiter=',')

# Ajustando os nomes das colunas para usarmos corretamente
data.columns = ['ocorrencia', 'data_ocorrencia']

# Convertendo a coluna de data para datetime
data['data_ocorrencia'] = pd.to_datetime(data['data_ocorrencia'])

# Contando as ocorrências por dia
daily_occurrences = data['data_ocorrencia'].value_counts().sort_index()

# Gerando e exibindo o histograma da distribuição das ocorrências
plt.figure(figsize=(10, 6))
plt.hist(daily_occurrences, bins=10, rwidth=0.9, color='blue', alpha=0.7)
plt.title('Distribuição de Frequência das Ocorrências por Dia')
plt.xlabel('Número de Ocorrências')
plt.ylabel('Quantidade de dias')
plt.grid(axis='y', alpha=0.75)
plt.xticks(range(0, int(daily_occurrences.max()) + 1))
plt.show()


