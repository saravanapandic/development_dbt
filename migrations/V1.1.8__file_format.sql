use database Stage_DB;
use schema sales_details;
CREATE OR REPLACE FILE FORMAT schema_check
  TYPE = CSV
  SKIP_HEADER = 1;
