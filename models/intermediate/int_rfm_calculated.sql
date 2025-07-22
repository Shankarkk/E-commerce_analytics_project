{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['intermediate']
) }}

with customer_orders as (
    select
        sc.customer_id,
        max(so.order_date) as most_recent_order,
        datediff('day', max(so.order_date), current_date) as recency,
        count(so.order_id) as frequency,
        sum(so.order_amount) as contribution
    from {{ ref('stg_customers') }} as sc
    join {{ ref('stg_orders') }} as so
        on sc.customer_id = so.customer_id
    group by sc.customer_id
)

select *
from customer_orders
