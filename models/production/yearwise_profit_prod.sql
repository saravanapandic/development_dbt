{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}

SELECT year(cast($8 as date)) as years,sum($14) as total_profit FROM @sales_stage group by years order by years
