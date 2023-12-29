{{
    config(
        materialized='incremental',database="target_DB",unique_key = 'years',schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}

SELECT * FROM {{ ref('Yearwise_profit') }} 
