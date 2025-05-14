-- Resposta do Comando SQL item a)
SELECT 
cp.cd_categoria, 
cp.ds_categoria,
mp.cd_produto,
mp.ds_produto
FROM mc_categoria_prod cp
LEFT JOIN mc_produto mp ON mp.cd_categoria = cp.cd_categoria
ORDER BY 2,4 ASC;

-- Resposta do Comando SQL item b)
SELECT 
cf.nr_cliente,
cl.nm_cliente,
cl.ds_email,
cl.nr_telefone,
cl.nm_login,
to_char(cf.dt_nascimento, 'DD-MM-YYYY') AS dt_nascimento,
to_char(cf.dt_nascimento, 'Day') AS dia_da_semana,
trunc(MONTHS_BETWEEN(SYSDATE, cf.dt_nascimento) / 12) AS idade,
cf.fl_sexo_biologico,
cf.nr_cpf
FROM mc_cli_fisica cf
INNER JOIN mc_cliente cl ON cl.nr_cliente = cf.nr_cliente;

-- Resposta do Comando SQL item c) 
SELECT
mv.cd_produto,
mp.ds_produto,
mv.dt_hr_visual
FROM mc_visualizacao mv
LEFT JOIN mc_produto mp ON mp.cd_produto = mv.cd_produto
ORDER BY 3 DESC;