
{{
    config(
         database='STAGE_DB',schema='SALES_DETAILS'
    )
}}
with source_data as (

    select 5 as id
    union all
    select null as id

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/
