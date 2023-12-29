{{
    config(
        materialized='incremental',database='STAGE_DB',unique_key = 'years',schema='SALES_DETAILS',incremental_strategy = 'merge',merge_update_columns = ['total_profit']
    )
}}
    
SELECT year(cast($8 as date)) as years,sum($14) as total_profit FROM @sales_stage group by years order by years
