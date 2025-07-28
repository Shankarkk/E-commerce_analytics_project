{{ config(
    materialized='table',
    unique_key='order_id',
    tags=['intermediate']
) }}

with int_orders as (

    select
        o.order_id,
        o.customer_id,
        c.first_name,
        o.order_date,
        o.status as raw_status,
        o.order_created_at
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_customers') }} c
        on o.customer_id = c.customer_id

),

order_amount_calc as(
    select
        oi.order_id,
        sum(oi.quantity * oi.unit_price) as
        order_amount
    from {{ref('stg_order_items')}} oi
    group by oi.order_id     
),

cleaned as (
    select
        io.order_id,
        io.customer_id,
        io.first_name,
        io.order_date,
        io.raw_status,
        case
            when lower(io.raw_status) in ('delivered', 'completed') then 'Completed'
            when lower(io.raw_status) in ('cancelled', 'canceled', 'cancel', 'closed') then 'Cancelled'
            when lower(io.raw_status) in ('pending', 'in transit', 'intransit', 'transit') then 'In Transit'
            else 'Other'
        end as order_status_cleaned,
        io.order_created_at,
        oa.order_amount
        from int_orders io     
        left join order_amount_calc oa on 
        io.order_id = oa.order_id
 
)
    select * from cleaned