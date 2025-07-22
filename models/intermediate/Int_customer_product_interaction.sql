{{ config(
    materialized='table',
    unique_key=['customer_id', 'product_id'],
    tags=['intermediate']
) }}
    
with order_items as (

    select 
        o.order_id,
        o.customer_id,
        i.product_id,
        i.quantity,
        i.amount
    from {{ ref('stg_orders') }} o
    join {{ ref('stg_order_items') }} i
      on o.order_id = i.order_id
    where o.status = 'delivered'

),

customer_product_metrics as (

    select 
        customer_id,
        product_id,
        count(distinct order_id) as total_orders,
        sum(quantity) as total_quantity,
        sum(amount) as total_spent_on_product
    from order_items
    group by customer_id, product_id

)

select * 
from customer_product_metrics
