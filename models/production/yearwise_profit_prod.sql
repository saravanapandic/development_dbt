{{
    config(
        materialized='incremental',database="production_dbt"
    )
}}

SELECT * FROM {{ ref('Yearwise_profit') }} 
