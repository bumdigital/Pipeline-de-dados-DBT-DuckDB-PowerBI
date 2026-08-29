{{ config(
    materialized='table'
) }}

select distinct
    data_pedido,
    extract(year from data_pedido) as ano,
    extract(month from data_pedido) as mes,
    extract(quarter from data_pedido) as trimestre

from {{ ref('vendas_silver') }}

where data_pedido is not null