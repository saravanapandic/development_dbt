SELECT $1,$6,$8 FROM @sales_stage where cast($6 as date) > cast($8 as date)
