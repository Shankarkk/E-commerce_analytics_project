{{ config(materialized='view', tags=['staging']) }}

with stg_customers as (
    select 
        customer_id,
        first_name,
        last_name,
        email,
        gender,
        created_at::timestamp as customer_created_at,
        updated_at::timestamp as customer_updated_at
    from {{ source('datafeed', 'raw_customer') }}
)
select * from stg_customers;
