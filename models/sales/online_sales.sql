[4:24 PM] Saravanapandi C
{{
    config(
        materialized='incremental'
    )
}}
SELECT $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14 FROM @sales_stage WHERE $4 = 'Online'
