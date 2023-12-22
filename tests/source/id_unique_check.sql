{{
    config(
       database="DBT_GITHUB"
    )
}}
SELECT $7, COUNT($7) as counts FROM @DBT_GITHUB.SALES_DETAILS.SALES_STAGE group by $7 HAVING counts > 1;
