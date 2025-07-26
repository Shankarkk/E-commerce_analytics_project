{{ config(materialized='view', tags=['staging']) }}
with source as (
    select 
        payment_id,
        order_id,
        payment_method,
        amount::decimal(10,2) as payment_amount,
        payment_status,
        payment_date::TIMESTAMP as payment_created_at
        from {{ source('datafeed','raw_payments') }}
)
select * from source
