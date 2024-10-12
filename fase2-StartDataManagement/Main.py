
# Coletando os dados do produto
nm_produto = input("Insira o nome do produto: ")
vl_produto = float(input('Insira o valor do produto: '))
tp_embalagem = input('Insira o tipo de embalagem: ')

# Armazenando os dados no produto em um dicionário
produto = { 
    "id": {
    'Nome':nm_produto, 
    'Valor':vl_produto,  
    'tp_embalagem':tp_embalagem
    }
}
print('\nProduto cadastrado !')
