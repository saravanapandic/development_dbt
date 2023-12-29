{{
    config(
       database="DBT_GITHUB",schema="sales_details"
    )
}}
SELECT $7, COUNT($7) as counts FROM @STAGE_DB.SALES_DETAILS.SALES_STAGE group by $7 HAVING counts > 1
