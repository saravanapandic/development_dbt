{{
    config(
        materialized='incremental',database='STAGE_DB',schema='SALES_DETAILS',incremental_strategy = 'merge'
    )
}}
SELECT 
    $3::varchar as Products,
    sum($9)::number as units_sold,
    $11::float as Cost_Price,
    $10::float as selling_price,
    sum($12)::float as Total_revenue, 
    sum($14)::float as Total_profit 
FROM @sales_stage group by $3,$11,$10
