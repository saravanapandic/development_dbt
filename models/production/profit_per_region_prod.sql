{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}
SELECT 
   * 
FROM {{ ref('profit_per_region') }} 
