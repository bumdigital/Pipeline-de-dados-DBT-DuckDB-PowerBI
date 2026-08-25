{{ config(
    materialized='table'
) }}

select *
from read_csv(
    'data/raw/base_vendas_dbt_duckdb_100k.csv',
    header = true,
    columns = {
        'id_pedido': 'BIGINT',
        'id_cliente': 'BIGINT',
        'data_pedido': 'DATE',
        'uf': 'VARCHAR',
        'cidade': 'VARCHAR',
        'categoria_produto': 'VARCHAR',
        'id_produto': 'BIGINT',
        'quantidade': 'BIGINT',
        'preco_unitario': 'DOUBLE',
        'desconto_pct': 'DOUBLE',
        'valor_frete': 'DOUBLE',
        'valor_bruto': 'DOUBLE',
        'valor_total': 'DOUBLE',
        'canal_venda': 'VARCHAR',
        'forma_pagamento': 'VARCHAR',
        'status_pedido': 'VARCHAR'
    }
)
