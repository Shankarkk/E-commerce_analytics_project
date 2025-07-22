-- models/marts/customer_segmentation_mart.sql

{{ config(
    materialized='table',
    schema='marts',
    tags=['customer_segmentation', 'rfm', 'churn_analysis']
) }}

with rfm_data as (
    select * from {{ ref('int_rfm_ranked_customers') }}
),

churn_logic as (
    select
        *,
        case 
            when recency <= 30 then 'Active'
            when recency > 30 and recency <= 90 then 'At Risk'
            else 'Churned'
        end as churn_status
    from rfm_data
),

behavior_logic as (
    select
        *,
        case 
            when frequency >= 10 and monetary >= 1000 then 'Loyal High Spender'
            when frequency >= 10 then 'Loyal Customer'
            when monetary >= 1000 then 'High Spender'
            else 'Occasional'
        end as behavioral_segment
    from churn_logic
)

select
    customer_id,
    recency,
    frequency,
    monetary,
    rfm_score,
    churn_status,
    behavioral_segment,
    churn_status || ' - ' || behavioral_segment as combined_segment
from behavior_logic
