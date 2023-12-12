use database {{ env_var('SF_DATABASE')}};

create schema SALES_DETAILS;

use schema SALES_DETAILS;

CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = CSV
  SKIP_HEADER = 1;

CREATE OR REPLACE STAGE sales_stage
  URL='azure://swethastorageaccount.blob.core.windows.net/csv'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;

use schema PUBLIC;

CREATE OR REPLACE STAGE sales_stage
  URL='azure://swethastorageaccount.blob.core.windows.net/csv'
  STORAGE_INTEGRATION = azure_integration
  FILE_FORMAT= my_csv_format;
