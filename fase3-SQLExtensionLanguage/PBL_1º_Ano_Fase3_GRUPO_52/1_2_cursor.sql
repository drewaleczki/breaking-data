DECLARE
    -- Definindo o cursor para selecionar os dados conforme solicitado
    CURSOR sac_cursor IS
        SELECT
            sac.nr_sac,
            sac.dt_abertura_sac,
            sac.hr_abertura_sac,
            sac.tp_sac,
            produto.cd_produto,
            produto.ds_produto,
            produto.vl_unitario,
            produto.vl_perc_lucro,
            cliente.nr_cliente,
            cliente.nm_cliente,
            estado.sg_estado,
            estado.nm_estado
        FROM
            mc_sgv_sac sac
            JOIN mc_produto produto ON sac.cd_produto = produto.cd_produto
            JOIN mc_cliente cliente ON sac.nr_cliente = cliente.nr_cliente
            JOIN mc_end_cli endereco ON cliente.nr_cliente = endereco.nr_cliente
            JOIN mc_logradouro logradouro ON endereco.cd_logradouro = logradouro.cd_logradouro
            JOIN mc_bairro bairro ON logradouro.cd_bairro = bairro.cd_bairro
            JOIN mc_cidade cidade ON bairro.cd_cidade = cidade.cd_cidade
            JOIN mc_estado estado ON cidade.sg_estado = estado.sg_estado;

    -- Variáveis para armazenar os dados do cursor
    v_nr_sac NUMBER;
    v_dt_abertura_sac DATE;
    v_hr_abertura_sac NUMBER;
    v_tp_sac CHAR(1);
    v_cd_produto NUMBER;
    v_ds_produto VARCHAR2(80);
    v_vl_unitario NUMBER(8,2);
    v_vl_perc_lucro NUMBER(8,2);
    v_nr_cliente NUMBER;
    v_nm_cliente VARCHAR2(160);
    v_sg_estado CHAR(2);
    v_nm_estado VARCHAR2(30);

    -- Variáveis para armazenar as transformações
    v_vl_unitario_lucro_produto NUMBER(8,2);
    v_ds_tipo_classificacao_sac VARCHAR2(30);
    v_vl_icms_produto NUMBER(8,2) := NULL; -- Mantém-se vazia conforme instrução
BEGIN
    -- Abrindo o cursor
    OPEN sac_cursor;

    -- Loop para percorrer cada linha do cursor
    LOOP
        FETCH sac_cursor INTO
            v_nr_sac, v_dt_abertura_sac, v_hr_abertura_sac, v_tp_sac, v_cd_produto,
            v_ds_produto, v_vl_unitario, v_vl_perc_lucro, v_nr_cliente, v_nm_cliente,
            v_sg_estado, v_nm_estado;
        
        EXIT WHEN sac_cursor%NOTFOUND;

        -- Transformação do tipo do SAC
        IF v_tp_sac = 'S' THEN
            v_ds_tipo_classificacao_sac := 'SUGESTÃO';
        ELSIF v_tp_sac = 'D' THEN
            v_ds_tipo_classificacao_sac := 'DÚVIDA';
        ELSIF v_tp_sac = 'E' THEN
            v_ds_tipo_classificacao_sac := 'ELOGIO';
        ELSE
            v_ds_tipo_classificacao_sac := 'CLASSIFICAÇÃO INVÁLIDA';
        END IF;

        -- Cálculo do lucro unitário
        v_vl_unitario_lucro_produto := (v_vl_perc_lucro / 100) * v_vl_unitario;

        -- Inserindo os dados transformados na tabela de destino
        INSERT INTO mc_sgv_ocorrencia_sac (
            nr_ocorrencia_sac,
            dt_abertura_sac,
            hr_abertura_sac,
            ds_tipo_classificacao_sac,
            cd_produto,
            ds_produto,
            vl_unitario_produto,
            vl_unitario_lucro_produto,
            sg_estado,
            nm_estado,
            nr_cliente,
            nm_cliente,
            vl_icms_produto
        ) VALUES (
            v_nr_sac,
            v_dt_abertura_sac,
            v_hr_abertura_sac,
            v_ds_tipo_classificacao_sac,
            v_cd_produto,
            v_ds_produto,
            v_vl_unitario,
            v_vl_unitario_lucro_produto,
            v_sg_estado,
            v_nm_estado,
            v_nr_cliente,
            v_nm_cliente,
            v_vl_icms_produto
        );
    END LOOP;

    -- Fechando o cursor
    CLOSE sac_cursor;

    -- Commit das transações para confirmar as inserções
    COMMIT;
END;
/