{{ config(
    materialized='table'
) }}

select
    -- Identificador do evento
    id_pedido,

    -- Chaves das dimensões
    id_cliente,
    id_produto,
    categoria_produto,
    uf,
    cidade,
    data_pedido,

    -- Medidas
    quantidade,
    preco_unitario,
    desconto_pct,
    valor_frete,
    valor_bruto,
    valor_total,

    -- Atributos do pedido
    canal_venda,
    forma_pagamento,
    status_pedido

from {{ ref('vendas_silver') }}

where id_pedido is not null
