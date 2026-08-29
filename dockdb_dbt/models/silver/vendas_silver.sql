{{ config(
    materialized = 'table'
) }}

with bronze as (

    select *
    from {{ ref('vendas_bronze') }}

),

tratamento as (

    select
        id_pedido,
        id_cliente,
        data_pedido,

        upper(nullif(trim(uf), '')) as uf,

        upper(nullif(trim(cidade), '')) as cidade,

        nullif(trim(categoria_produto), '') as categoria_produto,

        id_produto,
        quantidade,
        preco_unitario,
        desconto_pct,
        valor_frete,
        valor_bruto,
        valor_total,

        nullif(trim(canal_venda), '') as canal_venda,

        nullif(trim(forma_pagamento), '') as forma_pagamento,

        nullif(trim(status_pedido), '') as status_pedido

    from bronze

)

select *
from tratamento
