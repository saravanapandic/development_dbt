with source as (

    select * from {{ source('tpch', 'SUPPLIER') }}

),

supplier_table as (

    select
        S_SUPPKEY,
        S_NAME,
        S_ADDRESS,
        S_NATIONKEY,
        S_PHONE,
        S_ACCTBAL,
        S_COMMENT
    from source

)

select * from supplier_table