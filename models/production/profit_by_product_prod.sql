{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}
SELECT 
    * 
FROM {{ ref('profit_by_product') }} 
