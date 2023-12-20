{{
    config(
        materialized='incremental'
    )
}}
SELECT 
    $1::varchar as region, 
    sum($14)::float as total_profit 
FROM @sales_stage group by $1
