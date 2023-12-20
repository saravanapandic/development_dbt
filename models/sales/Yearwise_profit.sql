{{
    config(
        materialized='incremental'
    )
}}

SELECT 
    year(cast($8 as date))::number as years,
    sum($14) as total_profit::float
FROM @sales_stage group by years order by years
