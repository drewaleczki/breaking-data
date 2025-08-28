'''
Participantes:

Andre Luiz Sazana Waleczki     RM559685
Guilherme Vinícius dos Santos  RM560564
Henrique Caproni Siqueira      RM560105
Renan Thiago Aviz e Silva      RM560849
Thiago Evangelista Dias        RM559403
'''

# variaveis pra checar status e msg
nota_check = False
nota_msg = ""

# Loop para aguardar até digitar uma nota valida
while nota_check == False:

    try:

        # input pra receber a nota
        nota_check =True
        nota = int(input("Digite a nota de satisfação (0 a 100): "))

        # checando se a nota é valida
        if nota > 90 and nota <= 100:
            nota_msg = "Atendimento de qualidade"
        elif 70 <= nota <= 89:
            nota_msg = "Atendimento neutro"
        elif nota < 70:
            nota_msg = "Atendimento insatisfatório"
        else:
            nota_msg = "Nota inválida"
            nota_check = False

        print(f"Nota:{nota} - {nota_msg}")

    except:
        print("Por favor, insira um número válido.")

    # se tiver entrado nota válida parar loop
    if nota_check == True:
        break
