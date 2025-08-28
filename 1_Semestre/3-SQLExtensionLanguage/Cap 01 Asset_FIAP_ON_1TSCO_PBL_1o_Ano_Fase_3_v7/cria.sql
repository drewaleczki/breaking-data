--   em:        2022-12-12 17:17:42 BRST
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g

--- EXEMPLOS DE GERACAO DE IDENTITY E DE CRIACAO DE SEQUENCE

/*
CREATE TABLE mc_bairro (
    cd_bairro       NUMBER(8) GENERATED ALWAYS AS IDENTITY NOT NULL,
    cd_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45),
    nm_zona_bairro  VARCHAR2(20)
);


CREATE SEQUENCE SQ_MC_BAIRRO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

*/															
CREATE TABLE mc_bairro (
    cd_bairro       NUMBER(8) NOT NULL,
    cd_cidade       NUMBER(8) NOT NULL,
    nm_bairro       VARCHAR2(45),
    nm_zona_bairro  VARCHAR2(20)
);

COMMENT ON COLUMN mc_bairro.cd_bairro IS
    'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_bairro.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_bairro.nm_zona_bairro IS
    'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.';

ALTER TABLE mc_bairro ADD CONSTRAINT pk_mc_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE mc_categoria_prod (
    cd_categoria  NUMBER NOT NULL,
    tp_categoria  CHAR(1) NOT NULL,
    ds_categoria  VARCHAR2(500) NOT NULL,
    dt_inicio     DATE,
    dt_termino    DATE,
    st_categoria  CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_categoria_prod.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..';

COMMENT ON COLUMN mc_categoria_prod.tp_categoria IS
    'Nessa  coluna  será  armazenada o tipo de categoria que poderá  ser (V)ídeo ou (P)rodudto. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_categoria_prod.ds_categoria IS
    'Essa coluna irá armazenar descrição da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descrição única e serve para organizar os produtos em categorias simliares, melhorando a tomada de decisão.';

COMMENT ON COLUMN mc_categoria_prod.dt_inicio IS
    'Essa coluna irá receber  a data de início da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  obrigatório.';

COMMENT ON COLUMN mc_categoria_prod.dt_termino IS
    'Essa coluna irá receber  a data de encerramento  da categoria. Seu formato é dd/mm/yyyy e seu conteúdo deve ser sempre  opcional. Conteúdo obrigatório significa que a categoria foi encerrada a partir da data término. Já o conteúdo opcional indica que a categoria está ativa e operante.';

COMMENT ON COLUMN mc_categoria_prod.st_categoria IS
    'Essa coluna irá armazenar o stauts da categoria da Melhores Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

ALTER TABLE mc_categoria_prod ADD CONSTRAINT pk_mc_categoria PRIMARY KEY ( cd_categoria );

ALTER TABLE MC_CATEGORIA_PROD ADD CONSTRAINT CK_MC_CATEGORIA_PROD_ST_CATEG CHECK ( ST_CATEGORIA IN ('A','I'));

ALTER TABLE MC_CATEGORIA_PROD ADD CONSTRAINT CK_MC_CATEGORIA_PROD_TP_CATEG CHECK ( TP_CATEGORIA IN ('P','V'));

CREATE TABLE mc_cidade (
    cd_cidade  NUMBER(8) NOT NULL,
    sg_estado  CHAR(2) NOT NULL,
    nm_cidade  VARCHAR2(60) NOT NULL,
    cd_ibge    NUMBER(8),
    nr_ddd     NUMBER(3)
);

COMMENT ON COLUMN mc_cidade.cd_cidade IS
    'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_cidade.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_cidade.cd_ibge IS
    'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.';

COMMENT ON COLUMN mc_cidade.nr_ddd IS
    'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.';

ALTER TABLE mc_cidade ADD CONSTRAINT pk_mc_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE mc_cli_fisica (
    nr_cliente         NUMBER(10) NOT NULL,
    dt_nascimento      DATE NOT NULL,
    fl_sexo_biologico  CHAR(1) NOT NULL,
    ds_genero          VARCHAR2(100),
    nr_cpf             VARCHAR2(14) NOT NULL
);

COMMENT ON COLUMN mc_cli_fisica.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN mc_cli_fisica.dt_nascimento IS
    'Essa coluna irá armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. ';

COMMENT ON COLUMN mc_cli_fisica.fl_sexo_biologico IS
    'Essa coluna irá armazenar o sexo biológico do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.. ';

COMMENT ON COLUMN mc_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cli_fisica.nr_cpf IS
    'Essa coluna irá armazenar o número do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório. ';

ALTER TABLE mc_cli_fisica ADD CONSTRAINT pk_mc_cli_fisica PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cli_juridica (
    nr_cliente    NUMBER(10) NOT NULL,
    dt_fundacao   DATE,
    nr_cnpj       VARCHAR2(20),
    nr_inscr_est  VARCHAR2(15)
);

COMMENT ON COLUMN mc_cli_juridica.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN mc_cli_juridica.dt_fundacao IS
    'Essa coluna irá armazenar data  de fundação do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cli_juridica.nr_cnpj IS
    'Essa coluna irá armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cli_juridica.nr_inscr_est IS
    'Essa coluna irá armazenar o  numero da Inscrição Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser opcional';

ALTER TABLE mc_cli_juridica ADD CONSTRAINT pk_mc_cli_juridica PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cliente (
    nr_cliente       NUMBER(10) NOT NULL,
    nm_cliente       VARCHAR2(160) NOT NULL,
    qt_estrelas      NUMBER(1),
    vl_medio_compra  NUMBER(10, 2),
    st_cliente       CHAR(1),
    ds_email         VARCHAR2(100),
    nr_telefone      VARCHAR2(20),
    nm_login         VARCHAR2(50) NOT NULL,
    ds_senha         VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN mc_cliente.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.';

COMMENT ON COLUMN mc_cliente.nm_cliente IS
    'Essa coluna irá armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.';

COMMENT ON COLUMN mc_cliente.qt_estrelas IS
    'Essa coluna irá armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.';

COMMENT ON COLUMN mc_cliente.vl_medio_compra IS
    'Essa coluna irá armazenar o valor  médio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.';

COMMENT ON COLUMN mc_cliente.st_cliente IS
    'Essa coluna irá armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_cliente.ds_email IS
    'Essa coluna irá armazenar o email  do cliente da Melhorees Compras. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.';

COMMENT ON COLUMN mc_cliente.nr_telefone IS
    'Essa coluna irá armazenar o número do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.';

COMMENT ON COLUMN mc_cliente.nm_login IS
    'Essa coluna irá armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e  único para cada cliente.';

COMMENT ON COLUMN mc_cliente.ds_senha IS
    'Essa coluna irá armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.';

ALTER TABLE mc_cliente ADD CONSTRAINT pk_mc_cliente PRIMARY KEY ( nr_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT uk_mc_cliente_nome_cliente UNIQUE ( nm_cliente );

ALTER TABLE MC_CLIENTE ADD CONSTRAINT CK_MC_CLIENTE_ST_CLIENTE CHECK ( ST_CLIENTE IN ('A','I'));

CREATE TABLE mc_depto (
    cd_depto  NUMBER(3) NOT NULL,
    nm_depto  VARCHAR2(100) NOT NULL,
    st_depto  CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_depto.cd_depto IS
    'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_depto.nm_depto IS
    'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_depto.st_depto IS
    'Esta coluna irá receber o status do  departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.';

ALTER TABLE mc_depto ADD CONSTRAINT pk_mc_depto PRIMARY KEY ( cd_depto );

ALTER TABLE MC_DEPTO ADD CONSTRAINT CK_MC_DEPTO_ST_DEPTO CHECK ( ST_DEPTO IN ('A','I'));

CREATE TABLE mc_end_cli (
    nr_cliente          NUMBER(10) NOT NULL,
    cd_logradouro_cli   NUMBER(10) NOT NULL,
    nr_end              NUMBER(8) NOT NULL,
    ds_complemento_end  VARCHAR2(80),
    dt_inicio           DATE,
    dt_termino          DATE,
    st_end              CHAR(1)
);

COMMENT ON COLUMN mc_end_cli.nr_cliente IS
    'Esta coluna irá receber o número do cliente e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_end_cli.cd_logradouro_cli IS
    'Esta coluna irá receber o código do logradouro  do cliente e seu conteúdo é obrigatório.';

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

ALTER TABLE mc_end_cli ADD CONSTRAINT pk_mc_end_cli PRIMARY KEY ( nr_cliente,
                                                                  cd_logradouro_cli );
																  
ALTER TABLE MC_END_CLI ADD CONSTRAINT CK_MC_END_CLI_ST_END CHECK ( ST_END IN ('A','I'));
																  
CREATE TABLE mc_end_func (
    cd_funcionario      NUMBER(10) NOT NULL,
    cd_logradouro       NUMBER(10) NOT NULL,
    nr_end              NUMBER(8) NOT NULL,
    ds_complemento_end  VARCHAR2(80),
    dt_inicio           DATE NOT NULL,
    dt_termino          DATE,
    st_end              CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_end_func.nr_end IS
    'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.';

COMMENT ON COLUMN mc_end_func.dt_inicio IS
    'Data de início do endereço associado ao cliente.';

COMMENT ON COLUMN mc_end_func.dt_termino IS
    'Data de término do endereço associado ao cliente.';

ALTER TABLE mc_end_func ADD CONSTRAINT pk_mc_end_func_pk PRIMARY KEY ( cd_funcionario,
                                                                       cd_logradouro );

CREATE TABLE mc_estado (
    sg_estado  CHAR(2) NOT NULL,
    nm_estado  VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN mc_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.';

COMMENT ON COLUMN mc_estado.nm_estado IS
    'Esta coluna irá receber o nome do estado';

ALTER TABLE mc_estado ADD CONSTRAINT pk_mc_estado PRIMARY KEY ( sg_estado );

CREATE TABLE mc_funcionario (
    cd_funcionario     NUMBER(10) NOT NULL,
    cd_depto           NUMBER(3) NOT NULL,
    cd_gerente         NUMBER(10),
    nm_funcionario     VARCHAR2(160),
    dt_nascimento      DATE NOT NULL,
    fl_sexo_biologico  CHAR(1),
    ds_genero          VARCHAR2(100),
    ds_cargo           VARCHAR2(80) NOT NULL,
    vl_salario         NUMBER(10, 2),
    ds_email           VARCHAR2(80),
    st_func            CHAR(1),
    dt_cadastramento   DATE,
    dt_desligamento    DATE
);

COMMENT ON COLUMN mc_funcionario.cd_funcionario IS
    'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.cd_depto IS
    'Esta coluna irá receber o codigo do departamento onde o funcionario trabalha  e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.cd_gerente IS
    'Esta coluna irá receber o codigo do gestor do funcionario trabalha  e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.nm_funcionario IS
    'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.dt_nascimento IS
    'Esta coluna irá receber a data de nascimento  do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_funcionario.fl_sexo_biologico IS
    'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)';

COMMENT ON COLUMN mc_funcionario.ds_genero IS
    'Esta coluna irá receber o genero atribuido ao funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.ds_cargo IS
    'Esta coluna irá receber o cargo do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.vl_salario IS
    'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.ds_email IS
    'Esta coluna irá receber o email do funcionário e seu conteúdo é opcional.';

COMMENT ON COLUMN mc_funcionario.st_func IS
    'Essa coluna irá armazenar o stauts do funcionário da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN mc_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conteúdo é opcional.';

ALTER TABLE mc_funcionario ADD CONSTRAINT pk_mc_funcionario PRIMARY KEY ( cd_funcionario );

ALTER TABLE MC_FUNCIONARIO ADD CONSTRAINT CK_MC_FUNCIONARIO_ST_FUNC CHECK ( ST_FUNC IN ('A','I'));

CREATE TABLE mc_logradouro (
    cd_logradouro  NUMBER(10) NOT NULL,
    cd_bairro      NUMBER(8) NOT NULL,
    nm_logradouro  VARCHAR2(160) NOT NULL,
    nr_cep         NUMBER(8)
);

COMMENT ON COLUMN mc_logradouro.cd_logradouro IS
    'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_logradouro.cd_bairro IS
    'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_logradouro.nm_logradouro IS
    'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_logradouro.nr_cep IS
    'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.';

ALTER TABLE mc_logradouro ADD CONSTRAINT pk_mc_logradouro PRIMARY KEY ( cd_logradouro );

CREATE TABLE mc_produto (
    cd_produto         NUMBER(10) NOT NULL,
    cd_categoria       NUMBER NOT NULL,
    nr_cd_barras_prod  VARCHAR2(50),
    ds_produto         VARCHAR2(80) NOT NULL,
    vl_unitario        NUMBER(8, 2) NOT NULL,
    tp_embalagem       VARCHAR2(15),
    st_produto         CHAR(1),
    vl_perc_lucro      NUMBER(8, 2),
    ds_completa_prod   VARCHAR2(4000) NOT NULL
);

COMMENT ON COLUMN mc_produto.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.';

COMMENT ON COLUMN mc_produto.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..';

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

ALTER TABLE mc_produto ADD CONSTRAINT pk_mc_produto PRIMARY KEY ( cd_produto );

ALTER TABLE MC_PRODUTO ADD CONSTRAINT CK_MC_PRODUTO_ST_PRODUTO CHECK ( ST_PRODUTO IN ('A','I'));

CREATE TABLE mc_sgv_produto_video (
    cd_produto          NUMBER(10) NOT NULL,
    nr_sequencia        NUMBER(3) NOT NULL,
    cd_categoria        NUMBER NOT NULL,
    vd_produto          BLOB,
    tp_video_prod       VARCHAR2(10),
    ds_path_video_prod  VARCHAR2(500),
    st_video_prod       CHAR(1)
);

COMMENT ON COLUMN mc_sgv_produto_video.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.';

COMMENT ON COLUMN mc_sgv_produto_video.nr_sequencia IS
    'Essa coluna irá armazenar a sequencia do vídeo a partir do codigo do produto. Sempre o primeiro vídeo de determinado  produto deve iniciar com o número 1. Seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_sgv_produto_video.cd_categoria IS
    'Essa coluna irá armazenar a chave primária da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  será acionada a Sequence  SQ_MC_CATEGORIA que se encarregará de gerar o próximo número único da categoria..';

COMMENT ON COLUMN mc_sgv_produto_video.vd_produto IS
    'Essa coluna irá armazenar oo vídeo do produto no formato que melhor lhe  convier.  Para utilizar essa coluna tenha acesso a documentação oficial da Oracle. Seu conteúdo é opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.tp_video_prod IS
    'Essa coluna irá armazenar o tipo do  vídeo do produto. Seu conteúdo é opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.ds_path_video_prod IS
    'Essa coluna irá armazenar o caminho de acesso (link) contendo o  vídeo do produto. Seu conteúdo é opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.st_video_prod IS
    'Essa coluna irá armazenar o stauts do vídeo do produto da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).';

ALTER TABLE mc_sgv_produto_video ADD CONSTRAINT pk_mc_produto_imagem PRIMARY KEY ( nr_sequencia,
                                                                                   cd_produto );

ALTER TABLE MC_SGV_PRODUTO_VIDEO ADD CONSTRAINT CK_MC_SGV_PRODUTO_VIDEO_ST_VIDEO CHECK ( ST_VIDEO_PROD IN ('A','I'));

CREATE TABLE mc_sgv_sac (
    nr_sac                    NUMBER NOT NULL,
    nr_cliente                NUMBER(10) NOT NULL,
    cd_produto                NUMBER(10) NOT NULL,
    cd_funcionario            NUMBER(10),
    ds_detalhada_sac          CLOB,
    dt_abertura_sac           DATE,
    hr_abertura_sac           NUMBER(2),
    dt_atendimento            DATE,
    hr_atendimento_sac        NUMBER(2),
    nr_tempo_total_sac        NUMBER(10),
    ds_detalhada_retorno_sac  CLOB,
    tp_sac                    CHAR(1) NOT NULL,
    st_sac                    CHAR(1),
    nr_indice_satisfacao      NUMBER(2)
);

COMMENT ON COLUMN mc_sgv_sac.nr_sac IS
    'Essa coluna irá armazenar a chave primária da tabela de SAC de vídeo  da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.';

COMMENT ON COLUMN mc_sgv_sac.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da tabela NC_CLIENTE. ';

COMMENT ON COLUMN mc_sgv_sac.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.';

COMMENT ON COLUMN mc_sgv_sac.cd_funcionario IS
    'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_sac IS
    'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.dt_abertura_sac IS
    'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.hr_abertura_sac IS
    'Essa coluna  irá  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.';

COMMENT ON COLUMN mc_sgv_sac.dt_atendimento IS
    'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional..';

COMMENT ON COLUMN mc_sgv_sac.hr_atendimento_sac IS
    'Essa coluna  irá  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.';

COMMENT ON COLUMN mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  irá  receber o tempo total em horas  (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura.';

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.';

COMMENT ON COLUMN mc_sgv_sac.tp_sac IS
    'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (S)ugestão; (D)úvida ou  (E)logio.';

COMMENT ON COLUMN mc_sgv_sac.st_sac IS
    'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfação do cliente.';

COMMENT ON COLUMN mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.';

ALTER TABLE mc_sgv_sac ADD CONSTRAINT pk_mc_sgv_sac PRIMARY KEY ( nr_sac );

ALTER TABLE mc_sgv_sac ADD CONSTRAINT CK_mc_sgv_sac_tp_sac CHECK ( tp_sac IN ('D','E','S'));

CREATE TABLE mc_sgv_visualizacao_video (
    cd_visualizacao_video  NUMBER(10) NOT NULL,
    nr_cliente             NUMBER(10),
    cd_produto             NUMBER(10) NOT NULL,
    dt_visualizacao        DATE NOT NULL,
    nr_hora_visualizacao   NUMBER(2) NOT NULL,
    nr_minuto_video        NUMBER(2),
    nr_segundo_video       NUMBER(2)
);

COMMENT ON COLUMN mc_sgv_visualizacao_video.cd_visualizacao_video IS
    'Essa coluna irá armazenar a chave primária da tabela de visualização do vídeo, onde a cada click que o usuario logado ou anônimo realizar, será anotado o acesso realizado.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_cliente IS
    'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.cd_produto IS
    'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.dt_visualizacao IS
    'Essa  coluna  irá  receber a data da visualização feita pelo  usuário no formato dd/mm/yyyy. Essa coluna é obrigatória.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_hora_visualizacao IS
    'Essa  coluna  irá  receber o horário no formato HH24 da visualização feita pelo  usuário. Essa coluna é obrigatória.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_minuto_video IS
    'Essa  coluna  irá  receber o horário do minuto do vídeo quando foi feita a visualização pelo  usuário. Essa coluna é obrigatória e os valores possíveis estão entre 00 e 59, representando os minutos.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_segundo_video IS
    'Essa  coluna  irá  receber o horário dos segundos do vídeo quando foi feita a visualização pelo  usuário. Essa coluna é obrigatória e os valores possíveis estão entre 00 e 59, representando os minutos.';

ALTER TABLE mc_sgv_visualizacao_video ADD CONSTRAINT pk_mc_sgv_visualizacao_video PRIMARY KEY ( cd_visualizacao_video );

ALTER TABLE mc_bairro
    ADD CONSTRAINT fk_mc_bairro_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES mc_cidade ( cd_cidade );

ALTER TABLE mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_categoria_video FOREIGN KEY ( cd_categoria )
        REFERENCES mc_categoria_prod ( cd_categoria );

ALTER TABLE mc_cidade
    ADD CONSTRAINT fk_mc_cidade_estado FOREIGN KEY ( sg_estado )
        REFERENCES mc_estado ( sg_estado );

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_cliente_end FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_cli_fisica
    ADD CONSTRAINT fk_mc_cliente_fisica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_cli_juridica
    ADD CONSTRAINT fk_mc_cliente_juridica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_cliente_sgv_sac FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_sgv_visualizacao_video
    ADD CONSTRAINT fk_mc_cliente_visualiz_video FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente );

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_depto_func FOREIGN KEY ( cd_depto )
        REFERENCES mc_depto ( cd_depto );

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES mc_logradouro ( cd_logradouro );

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_func_superior FOREIGN KEY ( cd_gerente )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_funcionario_sgv_sac FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_logradouro
    ADD CONSTRAINT fk_mc_logradouro_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES mc_bairro ( cd_bairro );

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_logradouro_end FOREIGN KEY ( cd_logradouro_cli )
        REFERENCES mc_logradouro ( cd_logradouro );

ALTER TABLE mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_produto_imagem FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_produto_sgv_sac FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_sgv_visualizacao_video
    ADD CONSTRAINT fk_mc_produto_visualizacao FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE mc_produto
    ADD CONSTRAINT fk_mc_sub_categoria_prod FOREIGN KEY ( cd_categoria )
        REFERENCES mc_categoria_prod ( cd_categoria );

CREATE OR REPLACE TRIGGER arc_fk_arco_cli__mc_cli_fisica BEFORE
    INSERT OR UPDATE OF nr_cliente ON mc_cli_fisica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> :new.nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_FISICA in Table MC_CLI_FISICA violates Arc constraint on Table MC_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fk_arco_cl_mc_cli_juridica BEFORE
    INSERT OR UPDATE OF nr_cliente ON mc_cli_juridica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.nr_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> :new.nr_cliente ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_JURIDICA in Table MC_CLI_JURIDICA violates Arc constraint on Table MC_CLIENTE - discriminator column NR_CLIENTE doesn''t have value NR_CLIENTE');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

--
--
--
CREATE TABLE mc_sgv_ocorrencia_sac (
    nr_ocorrencia_sac             NUMBER NOT NULL,
    dt_abertura_sac               DATE,
    hr_abertura_sac               NUMBER(2),
    ds_tipo_classificacao_sac     VARCHAR2(30) NOT NULL,
    ds_indice_satisfacao_atd_sac  VARCHAR2(30),
    cd_produto                    NUMBER(10),
    ds_produto                    VARCHAR2(80) NOT NULL,
    vl_unitario_produto           NUMBER(10, 2) NOT NULL,
    vl_perc_lucro                 NUMBER(8, 2),
    vl_unitario_lucro_produto     NUMBER(8, 2),
    sg_estado                     CHAR(2) NOT NULL,
    nm_estado                     VARCHAR2(30) NOT NULL,
    nr_cliente                    NUMBER(10) NOT NULL,
    nm_cliente                    VARCHAR2(160) NOT NULL,
    vl_icms_produto               NUMBER(8, 2)
);

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nr_ocorrencia_sac IS
    'Essa coluna irá armazenar a chave primária da tabela ocorrência SAC, que será utilizada pela area de negócio da Melhores  Compras.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.dt_abertura_sac IS
    'Essa coluna  irá  receber a data e horário do chamado  SAC aberto pelo cliente. Seu conteudo deve ser obrigatório e deve ser uma cópia dos dados da coluna DT_ABERTURA_SAC na  tabela MC_SGV_SAC.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac IS
    'Essa coluna  irá  receber a descrição da classficação do tipo de chamado SAC. O tipo do chamado SAC aberto pelo cliente. Seu conteúdo deve ser  obrigatório e os possíveis valores são: Sugestão; Dúvida ou  Elogio. Esses valores devem ser calculados a partir do conteúdo da coluna TP_SAC na tabela MC_SGV_SAC.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac IS
    'Essa coluna irá receber a descrição do índice de satisfação  do cliente  perante o chamado aberto no SAC das Melhores Compras. Esse conteúdo pode ser recuperado na tabela ORCL da FIAP pf0110.fun_gera_indice_sac_cli e deve ser selecionado sempre que necessário.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.cd_produto IS
    'Essa coluna irá receber o código do produto e seu conteúdo deve ser obrigatório. Essa descrição  deve ser uma cópia dos dados da coluna CD_PRODUTO na tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_produto IS
    'Essa coluna irá receber a descrição do produto e seu conteúdo deve ser obrigatório. Essa descrição  deve ser uma cópia dos dados da coluna DS_PRODUTO na tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_unitario_produto IS
    'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 e  deve ser uma cópia dos dados da coluna VL_UNITARIO na tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_perc_lucro IS
    'Essa coluna irá armazenar o valor percentual  do lucro sobre o produto ofertado. Seu conteúdo deve ser uma cópia dos dados da coluna VL_PERC_LUCRO na tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto IS
    'Essa coluna irá armazenar o valor do lucro unitario do lucro sobre o produto ofertado. Seu conteúdo deve ser calculado sobre a seguinte formula: conteúdo da coluna (VL_PERC_LUCRO / 100 ) * VL_UNITARIO_PRODUTO. Esses valores se  encontram na tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório e deve ser uma cópia dos dados da coluna SG_ESTADO  na tabela MC_ESTADO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nm_estado IS
    'Esta coluna ira receber a descrição do nome  do Estado. Esse conteúdo é obrigatório e deve ser uma cópia dos dados da coluna NM_ESTADO  na tabela MC_ESTADO.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nr_cliente IS
    'Essa coluna irá receber o código do nome do cliente  e seu conteúdo deve ser obrigatório. Essa descrição  deve ser uma cópia dos dados da coluna NR_CLIENTE  na tabela MC_CLIENTE.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nm_cliente IS
    'Essa coluna irá receber o  nome do cliente  e seu conteúdo deve ser obrigatório. Essa descrição  deve ser uma cópia dos dados da coluna NM_CLIENTE  na tabela MC_CLIENTE.';

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_icms_produto IS
    'Essa coluna irá armazenar o valor médio do ICMS pago sobre o produto ofertado a partir do Estado onde o cliente solicita a entrega. Seu conteúdo deve ser calculado sobre a seguinte formula: conteúdo da coluna (VL_PERC_ALIQUOTA_MEDIA / 100 ) * VL_UNITARIO_PRODUTO. O valor da alíquota é extraído da procedure prc_pega_aliquota_media_ICMS e o valor unitário do produto se  encontra na tabela MC_PRODUTO.';

ALTER TABLE mc_sgv_ocorrencia_sac ADD CONSTRAINT pk_mc_ocorrencia_sac PRIMARY KEY ( nr_ocorrencia_sac );

--
-- Os scripts abaixo criam a estrutura de sequence para uso na fase 2 do PBL
--
ALTER TABLE MC_CLIENTE 
ADD CONSTRAINT UK_MC_CLIENTE_MM_LOGIN UNIQUE (NM_LOGIN);

CREATE SEQUENCE SQ_MC_DEPTO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_FUNCIONARIO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_CIDADE
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_BAIRRO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_LOGRADOURO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_CLIENTE
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_CATEGORIA
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_PRODUTO
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_SGV_VISUAL_PROD
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;

CREATE SEQUENCE SQ_MC_SGV_SAC
START WITH 1 
INCREMENT BY 1 
MAXVALUE 9999999999 
NOCACHE 
NOCYCLE;


--
-- Carga Inicial para execução do Quiz
--
INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'DIRETORIA', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, NULL, 'Florinda Glup', 'PRESIDENTE', 54732, TO_DATE('10102000','DDMMYYYY'), TO_DATE('13031960','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Silvana Silva', 'CONSELHEIRA', 8498, TO_DATE('18072008','DDMMYYYY'), TO_DATE('11051950','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Thais Luppy', 'CONSELHEIRA', 8765, TO_DATE('31032009','DDMMYYYY'), TO_DATE('21051980','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Maria Linda Tunner', 'CONSELHEIRA', 8812, TO_DATE('31031990','DDMMYYYY'), TO_DATE('27121997','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Telma Reitzman', 'CONSELHEIRA', 8760, TO_DATE('31082011','DDMMYYYY'), TO_DATE('26121997','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Vilma Dias', 'CONSELHEIRA', 8753, TO_DATE('21072010','DDMMYYYY'),  TO_DATE('25111997','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Miriam Lee', 'CONSELHEIRA', 8761, TO_DATE('14062011','DDMMYYYY'), TO_DATE('25012002','DDMMYYYY'));


INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'PLANEJAMENTO ESTRATEGICO', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Alice Lopes', 'GERENTE PLANEJAMENTO ESTRATEGICO', 11433, TO_DATE('18051991','DDMMYYYY'), TO_DATE('31072000','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Margarida Figueira', 'COORDENADORA PLANEJAMENTO ESTRATEGICO', 9988, TO_DATE('18052005','DDMMYYYY'), TO_DATE('21041990','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Cintia Sousa', 'ANALISTA PLANEJAMENTO', 5600, TO_DATE('23092009','DDMMYYYY'), TO_DATE('04051990','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-3, 'Fernanda Yamaha', 'ANALISTA PLANEJAMENTO', 5800, TO_DATE('20112006','DDMMYYYY'), TO_DATE('19111970','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-4, 'Dinah Honda', 'ANALISTA PLANEJAMENTO', 6800, TO_DATE('20111992','DDMMYYYY'), TO_DATE('11011992','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO, DT_DESLIGAMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-5, 'Samantha Vieira', 'ANALISTA PLANEJAMENTO', 6800, TO_DATE('02101997','DDMMYYYY'), TO_DATE('13091994','DDMMYYYY'),  TO_DATE('22122022','DDMMYYYY'));


INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-6, 'Nivia Maria Mello', 'ANALISTA QUALIDADE', 9700, TO_DATE('17062006','DDMMYYYY'), TO_DATE('25031991','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-7, 'Noemia Lima', 'ANALISTA QUALIDADE', 9887, TO_DATE('18092012','DDMMYYYY'), TO_DATE('16071992','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-8, 'Camila Limytz', 'ANALISTA QUALIDADE', 7543, TO_DATE('18052005','DDMMYYYY'), TO_DATE('12081998','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-9, 'Giovanna Potker', 'ANALISTA QUALIDADE', 6890, TO_DATE('18052005','DDMMYYYY'), TO_DATE('18071995','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-10, 'Giulia Mendez', 'ANALISTA QUALIDADE', 8076, TO_DATE('18052005','DDMMYYYY'), TO_DATE('21061999','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-11, 'Nice Faria', 'ANALISTA QUALIDADE', 8432, TO_DATE('18052005','DDMMYYYY'), TO_DATE('28081998','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-12, 'Joelma Tutti', 'ANALISTA QUALIDADE', 8965, TO_DATE('18052005','DDMMYYYY'), TO_DATE('25091994','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-13, 'Karen Kirk', 'ANALISTA QUALIDADE', 7431, TO_DATE('18052005','DDMMYYYY'), TO_DATE('05071995','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-14, 'Luisa Luppy', 'ANALISTA QUALIDADE', 7698, TO_DATE('18052005','DDMMYYYY'), TO_DATE('08031997','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-15, 'Paula Grande', 'ANALISTA QUALIDADE', 8765, TO_DATE('18052005','DDMMYYYY'), TO_DATE('22051993','DDMMYYYY'));


-- Gabarito fase 2 item  a) e b)
----------------------------------------------------------
INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'COMERCIAL', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Maria Linda Lopes', 'Gerente Comercial', 7222, TO_DATE('31032001','DDMMYYYY'), TO_DATE('30111983','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Luiza Zoop', 'Representante Comercial', 5783, TO_DATE('28042002','DDMMYYYY'), TO_DATE('02101976','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Monica Brasil', 'Representante Comercial', 7430, TO_DATE('16072002','DDMMYYYY'), TO_DATE('31121988','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'CONTABILIDADE', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Tatiana Mussi', 'Gerente Contabil', 5499, TO_DATE('31122001','DDMMYYYY'), TO_DATE('23061989','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Adriana Pinheiro', 'Assistente Contabil', 3477, TO_DATE('28042012','DDMMYYYY'), TO_DATE('01011987','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Monique Lara', 'Assistente Contabil', 3477, TO_DATE('29082014','DDMMYYYY'), TO_DATE('12121993','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'ESTOQUE', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Alice Costa', 'Gerente Logistica', 6280, TO_DATE('04112003','DDMMYYYY'), TO_DATE('22071993','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Flavia Junqueira', 'Analista Logistica', 4650, TO_DATE('27072004','DDMMYYYY'), TO_DATE('08081994','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Giovanna Lua', 'Assistente Logistica', 4650, TO_DATE('23032016','DDMMYYYY'), TO_DATE('14011998','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'FINANCEIRO', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Dolores Julio', 'Gerente Financeira', 8700, TO_DATE('21122003','DDMMYYYY'), TO_DATE('21031989','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Elisa Suhay', 'Analista Financeira', 4850, TO_DATE('22022005','DDMMYYYY'), TO_DATE('03031998','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Fernanda Yamaha', 'Analista Financeira', 4850, TO_DATE('29092009','DDMMYYYY'), TO_DATE('19051999','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'SAC (SERVICO DE ATENDIMENTO AO CLIENTE)', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Leonice Alvarez', 'Gerente SAC', 4912, TO_DATE('31072002','DDMMYYYY'), TO_DATE('11011994','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Beatriz Julio', 'Analista SAC', 2820, TO_DATE('26062010','DDMMYYYY'), TO_DATE('05051999','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Vitoria Oliveira', 'Analista SAC', 2820, TO_DATE('28082012','DDMMYYYY'), TO_DATE('13082000','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'RECURSOS HUMANOS (RH)', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Heloisa Suassana', 'Gerente RH', 7641, TO_DATE('20092003','DDMMYYYY'), TO_DATE('19101995','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Juliana Flores', 'Analista RH', 3400, TO_DATE('24042014','DDMMYYYY'), TO_DATE('09121996','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Karina Voltz', 'Analista RH', 3400, TO_DATE('17092016','DDMMYYYY'), TO_DATE('05042002','DDMMYYYY'));

INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'LOGISTICA', 'A');
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, NULL, 'Flor Deliz', 'Gerente Logistica', 7322, TO_DATE('10102000','DDMMYYYY'), TO_DATE('13031960','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Susy Pietro', 'Analista Logistica', 4600, TO_DATE('18072008','DDMMYYYY'), TO_DATE('11051950','DDMMYYYY'));
INSERT INTO MC_FUNCIONARIO(CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, DT_CADASTRAMENTO, DT_NASCIMENTO)
VALUES (SQ_MC_FUNCIONARIO.NEXTVAL, SQ_MC_DEPTO.CURRVAL, 1, 'Thammy July', 'Analista Logistica', 4578, TO_DATE('31032009','DDMMYYYY'), TO_DATE('21051980','DDMMYYYY'));


--
-- Este ultimo departamento esta como inativo e nao sera incorporado funcionarios dentro dele
--
INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'TECNOLOGIA DA INFORMAcaO (TI)', 'I');

SELECT * FROM MC_DEPTO;
SElECT * FROM  MC_FUNCIONARIO;

-- Gabarito fase 2 item  c)
----------------------------------------------------------
--
-- Cadastro de Estados do Brasil
--
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('AC', 'ACRE');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('AL', 'ALAGOAS');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('AP', 'AMAPA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('AM', 'AMAZONAS');   
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('BA', 'BAHIA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('CE', 'CEARa');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('ES', 'ESPiRITO SANTO');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('GO', 'GOIaS');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('MA', 'MARANHaO');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('MT', 'MATO GROSSO');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('MS', 'MATO GROSSO DO SUL');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('MG', 'MINAS GERAIS');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('PA', 'PARa');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('PB', 'PARAiBA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('PR', 'PARANa');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('PE', 'PERNAMBUCO');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('PI', 'PIAUi');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RJ', 'RIO DE JANEIRO');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RN', 'RIO GRANDE DO NORTE');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RS', 'RIO GRANDE DO SUL');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RO', 'RONDÔNIA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RR', 'RORAIMA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SC', 'SANTA CATARIA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SP', 'SaO PAULO');
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SE', 'SERGIPE');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('TO', 'TOCANTINS');  

--
-- Cadastro cidade, bairro e logradouro
--
-- 1o Estado: RS 
-- 1a Cidade: Porto Alegre
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'RS', 'Porto Alegre',  4314902, 52);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'Arpoadouro', 'ZONA NORTE');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Wenceslau Escobar', ' 91900000');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida do Forte', '91360001');

-- 1o Estado: RS 
-- 2a Cidade: Caxias do Sul
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'RS', 'Caxias do Sul',  4305108, 54);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'Vila Zenai', 'ZONA LESTE');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Rua principal', ' 95010110');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Rua Dr. Oliveira', ' 95010876');

-- 2o Estado: SP 
-- 1a Cidade: Sao Paulo
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'SP', 'Sao Paulo',  35, 11);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CAMBUCI', 'ZONA ZUL');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Lacerda Franco', '01536000');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Lins de Vasconcelos', '01536112');

-- 2o Estado: SP 
-- 2a Cidade: Atibaia
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'SP', 'Atibaia',  3504107, 11);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'Vila Zenai', 'ZONA LESTE');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Figueira Garden', '12940010');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Floriano Peixoto', '12940011');

-- 3o Estado: SC 
-- 1a Cidade: Florianopolis
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'SC', 'Florianopolis',  4205407, 48);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'ZONA ZUL');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Principal', '88058300');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Presidente Jose Luiz', '88058310');

-- 3o Estado: SC 
-- 2a Cidade: Joinville
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'SC', 'JOINVILLE',  3504107, 11);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'CENTRO');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Paulo Shoreze', '89232302');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Cesar Claro', '89232302');

-- 4o Estado: BA 
-- 1a Cidade: Salvador
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'BA', 'SALVADOR',  2927408, 71);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'ZONA ZUL');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Padre Otoloni', '40020901');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Maria Luiza', '40020901');

-- 4o Estado: BA 
-- 2a Cidade: Vitoria da Conquista
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'BA', 'Vitoria da Conquista',  2927412, 72);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'CENTRO');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Maria Vitoria', '40020931');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Carlos Klan', '40020921');

-- 5o Estado: CEARA 
-- 1a Cidade: FORTALEZA
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'CE', 'FORTALEZA',  2304400, 85);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'CENTRO');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida do Calcadao', '60312060');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Avenida Capitao do Mar', '60312060');

-- 5o Estado: CEARA 
-- 2a Cidade: Juazeiro do Norte
--
INSERT INTO MC_CIDADE(CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) VALUES (SQ_MC_CIDADE.NEXTVAL, 'CE', 'Juazeiro do Norte',  2304400, 86);
INSERT INTO MC_BAIRRO(CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) VALUES (SQ_MC_BAIRRO.NEXTVAL, SQ_MC_CIDADE.CURRVAL, 'CENTRO', 'CENTRO');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Monica Seles', '60312054');
INSERT INTO MC_LOGRADOURO(CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) VALUES (SQ_MC_LOGRADOURO.NEXTVAL, SQ_MC_BAIRRO.CURRVAL, 'Av. Michel Luiz', '60312054');

-- Gabarito fase 2 item  d)
----------------------------------------------------------
--
INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 1, 2, 202, TO_DATE('01012000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 2, 4, 434, TO_DATE('10052000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 3, 5, 354, TO_DATE('08062000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 4, 6, 467, TO_DATE('11092003','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 5, 12, 230, TO_DATE('13032002','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 6, 20, 299, TO_DATE('18052001','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 7, 11, 21, TO_DATE('30122000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 8, 13, 341, TO_DATE('30122000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 9, 1, 87, TO_DATE('30122000','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 10, 10, 87, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 11, 9, 233, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 12, 14, 716, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 13, 15, 6, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 14, 16, 78, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 15, 17, 21, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 16, 18, 221, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 17, 19, 221, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 18, 20, 221, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 19, 17, 79, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 20, 1, 79, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_FUNC(CD_FUNCIONARIO, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 21, 2, 79, TO_DATE('12121997','DDMMYYYY'), 'A');

-- Gabarito fase 2 item  e)
----------------------------------------------------------
--
INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'CAMILA LUCIO', 'CAMIS', 'CAMIS');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-15000, 'F', 13001023400);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SUELI THOMPSON', 'SUELI', 'SUELI');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-14678, 'F', 13209876522);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SUSI VEIGA', 'SUSI', 'SUSI');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-14990, 'F', 9876544212);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SILMARA SANCY', 'SILMARA', 'SILMARA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-16789, 'F', 08765432122);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'MARA MARAVILHA', 'MARA', 'MARA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-17654, 'F', 98765632212);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'JULIANA VITAUSTAS', 'JULIANA', 'JULIANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-16545, 'F', 08765432144);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'JOANA MARTINS', 'JOANA', 'JOANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-19008, 'F', 08765434577);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'HELENA PILDAP', 'HELENA', 'HELENA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-19345, 'F', 09876543221);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'IVANA MARY', 'IVANA', 'IVANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-18761, 'F', 08309812312);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'KELLY DULIP', 'KELLY', 'KELLY');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-17890, 'F', 09308877654);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'IBM CONSULTORIA', 'IBM', 'IBM');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-42000, 02045677000121);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'MICROSOFT CONSULTORIA', 'MICROSOFT', 'MICROSOFT');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-28000, 03457000122);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'ORACLE CONSULTORIA', 'ORACLE', 'ORACLE');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-35000, 02248000155);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'AWS CONSULTORIA', 'AWS', 'AWS');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-12500, 04567000156);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'GCP CONSULTORIA', 'GCP', 'GCP');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-8000, 05867000132);

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 1, 12, 23, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 2, 1, 31, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 3, 7, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 4, 5, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 5, 6, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 6, 8, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 7, 9, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 8, 3, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 9, 1, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 10, 12, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 11, 10, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 12, 14, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 13, 15, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 14, 18, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, DT_INICIO, ST_END)
VALUES( 15, 20, 1, TO_DATE('12121997','DDMMYYYY'), 'A');


-- Gabarito fase 2 item  g)
----------------------------------------------------------
--
INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Artesanato', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'audio', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Brinquedos', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Celular e Smartphone', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Colchoes', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Esporte e Lazer', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Ferramentas', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Games', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Informatica', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Livros', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Pet Shop', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'TV e Utilidades Domesticas', SYSDATE-22000, 'A' );

-- Gabarito fase 2 item h)
-------------------------------------------
INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Instalacao do produto', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Uso no cotidiano', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Comercial com personalidade', SYSDATE-22000, 'A' );

-- Gabarito fase 2 item i)
-------------------------------------------
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 1, 'Boneca de Pano LupaLupa', 55.52, 'Boneca de Pano especial feita a mao', 48);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 2, 'Fone ouvido Sony wifi', 132, 'Fone de ouvido top de mercado', 34);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 3, 'Jogo tabuleiro imagem  e acao', 220, 'famoso jogo de tabuleiro', 30);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 4, 'Celular Samsumg 20 geracao', 2134, 'Novo celular 3d samsumg',32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 5, 'Colchao Castor Molas King', 1456, 'Novo colchao molas king castor', 28);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Tenis Nike voador', 657, 'Tenis Nike para pratica esportiva',29);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Meia Mizuno 5 star', 54, 'meia mizuno 5 star', 60);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Calcao banho marinho', 65, 'Calcao de banho para piscina na cor marinho', 32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Chave de Venda 15 opcoes', 45, 'Chave de fenda especial com15 opcoes de acesso ao parafuso', 32);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Furadeira Marcenaria Profissional', 546, 'Furadeira Thompson de ultima geracao',33.9);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Maleta com 150 chaves de boca', 499, 'Maleta contendo 150 chaves de boca dos  mais variados tipos',33.8);


INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 8, 'Jogo Game of Throne PS6', 389, 'O novo jogo do Game of Throne disponivel para uso asap',31);
,
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Notebook core i7 16Gb Memoria Del 14 inspirion', 2640, 'Notebook Dell Inspirion ultima geracao pesando apenas 0,9kg',30);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Notebook core i5 16Gb Memoria Del 14 inspirion', 2340, 'Notebook Dell Inspirion ultima geracao pesando apenas 0,9kg', 32);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Mouse sem fio', 54, 'Mouse sem fio com conexao USB',33);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 10, 'Livro Viajando com a vida', 22, 'Livro que  explica a importancia de viver feliz',70);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 10, 'Livro conhecendo o futuro', 55, 'Livro que explica o sentido da vida',32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 11, 'Coleira anti pulga cachorro pequeno', 67, 'Coleira antipulga para cachorro pequeno',22);
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 11, 'Racao Royal Canin', 122, 'Racao especial Royal Canin',24);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 12, 'Smart TV 60 polegadas', 2567, 'Melhor TV smart do mercado', 29);


-- Gabarito fase 2 item j)
-------------------------------------------
INSERT INTO MC_SGV_PRODUTO_VIDEO  (CD_PRODUTO, NR_SEQUENCIA, CD_CATEGORIA, TP_VIDEO_PROD, DS_PATH_VIDEO_PROD, ST_VIDEO_PROD) 
VALUES (10, 1, 14, 'DICA', '/video/video_12.mp4', 'A');

INSERT INTO MC_SGV_PRODUTO_VIDEO  (CD_PRODUTO, NR_SEQUENCIA, CD_CATEGORIA, TP_VIDEO_PROD, DS_PATH_VIDEO_PROD, ST_VIDEO_PROD) 
VALUES (15, 1, 15, 'DICA', '/video/video_15.mp4', 'A');


-- Gabarito fase 2 item k)
-------------------------------------------
INSERT INTO MC_SGV_VISUALIZACAO_VIDEO(CD_VISUALIZACAO_VIDEO, NR_CLIENTE, CD_PRODUTO, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (SQ_MC_SGV_VISUAL_PROD.NEXTVAL, 10, 15, SYSDATE-10, 22, 30,22);

INSERT INTO MC_SGV_VISUALIZACAO_VIDEO(CD_VISUALIZACAO_VIDEO, NR_CLIENTE, CD_PRODUTO, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (SQ_MC_SGV_VISUAL_PROD.NEXTVAL, 10, 13, SYSDATE-8, 14, 12,55);

INSERT INTO MC_SGV_VISUALIZACAO_VIDEO(CD_VISUALIZACAO_VIDEO, NR_CLIENTE, CD_PRODUTO, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (SQ_MC_SGV_VISUAL_PROD.NEXTVAL, 10, 16, SYSDATE-5, 16, 43,09);

INSERT INTO MC_SGV_VISUALIZACAO_VIDEO(CD_VISUALIZACAO_VIDEO, NR_CLIENTE, CD_PRODUTO, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (SQ_MC_SGV_VISUAL_PROD.NEXTVAL, 10, 18, SYSDATE-2, 09, 31,56);

INSERT INTO MC_SGV_VISUALIZACAO_VIDEO(CD_VISUALIZACAO_VIDEO, NR_CLIENTE, CD_PRODUTO, DT_VISUALIZACAO, NR_HORA_VISUALIZACAO, NR_MINUTO_VIDEO, NR_SEGUNDO_VIDEO)
VALUES (SQ_MC_SGV_VISUAL_PROD.NEXTVAL, 10, 19, SYSDATE-1, 12, 12,12);

-- Gabarito fase 2 item l)
-------------------------------------------
COMMIT;

-- Gabarito fase 2 item m)
INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'P', 'Bem Estar', SYSDATE-1000, 'I' );

-- Gabarito fase 2 item n)
INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, DS_COMPLETA_PROD, ST_PRODUTO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, SQ_MC_CATEGORIA.CURRVAL, 'Aromatizante casa', 12, 'novo aromatizante floral', 'I');

-- Gabarito fase 2 item o)
UPDATE MC_FUNCIONARIO SET DS_CARGO = 'Conselheira Sr', VL_SALARIO = VL_SALARIO * 1.12
WHERE CD_FUNCIONARIO = 3;

-- Gabarito fase 2 item p)
UPDATE MC_CATEGORIA_PROD SET DS_CATEGORIA = 'Games e Jogos Digitais'
WHERE DS_CATEGORIA = 'Games';

-- Gabarito fase 2 item q)
UPDATE MC_DEPTO SET NM_DEPTO = 'COMERCIAL E RELACIONAMENTO CLIENTE'
WHERE NM_DEPTO = 'COMERCIAL';

-- Gabarito fase 2 item r)
UPDATE MC_CLI_FISICA SET DT_NASCIMENTO = TO_DATE('18052002','DDMMYYYY')
WHERE NR_CLIENTE = 7;

-- Gabarito fase 2 item s)
UPDATE MC_CATEGORIA_PROD SET DS_CATEGORIA = 'Comercial com Pessoa Famosa'
WHERE DS_CATEGORIA = 'Comercial com personalidade';

-- Gabarito fase 2 item t)
UPDATE MC_FUNCIONARIO SET ST_FUNC = 'I', DT_DESLIGAMENTO = SYSDATE
WHERE CD_FUNCIONARIO = 11;

-- Gabarito fase 2 item u) **Rever nao tem nada cadastrado
INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, DS_DETALHADA_SAC,
DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 5, 15, 7, 'Cliente nao consegue ativar o mouse', sysdate-1, 14, 'D', 'E');

UPDATE MC_SGV_SAC  SET DS_DETALHADA_RETORNO_SAC = 'O cliente revisitou os videos e refez a instalacao e agora esta tudo 100%',
DT_ATENDIMENTO = SYSDATE, HR_ATENDIMENTO_SAC = 2, NR_TEMPO_TOTAL_SAC = NR_TEMPO_TOTAL_SAC+2
WHERE NR_SAC = 1;

-- Gabarito fase 2 item v) 
UPDATE MC_END_CLI  SET ST_END = 'I', DT_TERMINO = SYSDATE-1
WHERE NR_CLIENTE = 7  AND ROWNUM = 1;

-- Gabarito item w)
UPDATE MC_END_FUNC  SET ST_END = 'I', DT_TERMINO = SYSDATE-1
WHERE CD_FUNCIONARIO = 11  AND ROWNUM = 1;

--
-- Confirma as transações pendentes
commit;

-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             36
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
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
-- ERRORS                                   0
-- WARNINGS                                 0

