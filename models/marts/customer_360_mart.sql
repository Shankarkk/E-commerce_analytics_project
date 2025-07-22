{{ config(
    materialized='table',
    tags=['mart'],
    unique_key='customer_id'
) }}

WITH rfm AS (
    SELECT *
    FROM {{ ref('int_rfm_ranked_customers') }}
),

top_product AS (
    SELECT 
        customer_id,
        product_id AS top_product_id,
        total_quantity,
        total_spent_on_product
    FROM {{ ref('mart_top_product_per_customer') }}
),

order_summary AS (
    SELECT *
    FROM {{ ref('int_customer_order_summary') }}
)

SELECT
    rfm.customer_id,
    
    -- RFM Segmentation
    rfm.recency,
    rfm.frequency,
    rfm.monetary,
    rfm.rfm_rank,
    rfm.customer_activity_status,
    rfm.customer_value_segment,

    -- Top product interaction
    top_product.top_product_id,
    top_product.total_quantity,
    top_product.total_spent_on_product,

    -- Order & revenue metrics
    order_summary.total_orders,
    order_summary.contribution

FROM rfm
LEFT JOIN top_product
    ON rfm.customer_id = top_product.customer_id
LEFT JOIN order_summary
    ON rfm.customer_id = order_summary.customer_id
