{{ config(
    materialized='table'
) }}

select distinct
    uf,
    cidade

from {{ ref('vendas_silver') }}

where uf is not null
  and cidade is not null
