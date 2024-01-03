use database Stage_DB;
use schema sales_details;
--------------------------------------------------------------------------------------
CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = CSV
  SKIP_HEADER = 1;
--------------------------------------------------------------------------------------
CREATE OR REPLACE STAGE sales_stages
  URL='azure://azurestoragedbt.blob.core.windows.net/source/sales_record'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;