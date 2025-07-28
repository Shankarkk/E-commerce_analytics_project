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

final_rfm as (
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
),
rfm_segmented as (
    select
        customer_id,
        recency_days,
        frequency,
        monetary,
        recency_score,
        frequency_score,
        monetary_score,
        rfm_score,
        case 
            when rfm_score between '555' and '543' then 'Champions'
            when rfm_score between '542' and '444' then 'Loyal Customers'
            when rfm_score between '443' and '333' then 'Potential Loyalist'
            when rfm_score between '332' and '222' then 'At Risk'
            else 'Hibernating'
        end as rfm_segment
    from final_rfm
)

select * from rfm_segmented