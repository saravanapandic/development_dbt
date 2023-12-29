SELECT $1,$6,$8 FROM @STAGE_DB.SALES_DETAILS.SALES_STAGE where cast($6 as date) > cast($8 as date)
