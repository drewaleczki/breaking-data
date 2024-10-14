CREATE TABLE mc_bairro (
    cd_bairro      NUMBER(8) GENERATED ALWAYS AS IDENTITY NOT NULL,
    cd_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45),
    nm_zona_bairro VARCHAR2(20)
);

COMMENT ON COLUMN mc_bairro.cd_bairro IS
    'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_bairro.nm_zona_bairro IS
    'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

ALTER TABLE mc_bairro ADD CONSTRAINT mc_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE mc_categoria_prod (
    cd_categoria NUMBER(10) GENERATED ALWAYS AS IDENTITY NOT NULL,
    tp_categoria CHAR(1) NOT NULL,
    ds_categoria VARCHAR2(500) NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_termino   DATE,
    st_categoria CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_categoria_prod.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria.'
    ;

COMMENT ON COLUMN mc_categoria_prod.tp_categoria IS
    'Nessa  coluna  será  armazenada o tipo de categoria que poderá  ser (V)ídeo ou (P)rodudto. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_categoria_prod.ds_categoria IS
    'Essa coluna irá armazenar descrição da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descrição única e serve para organizar os produtos em categorias simliares, melhorando a tomada de decisão.'
    ;

COMMENT ON COLUMN mc_categoria_prod.dt_inicio IS
    'Essa coluna irá receber  a data de início da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  obrigatório.';

COMMENT ON COLUMN mc_categoria_prod.dt_termino IS
    'Essa coluna irá receber  a data de encerramento  da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  opcional. Conteúdo obrigatório significa que a categoria foi encerrada a partir da data término. Já o conteúdo opcional indica que a categoria está ativa e operante.'
    ;

COMMENT ON COLUMN mc_categoria_prod.st_categoria IS
    'Essa coluna irá armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

ALTER TABLE mc_categoria_prod
    ADD CONSTRAINT ck_vl_dt_termino CHECK ( ( dt_termino IS NOT NULL
                                              AND st_categoria = 'I' )
                                            OR ( dt_termino IS NULL
                                                 AND st_categoria = 'A' ) );

ALTER TABLE mc_categoria_prod ADD CONSTRAINT mc_categoria_prod_pk PRIMARY KEY ( cd_categoria );



ALTER TABLE mc_categoria_prod ADD CONSTRAINT un_mc_cat_prod_ds_cat UNIQUE ( ds_categoria );

CREATE TABLE mc_cidade (
    cd_cidade NUMBER(8) GENERATED ALWAYS AS IDENTITY NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    nm_cidade VARCHAR2(60) NOT NULL,
    cd_ibge   NUMBER(8),
    nr_ddd    NUMBER(3)
);

COMMENT ON COLUMN mc_cidade.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

COMMENT ON COLUMN mc_cidade.nr_ddd IS
    'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.';

ALTER TABLE mc_cidade ADD CONSTRAINT mc_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE mc_cli_fisica (
    nr_cliente        NUMBER(10) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    fl_sexo_biologico CHAR(1) NOT NULL,
    ds_genero         VARCHAR2(100),
    nr_cpf            VARCHAR2(14) NOT NULL
);

COMMENT ON COLUMN mc_cli_fisica.nr_cliente IS
    'Essa coluna armazena o número do cliente Pessoa Física.';

COMMENT ON COLUMN mc_cli_fisica.dt_nascimento IS
    'Essa coluna irá armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. '
    ;

COMMENT ON COLUMN mc_cli_fisica.fl_sexo_biologico IS
    'Essa coluna irá armazenar o sexo biológico do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.. '
    ;

COMMENT ON COLUMN mc_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cli_fisica.nr_cpf IS
    'Essa coluna irá armazenar o número do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. '
    ;

ALTER TABLE mc_cli_fisica ADD CONSTRAINT mc_cli_fisica_pk PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cli_juridica (
    nr_cliente   NUMBER(10) NOT NULL,
    dt_fundacao  DATE NOT NULL,
    nr_cnpj      VARCHAR2(20) NOT NULL,
    nr_inscr_est VARCHAR2(15)
);

COMMENT ON COLUMN mc_cli_juridica.nr_cliente IS
    'Essa coluna armazena o número do Cliente Pessoa Jurídica.';

COMMENT ON COLUMN mc_cli_juridica.dt_fundacao IS
    'Essa coluna irá armazenar data  de fundação do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_cnpj IS
    'Essa coluna irá armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_inscr_est IS
    'Essa coluna irá armazenar o  numero da Inscrição Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser opcional'
    ;

ALTER TABLE mc_cli_juridica ADD CONSTRAINT mc_cli_juridica_pk PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cliente (
    nr_cliente      NUMBER(10) GENERATED ALWAYS AS IDENTITY NOT NULL,
    nm_cliente      VARCHAR2(160) NOT NULL,
    qt_estrelas     NUMBER(1),
    vl_medio_compra NUMBER(10, 2),
    st_cliente      CHAR(1) NOT NULL,
    ds_email        VARCHAR2(100),
    nr_telefone     VARCHAR2(20),
    nm_login        VARCHAR2(50) NOT NULL,
    ds_senha        VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN mc_cliente.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.'
    ;

COMMENT ON COLUMN mc_cliente.nm_cliente IS
    'Essa coluna irá armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cliente.qt_estrelas IS
    'Essa coluna irá armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.'
    ;

COMMENT ON COLUMN mc_cliente.vl_medio_compra IS
    'Essa coluna irá armazenar o valor  médio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.'
    ;

COMMENT ON COLUMN mc_cliente.st_cliente IS
    'Essa coluna irá armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_cliente.ds_email IS
    'Essa coluna irá armazenar o email  do cliente da Melhorees Compras. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.'
    ;

COMMENT ON COLUMN mc_cliente.nr_telefone IS
    'Essa coluna irá armazenar o número do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.'
    ;

COMMENT ON COLUMN mc_cliente.nm_login IS
    'Essa coluna irá armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e  único para cada cliente.'
    ;

COMMENT ON COLUMN mc_cliente.ds_senha IS
    'Essa coluna irá armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.'
    ;

ALTER TABLE mc_cliente ADD CONSTRAINT mc_cliente_pk PRIMARY KEY ( nr_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT un_mc_cliente_login UNIQUE ( nm_login );

ALTER TABLE mc_cliente ADD CONSTRAINT un_mc_cliente_nome_cliente UNIQUE ( nm_cliente );

CREATE TABLE mc_depto (
    cd_depto NUMBER(3) GENERATED ALWAYS AS IDENTITY NOT NULL,
    nm_depto VARCHAR2(100) NOT NULL,
    st_depto CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_depto.cd_depto IS
    'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_depto.nm_depto IS
    'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_depto.st_depto IS
    'Esta coluna irá receber o status do  departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.'
    ;

ALTER TABLE mc_depto
    ADD CONSTRAINT ck_status_depto CHECK ( st_depto IN ( 'A', 'I' ) );

ALTER TABLE mc_depto ADD CONSTRAINT pk_mc_depto PRIMARY KEY ( cd_depto );

ALTER TABLE mc_depto ADD CONSTRAINT un_mc_depto_nome UNIQUE ( nm_depto );

CREATE TABLE mc_end_cli (
    nr_cliente         NUMBER(10) NOT NULL,
    cd_logradouro      NUMBER(5) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE,
    dt_termino         DATE,
    st_end             CHAR(1)
);

COMMENT ON COLUMN mc_end_cli.nr_end IS
    'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.';

COMMENT ON COLUMN mc_end_cli.ds_complemento_end IS
    'Esta coluna irá receber o complemento do endereço do cliente e seu conteúdo pode ser opcional.';

COMMENT ON COLUMN mc_end_cli.dt_inicio IS
    'Data de início do endereço associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.dt_termino IS
    'Data de término do endereço associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.st_end IS
    'Status do endereço. (A)itvo ou (I)nativo.';

CREATE UNIQUE INDEX mc_end_cli__idx ON
    mc_end_cli (
        nr_cliente
    ASC );

ALTER TABLE mc_end_cli ADD CONSTRAINT mc_end_cli_pk PRIMARY KEY ( nr_cliente,
                                                                  cd_logradouro );

CREATE TABLE mc_end_func (
    cd_funcionario     NUMBER(10) NOT NULL,
    cd_logradouro      NUMBER(5) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE,
    st_end             CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_end_func.nr_end IS
    'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.';

COMMENT ON COLUMN mc_end_func.dt_inicio IS
    'Data de início do endereço associado ao cliente.';

COMMENT ON COLUMN mc_end_func.dt_termino IS
    'Data de término do endereço associado ao cliente.';

ALTER TABLE mc_end_func ADD CONSTRAINT mc_end_func_pk PRIMARY KEY ( cd_funcionario,
                                                                    cd_logradouro );

CREATE TABLE mc_estado (
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN mc_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado';

ALTER TABLE mc_estado ADD CONSTRAINT mc_estado_pk PRIMARY KEY ( sg_estado );

CREATE TABLE mc_funcionario (
    cd_funcionario    NUMBER(10) GENERATED ALWAYS AS IDENTITY NOT NULL,
    cd_gerente        NUMBER(10),
    cd_depto          NUMBER(3) NOT NULL,
    nm_funcionario    VARCHAR2(160) NOT NULL,
    cpf_funcionario   NUMBER(11) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    nr_telefone_func  VARCHAR2(20) NOT NULL,
    ds_email          VARCHAR2(80) NOT NULL,
    fl_sexo_biologico CHAR(1) NOT NULL,
    ds_cargo          VARCHAR2(80) NOT NULL,
    vl_salario        NUMBER(10, 2),
    st_func           CHAR(1) NOT NULL,
    dt_cadastramento  DATE NOT NULL,
    dt_desligamento   DATE
);

COMMENT ON COLUMN mc_funcionario.cd_funcionario IS
    'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.cd_depto IS
    'Essa coluna ira receber o código do departamento em que o funcionário trabalha.';

COMMENT ON COLUMN mc_funcionario.nm_funcionario IS
    'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.cpf_funcionario IS
    'Essa coluna vai receber o identificador único de pessoa física, seu conteúdo deve ser único.';

COMMENT ON COLUMN mc_funcionario.dt_nascimento IS
    'Esta coluna irá receber a data de nascimento  do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.nr_telefone_func IS
    'Essa coluna recebe o número de telefone do funcionário.	';

COMMENT ON COLUMN mc_funcionario.ds_email IS
    'Essa coluna recebe o e-mail do funcionário.';

COMMENT ON COLUMN mc_funcionario.fl_sexo_biologico IS
    'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)'
    ;

COMMENT ON COLUMN mc_funcionario.ds_cargo IS
    'Essa coluna recebe o nome do cargo do funcionário.';

COMMENT ON COLUMN mc_funcionario.vl_salario IS
    'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.st_func IS
    'Essa coluna irá armazenar o status do funcionário da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN mc_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conteúdo é opcional.';

ALTER TABLE mc_funcionario ADD CONSTRAINT mc_funcionario_pk PRIMARY KEY ( cd_funcionario );

ALTER TABLE mc_funcionario ADD CONSTRAINT un_mc_func_cpf_funcionario UNIQUE ( cpf_funcionario );


CREATE TABLE mc_logradouro (
    cd_logradouro NUMBER(5) GENERATED ALWAYS AS IDENTITY NOT NULL,
    cd_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(160) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL
);

COMMENT ON COLUMN mc_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_logradouro.nr_cep IS
    'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.';

ALTER TABLE mc_logradouro ADD CONSTRAINT mc_logradouro_pk PRIMARY KEY ( cd_logradouro );

CREATE TABLE mc_produto (
    cd_produto        NUMBER(10) GENERATED ALWAYS AS IDENTITY NOT NULL,
    cd_categoria      NUMBER(10) NOT NULL,
    nr_cd_barras_prod VARCHAR2(50),
    ds_produto        VARCHAR2(80) NOT NULL,
    vl_unitario       NUMBER(8, 2) NOT NULL,
    tp_embalagem      VARCHAR2(15),
    st_produto        CHAR(1) NOT NULL,
    vl_perc_lucro     NUMBER(8, 2),
    ds_completa_prod  VARCHAR2(4000) NOT NULL
);

COMMENT ON COLUMN mc_produto.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.'
    ;

COMMENT ON COLUMN mc_produto.nr_cd_barras_prod IS
    'Essa coluna irá armazenar o número do codigo de barras  do produto. Seu conteúdo deve ser opcional.';

COMMENT ON COLUMN mc_produto.ds_produto IS
    'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser  obrigatorio.';

COMMENT ON COLUMN mc_produto.vl_unitario IS
    'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 ';

COMMENT ON COLUMN mc_produto.tp_embalagem IS
    'Essa coluna irá armazenar o tipo de embalagem do produto. Seu conteúdo pode ser opcional.';

COMMENT ON COLUMN mc_produto.st_produto IS
    'Essa coluna irá armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_produto.vl_perc_lucro IS
    'Essa coluna irá armazenar o percentual  do lucro médio para cada produto. Seu conteúdo deve ser opcional.';

COMMENT ON COLUMN mc_produto.ds_completa_prod IS
    'Essa coluna irá armazenar a descrição completa do produto. Seu conteúdo deve ser  obrigatorio.';

ALTER TABLE mc_produto
    ADD CONSTRAINT "_CK_VL_STS_PRODUTO" CHECK ( st_produto IN ( 'A', 'I' ) );

ALTER TABLE mc_produto ADD CONSTRAINT ck_vl_unitario CHECK ( vl_unitario > 0 );

ALTER TABLE mc_produto ADD CONSTRAINT mc_produto_pk PRIMARY KEY ( cd_produto );

ALTER TABLE mc_produto ADD CONSTRAINT un_mc_produto_ds_produto UNIQUE ( ds_produto );

CREATE TABLE mc_sgv_sac (
    nr_sac                   NUMBER(10) GENERATED ALWAYS AS IDENTITY NOT NULL,
    nr_cliente               NUMBER(10) NOT NULL,
    cd_funcionario           NUMBER(10) NOT NULL,
    cd_produto               NUMBER(10) NOT NULL,
    cd_funcionario11         NUMBER(11) NOT NULL,
    ds_detalhada_sac         VARCHAR2(4000) NOT NULL,
    dt_abertura_sac          DATE NOT NULL,
    dt_conclusao             DATE,
    hr_abertura_sac          NUMBER(2) NOT NULL,
    dt_atendimento           DATE,
    hr_atendimento_sac       NUMBER(2),
    nr_tempo_total_sac       NUMBER(10),
    ds_detalhada_retorno_sac VARCHAR2(4000),
    tp_sac                   CHAR(1) NOT NULL,
    st_sac                   CHAR(1) NOT NULL,
    nr_indice_satisfacao     NUMBER(2)
);

COMMENT ON COLUMN mc_sgv_sac.nr_sac IS
    'Essa coluna irá armazenar a chave primária da tabela de SAC de vídeo  da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_cliente IS
    'Essa coluna recebe o identificador do cliente da tabela MC_CLIENTE.';

COMMENT ON COLUMN mc_sgv_sac.cd_funcionario IS
    'Essa coluna recebe o Código do funcionário da tabela MC_FUNCIONARIO que está responsável pelo atendimento.';

COMMENT ON COLUMN mc_sgv_sac.cd_produto IS
    'Essa coluna recebe o código do produto da tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_sac IS
    'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.dt_abertura_sac IS
    'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.hr_abertura_sac IS
    'Essa coluna  irá  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.dt_atendimento IS
    'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional..'
    ;

COMMENT ON COLUMN mc_sgv_sac.hr_atendimento_sac IS
    'Essa coluna  irá  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  irá  receber o tempo total em horas  (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura.'
    ;

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.'
    ;

COMMENT ON COLUMN mc_sgv_sac.tp_sac IS
    'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (S)ugestão; (D)úvida ou  (E)logio.'
    ;

COMMENT ON COLUMN mc_sgv_sac.st_sac IS
    'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfação do cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.'
    ;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT CK_CLASS_CHAMADO 
    CHECK (( (
    dt_conclusao IS NOT NULL
    AND st_sac IN ( 'F', 'X', 'C' )
OR (
    dt_conclusao IS NULL
    AND st_sac IN ( 'A', 'E', 'C' )
) )))
;
ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_dt_chamado CHECK ( dt_conclusao > dt_atendimento
                                         AND dt_atendimento > dt_abertura_sac );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_ind_sats CHECK ( nr_indice_satisfacao > 0
                                       AND nr_indice_satisfacao <= 10 );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_tp_sac CHECK ( tp_sac IN ( 'S', 'R' ) );

ALTER TABLE mc_sgv_sac ADD CONSTRAINT mc_sgv_sac_pk PRIMARY KEY ( nr_sac );

CREATE TABLE mc_video (
    cd_produto   NUMBER(10) NOT NULL,
    nr_sequencia NUMBER(3) NOT NULL,
    ds_video     VARCHAR2(500) NOT NULL,
    nr_duracao   NUMBER(4) NOT NULL,
    st_video     CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    ds_class     VARCHAR2(50),
    vd_produto   VARCHAR2(500)
);

COMMENT ON COLUMN mc_video.cd_produto IS
    'Nessa  coluna  será  armazenada o Código de produto, que pode ter nenhum ou vários vídeos associados e cada vídeo somente pode ser exibido caso seu status (ST_VIDEO) esteja em “A” (ativo). '
    ;

COMMENT ON COLUMN mc_video.nr_sequencia IS
    'Essa coluna irá armazenar a sequencia do vídeo a partir do codigo do produto. Sempre o primeiro vídeo de determinado  produto deve iniciar com o número 1. Seu conteúdo é obrigatório.'
    ;

COMMENT ON COLUMN mc_video.ds_video IS
    'Essa coluna armazena a descrição sobre o vídeo.';

COMMENT ON COLUMN mc_video.nr_duracao IS
    'Essa coluna armazena a duração do vídeo em segundos.';

COMMENT ON COLUMN mc_video.st_video IS
    'Essa coluna armazena o Status do video, podendo ser A(tivo)  ou I(nativo). Vídeos inativo não podem ser visualizados.';

COMMENT ON COLUMN mc_video.dt_cadastro IS
    'Essa coluna armazena a data em que o vídeo foi cadastrado.';

COMMENT ON COLUMN mc_video.vd_produto IS
    'Essa coluna irá armazenar oo vídeo do produto no formato que melhor lhe  convier.  Para utilizar essa coluna tenha acesso a documentação oficial da Oracle. Seu conteúdo é opcional.'
    ;

CREATE UNIQUE INDEX mc_video__idx ON
    mc_video (
        cd_produto
    ASC );

ALTER TABLE mc_video
    ADD CONSTRAINT ck_sts_video CHECK ( st_video IN ( 'A', 'I' ) );

ALTER TABLE mc_video ADD CONSTRAINT mc_video_pk PRIMARY KEY ( cd_produto );


CREATE TABLE mc_visualizacao (
    cd_visual    NUMBER(5),
    nr_cliente   NUMBER(10) NOT NULL,
    cd_produto   NUMBER(10) NOT NULL,
    cd_video     NUMBER(5) NOT NULL,
    dt_hr_visual DATETIME NOT NULL,
    st_usuario   CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_visualizacao.cd_visual IS
    'Essa coluna armazena o código de visualização do vídeo no momento em que foi assistido por um usuário logado ou anônimo.';

COMMENT ON COLUMN mc_visualizacao.nr_cliente IS
    'Essa coluna armazena o Número do Cliente que assistiu ao vídeo, se ele estava logado.';

COMMENT ON COLUMN mc_visualizacao.cd_produto IS
    'Essa coluna armazena o código do produto a qual o a visualização e o vídeo estão relacionados.';

COMMENT ON COLUMN mc_visualizacao.cd_video IS
    'Essa coluna armazena o código do vídeo a qual a visualização pertence.';

COMMENT ON COLUMN mc_visualizacao.dt_hr_visual IS
    'Essa coluna armazena a data, hora, minuto e segundo em que o vídeo visualizado no formato dd-mm-yyyy hh:mm:ss.';

COMMENT ON COLUMN mc_visualizacao.st_usuario IS
    'Essa coluna armazena o status do usuário que visualizou o vídeo.';

ALTER TABLE mc_visualizacao
    ADD CONSTRAINT mc_visualizacao_pk PRIMARY KEY ( cd_visual,
                                                    cd_produto,
                                                    cd_video );

ALTER TABLE mc_logradouro
    ADD CONSTRAINT fk_mc_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES mc_bairro ( cd_bairro );

ALTER TABLE mc_bairro
    ADD CONSTRAINT fk_mc_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES mc_cidade ( cd_cidade );

ALTER TABLE mc_cli_fisica
    ADD CONSTRAINT fk_mc_cliente_mc_cli_fisica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_cli_juridica
    ADD CONSTRAINT fk_mc_cliente_mc_cli_juridica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_cliente_mc_end_cli FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_visualizacao
    ADD CONSTRAINT fk_mc_cliente_mc_visualizacao FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_cliente_nr_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_depto_cd_depto FOREIGN KEY ( cd_depto )
        REFERENCES mc_depto ( cd_depto );

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES mc_logradouro ( cd_logradouro );

ALTER TABLE mc_cidade
    ADD CONSTRAINT fk_mc_estado FOREIGN KEY ( sg_estado )
        REFERENCES mc_estado ( sg_estado );
        
ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_func_cd_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_func_superior FOREIGN KEY ( cd_gerente )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_logradouro_end FOREIGN KEY ( cd_logradouro )
        REFERENCES mc_logradouro ( cd_logradouro );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_prod_cd_produto FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_video
    ADD CONSTRAINT fk_mc_produto_cd_produtov1 FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_produto
    ADD CONSTRAINT fk_mc_sub_categoria_prod FOREIGN KEY ( cd_categoria )
        REFERENCES mc_categoria_prod ( cd_categoria );

ALTER TABLE mc_visualizacao
    ADD CONSTRAINT fk_mc_video_cd_video FOREIGN KEY ( cd_produto )
        REFERENCES mc_video ( cd_produto );

CREATE SEQUENCE SQ_MC_VIDEO
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999999
NOCACHE
NOCYCLE;


--  ERROR: No Discriminator Value found for FK FK_MC_CLIENTE_MC_CLI_JURIDICA - constraint trigger for Arc Arc_2 cannot be generated 

--  ERROR: No Discriminator Value found for FK FK_MC_CLIENTE_MC_CLI_FISICA - constraint trigger for Arc Arc_2 cannot be generated



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             1
-- ALTER TABLE                             52
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   4
-- WARNINGS                                 0