with recent_orders as (
    select 
        customer_id, 
        max(order_date) as last_order_date
    from {{ ref('stg_orders') }}
    group by customer_id
),
churned as (
    select
        r.customer_id,
        r.last_order_date,
        datediff(day, r.last_order_date, current_date) as days_since_last_purchase,
        case 
            when datediff(day, r.last_order_date, current_date) > 60 then 'Churned'
            else 'Active'
        end as churn_status
    from recent_orders r
)

select * from churned
