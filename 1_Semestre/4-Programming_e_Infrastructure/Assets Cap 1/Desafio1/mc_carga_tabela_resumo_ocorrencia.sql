set serveroutput on size 100000;

declare
/*----------------------------------------------------------------------------------
Objetivo     : Este bloco anonimo tem por objetivo cadastrar todos os chamados   
                feitos pelos clientes no SAC da empresa Melhores Compras.         
                As informações sobre essas ocorrências são processadas      		
                e transferidas para a tabela mc_sgv_ocorrencia_sac e a partir daí 
                fica disponível para uso da área de negócio						
Autor        : Oivlas Sakspildap                                                 
Data Criação : 18/04/2023                                                        
Parâmetro in : N/A                       										
Parametro out: N/A                       										
Data Ult Alt 		Autor 			Descrição				     				
-----------------	--------------	-------------------------------------------  
*/
cursor c_abertura_sac is
select 	s.nr_sac,
		s.dt_abertura_sac,
		s.hr_abertura_sac,
        s.tp_sac,
        s.nr_indice_satisfacao,
        s.cd_produto,
        p.ds_produto,
        p.vl_unitario vl_unitario_prod,
        p.vl_perc_lucro,
        s.nr_cliente,
        c.nm_cliente
from	mc_sgv_sac s inner join mc_produto p 
on (s.cd_produto = p.cd_produto) inner join mc_cliente c
on (s.nr_cliente = c.nr_cliente);

r_cursor_sac c_abertura_sac%rowtype;

v_ds_tipo_classificacao_sac 	mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac%type;
v_ds_indice_satisfacao_atd_sac 	mc_sgv_ocorrencia_sac.ds_indice_satisfacao_atd_sac%type;
v_vl_unitario_lucro_produto     mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto%type;
v_vl_icms_produto               mc_sgv_ocorrencia_sac.vl_icms_produto%type;
v_sg_estado                     mc_estado.sg_estado%type;
v_nm_estado                     mc_estado.nm_estado%type;
v_nr_ocorrencia_sac             number;

begin

	--
	-- Antes de iniciar o processamento, eliminamos todas as linhas da tabela resumo ocorrencia SAC
	--
	execute immediate 'truncate table mc_sgv_ocorrencia_sac';
	
	open c_abertura_sac;
	loop
		fetch c_abertura_sac into r_cursor_sac;

		if c_abertura_sac%notfound then
			exit;
		end if;

		if r_cursor_sac.tp_sac = 'D' then
			v_ds_tipo_classificacao_sac := 'DUVIDA';
		elsif r_cursor_sac.tp_sac = 'S' then
			v_ds_tipo_classificacao_sac := 'SUGESTAO';
		end if;

        prc_mc_gera_indice_satisfacao_atd(r_cursor_sac.nr_indice_satisfacao, v_ds_indice_satisfacao_atd_sac);

        v_vl_unitario_lucro_produto :=  r_cursor_sac.vl_unitario_prod - (r_cursor_sac.vl_unitario_prod * (r_cursor_sac.vl_perc_lucro/100));

        --
        -- Após definição da regra de negócio, selecionamos apenas um dos endereços
        -- do cliente. Assim é possível ter em mãos o Estado (sigla e nome)
        --
  
        begin
            select 	cid.sg_estado, est.nm_estado
            into	v_sg_estado, v_nm_estado
            from mc_estado est inner join mc_cidade cid 
            on (cid.sg_estado = est.sg_estado) inner join mc_bairro b
            on (b.cd_cidade = cid.cd_cidade) inner join mc_logradouro l
            on (l.cd_bairro = b.cd_bairro) inner join mc_end_cli ec
            on (l.cd_logradouro = ec.cd_logradouro_cli)
            where ec.nr_cliente = r_cursor_sac.nr_cliente and rownum < 2;
        exception
            -- caso não encontre um endereço para o cliente, limpe os dados referente ao Estado
            when no_data_found then
                v_sg_estado := '';
                v_nm_estado := '';
        end;
        --
        -- Calcula o valor do icms do produto
        --
        v_vl_icms_produto := fun_mc_gera_aliquota_media_icms_estado(v_sg_estado);
        
        --
        -- De posse de todas as variáveis, cadastramos os dados na tabela consolidada
        --
        
        --
        -- Selecionamos o próximo valor disponível para o número da ocorrência
        --
        select  nvl(max(nr_ocorrencia_sac),0)+1
        into    v_nr_ocorrencia_sac
        from    mc_sgv_ocorrencia_sac;
        
        begin
            insert into mc_sgv_ocorrencia_sac(
            nr_ocorrencia_sac, 
            dt_abertura_sac, 
            hr_abertura_sac, 
            ds_tipo_classificacao_sac,
            ds_indice_satisfacao_atd_sac, 
            cd_produto, 
            ds_produto, 
            vl_unitario_produto, 
            vl_perc_lucro, 
            vl_unitario_lucro_produto, 
            sg_estado, 
            nm_estado,
            nr_cliente, 
            nm_cliente, 
            vl_icms_produto)
            values
            (
            v_nr_ocorrencia_sac,
            r_cursor_sac.dt_abertura_sac,
            r_cursor_sac.hr_abertura_sac,
            v_ds_tipo_classificacao_sac,
            v_ds_indice_satisfacao_atd_sac,
            r_cursor_sac.cd_produto,
            r_cursor_sac.ds_produto,
            r_cursor_sac.vl_unitario_prod,
            r_cursor_sac.vl_perc_lucro,
            v_vl_unitario_lucro_produto,
            v_sg_estado,
            v_nm_estado,
            r_cursor_sac.nr_cliente,
            r_cursor_sac.nm_cliente,
            v_vl_icms_produto            
            );
        exception
            when others then
                raise_application_error( -20222, 'Erro crítico !' || SQLErrM);
        end;

	end loop;
    
    --
    -- Após o processamento, confirmação das transações pendentes
    --
	commit;
    close c_abertura_sac;
    
	--
	-- Emite mensagem de conclusão do processamento
	--
	dbms_output.put_line('Processamento concluido com sucesso!' );
	
end;
/
