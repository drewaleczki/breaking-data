------ DML

---- Popular dados:

-- a) Checar se os dois clientes cadastrados tem endereço cadastrado
-- Ambos tem endereço cadastrado
select 
mc.nr_cliente, 
mc.nm_cliente,
case when mcf.nr_cliente is not null then 'PF' else 'PJ' end as tp_cliente,
mec.cd_logradouro,
ml.nr_cep,
ml.nm_logradouro,
ml.cd_bairro,
mb.nm_bairro,
mb.cd_cidade,
mci.nm_cidade,
mci.sg_estado,
mes.nm_estado
from mc_cliente mc
left join mc_cli_fisica mcf on mcf.nr_cliente = mc.nr_cliente
left join mc_cli_juridica mcj on mcj.nr_cliente = mc.nr_cliente
left join mc_end_cli mec on mec.nr_cliente = mc.nr_cliente
left join mc_logradouro ml on ml.cd_logradouro = mec.cd_logradouro
left join mc_bairro mb on mb.cd_bairro = ml.cd_bairro
left join mc_cidade mci on mci.cd_cidade = mb.cd_cidade
left join mc_estado mes on mes.sg_estado = mci.sg_estado;

-- b) Inserir um funcionário em um ID já preenchido
--recebemos o erro: ORA-00001: restrição exclusiva (RM559685.MC_CLI_FISICA_PK) violada, ou seja não é possivel de adicionar sobre um ID já existente

INSERT INTO MC_CLIENTE (NM_CLIENTE, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) VALUES('Pedro Ronaldo', 'A', 'cr8@mc.com', null, 'cr8', 'camisa8');
INSERT INTO MC_CLI_FISICA (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF) VALUES (1, TO_DATE ('02-05-1988', 'DD-MM-YYYY'), 'M', null, '888.888.888-88');

---- Alterar Dados:
-- c) Ajustar salário
UPDATE mc_funcionario
SET vl_salario = vl_salario + vl_salario * 0.12
WHERE cd_funcionario = 1;
-- Salario original ID 1: 11983
-- Salario atualizado ID 1: 13420,96

-- d) Ajustar informação
update mc_end_cli
set st_end = 'I'
where nr_cliente = 1;

update mc_end_cli
set dt_termino = TO_DATE('14-10-2024', 'DD-MM-YYYY')
where nr_cliente = 1;

-- e) Eliminar estado de uma cidade
delete from mc_estado where sg_estado = 'MG'
--Relatório de erros -
--ORA-02292: restrição de integridade (RM559685.FK_MC_ESTADO) violada - registro filho localizado

-- f) Update no status do produto:
update mc_produto
set ST_PRODUTO = 'X'
where cd_produto = 1;
--Relatório de erros -
--ORA-02290: restrição de verificação (RM559685._CK_VL_STS_PRODUTO) violada

---- 1.3 Segundo Desafio da fase: Comandos DQL (Data Query Language)

-- a) categorias de produto e respectivos produtos de cada categoria
select 
cp.cd_categoria, 
cp.ds_categoria,
mp.cd_produto,
mp.ds_produto
from mc_categoria_prod cp
left join mc_produto mp on mp.cd_categoria = cp.cd_categoria
order by 2,4 asc -- Podemos usar a numeração da coluna ao invés do nome
;

-- b) dados dos clientes pessoas físicas.
select 
cf.nr_cliente,
cl.nm_cliente,
cl.ds_email,
cl.nr_telefone,
cl.nm_login,
to_char(cf.dt_nascimento, 'DD-MM-YYYY') as dt_nascimento,
to_char(cf.dt_nascimento, 'Day') as dia_da_semana,
trunc(MONTHS_BETWEEN(sysdate, cf.dt_nascimento) / 12) as idade,
cf.fl_sexo_biologico,
cf.nr_cpf
from mc_cli_fisica cf
inner join mc_cliente cl on cl.nr_cliente = cf.nr_cliente;

-- c) Exibição das visualizações
select
mv.cd_produto,
mp.ds_produto,
mv.dt_hr_visual
from mc_visualizacao mv
left join mc_produto mp on mp.cd_produto = mv.cd_produto
order by 3 desc;

