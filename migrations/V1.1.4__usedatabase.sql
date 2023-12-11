use database ${{ secrets.SF_DATABASE }};

CREATE OR REPLACE FILE FORMAT my_csv_format
  TYPE = CSV
  SKIP_HEADER = 1;
