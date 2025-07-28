{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['rfm','intermediate']
) }}

with customer_summary as (
    select
        customer_id,
        total_orders,
        total_spent,
        last_order_date        
      from {{ ref('int_customer_order_summary') }}
),

add_recency as (
    select 
         customer_id,
         total_orders,
         total_spent,
         last_order_date,
         datediff('day',last_order_date,current_date)as recency_days,
         ntile(5) over (order by datediff('day',last_order_date,current_date))as recency_score,
         ntile(5) over (order by total_orders desc)as frequency_score,
         ntile(5) over (order by total_spent desc) monetary_score,
         from customer_summary  
),

final as (
    select 
        customer_id,
        recency_days,
        total_orders as frequency,
        total_spent as monetary,
        recency_score,
        frequency_score,
        monetary_score,
        cast(recency_score as string) ||
        cast(frequency_score as string) ||
        cast(monetary_score as string) as rfm_score
        from add_recency
)        
select * from final