{{ config(
    materialized = 'table',
    alias = 'mart_customer_360',
    tags = ['mart','customer_360','final']
)}}

--Base Customer Info
with customer_base as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        c.gender,
        c.customer_created_at as customer_since
    from {{ref('stg_customers')}} c
),

--Monthly Order Metrics
monthly_orders as (
    select 
         customer_id,
         count(DISTINCT order_id) as total_orders,
         max(order_date) as last_order_date,
         min(order_date) as first_order_date
    from {{ref('int_orders')}}
    group by customer_id
),

--RFM data
rfm_data as (
    select  
        customer_id,
        recency_days,
        frequency,
        monetary,
        rfm_score
    from {{ ref('int_rfm_rank_calc') }}    
),

--Total Spend & Segment
customer_summary as (
    select 
        customer_id,
        total_spent,
        customer_segment
    from {{ref('int_customer_order_summary')}}    
)

--Final customer 360 Mart
select
        cb.customer_id,
        cb.first_name,
        cb.last_name,
        cb.email,
        cb.gender,
        cb.customer_since,
        coalesce(mo.total_orders,0) as total_orders,
        mo.first_order_date,
        mo.last_order_date,
        rfm.frequency as order_frequency,
        rfm.monetary as total_monetary_value,
        rfm.rfm_score,
        cs.total_spent,
        cs.customer_segment as rfm_segment
        from customer_base cb 
        LEFT JOIN monthly_orders mo ON
        cb.customer_id =mo.customer_id
        LEFT JOIN rfm_data rfm ON
        cb.customer_id = rfm.customer_id
        LEFT JOIN customer_summary cs ON 
        cb.customer_id = cs.customer_id