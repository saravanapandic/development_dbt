use database SOURCE2;
use schema DEMO;

CREATE STAGE my_int_stage
  COPY_OPTIONS = (ON_ERROR='skip_file');
