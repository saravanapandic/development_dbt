with source as (

    select * from {{ source('tpch', 'CUSTOMER') }}

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
        C_COMMENT
    from source

)

select * from customer_table