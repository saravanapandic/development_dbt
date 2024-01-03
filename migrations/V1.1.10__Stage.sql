use database Stage_DB;
use schema sales_details;

CREATE OR REPLACE STAGE STAGE_DB.SALES_DETAILS.sales_stage
  URL='azure://azurestoragedbt.blob.core.windows.net/source/sales_record'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;
