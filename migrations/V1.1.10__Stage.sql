use database Stage_DB;
use schema sales_details;

CREATE OR REPLACE FILE FORMAT Stage_DB.sales_details.my_csv_format
  TYPE = CSV
  SKIP_HEADER = 1;

CREATE OR REPLACE STAGE STAGE_DB.SALES_DETAILS.sales_stage
  URL='azure://azurestoragedbt.blob.core.windows.net/source/sales_record'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;
CREATE OR REPLACE FILE FORMAT Stage_DB.Public.my_csv_format
  TYPE = CSV
  SKIP_HEADER = 1;
