{{
    config(
        materialized='incremental'
    )
}}
SELECT $3 as Products,sum($9) as units_sold,$11 as Cost_Price, $10 as selling_price,sum($12) as Total_revenue, sum($14) as Total_profit FROM @sales_stage group by $3,$11,$10
