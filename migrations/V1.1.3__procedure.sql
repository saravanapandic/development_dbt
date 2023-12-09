USE DATABASE STAGE_DBT;
USE SCHEMA PUBLIC;
create or replace procedure view_and_insert_LD()
    RETURNS varchar null
    LANGUAGE SQL 
    EXECUTE AS caller
    as
    declare
    table_list resultset default (select TABLE_NAME,table_id,SCHEMA_NAME,DATABASE_NAME from HOUSEKEEPING.ACTIVES_TABLE.TABLE_INFORMATION);
    table_fetch cursor for table_list;
    TABLE_ID int;
    TABLE_NAME varchar;
    SCHEMA_NAME varchar;
    DATABASE_NAME varchar;
    join_table_Details varchar;
    Last_accessed_person varchar;
    time_of_accessed TIMESTAMP_ltz;
    column_accessed array;
    rows_produced int;
    --insert column 
    QueryText_ACCESSED varchar;
    Last_Insert_person varchar;
    Last_Insert_TIME TIMESTAMP_ltz;
    column_accessed_Insert array;
    QueryText_Insert varchar;
    Storage_written number;
    rows_insertd int;
    --update column
    Last_Updated_person varchar;
    Last_Updated_time TIMESTAMP_ltz;
    column_ACCESSED_updated array;
    Querytext_update varchar;
    rows_update int;
    --drop column
    Last_drop_by varchar;
    Last_Drop_time TIMESTAMP_ltz;
    Column_drop array;
    QueryText_drop varchar;
    drop_type varchar;
    rows_drop int;
    --alter 
    Last_AlterTable_by varchar;
    Last_AlterTable_Time TIMESTAMP_ltz;
    Last_AlterTable_Details object;
    QueryText_Alter varchar;
    Alter_type varchar;
    maxs TIMESTAMP_ltz;
    Last_Active_time TIMESTAMP_ltz;
    --row ,storage
    total_rowcount_in_table int;
    Total_storage_usage_bytes number;
    begin
    FOR row_variable IN table_fetch DO 
    begin
    TABLE_ID:=row_variable.table_id;
    TABLE_NAME:=row_variable.TABLE_NAME;
    SCHEMA_NAME:=row_variable.SCHEMA_NAME;
    DATABASE_NAME:=row_variable.DATABASE_NAME;
    join_table_Details:=(:DATABASE_NAME||'.'||:SCHEMA_NAME||'.'||:TABLE_NAME);
    --view list
     (select  t1.USER_NAME,t1.QUERY_START_TIME,t1.DIRECT_OBJECTS_ACCESSED,t2.QUERY_TEXT,t2.ROWS_PRODUCED  into :Last_accessed_person,:time_of_accessed,:column_accessed,:QueryText_ACCESSED,:rows_produced
        FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY t1 , (lateral flatten(base_objects_accessed) f1)
       join 
       SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY t2
          WHERE f1.value:"objectName"::string=:join_table_Details
         AND f1.value:"objectDomain"::string='Table' and OBJECT_MODIFIED_BY_DDL is null and  ARRAY_SIZE(OBJECTS_MODIFIED)=0 and 
       t2.QUERY_ID=t1.QUERY_ID
         order by query_start_time desc limit 1);
  ---insert query -----------------------------------------
    select t1.USER_NAME,t1.QUERY_START_TIME,t1.OBJECTS_MODIFIED,t2.QUERY_TEXT,t2.BYTES_WRITTEN,t2.ROWS_INSERTED into :Last_Insert_person,:Last_Insert_TIME,:column_accessed_Insert,:QueryText_Insert,:Storage_written,:rows_insertd
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY t1
     , (lateral flatten(OBJECTS_MODIFIED) f1)
     join 
     SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY t2
          WHERE f1.value:"objectName"::string=:join_table_Details
AND f1.value:"objectDomain"::string='Table'  and t2.QUERY_ID=t1.QUERY_ID and  t2.query_type='INSERT' and t2.rows_inserted >0 and t2.EXECUTION_STATUS='SUCCESS'
order by query_start_time desc limit 1 ;
 
--updated query--------------------------
select t1.QUERY_START_TIME,t1.USER_NAME,t1.OBJECTS_MODIFIED,t2.QUERY_TEXT,t2.ROWS_UPDATED into :Last_Updated_time,:Last_Updated_person,:column_ACCESSED_updated,:Querytext_update,:rows_update
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY t1
     , (lateral flatten(OBJECTS_MODIFIED) f1)
     join 
     SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY t2
          WHERE f1.value:"objectName"::string=:join_table_Details
AND f1.value:"objectDomain"::string='Table'  and t2.QUERY_ID=t1.QUERY_ID and  t2.query_type='UPDATE' and t2.rows_updated>0
order by query_start_time desc limit 1 ;
--drop query-----------------------
select t1.QUERY_START_TIME,t1.USER_NAME,t1.OBJECTS_MODIFIED,t2.QUERY_TEXT,t2.QUERY_TYPE,t2.ROWS_DELETED into :Last_Drop_time,:Last_drop_by,:Column_drop,:QueryText_drop,:drop_type,:rows_drop
FROM SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY t1
     , (lateral flatten(OBJECTS_MODIFIED) f1)
     join 
     SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY t2
          WHERE f1.value:"objectName"::string=:join_table_Details
AND f1.value:"objectDomain"::string='Table'  and t2.QUERY_ID=t1.QUERY_ID and  t2.query_type in ('DELETE','TRUNCATE_TABLE')
order by query_start_time desc limit 1 ;
--alter query----------------------------------
select t1.USER_NAME,t1.QUERY_START_TIME,t1.OBJECT_MODIFIED_BY_DDL,t2.QUERY_TEXT,t2.QUERY_TYPE into :Last_AlterTable_by,
    :Last_AlterTable_Time,
    :Last_AlterTable_Details,
    :QueryText_Alter,:Alter_type from SNOWFLAKE.ACCOUNT_USAGE.ACCESS_HISTORY t1 join 
     SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY t2 where OBJECT_MODIFIED_BY_DDL:"objectName"=:join_table_Details and t2.QUERY_ID=t1.QUERY_ID and OBJECT_MODIFIED_BY_DDL:"operationType"='ALTER' order by query_start_time desc limit 1; 
--row,storage---
select ROW_COUNT,BYTES into :total_rowcount_in_table,
    :Total_storage_usage_bytes  from SNOWFLAKE.ACCOUNT_USAGE.TABLES where TABLE_NAME= :TABLE_NAME and TABLE_SCHEMA= :SCHEMA_NAME  and TABLE_CATALOG = :DATABASE_NAME   and deleted is null;
     --last active time --
 
     if( :time_of_accessed > :Last_Insert_TIME) then
        set maxs:= :time_of_accessed;
    else
        set maxs:= :Last_Insert_TIME;
    end if;
    if(:maxs < :Last_Updated_time) then
        set maxs:= :Last_Updated_time;
    elseif(:maxs < :Last_Drop_time)then
        set maxs:= :Last_Drop_time;
    elseif(:maxs < :Last_AlterTable_Time) then
        set maxs:= :Last_AlterTable_Time;
    else
        set maxs := :maxs ;
    end if;
     Last_Active_time:= :maxs;
   --updted table information---
    update HOUSEKEEPING.ACTIVES_TABLE.TABLE_INFORMATION
    set Last_accessed_person= :Last_accessed_person,time_of_accessed=:time_of_accessed,column_accessed=:column_accessed,QueryText_ACCESSED= :QueryText_ACCESSED,rows_produced= :rows_produced,LAST_INSERT_PERSON=:Last_Insert_person,QueryText_Insert =:QueryText_Insert,
    column_accessed_Insert =:column_accessed_Insert,
    Storage_written =:Storage_written,
    rows_insertd =:rows_insertd,
    Last_Insert_TIME=:Last_Insert_TIME,
    Last_Updated_person =:Last_Updated_person ,
    Last_Updated_time=:Last_Updated_time,
    column_ACCESSED_updated=:column_ACCESSED_updated,
    Querytext_update=:Querytext_update,
     rows_update=:rows_update,
     Last_Drop_time=:Last_Drop_time,
     Last_drop_by=:Last_drop_by,
     Column_drop=:Column_drop,
     QueryText_drop=:QueryText_drop,
     drop_type=:drop_type,
     rows_drop=:rows_drop,
     Last_AlterTable_by=:Last_AlterTable_by,
     Last_AlterTable_Time=:Last_AlterTable_Time,
     Last_AlterTable_Details=:Last_AlterTable_Details,
     QueryText_Alter=:QueryText_Alter,
     Alter_type =:Alter_type ,
     Last_Active_time =:Last_Active_time,
     total_rowcount_in_table=:total_rowcount_in_table,
     Total_storage_usage_bytes =:Total_storage_usage_bytes 
     where TABLE_ID= :TABLE_ID; 
    end;
    end for;
  return 'run successfully';
    end;
 
