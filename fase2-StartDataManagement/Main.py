opcao_Menu = 0

print("Bem vindo, poderia inserir os dados do produto abaixo\n")

while opcao_Menu != 2:

    # Coletando os dados do produto
    try:
        nm_produto = input("Insira o nome do produto: ")
        vl_produto = float(input('Insira o valor do produto: '))
        tp_embalagem = input('Insira o tipo de embalagem: ')

    except ValueError:
        print("\nPor favor, insira um valor número no 'Valor do produto'")
        vl_produto = float(input('Insira o valor do produto: '))

    # Armazenando os dados no produto em um dicionário
    produto = { 
        "id": {
        'Nome':nm_produto, 
        'Valor':vl_produto,  
        'tp_embalagem':tp_embalagem
        }
    }
    print('\nProduto cadastrado !')

    # Calculando o ICMS
    Calculo_ICMS = lambda vl_produto: f"O valor do imposto (ICMS) é R$ {vl_produto * 0.18}"
    print(Calculo_ICMS(vl_produto))

    # Menu
    opcao_Menu = int(input('''
[1] - Cadastrar um novo produto
[2] - Sair
                       
Escolha uma opção acima: '''))
