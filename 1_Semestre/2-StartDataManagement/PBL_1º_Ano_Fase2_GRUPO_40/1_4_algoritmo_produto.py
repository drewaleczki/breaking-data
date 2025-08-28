'''
FASE 2- Terceiro Desafio da Fase: Algoritmo Python

DADOS DOS ALUNOS

RM559685 - Andre Luiz Sazana Waleczki 
RM560564 - Guilherme Vinícius dos Santos 
RM560105 - Henrique Caproni Siqueira 
RM560849 - Renan Thiago Aviz e Silva 
RM559403 - Thiago Evangelista Dias 


'''

# biblioteca JSON
import json


# funcao lambda para calcular o ICMS
calculo_ICMS = lambda valor: round(valor * 0.18, 2)


# lista para armazenar os produtos
produtos = []


# codigos ANSI para cores
CYAN = '\033[96m'
YELLOW = '\033[93m'
GREEN = '\033[92m'
RED = '\033[91m'
MAGENTA = '\033[95m'
RESET = '\033[0m'  # reseta a cor


# primeiro contato
print(f"{CYAN}Bem-vindo! Vamos cadastrar novos produtos!{RESET}\n")
print(f"{RED}Para gerar o arquivo JSON é necessário cadastrar pelo menos 5 produtos, combinado?{RESET}\n\n")


# executar ate que o usuario opte por sair
resposta = 'sim'


# enquanto nao sair
while resposta=='sim':



        # repetir bloco enquanto o usuario nao digitar uma descricao valida
        while True:

            try: 
                # coletando os dados do produto
                descricao   = input(F"{YELLOW}Insira a descrição do produto: {RESET}")

                if len(descricao)<=0 or descricao==' ':
                    raise ValueError
                
                break

            # o campo valor do produto devera ter conter pelo menos 1 caracter
            except ValueError:
                print(f"{RED}\nErro: Por favor, insira pelo menos 1 caracter na descrição.\n {RESET}")



        # repetir bloco enquanto o usuario nao digitar um valor numerico maior que 0
        while True:

            try:                

                # o valor devera ser numerico
                valor       = float(input(F"{YELLOW}Insira o valor do produto: {RESET}"))

                # o valor deverá ser maior que zero para calcular o ICMS
                if valor<=0:
                    raise ValueError
                
                break

            # o campo valor do produto devera ter valor numerico maior que 0 (ZERO)
            except ValueError:
                print(f"{RED}\nErro: Por favor, insira um valor numérico maior que 0 (ZERO), Ex: 1825.68. \n{RESET}")



        embalagem   = input(F"{YELLOW}Insira o tipo de embalagem: {RESET}")

        # calculando o ICMS
        icms = calculo_ICMS(valor)

        # armazenando os dados do produto
        produto = {
            "Descricao":    descricao,
            "Valor":        valor,
            "Embalagem":    embalagem,
            "ICMS":         icms
        }
        produtos.append(produto)

        # pergunta ao usuario se deseja continuar cadastrando
        resposta = input(f"\n{CYAN}Deseja cadastrar um novo produto? (sim/não): {RESET}").strip().lower()



# verifica se ha no minimo 5 produtos cadastrados
if len(produtos) >= 5:

    # salvando os dados no arquivo JSON
    nome_arquivo = '1_5_arquivo_produto.json'
    with open(nome_arquivo, 'w') as arquivo_json:
        json.dump(produtos, arquivo_json, indent=4)

    print(f"\nCadastro encerrado. {len(produtos)} produtos foram salvos no arquivo '{nome_arquivo}'.")

else:

    print(f"\nVocê cadastrou {len(produtos)} produto(s). O mínimo necessário é de 5 produtos para gerar o arquivo JSON.")