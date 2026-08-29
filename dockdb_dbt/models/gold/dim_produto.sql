{{ config(
    materialized='table'
) }}

select distinct
    id_produto

from {{ ref('vendas_silver') }}

where id_produto is not null
