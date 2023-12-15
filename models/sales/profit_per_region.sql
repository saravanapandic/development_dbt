{{
    config(
        materialized='incremental'
    )
}}
SELECT $1 as region, sum($14) as total_profit FROM @sales_stage group by $1
