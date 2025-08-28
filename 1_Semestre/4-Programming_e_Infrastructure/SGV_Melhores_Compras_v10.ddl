-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-11-04 17:14:17 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE mc_bairro (
    cd_bairro      NUMBER(8) NOT NULL,
    cd_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45),
    nm_zona_bairro VARCHAR2(20)
);

COMMENT ON COLUMN mc_bairro.cd_bairro IS
    'Esta coluna ir� receber o codigo do bairro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

ALTER TABLE mc_bairro ADD CONSTRAINT mc_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE mc_categoria_prod (
    cd_categoria NUMBER(10) NOT NULL,
    tp_categoria CHAR(1) NOT NULL,
    ds_categoria VARCHAR2(500) NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_termino   DATE,
    st_categoria CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_categoria_prod.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria.'
    ;

COMMENT ON COLUMN mc_categoria_prod.tp_categoria IS
    'Nessa  coluna  ser�  armazenada o tipo de categoria que poder�  ser (V)�deo ou (P)rodudto. Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN mc_categoria_prod.ds_categoria IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o.'
    ;

COMMENT ON COLUMN mc_categoria_prod.dt_inicio IS
    'Essa coluna ir� receber  a data de in�cio da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  obrigat�rio.';

COMMENT ON COLUMN mc_categoria_prod.dt_termino IS
    'Essa coluna ir� receber  a data de encerramento  da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  opcional. Conte�do obrigat�rio significa que a categoria foi encerrada a partir da data t�rmino. J� o conte�do opcional indica que a categoria est� ativa e operante.'
    ;

COMMENT ON COLUMN mc_categoria_prod.st_categoria IS
    'Essa coluna ir� armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

ALTER TABLE mc_categoria_prod
    ADD CONSTRAINT ck_vl_dt_termino CHECK ( ( dt_termino IS NOT NULL
                                              AND st_categoria = 'I' )
                                            OR ( dt_termino IS NULL
                                                 AND st_categoria = 'A' ) );

ALTER TABLE mc_categoria_prod ADD CONSTRAINT mc_categoria_prod_pk PRIMARY KEY ( cd_categoria );

ALTER TABLE mc_categoria_prod ADD CONSTRAINT un_mc_cat_prod_ds_cat UNIQUE ( ds_categoria );

CREATE TABLE mc_cidade (
    cd_cidade  NUMBER(8) NOT NULL,
    sg_estado  CHAR(2) NOT NULL,
    nm_cidade  VARCHAR2(60) NOT NULL,
    cd_ibge    NUMBER(8),
    nr_ddd     NUMBER(3)
);

COMMENT ON COLUMN mc_cidade.cd_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_cidade.cd_ibge IS
    'Esta coluna ir� receber o c�digo do IBGE que fornece informa��es para gera��o da NFe.';

COMMENT ON COLUMN mc_cidade.nr_ddd IS
    'Esta coluna ir� receber o n�mero do DDD da cidade para ser utilizado no contato telef�nico. Seu conteudo � opcional.';

ALTER TABLE mc_cidade ADD CONSTRAINT mc_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE mc_cli_fisica (
    nr_cliente        NUMBER(10) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    fl_sexo_biologico CHAR(1) NOT NULL,
    ds_genero         VARCHAR2(100),
    nr_cpf            VARCHAR2(14) NOT NULL
);

COMMENT ON COLUMN mc_cli_fisica.nr_cliente IS
    'Essa coluna armazena o n�mero do cliente Pessoa F�sica.';

COMMENT ON COLUMN mc_cli_fisica.dt_nascimento IS
    'Essa coluna ir� armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;

COMMENT ON COLUMN mc_cli_fisica.fl_sexo_biologico IS
    'Essa coluna ir� armazenar o sexo biol�gico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.. '
    ;

COMMENT ON COLUMN mc_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN mc_cli_fisica.nr_cpf IS
    'Essa coluna ir� armazenar o n�mero do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;

ALTER TABLE mc_cli_fisica ADD CONSTRAINT mc_cli_fisica_pk PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cli_juridica (
    nr_cliente   NUMBER(10) NOT NULL,
    dt_fundacao  DATE NOT NULL,
    nr_cnpj      VARCHAR2(20) NOT NULL,
    nr_inscr_est VARCHAR2(15)
);

COMMENT ON COLUMN mc_cli_juridica.nr_cliente IS
    'Essa coluna armazena o n�mero do Cliente Pessoa Jur�dica.';

COMMENT ON COLUMN mc_cli_juridica.dt_fundacao IS
    'Essa coluna ir� armazenar data  de funda��o do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_cnpj IS
    'Essa coluna ir� armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_inscr_est IS
    'Essa coluna ir� armazenar o  numero da Inscri��o Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser opcional'
    ;

ALTER TABLE mc_cli_juridica ADD CONSTRAINT mc_cli_juridica_pk PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cliente (
    nr_cliente      NUMBER(10) NOT NULL,
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
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual ter� sempre o n�mero disponivel para uso.'
    ;

COMMENT ON COLUMN mc_cliente.nm_cliente IS
    'Essa coluna ir� armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN mc_cliente.qt_estrelas IS
    'Essa coluna ir� armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e ser poss�vel de estar entre 1 e 5 estrelas.'
    ;

COMMENT ON COLUMN mc_cliente.vl_medio_compra IS
    'Essa coluna ir� armazenar o valor  m�dio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e deve ser calculado diariamente.'
    ;

COMMENT ON COLUMN mc_cliente.st_cliente IS
    'Essa coluna ir� armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_cliente.ds_email IS
    'Essa coluna ir� armazenar o email  do cliente da Melhorees Compras. No minimo � esperado um email contendo o caractere (@) em seu conte�do.'
    ;

COMMENT ON COLUMN mc_cliente.nr_telefone IS
    'Essa coluna ir� armazenar o n�mero do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pr� definida.'
    ;

COMMENT ON COLUMN mc_cliente.nm_login IS
    'Essa coluna ir� armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conte�do deve ser obrigat�rio e  �nico para cada cliente.'
    ;

COMMENT ON COLUMN mc_cliente.ds_senha IS
    'Essa coluna ir� armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

ALTER TABLE mc_cliente ADD CONSTRAINT mc_cliente_pk PRIMARY KEY ( nr_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT uk_mc_cliente_nome_cliente UNIQUE ( nm_cliente );

ALTER TABLE mc_cliente
    ADD CONSTRAINT ck_st_cliente CHECK ( st_cliente IN ( 'A', 'I' ) );

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

CREATE TABLE mc_depto (
    cd_depto NUMBER(3) NOT NULL,
    nm_depto VARCHAR2(100) NOT NULL,
    st_depto CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_depto.cd_depto IS
    'Esta coluna ir� receber o codigo do departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_depto.nm_depto IS
    'Esta coluna ir� receber o nome do  departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_depto.st_depto IS
    'Esta coluna ir� receber o status do  departamento  e seu conte�do � obrigat�rio. Os valores poss�veis s�o: (A)tivo e (I)nativo.'
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
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN mc_end_cli.ds_complemento_end IS
    'Esta coluna ir� receber o complemento do endere�o do cliente e seu conte�do pode ser opcional.';

COMMENT ON COLUMN mc_end_cli.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.st_end IS
    'Status do endere�o. (A)itvo ou (I)nativo.';

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
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN mc_end_func.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_func.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

ALTER TABLE mc_end_func ADD CONSTRAINT mc_end_func_pk PRIMARY KEY ( cd_funcionario,
                                                                    cd_logradouro );

CREATE TABLE mc_estado (
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN mc_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_estado.nm_estado IS
    'Esta coluna ir� receber o nome do estado';

ALTER TABLE mc_estado ADD CONSTRAINT mc_estado_pk PRIMARY KEY ( sg_estado );

CREATE TABLE mc_funcionario (
    cd_funcionario    NUMBER(10) NOT NULL,
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
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.cd_depto IS
    'Essa coluna ira receber o c�digo do departamento em que o funcion�rio trabalha.';

COMMENT ON COLUMN mc_funcionario.nm_funcionario IS
    'Esta coluna ir� receber o nome do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.cpf_funcionario IS
    'Essa coluna vai receber o identificador �nico de pessoa f�sica, seu conte�do deve ser �nico.';

COMMENT ON COLUMN mc_funcionario.dt_nascimento IS
    'Esta coluna ir� receber a data de nascimento  do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.nr_telefone_func IS
    'Essa coluna recebe o n�mero de telefone do funcion�rio.	';

COMMENT ON COLUMN mc_funcionario.ds_email IS
    'Essa coluna recebe o e-mail do funcion�rio.';

COMMENT ON COLUMN mc_funcionario.fl_sexo_biologico IS
    'Esta coluna ir� receber o sexo biol�gico do funcion�rio e seu conte�do � obrigat�rio.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)'
    ;

COMMENT ON COLUMN mc_funcionario.ds_cargo IS
    'Essa coluna recebe o nome do cargo do funcion�rio.';

COMMENT ON COLUMN mc_funcionario.vl_salario IS
    'Esta coluna ir� receber o valor do sal�rio do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN mc_funcionario.st_func IS
    'Essa coluna ir� armazenar o status do funcion�rio da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN mc_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conte�do � opcional.';

ALTER TABLE mc_funcionario ADD CONSTRAINT mc_funcionario_pk PRIMARY KEY ( cd_funcionario );

ALTER TABLE mc_funcionario ADD CONSTRAINT un_mc_func_cpf_funcionario UNIQUE ( cpf_funcionario );

CREATE TABLE mc_logradouro (
    cd_logradouro NUMBER(5) NOT NULL,
    cd_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(160) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL
);

COMMENT ON COLUMN mc_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_logradouro.nr_cep IS
    'Esta coluna ir� receber o numero do CEP do Logradouro e seu conte�do � obrigat�rio.';

ALTER TABLE mc_logradouro ADD CONSTRAINT mc_logradouro_pk PRIMARY KEY ( cd_logradouro );

CREATE TABLE mc_produto (
    cd_produto        NUMBER(10) NOT NULL,
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
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.'
    ;

COMMENT ON COLUMN mc_produto.nr_cd_barras_prod IS
    'Essa coluna ir� armazenar o n�mero do codigo de barras  do produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN mc_produto.ds_produto IS
    'Essa coluna ir� armazenar a descri��o principal do produto. Seu conte�do deve ser  obrigatorio.';

COMMENT ON COLUMN mc_produto.vl_unitario IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 ';

COMMENT ON COLUMN mc_produto.tp_embalagem IS
    'Essa coluna ir� armazenar o tipo de embalagem do produto. Seu conte�do pode ser opcional.';

COMMENT ON COLUMN mc_produto.st_produto IS
    'Essa coluna ir� armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_produto.vl_perc_lucro IS
    'Essa coluna ir� armazenar o percentual  do lucro m�dio para cada produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN mc_produto.ds_completa_prod IS
    'Essa coluna ir� armazenar a descri��o completa do produto. Seu conte�do deve ser  obrigatorio.';

ALTER TABLE mc_produto
    ADD CONSTRAINT "_CK_VL_STS_PRODUTO" CHECK ( st_produto IN ( 'A', 'I' ) );

ALTER TABLE mc_produto ADD CONSTRAINT ck_vl_unitario CHECK ( vl_unitario > 0 );

ALTER TABLE mc_produto ADD CONSTRAINT mc_produto_pk PRIMARY KEY ( cd_produto );

ALTER TABLE mc_produto ADD CONSTRAINT un_mc_produto_ds_produto UNIQUE ( ds_produto );

CREATE TABLE mc_sgv_ocorrencia_sac (
    nr_ocorrencia_sac            NUMBER NOT NULL,
    dt_abertura_sac              DATE NOT NULL,
    hr_abertura_sac              NUMBER(2),
    ds_tipo_classificacao_sac    VARCHAR2(30) NOT NULL,
    ds_indice_satisfacao_atd_sac VARCHAR2(30),
    cd_produto                   NUMBER(10) NOT NULL,
    ds_produto                   VARCHAR2(80) NOT NULL,
    vl_unitario_produto          NUMBER(10, 2) NOT NULL,
    vl_perc_lucro                NUMBER(8, 2),
    vl_unitario_lucro_produto    NUMBER(8, 2),
    sg_estado                    CHAR(2) NOT NULL,
    nm_estado                    VARCHAR2(30) NOT NULL,
    nr_cliente                   NUMBER(10) NOT NULL,
    nm_cliente                   VARCHAR2(160) NOT NULL,
    vl_icms_produto              NUMBER(8, 2)
);

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nr_ocorrencia_sac IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela ocorr�ncia SAC, que ser� utilizada pela area de neg�cio da Melhores  Compras.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do chamado  SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio e deve ser uma c�pia dos dados da coluna DT_ABERTURA_SAC na  tabela T_MC_SGV_SAC.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac IS
    'Essa coluna  ir�  receber a descri��o da classfica��o do tipo de chamado SAC. O tipo do chamado SAC aberto pelo cliente. Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: Sugest�o; D�vida ou  Elogio. Esses valores devem ser calculados a partir do conte�do da coluna TP_SAC na tabela T_MC_SGV_SAC.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac IS
    'Essa coluna ir� receber a descri��o do �ndice de satisfa��o  do cliente  perante o chamado aberto no SAC das Melhores Compras. Esse conte�do pode ser recuperado na tabela ORCL da FIAP pf0110.fun_gera_indice_sac_cli e deve ser selecionado sempre que necess�rio.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.cd_produto IS
    'Essa coluna ir� receber o c�digo do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna CD_PRODUTO na tabela T_MC_PRODUTO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.ds_produto IS
    'Essa coluna ir� receber a descri��o do produto e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna DS_PRODUTO na tabela T_MC_PRODUTO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_unitario_produto IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 e  deve ser uma c�pia dos dados da coluna VL_UNITARIO na tabela T_MC_PRODUTO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_perc_lucro IS
    'Essa coluna ir� armazenar o valor percentual  do lucro sobre o produto ofertado. Seu conte�do deve ser uma c�pia dos dados da coluna VL_PERC_LUCRO na tabela T_MC_PRODUTO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto IS
    'Essa coluna ir� armazenar o valor do lucro unitario do lucro sobre o produto ofertado. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_LUCRO / 100 ) * VL_UNITARIO_PRODUTO. Esses valores se  encontram na tabela T_MC_PRODUTO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna SG_ESTADO  na tabela T_MC_ESTADO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nm_estado IS
    'Esta coluna ira receber a descri��o do nome  do Estado. Esse conte�do � obrigat�rio e deve ser uma c�pia dos dados da coluna NM_ESTADO  na tabela T_MC_ESTADO.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nr_cliente IS
    'Essa coluna ir� receber o c�digo do nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NR_CLIENTE  na tabela T_MC_CLIENTE.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.nm_cliente IS
    'Essa coluna ir� receber o  nome do cliente  e seu conte�do deve ser obrigat�rio. Essa descri��o  deve ser uma c�pia dos dados da coluna NM_CLIENTE  na tabela T_MC_CLIENTE.'
    ;

COMMENT ON COLUMN mc_sgv_ocorrencia_sac.vl_icms_produto IS
    'Essa coluna ir� armazenar o valor m�dio do ICMS pago sobre o produto ofertado a partir do Estado onde o cliente solicita a entrega. Seu conte�do deve ser calculado sobre a seguinte formula: conte�do da coluna (VL_PERC_ALIQUOTA_MEDIA / 100 ) * VL_UNITARIO_PRODUTO. O valor da al�quota � extra�do da procedure prc_pega_aliquota_media_ICMS e o valor unit�rio do produto se  encontra na tabela T_MC_PRODUTO.'
    ;

ALTER TABLE mc_sgv_ocorrencia_sac ADD CONSTRAINT pk_mc_ocorrencia_sac PRIMARY KEY ( nr_ocorrencia_sac );

CREATE TABLE mc_sgv_sac (
    nr_sac                   NUMBER(10) NOT NULL,
    nr_cliente               NUMBER(10) NOT NULL,
    cd_funcionario           NUMBER(10) NOT NULL,
    cd_produto               NUMBER(10) NOT NULL,
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
    'Essa coluna ir� armazenar a chave prim�ria da tabela de SAC de v�deo  da Melhorees Compras. A cada SAC cadastrado pelo cliente ser� acionada a Sequence  SQ_MC_SGV_SAC que se encarregar� de gerar o pr�ximo n�mero �nico do chamado SAC feito pelo Cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_cliente IS
    'Essa coluna recebe o identificador do cliente da tabela MC_CLIENTE.';

COMMENT ON COLUMN mc_sgv_sac.cd_funcionario IS
    'Essa coluna recebe o C�digo do funcion�rio da tabela MC_FUNCIONARIO que est� respons�vel pelo atendimento.';

COMMENT ON COLUMN mc_sgv_sac.cd_produto IS
    'Essa coluna recebe o c�digo do produto da tabela MC_PRODUTO.';

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_sac IS
    'Essa coluna  ir�  receber a descri��o completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.hr_abertura_sac IS
    'Essa coluna  ir�  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.dt_atendimento IS
    'Essa coluna  ir�  receber a data e hor�rio do atendmiento SAC feita pelo funcion�rio da Melhores Compras. Seu conteudo deve ser opcional..'
    ;

COMMENT ON COLUMN mc_sgv_sac.hr_atendimento_sac IS
    'Essa coluna  ir�  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  ir�  receber o tempo total em horas  (HH24) computado desde a abertura at� a conclus�o dele. A unidade de medida � horas, ou seja, em quantas horas o chamado foi conclu�do desde a sua abertura.'
    ;

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  ir�  receber a descri��o detalhada do retorno feito pelo funcion�rio a partir da solicita��o do cliente. Seu conte�do deve ser opcional e preenchido pelo funcion�rio.'
    ;

COMMENT ON COLUMN mc_sgv_sac.tp_sac IS
    'Essa coluna  ir�  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (S)ugest�o; (D)�vida ou  (E)logio.'
    ;

COMMENT ON COLUMN mc_sgv_sac.st_sac IS
    'Essa coluna  ir�  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfa��o do cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  ir�  receber o �ndice de satisfa��o, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse �ndice de satisfa��o � opcional e informado pelo cliente ao final do atendimento.'
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
    ADD CONSTRAINT ck_tp_sac CHECK ( tp_sac IN ( 'S', 'D', 'E' ) );

ALTER TABLE mc_sgv_sac ADD CONSTRAINT mc_sgv_sac_pk PRIMARY KEY ( nr_sac );

CREATE TABLE mc_video (
    cd_produto   NUMBER(10) NOT NULL,
    nr_sequencia NUMBER(3) NOT NULL,
    ds_video     VARCHAR2(500) NOT NULL,
    nr_duracao   NUMBER(4) NOT NULL,
    st_video     CHAR(1) NOT NULL,
    dt_cadastro  DATE NOT NULL,
    ds_class     VARCHAR2(50),
    vd_produto   BLOB,
    cd_class     NUMBER(5)
);

COMMENT ON COLUMN mc_video.cd_produto IS
    'Nessa  coluna  ser�  armazenada o C�digo de produto, que pode ter nenhum ou v�rios v�deos associados e cada v�deo somente pode ser exibido caso seu status (ST_VIDEO) esteja em �A� (ativo). '
    ;

COMMENT ON COLUMN mc_video.nr_sequencia IS
    'Essa coluna ir� armazenar a sequencia do v�deo a partir do codigo do produto. Sempre o primeiro v�deo de determinado  produto deve iniciar com o n�mero 1. Seu conte�do � obrigat�rio.'
    ;

COMMENT ON COLUMN mc_video.ds_video IS
    'Essa coluna armazena a descri��o sobre o v�deo.';

COMMENT ON COLUMN mc_video.nr_duracao IS
    'Essa coluna armazena a dura��o do v�deo em segundos.';

COMMENT ON COLUMN mc_video.st_video IS
    'Essa coluna armazena o Status do video, podendo ser A(tivo)  ou I(nativo). V�deos inativo n�o podem ser visualizados.';

COMMENT ON COLUMN mc_video.dt_cadastro IS
    'Essa coluna armazena a data em que o v�deo foi cadastrado.';

COMMENT ON COLUMN mc_video.vd_produto IS
    'Essa coluna ir� armazenar oo v�deo do produto no formato que melhor lhe  convier.  Para utilizar essa coluna tenha acesso a documenta��o oficial da Oracle. Seu conte�do � opcional.'
    ;

CREATE UNIQUE INDEX mc_video__idx ON
    mc_video (
        cd_produto
    ASC );

ALTER TABLE mc_video
    ADD CONSTRAINT ck_sts_video CHECK ( st_video IN ( 'A', 'I' ) );

ALTER TABLE mc_video ADD CONSTRAINT mc_video_pk PRIMARY KEY ( cd_produto );

CREATE TABLE mc_video_class (
    cd_class   NUMBER(5) NOT NULL,
    cd_produto NUMBER(10),
    ds_class   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN mc_video_class.cd_class IS
    'Essa coluna armazena o c�digo de Classifica��o do v�deo.';

COMMENT ON COLUMN mc_video_class.ds_class IS
    'Essa coluna armazena a classifica��o do v�deo, podendo ser V�deo de instala��o do produto; Uso no cotidiano; Comercial com personalidade; entre outros. '
    ;

CREATE UNIQUE INDEX mc_video_class__idx ON
    mc_video_class (
        cd_produto
    ASC );

ALTER TABLE mc_video_class ADD CONSTRAINT mc_video_class_pk PRIMARY KEY ( cd_class );

CREATE TABLE mc_visualizacao (
    cd_visual    NUMBER(5) NOT NULL,
    nr_cliente   NUMBER(10) NOT NULL,
    cd_produto   NUMBER(10) NOT NULL,
    cd_video     NUMBER(5) NOT NULL,
    dt_hr_visual DATE NOT NULL,
    st_usuario   CHAR(1) NOT NULL
);

COMMENT ON COLUMN mc_visualizacao.cd_visual IS
    'Essa coluna armazena o c�digo de visualiza��o do v�deo no momento em que foi assistido por um usu�rio logado ou an�nimo.';

COMMENT ON COLUMN mc_visualizacao.nr_cliente IS
    'Essa coluna armazena o N�mero do Cliente que assistiu ao v�deo, se ele estava logado.';

COMMENT ON COLUMN mc_visualizacao.cd_produto IS
    'Essa coluna armazena o c�digo do produto a qual o a visualiza��o e o v�deo est�o relacionados.';

COMMENT ON COLUMN mc_visualizacao.cd_video IS
    'Essa coluna armazena o c�digo do v�deo a qual a visualiza��o pertence.';

COMMENT ON COLUMN mc_visualizacao.dt_hr_visual IS
    'Essa coluna armazena a data, hora, minuto e segundo em que o v�deo visualizado no formato dd-mm-yyyy hh:mm:ss.';

COMMENT ON COLUMN mc_visualizacao.st_usuario IS
    'Essa coluna armazena o status do usu�rio que visualizou o v�deo.';

ALTER TABLE mc_visualizacao ADD CONSTRAINT mc_visualizacao_pk PRIMARY KEY ( cd_visual,
                                                                            cd_produto );
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
    'Essa coluna ir� armazenar a chave prim�ria da tabela de visualiza��o do v�deo, onde a cada click que o usuario logado ou an�nimo realizar, ser� anotado o acesso realizado.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual ter� sempre o n�mero disponivel para uso.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.dt_visualizacao IS
    'Essa  coluna  ir�  receber a data da visualiza��o feita pelo  usu�rio no formato dd/mm/yyyy. Essa coluna � obrigat�ria.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_hora_visualizacao IS
    'Essa  coluna  ir�  receber o hor�rio no formato HH24 da visualiza��o feita pelo  usu�rio. Essa coluna � obrigat�ria.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_minuto_video IS
    'Essa  coluna  ir�  receber o hor�rio do minuto do v�deo quando foi feita a visualiza��o pelo  usu�rio. Essa coluna � obrigat�ria e os valores poss�veis est�o entre 00 e 59, representando os minutos.';

COMMENT ON COLUMN mc_sgv_visualizacao_video.nr_segundo_video IS
    'Essa  coluna  ir�  receber o hor�rio dos segundos do v�deo quando foi feita a visualiza��o pelo  usu�rio. Essa coluna � obrigat�ria e os valores poss�veis est�o entre 00 e 59, representando os minutos.';

ALTER TABLE mc_sgv_visualizacao_video ADD CONSTRAINT pk_mc_sgv_visualizacao_video PRIMARY KEY ( cd_visualizacao_video );

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
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.';

COMMENT ON COLUMN mc_sgv_produto_video.nr_sequencia IS
    'Essa coluna ir� armazenar a sequencia do v�deo a partir do codigo do produto. Sempre o primeiro v�deo de determinado  produto deve iniciar com o n�mero 1. Seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_sgv_produto_video.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria..';

COMMENT ON COLUMN mc_sgv_produto_video.vd_produto IS
    'Essa coluna ir� armazenar oo v�deo do produto no formato que melhor lhe  convier.  Para utilizar essa coluna tenha acesso a documenta��o oficial da Oracle. Seu conte�do � opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.tp_video_prod IS
    'Essa coluna ir� armazenar o tipo do  v�deo do produto. Seu conte�do � opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.ds_path_video_prod IS
    'Essa coluna ir� armazenar o caminho de acesso (link) contendo o  v�deo do produto. Seu conte�do � opcional.';

COMMENT ON COLUMN mc_sgv_produto_video.st_video_prod IS
    'Essa coluna ir� armazenar o stauts do v�deo do produto da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

ALTER TABLE mc_sgv_produto_video ADD CONSTRAINT pk_mc_produto_imagem PRIMARY KEY ( nr_sequencia,
                                                                                   cd_produto );
ALTER TABLE mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_categoria_video FOREIGN KEY ( cd_categoria )
        REFERENCES mc_categoria_prod ( cd_categoria );

ALTER TABLE mc_sgv_produto_video
    ADD CONSTRAINT fk_mc_produto_imagem FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto );

ALTER TABLE MC_SGV_PRODUTO_VIDEO ADD CONSTRAINT CK_MC_SGV_PRODUTO_VIDEO_ST_VIDEO CHECK ( ST_VIDEO_PROD IN ('A','I'));

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

ALTER TABLE mc_video
    ADD CONSTRAINT relation_20 FOREIGN KEY ( cd_class )
        REFERENCES mc_video_class ( cd_class );

ALTER TABLE mc_video_class
    ADD CONSTRAINT relation_20v1 FOREIGN KEY ( cd_produto )
        REFERENCES mc_video ( cd_produto );


-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             4
-- ALTER TABLE                             55
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
-- ERRORS                                   2
-- WARNINGS                                 1

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

----------------------------------------------------------

-- Carga Inicial dos dados
VARIABLE depto_id NUMBER; 
-- Setor DIRETORIA
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'DIRETORIA', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, NULL, 'Florinda Glup', 'PRESIDENTE', 54732, 
    TO_DATE('10102000','DDMMYYYY'), TO_DATE('13031960','DDMMYYYY'), 12345678901, '11987654321', 
    'florinda.glup@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Silvana Silva', 'CONSELHEIRA', 8498, 
    TO_DATE('18072008','DDMMYYYY'), TO_DATE('11051950','DDMMYYYY'), 23456789012, '11987651234', 
    'silvana.silva@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Thais Luppy', 'CONSELHEIRA', 8765, 
    TO_DATE('31032009','DDMMYYYY'), TO_DATE('21051980','DDMMYYYY'), 34567890123, '11987651235', 
    'thais.luppy@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Maria Linda Tunner', 'CONSELHEIRA', 8812, 
    TO_DATE('31031990','DDMMYYYY'), TO_DATE('27121997','DDMMYYYY'), 45678901234, '11987651236', 
    'maria.tunner@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Telma Reitzman', 'CONSELHEIRA', 8760, 
    TO_DATE('31082011','DDMMYYYY'), TO_DATE('26121997','DDMMYYYY'), 56789012345, '11987651237', 
    'telma.reitzman@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Vilma Dias', 'CONSELHEIRA', 8753, 
    TO_DATE('21072010','DDMMYYYY'), TO_DATE('25111997','DDMMYYYY'), 67890123456, '11987651238', 
    'vilma.dias@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Miriam Lee', 'CONSELHEIRA', 8761, 
    TO_DATE('14062011','DDMMYYYY'), TO_DATE('25012002','DDMMYYYY'), 78901234567, '11987651239', 
    'miriam.lee@email.com', 'F', 'A'
);
-- Setor PLANEJAMENTO ESTRATEGICO
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'PLANEJAMENTO ESTRATEGICO', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Alice Lopes', 'GERENTE PLANEJAMENTO ESTRATEGICO', 11433, 
    TO_DATE('18051991','DDMMYYYY'), TO_DATE('31072000','DDMMYYYY'), 19876543210, '11987651260', 
    'alice.lopes@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Margarida Figueira', 'COORDENADORA PLANEJAMENTO ESTRATEGICO', 9988, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('21041990','DDMMYYYY'), 29876543210, '11987651261', 
    'margarida.figueira@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Cintia Sousa', 'ANALISTA PLANEJAMENTO', 5600, 
    TO_DATE('23092009','DDMMYYYY'), TO_DATE('04051990','DDMMYYYY'), 39876543210, '11987651262', 
    'cintia.sousa@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Fernanda Yamaha', 'ANALISTA PLANEJAMENTO', 5800, 
    TO_DATE('20112006','DDMMYYYY'), TO_DATE('19111970','DDMMYYYY'), 49876543210, '11987651263', 
    'fernanda.yamaha@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Dinah Honda', 'ANALISTA PLANEJAMENTO', 6800, 
    TO_DATE('20111992','DDMMYYYY'), TO_DATE('11011992','DDMMYYYY'), 59876543210, '11987651264', 
    'dinah.honda@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC, DT_DESLIGAMENTO
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Samantha Vieira', 'ANALISTA PLANEJAMENTO', 6800, 
    TO_DATE('02101997','DDMMYYYY'), TO_DATE('13091994','DDMMYYYY'), 69876543210, '11987651265', 
    'samantha.vieira@email.com', 'F', 'I', TO_DATE('22122022','DDMMYYYY')
);
-- Setor QUALIDADE
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'QUALIDADE', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Nivia Maria Mello', 'ANALISTA QUALIDADE', 9700, 
    TO_DATE('17062006','DDMMYYYY'), TO_DATE('25031991','DDMMYYYY'), 30123456789, '11987651270', 
    'nivia.mello@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Noemia Lima', 'ANALISTA QUALIDADE', 9887, 
    TO_DATE('18092012','DDMMYYYY'), TO_DATE('16071992','DDMMYYYY'), 30223456789, '11987651271', 
    'noemia.lima@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Camila Limytz', 'ANALISTA QUALIDADE', 7543, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('12081998','DDMMYYYY'), 30323456789, '11987651272', 
    'camila.limytz@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Giovanna Potker', 'ANALISTA QUALIDADE', 6890, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('18071995','DDMMYYYY'), 30423456789, '11987651273', 
    'giovanna.potker@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Giulia Mendez', 'ANALISTA QUALIDADE', 8076, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('21061999','DDMMYYYY'), 30523456789, '11987651274', 
    'giulia.mendez@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Nice Faria', 'ANALISTA QUALIDADE', 8432, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('28081998','DDMMYYYY'), 30623456789, '11987651275', 
    'nice.faria@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Joelma Tutti', 'ANALISTA QUALIDADE', 8965, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('25091994','DDMMYYYY'), 30723456789, '11987651276', 
    'joelma.tutti@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Karen Kirk', 'ANALISTA QUALIDADE', 7431, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('05071995','DDMMYYYY'), 30823456789, '11987651277', 
    'karen.kirk@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Luisa Luppy', 'ANALISTA QUALIDADE', 7698, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('08031997','DDMMYYYY'), 30923456789, '11987651278', 
    'luisa.luppy@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Paula Grande', 'ANALISTA QUALIDADE', 8765, 
    TO_DATE('18052005','DDMMYYYY'), TO_DATE('22051993','DDMMYYYY'), 31023456789, '11987651279', 
    'paula.grande@email.com', 'F', 'A'
);
-- Setor COMERCIAL
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'COMERCIAL', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Maria Linda Lopes', 'Gerente Comercial', 7222, 
    TO_DATE('31032001','DDMMYYYY'), TO_DATE('30111983','DDMMYYYY'), 31123456789, '11987651280', 
    'maria.linda.lopes@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Luiza Zoop', 'Representante Comercial', 5783, 
    TO_DATE('28042002','DDMMYYYY'), TO_DATE('02101976','DDMMYYYY'), 31223456789, '11987651281', 
    'luiza.zoop@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Monica Brasil', 'Representante Comercial', 7430, 
    TO_DATE('16072002','DDMMYYYY'), TO_DATE('31121988','DDMMYYYY'), 31323456789, '11987651282', 
    'monica.brasil@email.com', 'F', 'A'
);
-- Setor CONTABILIDADE
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'CONTABILIDADE', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Tatiana Mussi', 'Gerente Contabil', 5499, 
    TO_DATE('31122001','DDMMYYYY'), TO_DATE('23061989','DDMMYYYY'), 31423456789, '11987651283', 
    'tatiana.mussi@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Adriana Pinheiro', 'Assistente Contabil', 3477, 
    TO_DATE('28042012','DDMMYYYY'), TO_DATE('01011987','DDMMYYYY'), 31523456789, '11987651284', 
    'adriana.pinheiro@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Monique Lara', 'Assistente Contabil', 3477, 
    TO_DATE('29082014','DDMMYYYY'), TO_DATE('12121993','DDMMYYYY'), 31623456789, '11987651285', 
    'monique.lara@email.com', 'F', 'A'
);
-- Setor ESTOQUE
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'ESTOQUE', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Alice Costa', 'Gerente Logistica', 6280, 
    TO_DATE('04112003','DDMMYYYY'), TO_DATE('22071993','DDMMYYYY'), 31723456789, '11987651286', 
    'alice.costa@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Flavia Junqueira', 'Analista Logistica', 4650, 
    TO_DATE('27072004','DDMMYYYY'), TO_DATE('08081994','DDMMYYYY'), 31823456789, '11987651287', 
    'flavia.junqueira@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Giovanna Lua', 'Assistente Logistica', 4650, 
    TO_DATE('23032016','DDMMYYYY'), TO_DATE('14011998','DDMMYYYY'), 31923456789, '11987651288', 
    'giovanna.lua@email.com', 'F', 'A'
);
-- Setor FINANCEIRO
-- Inserção no MC_DEPTO e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'FINANCEIRO', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Dolores Julio', 'Gerente Financeira', 8700, 
    TO_DATE('21122003','DDMMYYYY'), TO_DATE('21031989','DDMMYYYY'), 32023456789, '11987651289', 
    'dolores.julio@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Elisa Suhay', 'Analista Financeira', 4850, 
    TO_DATE('22022005','DDMMYYYY'), TO_DATE('03031998','DDMMYYYY'), 32123456789, '11987651290', 
    'elisa.suhay@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Fernanda Yamaha', 'Analista Financeira', 4850, 
    TO_DATE('29092009','DDMMYYYY'), TO_DATE('19051999','DDMMYYYY'), 32223456789, '11987651291', 
    'fernanda.yamaha@email.com', 'F', 'A'
);
-- Setor SAC
-- Inserção no MC_DEPTO para SAC e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'SAC (SERVICO DE ATENDIMENTO AO CLIENTE)', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Leonice Alvarez', 'Gerente SAC', 4912, 
    TO_DATE('31072002','DDMMYYYY'), TO_DATE('11011994','DDMMYYYY'), 32323456789, '11987651292', 
    'leonice.alvarez@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Beatriz Julio', 'Analista SAC', 2820, 
    TO_DATE('26062010','DDMMYYYY'), TO_DATE('05051999','DDMMYYYY'), 32423456789, '11987651293', 
    'beatriz.julio@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Vitoria Oliveira', 'Analista SAC', 2820, 
    TO_DATE('28082012','DDMMYYYY'), TO_DATE('13082000','DDMMYYYY'), 32523456789, '11987651294', 
    'vitoria.oliveira@email.com', 'F', 'A'
);

-- Setor Recursos Humanos (RH)
-- Inserção no MC_DEPTO para RH e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'RECURSOS HUMANOS (RH)', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Heloisa Suassana', 'Gerente RH', 7641, 
    TO_DATE('20092003','DDMMYYYY'), TO_DATE('19101995','DDMMYYYY'), 32623456789, '11987651295', 
    'heloisa.suassana@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-1, 'Juliana Flores', 'Analista RH', 3400, 
    TO_DATE('24042014','DDMMYYYY'), TO_DATE('09121996','DDMMYYYY'), 32723456789, '11987651296', 
    'juliana.flores@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, SQ_MC_FUNCIONARIO.CURRVAL-2, 'Karina Voltz', 'Analista RH', 3400, 
    TO_DATE('17092016','DDMMYYYY'), TO_DATE('05042002','DDMMYYYY'), 32823456789, '11987651297', 
    'karina.voltz@email.com', 'F', 'A'
);

-- Setor Logística
-- Inserção no MC_DEPTO para Logística e captura do CD_DEPTO gerado
INSERT INTO MC_DEPTO (CD_DEPTO, NM_DEPTO, ST_DEPTO)
VALUES (SQ_MC_DEPTO.NEXTVAL, 'LOGISTICA', 'A')
RETURNING CD_DEPTO INTO :depto_id;

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, NULL, 'Flor Deliz', 'Gerente Logistica', 7322, 
    TO_DATE('10102000','DDMMYYYY'), TO_DATE('13031960','DDMMYYYY'), 32923456789, '11987651298', 
    'flor.deliz@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Susy Pietro', 'Analista Logistica', 4600, 
    TO_DATE('18072008','DDMMYYYY'), TO_DATE('11051950','DDMMYYYY'), 33023456789, '11987651299', 
    'susy.pietro@email.com', 'F', 'A'
);

INSERT INTO MC_FUNCIONARIO(
    CD_FUNCIONARIO, CD_DEPTO, CD_GERENTE, NM_FUNCIONARIO, DS_CARGO, VL_SALARIO, 
    DT_CADASTRAMENTO, DT_NASCIMENTO, CPF_FUNCIONARIO, NR_TELEFONE_FUNC, DS_EMAIL, 
    FL_SEXO_BIOLOGICO, ST_FUNC
) VALUES (
    SQ_MC_FUNCIONARIO.NEXTVAL, :depto_id, 1, 'Thammy July', 'Analista Logistica', 4578, 
    TO_DATE('31032009','DDMMYYYY'), TO_DATE('21051980','DDMMYYYY'), 33123456789, '11987651300', 
    'thammy.july@email.com', 'F', 'A'
);
-- Este ultimo departamento esta como inativo e nao sera incorporado funcionarios dentro dele
INSERT INTO MC_DEPTO(CD_DEPTO, NM_DEPTO, ST_DEPTO) VALUES (SQ_MC_DEPTO.NEXTVAL, 'TECNOLOGIA DA INFORMAcaO (TI)', 'I');
-- Cadastro de Estados do Brasil
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
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RO', 'ROND�NIA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('RR', 'RORAIMA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SC', 'SANTA CATARIA');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SP', 'SaO PAULO');
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('SE', 'SERGIPE');  
INSERT INTO MC_ESTADO(SG_ESTADO, NM_ESTADO) VALUES ('TO', 'TOCANTINS');  

-- Cadastro de cidade, bairro e logradouro usando variáveis para captura dos IDs

-- 1o Estado: RS - Cidade: Porto Alegre
VARIABLE cidade_id NUMBER;
VARIABLE bairro_id NUMBER;

INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'RS', 'Porto Alegre', 4314902, 52)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'Arpoadouro', 'ZONA NORTE')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Wenceslau Escobar', '91900000');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida do Forte', '91360001');

-- 1o Estado: RS - Cidade: Caxias do Sul
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'RS', 'Caxias do Sul', 4305108, 54)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'Vila Zenai', 'ZONA LESTE')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Rua principal', '95010110');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Rua Dr. Oliveira', '95010876');

-- 2o Estado: SP - Cidade: Sao Paulo
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'SP', 'Sao Paulo', 35, 11)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CAMBUCI', 'ZONA SUL')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Lacerda Franco', '01536000');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Lins de Vasconcelos', '01536112');

-- 2o Estado: SP - Cidade: Atibaia
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'SP', 'Atibaia', 3504107, 11)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'Vila Zenai', 'ZONA LESTE')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Figueira Garden', '12940010');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Floriano Peixoto', '12940011');

-- 3o Estado: SC - Cidade: Florianopolis
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'SC', 'Florianopolis', 4205407, 48)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'ZONA SUL')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Principal', '88058300');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Presidente Jose Luiz', '88058310');

-- 3o Estado: SC - Cidade: Joinville
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'SC', 'JOINVILLE', 3504107, 11)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'CENTRO')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Paulo Shoreze', '89232302');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Cesar Claro', '89232302');

-- 4o Estado: BA - Cidade: Salvador
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'BA', 'SALVADOR', 2927408, 71)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'ZONA SUL')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Padre Otoloni', '40020901');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Maria Luiza', '40020901');

-- 4o Estado: BA - Cidade: Vitoria da Conquista
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'BA', 'Vitoria da Conquista', 2927412, 72)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'CENTRO')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Maria Vitoria', '40020931');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Carlos Klan', '40020921');

-- 5o Estado: CEARA - Cidade: Fortaleza
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'CE', 'FORTALEZA', 2304400, 85)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'CENTRO')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida do Calcadao', '60312060');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Avenida Capitao do Mar', '60312060');

-- 5o Estado: CEARA - Cidade: Juazeiro do Norte
INSERT INTO MC_CIDADE (CD_CIDADE, SG_ESTADO, NM_CIDADE, CD_IBGE, NR_DDD) 
VALUES (SQ_MC_CIDADE.NEXTVAL, 'CE', 'Juazeiro do Norte', 2304400, 86)
RETURNING CD_CIDADE INTO :cidade_id;

INSERT INTO MC_BAIRRO (CD_BAIRRO, CD_CIDADE, NM_BAIRRO, NM_ZONA_BAIRRO) 
VALUES (SQ_MC_BAIRRO.NEXTVAL, :cidade_id, 'CENTRO', 'CENTRO')
RETURNING CD_BAIRRO INTO :bairro_id;

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Monica Seles', '60312054');

INSERT INTO MC_LOGRADOURO (CD_LOGRADOURO, CD_BAIRRO, NM_LOGRADOURO, NR_CEP) 
VALUES (SQ_MC_LOGRADOURO.NEXTVAL, :bairro_id, 'Av. Michel Luiz', '60312054');

-- Cadastro de Endereço dos funcionários cadastrados

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


-- Cadastro de Clientes físicos

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'CAMILA LUCIO', 'A',  'CAMIS', 'CAMIS');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-15000, 'F', 13001023400);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SUELI THOMPSON', 'A',  'SUELI', 'SUELI');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-14678, 'F', 13209876522);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SUSI VEIGA', 'A',  'SUSI', 'SUSI');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-14990, 'F', 9876544212);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'SILMARA SANCY', 'A',  'SILMARA', 'SILMARA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-16789, 'F', 08765432122);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'MARA MARAVILHA', 'A',  'MARA', 'MARA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-17654, 'F', 98765632212);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'JULIANA VITAUSTAS', 'A',  'JULIANA', 'JULIANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-16545, 'F', 08765432144);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'JOANA MARTINS', 'A',  'JOANA', 'JOANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-19008, 'F', 08765434577);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'HELENA PILDAP', 'A',  'HELENA', 'HELENA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-19345, 'F', 09876543221);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'IVANA MARY', 'A',  'IVANA', 'IVANA');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-18761, 'F', 08309812312);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'KELLY DULIP', 'A',  'KELLY', 'KELLY');
INSERT INTO MC_CLI_FISICA(NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, NR_CPF)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-17890, 'F', 09308877654);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'IBM CONSULTORIA', 'A',  'IBM', 'IBM');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-42000, 02045677000121);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'MICROSOFT CONSULTORIA', 'A',  'MICROSOFT', 'MICROSOFT');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-28000, 03457000122);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'ORACLE CONSULTORIA', 'A',  'ORACLE', 'ORACLE');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-35000, 02248000155);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'AWS CONSULTORIA', 'A',  'AWS', 'AWS');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-12500, 04567000156);

INSERT INTO MC_CLIENTE(NR_CLIENTE, NM_CLIENTE, ST_CLIENTE, NM_LOGIN, DS_SENHA)
VALUES (SQ_MC_CLIENTE.NEXTVAL,'GCP CONSULTORIA', 'A',  'GCP', 'GCP');
INSERT INTO MC_CLI_JURIDICA(NR_CLIENTE, DT_FUNDACAO, NR_CNPJ)
VALUES (SQ_MC_CLIENTE.CURRVAL, SYSDATE-8000, 05867000132);

-- Cadastro de endereço de Clientes

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 1, 12, 23, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 2, 1, 31, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 3, 7, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 4, 5, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 5, 6, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 6, 8, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 7, 9, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 8, 3, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 9, 1, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 10, 12, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 11, 10, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 12, 14, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 13, 15, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 14, 18, 1, TO_DATE('12121997','DDMMYYYY'), 'A');

INSERT INTO MC_END_CLI(NR_CLIENTE, CD_LOGRADOURO, NR_END, DT_INICIO, ST_END)
VALUES( 15, 20, 1, TO_DATE('12121997','DDMMYYYY'), 'A');


-- Categoria dos produtos

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

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Instalacao do produto', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Uso no cotidiano', SYSDATE-22000, 'A' );

INSERT INTO MC_CATEGORIA_PROD(CD_CATEGORIA, TP_CATEGORIA, DS_CATEGORIA, DT_INICIO, ST_CATEGORIA)
VALUES (SQ_MC_CATEGORIA.NEXTVAL,'V', 'Comercial com personalidade', SYSDATE-22000, 'A' );

-- Cadastro de Produtos

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 1, 'Boneca de Pano LupaLupa', 55.52, 'A', 'Boneca de Pano especial feita a mao', 48);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 2, 'Fone ouvido Sony wifi', 132, 'A', 'Fone de ouvido top de mercado', 34);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 3, 'Jogo tabuleiro imagem  e acao', 220, 'A', 'famoso jogo de tabuleiro', 30);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 4, 'Celular Samsumg 20 geracao', 2134, 'A', 'Novo celular 3d samsumg',32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 5, 'Colchao Castor Molas King', 1456, 'A', 'Novo colchao molas king castor', 28);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Tenis Nike voador', 657, 'A', 'Tenis Nike para pratica esportiva',29);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Meia Mizuno 5 star', 54, 'A', 'meia mizuno 5 star', 60);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 6, 'Calcao banho marinho', 65, 'A', 'Calcao de banho para piscina na cor marinho', 32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Chave de Venda 15 opcoes', 45, 'A', 'Chave de fenda especial com15 opcoes de acesso ao parafuso', 32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Furadeira Marcenaria Profissional', 546, 'A', 'Furadeira Thompson de ultima geracao',33.9);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 7, 'Maleta com 150 chaves de boca', 499, 'A', 'Maleta contendo 150 chaves de boca dos  mais variados tipos',33.8);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 8, 'Jogo Game of Throne PS6', 389, 'A', 'O novo jogo do Game of Throne disponivel para uso asap',31);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Notebook core i7 16Gb Memoria Del 14 inspirion', 2640, 'A', 'Notebook Dell Inspirion ultima geracao pesando apenas 0,9kg',30);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Notebook core i5 16Gb Memoria Del 14 inspirion', 2340, 'A', 'Notebook Dell Inspirion ultima geracao pesando apenas 0,9kg', 32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 9, 'Mouse sem fio', 54, 'A', 'Mouse sem fio com conexao USB',33);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 10, 'Livro Viajando com a vida', 22, 'A', 'Livro que  explica a importancia de viver feliz',70);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 10, 'Livro conhecendo o futuro', 55, 'A', 'Livro que explica o sentido da vida',32);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 11, 'Coleira anti pulga cachorro pequeno', 67, 'A', 'Coleira antipulga para cachorro pequeno',22);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 11, 'Racao Royal Canin', 122, 'A', 'Racao especial Royal Canin',24);

INSERT INTO MC_PRODUTO (CD_PRODUTO, CD_CATEGORIA, DS_PRODUTO, VL_UNITARIO, ST_PRODUTO, DS_COMPLETA_PROD, VL_PERC_LUCRO)
VALUES(SQ_MC_PRODUTO.NEXTVAL, 12, 'Smart TV 60 polegadas', 2567, 'A', 'Melhor TV smart do mercado', 29);

-- Insere o video do produto

INSERT INTO MC_SGV_PRODUTO_VIDEO  (CD_PRODUTO, NR_SEQUENCIA, CD_CATEGORIA, TP_VIDEO_PROD, DS_PATH_VIDEO_PROD, ST_VIDEO_PROD) 
VALUES (10, 1, 14, 'DICA', '/video/video_12.mp4', 'A');

INSERT INTO MC_SGV_PRODUTO_VIDEO  (CD_PRODUTO, NR_SEQUENCIA, CD_CATEGORIA, TP_VIDEO_PROD, DS_PATH_VIDEO_PROD, ST_VIDEO_PROD) 
VALUES (15, 1, 15, 'DICA', '/video/video_15.mp4', 'A');

-- Insere a visualização do video

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

-- Insere e ajusta valores do SAC

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 5, 15, 7, 'Cliente nao consegue ativar o mouse', sysdate-1, 14, 'D', 'E');

UPDATE MC_SGV_SAC  SET DS_DETALHADA_RETORNO_SAC = 'O cliente revisitou os videos e refez a instalacao e agora esta tudo 100%',
DT_ATENDIMENTO = SYSDATE, HR_ATENDIMENTO_SAC = 2, NR_TEMPO_TOTAL_SAC = NR_TEMPO_TOTAL_SAC+2
WHERE NR_SAC = 1;


-- Assets Fase 4 (Ajustado)

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 3, 15, 2, 3,'Mouse n�o funciona corretamente!', sysdate-7, 12, 'D', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 4, 7, 3, 1,'A meia veio furada', sysdate-6, 15, 'D', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 3, 7, 1, 5, 'Foi enviado apenas um p� da meia', sysdate-5, 8, 'D', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 8, 2, 4, 7, 'O fone de ouvido funciona apenas em um orelha', sysdate-4, 7, 'D', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 6, 3, 2, 6,'O jogo imagem e a��o veio faltando pe�as', sysdate-3, 12, 'D', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 5, 8, 3, 9, 'O calcao deveria vir lacrado', sysdate-2, 20, 'S', 'E');

INSERT INTO MC_SGV_SAC(NR_SAC, NR_CLIENTE, CD_PRODUTO, CD_FUNCIONARIO, NR_INDICE_SATISFACAO, DS_DETALHADA_SAC, DT_ABERTURA_SAC, HR_ABERTURA_SAC, TP_SAC, ST_SAC)
VALUES (SQ_MC_SGV_SAC.NEXTVAL, 2, 6, 2, 9, 'A cor do tenis poderia ser mais brilhante', sysdate-1, 23, 'S', 'E');

-- Update nos endereços de Cliente e Funcionário
UPDATE MC_END_CLI  SET ST_END = 'I', DT_TERMINO = SYSDATE-1
WHERE NR_CLIENTE = 7  AND ROWNUM = 1;

UPDATE MC_END_FUNC  SET ST_END = 'I', DT_TERMINO = SYSDATE-1
WHERE CD_FUNCIONARIO = 11  AND ROWNUM = 1;

-- Criação de Procedure prc_mc_gera_indice_satisfacao_atd

create or replace procedure prc_mc_gera_indice_satisfacao_atd(p_nr_indice in number, p_ds_indice out varchar2) as
begin
	if p_nr_indice between 0 and 6 then
		p_ds_indice := 'Cliente detrator';
	elsif p_nr_indice between 7 and 8 then
		p_ds_indice := 'Cliente neutro';
	elsif p_nr_indice between 9 and 10 then
		p_ds_indice := 'Cliente promotor';
	else 
		p_ds_indice := '�ndice satisfa��o inv�lido';
	end if;
end;
/

-- Criação de tabela t_mc_aliquota_media_icms_estado
CREATE TABLE t_mc_aliquota_media_icms_estado (
    sg_estado VARCHAR2(2) PRIMARY KEY,  -- C�digo do estado (UF)
    vl_perc_aliquota_media NUMBER        -- Al�quota m�dia do ICMS
);

-- Insert na tabela t_mc_aliquota_media_icms_estado

INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('AC', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('AL', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('AM', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('AP', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('BA', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('CE', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('DF', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('ES', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('GO', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('MA', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('MG', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('MS', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('MT', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('PA', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('PB', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('PE', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('PI', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('PR', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('RJ', 19);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('RN', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('RO', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('RR', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('RS', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('SC', 17);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('SE', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('SP', 18);
INSERT INTO t_mc_aliquota_media_icms_estado (sg_estado, vl_perc_aliquota_media) VALUES ('TO', 17);

-- Cria a function fun_mc_gera_aliquota_media_icms_estado
create or replace function fun_mc_gera_aliquota_media_icms_estado(p_sg_estado in varchar) return number is 
v_vl_perc_aliquota_media number;
begin
	begin
		select 	vl_perc_aliquota_media
		into	v_vl_perc_aliquota_media
		from	t_mc_aliquota_media_icms_estado
        where   sg_estado = p_sg_estado;
	exception
		when others then
				v_vl_perc_aliquota_media := 00;
	end;
    return v_vl_perc_aliquota_media;
end;
/

-- Commita as transações

COMMIT;