{{
    config(
       database="STAGE_DB",schema="sales_details"
    )
}}
SELECT $1,$9,$10,$11,$12,$13,$14 FROM @STAGE_DB.SALES_DETAILS.SALES_STAGE WHERE $9 < 0 OR $10 < 0 OR $11 < 0 OR $12 < 0 OR $13 < 0 OR $14 < 0
