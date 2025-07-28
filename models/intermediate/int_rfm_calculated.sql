{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['intermediate']
) }}

with customer_order_data as(
    select
        o.customer_id,
        o.order_id,
        o.order_date,
        oi.quantity,
        oi.unit_price,
        (oi.quantity * oi.unit_price)as order_total
        from {{ref ('stg_orders') }} o
        JOIN {{ref ('stg_order_items') }} oi
        ON o.order_id = oi.order_id
        where o.status = 'delivered'
        
),

customer_rfm_summary as (
    select
        customer_id,
        max(order_date) as last_order_date,
        count(DISTINCT order_id) as frequency,
        sum(order_total) as monetary_value
    from customer_order_data
    GROUP BY customer_id
),

rfm_final as (
    select
        customer_id,
        DATEDIFF('day',last_order_date,current_date) as recency,
        frequency,
        monetary_value
        from customer_rfm_summary
)
select * from rfm_final