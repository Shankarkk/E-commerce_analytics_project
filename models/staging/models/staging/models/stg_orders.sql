-- Path:staging/stg_orders.sql
{{ config(materialized='view', tags=['staging']) }}

with stg_orders as (
    select 
        order_id,
        customer_id,
        order_date::date as order_date,
        order_amount,
        status,
        created_at::timestamp as order_created_at,
        updated_at::timestamp as order_updated_at
    from {{ source('datafeed', 'raw_orders') }}
)
select * from stg_orders;
