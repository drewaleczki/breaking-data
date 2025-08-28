-- Quantidade de SAC por Categoria

SELECT
cp.ds_categoria AS categoria,
count(sac.nr_sac) AS chamados
FROM mc_categoria_prod cp
LEFT JOIN mc_produto pr ON pr.cd_categoria = cp.cd_categoria
LEFT JOIN mc_sgv_sac sac ON sac.cd_produto = pr.cd_produto
GROUP BY cp.ds_categoria;

