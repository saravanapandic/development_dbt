{{
    config(
        materialized='incremental',database="target_DB",unique_key = 'Products',schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}
SELECT 
    * 
FROM {{ ref('profit_by_product') }} 
