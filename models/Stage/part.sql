with source as (

    select * from {{ source('tpch', 'PART') }}

),

partner_table as (

    select
        P_PARTKEY,
        P_NAME,
        P_MFGR,
        P_BRAND,
        P_TYPE,
        P_SIZE,
        P_CONTAINER,
        P_RETAILPRICE,
        P_COMMENT

    from source

)

select * from partner_table