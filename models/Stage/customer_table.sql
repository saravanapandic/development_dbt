{{
    config(
        materialized='incremental'
    )
}}
with source as (

    select * from {{ source('sample_increment', 'CUSTOMER') }}

),
customer_table as (

    select
        C_CUSTKEY,
        C_NAME,
        C_ADDRESS,
        C_NATIONKEY,
        C_PHONE,
        C_ACCTBAL,
        C_MKTSEGMENT,
        C_COMMENT,
        insert_date
    from source
)
select * from customer_table
{% if is_incremental() %}
  where insert_date  > (select max(insert_date) from {{ this }})
{% endif %}