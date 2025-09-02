# Dicionário de Dados — Data Mart de Estoque (Melhores Compras)

## Convenções
- **Grão da fato:** 1 linha por **Produto × Centro de Distribuição × Data** (promoção opcional).
- **SK** = Surrogate Key (chave técnica do DW).
- **Obrig.**: S (Sim) / N (Não).

---

## Tabela: `FATO_ESTOQUE`
**Descrição:** Medidas de estoque por produto, CD e data (com possibilidade de análise por promoção).  
**PK:** `sk_fato_estoque`  
**FKs:** `sk_produto → dim_produto(sk_produto)`; `sk_centro_distribuicao → dim_centro_distribuicao(sk_centro_distribuicao)`; `sk_tempo → dim_tempo(sk_tempo)`; `sk_promocao → dim_promocoes(sk_promocao)`.

| Coluna | Tipo | Obrig. | Descrição |
|---|---|---:|---|
| sk_fato_estoque | NUMBER(12) | S | Surrogate key da linha da fato. |
| sk_produto | NUMBER(5) | S | FK para dimensão de produto. |
| sk_centro_distribuicao | NUMBER(10) | S | FK para dimensão de centro de distribuição. |
| sk_tempo | NUMBER(10) | S | FK para dimensão de tempo. |
| sk_promocao | NUMBER(10) | N | FK para dimensão de promoções (quando aplicável). |
| qt_estoque_atual | NUMBER(10,2) | N | Quantidade em estoque na data. |
| qt_estoque_minimo | NUMBER(10,2) | N | Quantidade mínima definida. |
| vl_unitario | NUMBER(12,2) | N | Preço unitário vigente (snapshot). |
| vl_estoque | NUMBER(15,2) | N | Valor em estoque (qt_estoque_atual × vl_unitario). |
| qt_vendida | NUMBER(12,2) | N | Quantidade vendida no período (se integrado). |
| dt_carga | DATE | S | Data/hora de carga no DW (controle). |

---

## Tabela: `DIM_PRODUTO`
**Descrição:** Atributos descritivos do produto (SCD2 recomendada).  
**PK:** `sk_produto`

| Coluna | Tipo | Obrig. | Descrição |
|---|---|---:|---|
| sk_produto | NUMBER(5/10) | S | Surrogate key do produto. |
| cd_produto_oltp | NUMBER(10) | S | Chave natural na fonte (OLTP). |
| nm_produto | VARCHAR2(80) | S | Nome do produto. |
| sku | VARCHAR2(40) | N | SKU do produto. |
| marca | VARCHAR2(60) | N | Marca do produto. |
| cor | VARCHAR2(40) | N | Cor. |
| dimensoes_fisicas | VARCHAR2(120) | N | Ex.: L×A×P (formato definido pelo grupo). |
| categoria | VARCHAR2(100) | S | Categoria do produto. |
| subcategoria | VARCHAR2(100) | S | Subcategoria do produto. |
| prioridade_abastecimento | VARCHAR2(10) | N | Alta/Média/Baixa (prioridade de reposição). |
| st_produto | CHAR(1) | N | Status (ex.: A/I). |
| dt_inicio | DATE | S | Início da vigência do registro (SCD2). |
| dt_fim | DATE | N | Fim da vigência do registro (SCD2). |
| fl_atual | CHAR(1) | S | Flag do registro atual (S/N). |

---

## Tabela: `DIM_CENTRO_DISTRIBUICAO`
**Descrição:** Centros de distribuição e sua localização/capacidade.  
**PK:** `sk_centro_distribuicao`

| Coluna | Tipo | Obrig. | Descrição |
|---|---|---:|---|
| sk_centro_distribuicao | NUMBER(10) | S | Surrogate key do CD. |
| nr_loja_oltp | NUMBER(5) | S | Chave natural do CD (OLTP). |
| nm_loja | VARCHAR2(100) | S | Nome do centro de distribuição/loja. |
| estado | CHAR(2) | S | UF do CD. |
| cidade | VARCHAR2(60) | S | Cidade do CD. |
| bairro | VARCHAR2(45) | N | Bairro do CD. |
| cap_armazenamento | NUMBER(12,2) | N | Capacidade de armazenamento (unidade definida pelo grupo). |

---

## Tabela: `DIM_TEMPO`
**Descrição:** Calendário para análises temporais.  
**PK:** `sk_tempo`

| Coluna | Tipo | Obrig. | Descrição |
|---|---|---:|---|
| sk_tempo | NUMBER(10) | S | Surrogate key da data. |
| data | DATE | S | Data calendário (YYYY-MM-DD). |
| ano | NUMBER(4) | S | Ano (YYYY). |
| semestre | NUMBER(1) | S | 1 ou 2. |
| trimestre | NUMBER(1) | S | 1 a 4. |
| mes | NUMBER(2) | S | 1 a 12. |
| mes_nome | VARCHAR2(15) | N | Nome do mês (pt-BR). |
| dia | NUMBER(2) | S | 1 a 31. |
| dia_semana | VARCHAR2(12) | S | Dia da semana por extenso. |
| feriado_nacional | CHAR(1) | N | S/N (marcação própria). |

---

## Tabela: `DIM_PROMOCOES`
**Descrição:** Promoções ativas que podem impactar estoque/vendas.  
**PK:** `sk_promocao`

| Coluna | Tipo | Obrig. | Descrição |
|---|---|---:|---|
| sk_promocao | NUMBER(10) | S | Surrogate key da promoção. |
| nr_promocao_oltp | NUMBER | S | Chave natural (OLTP). |
| ds_promocao | VARCHAR2(100) | S | Descrição da promoção. |
| dt_inicio | DATE | S | Data de início. |
| dt_termino | DATE | S | Data de término. |
| st_promocao | CHAR(1) | N | Status da promoção (ex.: A/I). |

---

## Observações
- **Produtos abaixo do estoque mínimo:** compare `qt_estoque_atual` vs `qt_estoque_minimo`, por **CD** e **tempo**.  
- **Rotatividade:** calcule via `qt_vendida` no período / estoque médio.  
- **Valor de estoque por Estado/Cidade/Bairro:** use `vl_estoque` com `dim_centro_distribuicao`.  
- **Impacto de promoções:** utilize `sk_promocao` e faixas de `dt_inicio/dt_termino`.  
