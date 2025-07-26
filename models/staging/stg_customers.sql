{{ config(
    materialized='view',
    tags=['staging']
) }}
with source as (

    select 
        customer_id,
        first_name,
        last_name,
        email,
        gender,
        created_at::timestamp as customer_created_at
    from {{ source('datafeed','raw_customers') }}
)
select * from source 