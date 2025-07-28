{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['mart','monthly','final']
) }}

with base as (
    select
        oi.product_id,
        p.product_name,
        c.category_name,
        DATE_TRUNC('MONTH',o.order_date) as order_month,
        oi.quantity,
        oi.unit_price,
        o.customer_id        
      from {{ ref('stg_order_items') }} oi 
      JOIN {{ ref('stg_products',) }} p ON
      oi.product_id = p.product_id
      JOIN {{ ref('stg_categories') }} c ON
      p.category = c.category_id
      JOIN {{ ref("stg_orders") }} o ON
      oi.order_id = o.order_id
)
    select 
         product_id,
         product_name,
         category_name,
         order_month,
         sum(quantity) as total_quantity,
         sum(quantity * unit_price) as total_revenue,
         count(DISTINCT customer_id) as unique_customers
         from base  
         group by product_id,product_name,category_name,order_month
         order by order_month desc,total_revenue desc
