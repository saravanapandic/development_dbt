{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}
SELECT 
   * 
FROM {{ ref('offline_sales') }} 
