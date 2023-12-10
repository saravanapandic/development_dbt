create or replace PROCEDURE Details(id float)
RETURNS table()
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
  Select_id RESULTSET;
BEGIN
  Select_id := ''SELECT * FROM DEMO.PROCEDURE.WORLDWIDES WHERE LAT =''||:id ||''limit 1'';
  EXECUTE IMMEDIATE :Select_id;
  --RETURN TABLE(res);
END;
$$;
