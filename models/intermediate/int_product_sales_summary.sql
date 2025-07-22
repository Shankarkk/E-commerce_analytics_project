{{ config(
    materialized='table',
    unique_key='product_id',
    tags=['intermediate']
) }}
    
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS total_units_sold,
        SUM(oi.quantity * oi.total_price) AS total_revenue,
        ROUND(SUM(oi.quantity * oi.total_price) / NULLIF(SUM(oi.quantity), 0), 2) AS avg_selling_price,
        COUNT(DISTINCT o.customer_id) AS unique_customers
    FROM {{ ref('stg_order_items') }} oi
    JOIN {{ ref('stg_orders') }} o
        ON oi.order_id = o.order_id
    JOIN {{ ref('stg_products') }} p
        ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)

SELECT * FROM product_sales

