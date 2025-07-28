{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['intermediate']
) }}

WITH customer_orders AS (
    SELECT 
        o.customer_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_items,
        SUM(oi.quantity * oi.unit_price) AS total_spent,
        MIN(o.order_date) AS first_order_date,
        MAX(o.order_date) AS last_order_date,
        ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_order_items') }} oi 
        ON o.order_id = oi.order_id
    GROUP BY o.customer_id
),

final AS (
    SELECT 
        co.customer_id,
        sc.first_name,
        sc.last_name,
        co.total_orders,
        co.total_items,
        co.total_spent,
        co.first_order_date,
        co.last_order_date,
        co.avg_order_value,
        CASE 
            WHEN co.total_spent > 5000 THEN 'High Value'
            WHEN co.total_spent BETWEEN 2000 AND 5000 THEN 'Mid Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_orders co
    JOIN {{ ref('stg_customers') }} sc 
        ON co.customer_id = sc.customer_id
)

SELECT * FROM final
