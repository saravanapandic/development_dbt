{{
    config(
        materialized='incremental',database="production_dbt",schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}

SELECT * FROM {{ ref('Yearwise_profit') }} 
