{{
    config(
        materialized='incremental'
    )
}}
SELECT $1 as Region,$2 as Country,$3 as Item_type, $4 as Sales_type ,$5 as Order_priority, $6 as Order_date,$7 as order_id,$8 as Ship_date ,$9 as units_sold,$10 as units_price, $11 as unit_cost,$12 as total revenue,$13  as total_cost,$14 as total_profit,$8-$6 as Date_difference FROM @sales_stage WHERE $4 = 'Online'
