{{
    config(
        materialized='incremental',database="target_DB",unique_key = 'region',schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}
SELECT 
   * 
FROM {{ ref('profit_per_region') }} 
