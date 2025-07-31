{{ config(
    materialized='incremental',
    unique_key='order_id',
    tags=['intermediate']
) }}

with orders as (

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

{% if is_incremental() %}
    where o.order_created_at > (select max(order_created_at)
from {{this}})
{% endif %}
),

order_amount_calc as(
    select
        oi.order_id,
        sum(oi.quantity * oi.unit_price) as
        order_amount
    from {{ref('stg_order_items')}} oi
    group by oi.order_id    
),

final as (
    select
        o.order_id,
        o.customer_id,
        o.first_name,
        o.order_date,
        o.raw_status,
        case
            when lower(o.raw_status) in ('delivered', 'completed') then 'Completed'
            when lower(o.raw_status) in ('cancelled', 'canceled', 'cancel', 'closed') then 'Cancelled'
            when lower(o.raw_status) in ('pending', 'in transit', 'intransit', 'transit') then 'In Transit'
            else 'Other'
        end as order_status_cleaned,
        o.order_created_at,
        oac.order_amount
        from orders o    
        left join order_amount_calc oac on
        o.order_id = oac.order_id
 
)
    select * from final