{{
    config(
        materialized='incremental',database='STAGE_DB',schema='SALES_DETAILS',unique_key = 'order_id',incremental_strategy = 'merge',merge_update_columns = ['order_id']
    )
}}
SELECT 
    $1::varchar as region, 
    sum($14)::float as total_profit 
FROM @sales_stage group by $1
