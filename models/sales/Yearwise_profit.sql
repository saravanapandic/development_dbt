{{
    config(
        materialized='incremental'
    )
}}

SELECT year(cast($8 as date)) as years,sum($14) as total_profit FROM @my_ext_stage group by years order by years
