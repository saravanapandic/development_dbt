SELECT $7, COUNT($7) as counts FROM @sales_stage group by $7 HAVING counts > 1
