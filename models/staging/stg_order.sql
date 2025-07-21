
{{ config(materialized='view', tags=['staging']) }}

with stg_orders as (
    select 
        order_id,
        customer_id,
        product_id,
        order_date::timestamp as order_date,
        status,
        created_at::timestamp as order_created_at,
        updated_at::timestamp as order_updated_at
    from {{ source('datafeed', 'raw_orders') }}
)
select * from stg_orders;
