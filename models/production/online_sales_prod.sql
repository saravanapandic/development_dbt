{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}
SELECT 
    * 
FROM {{ ref('online_sales') }} 
