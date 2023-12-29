{{
    config(
       database="STAGE_DB",schema="sales_details"
    )
}}
SELECT $1,$4 FROM @STAGE_DB.SALES_DETAILS.SALES_STAGE WHERE $4 NOT IN ('Online','Offline')
