use database SOURCE2;
use schema PUBLIC;

CREATE STAGE my_int_stage
  COPY_OPTIONS = (ON_ERROR='skip_file');
