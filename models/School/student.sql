with source_data as (

    select 1 as id,'swetha' as name, 21 as age
    union all
    select 1 as id, 'saravana' as name, 22 as age
    union all
    select 2 as id, 'shajahan' as name, 22 as age
    union all
    select null as id, 'sashanth' as name, 22 as age

)

select *
from source_data