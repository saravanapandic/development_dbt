{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}
SELECT 
    $1::varchar as region, 
    sum($14)::float as total_profit 
FROM {{ ref('profit_per_region') }} group by $1
