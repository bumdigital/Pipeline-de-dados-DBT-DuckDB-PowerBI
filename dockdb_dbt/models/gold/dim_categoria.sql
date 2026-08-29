{{ config(
    materialized='table'
) }}

select distinct
    categoria_produto

from {{ ref('vendas_silver') }}

where categoria_produto is not null