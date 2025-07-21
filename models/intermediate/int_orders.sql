--path:models/intermediate/int_orders.sql
{{ config(
    materialized = 'view',
    tags = ['intermediate']
) }}

-- Step 1: Join raw customer and order data
with int_orders as (

    select
        o.order_id,
        o.customer_id,
        c.first_name,
        o.order_date,
        o.total_amount,
        o.status as raw_status,
        o.created_at,
        o.updated_at
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_customers') }} c
        on o.customer_id = c.customer_id

),

-- Step 2: Clean the order status values
cleaned as (

    select
        order_id,
        customer_id,
        first_name,
        order_date,
        total_amount,
        raw_status,

        case
            when lower(raw_status) in ('delivered', 'completed') then 'Completed'
            when lower(raw_status) in ('cancelled', 'canceled', 'cancel', 'closed') then 'Cancelled'
            when lower(raw_status) in ('pending', 'in transit', 'intransit', 'transit') then 'In Transit'
            else 'Other'
        end as order_status_cleaned,

        created_at,
        updated_at

    from int_orders

)

-- Step 3: Final output
select * from cleaned;
