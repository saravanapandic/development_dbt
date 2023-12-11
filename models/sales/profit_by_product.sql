{{
    config(
        materialized='incremental'
    )
}}
SELECT $3 as Products,sum($14) as Total_profit FROM @sales_stage group by $3
