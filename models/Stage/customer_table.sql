{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns',
        unique_key='C_CUSTKEY',
        merge_update_columns = ['C_NAME']
        
    )
}}
with source as (

    select * from {{ source('sample_increment', 'CUSTOMER') }}

),
customer_table as (

    select
        *
    from source
)
select * from customer_table
