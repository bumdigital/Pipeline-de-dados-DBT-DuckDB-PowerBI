{{ config(
    materialized='table'
) }}

select distinct
    id_cliente

from {{ ref('vendas_silver') }}

where id_cliente is not null
