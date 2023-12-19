{% snapshot orders_snapshot %}

{{    
  config(    
    target_schema='MARKETING',        
    strategy='check',
    unique_key='C_CUSTKEY',           
    check_cols=['C_CUSTKEY'],
    invalidate_hard_deletes=false    
  )  
}}  

select * from {{ source('sample_increment', 'CUSTOMER') }}

{% endsnapshot %}