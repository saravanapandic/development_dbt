{{
    config(
        materialized='incremental',database="target_DB",unique_key = 'order_id',schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}
SELECT 
   * 
FROM {{ ref('offline_sales') }} 
