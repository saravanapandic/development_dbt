{{
    config(
        materialized='incremental',database="target_DB",schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}
SELECT 
   * 
FROM {{ ref('offline_sales') }} 
