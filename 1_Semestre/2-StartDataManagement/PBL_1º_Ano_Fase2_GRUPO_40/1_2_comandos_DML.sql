-- Resposta do Comando SQL item a)
INSERT INTO MC_CLIENTE (NM_CLIENTE, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) VALUES('Cristiano Ronaldo', 'A', 'cr7@mc.com', null, 'cr7', 'camisa7');
INSERT INTO MC_CLI_FISICA (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF) VALUES (1, TO_DATE ('05-02-1985', 'DD-MM-YYYY'), 'M', null, '777.777.777-77');
INSERT INTO MC_CLIENTE (NM_CLIENTE, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) VALUES('Al-Nassr', 'A', 'alnassr@mc.com', null, 'alnassr', 'arabia');
INSERT INTO MC_CLI_JURIDICA (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST) VALUES (2, TO_DATE ('24-10-1955', 'DD-MM-YYYY'), '23.132.654/0001-07', null);
INSERT INTO MC_END_CLI (NR_CLIENTE,CD_LOGRADOURO,NR_END,DS_COMPLEMENTO_END,DT_INICIO,DT_TERMINO,ST_END) VALUES (1,1,180,'Apto 101',TO_DATE('01-01-2024', 'DD-MM-YYYY'),null,'A');
INSERT INTO MC_END_CLI (NR_CLIENTE,CD_LOGRADOURO,NR_END,DS_COMPLEMENTO_END,DT_INICIO,DT_TERMINO,ST_END) VALUES (2,3,1000,'Galpão 231 - Bloco C',TO_DATE('15-03-2023', 'DD-MM-YYYY'),null,'A');
-- Dados inseridos conforme as exigencias.

-- Resposta do Comando SQL item b)
INSERT INTO MC_CLIENTE (NM_CLIENTE, ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA) VALUES('Pedro Ronaldo', 'A', 'cr8@mc.com', null, 'cr8', 'camisa8');
INSERT INTO MC_CLI_FISICA (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF) VALUES (1, TO_DATE ('02-05-1988', 'DD-MM-YYYY'), 'M', null, '888.888.888-88');
-- Recebemos o erro: ORA-00001: restrição exclusiva (RM559685.MC_CLI_FISICA_PK) violada, ou seja não é possivel de adicionar dados sobre um ID já existente.

-- Resposta do Comando SQL item c)
UPDATE mc_funcionario
SET vl_salario = vl_salario + vl_salario * 0.12
WHERE cd_funcionario = 1;
-- Aqui o salário Original é de 11.983, após o UPDATE o salário passará a ser de 13.420,96.

-- Resposta do comando SQL item d)
UPDATE mc_end_cli
SET st_end = 'I'
WHERE nr_cliente = 1;

UPDATE mc_end_cli
SET dt_termino = TO_DATE('14-10-2024', 'DD-MM-YYYY')
WHERE nr_cliente = 1;
-- Dados alterados conforme as exigencias.

-- Resposta do comando SQL item e)
DELETE FROM mc_estado WHERE sg_estado = 'MG';
-- Recebemos o erro ORA-02292: restrição de integridade (RM559685.FK_MC_ESTADO) violada - registro filho localizado, que impede que o registro seja deletado por conta da depedencia superior.

-- Resposta do comando SQL item f)
UPDATE mc_produto
SET st_produto = 'X'
WHERE cd_produto = 1; 
-- Recebemos o erro ORA-02290: restrição de verificação (RM559685._CK_VL_STS_PRODUTO) violada que garante que os únicos conteúdos da coluna sejam 'A' e 'I'