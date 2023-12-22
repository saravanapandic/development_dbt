{{
    config(
        materialized='incremental',database='DBT_GITHUB'
    )
}}
   
SELECT year(cast($8 as date)) as years,sum($14) as total_profit FROM @sales_stage group by years order by years
