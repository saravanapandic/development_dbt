{{
    config(
        materialized='incremental'
    )
}}
SELECT $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$8-$6 as Date_difference FROM @sales_stage WHERE $4 = 'Offline'
