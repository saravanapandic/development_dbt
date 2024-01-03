CREATE OR REPLACE STAGE sales_stage
  URL='azure://azurestoragedbt.blob.core.windows.net/source/sales_record'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;
