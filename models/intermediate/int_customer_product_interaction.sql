{{ config(
    materialized='incremental',
    unique_key=['customer_id', 'product_id'],
    incremental_strategy='merge',
    tags=['intermediate']
) }}


WITH order_items AS (
    SELECT
        o.order_id,
        o.customer_id,
        i.product_id,
        i.quantity,
        i.unit_price,
        o.order_date
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_order_items') }} i
        ON o.order_id = i.order_id
    WHERE o.status = 'delivered'
),


customer_product_metrics AS (
    SELECT
        customer_id,
        product_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS total_quantity,
        SUM(unit_price * quantity) AS total_spent_on_product,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date
    FROM order_items
    {% if is_incremental() %}
    WHERE order_date > (SELECT MAX(last_order_date) FROM {{ this }})
    {% endif %}
    GROUP BY customer_id, product_id
)


SELECT * FROM customer_product_metrics
