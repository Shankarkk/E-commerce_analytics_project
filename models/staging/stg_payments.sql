{{ config(materialized='view', tags=['staging']) }}

with stg_payments as (
    select 
        payment_id,
        order_id,
        payment_method,
        amount::decimal(10,2) as payment_amount,
        created_at::timestamp as payment_created_at,
        updated_at::timestamp as payment_updated_at
    from {{ source('datafeed', 'raw_payments') }}
)
select * from stg_payments;
