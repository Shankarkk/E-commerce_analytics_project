-- models/marts/top_rfm_customers_mart.sql

{{ config(
    materialized = 'table',
    schema = 'marts',
    tags = ['top_rfm_customers', 'rfm', 'customer_segmentation']
) }}

with ranked as (
    select * 
    from {{ ref('int_rfm_ranked') }}
    where rno <= 20
)

select
    customer_id,
    contribution,
    recency,
    frequency,
    monetary,
    rno,
    case
        when recency <= 7 then 'Highly Active'
        when recency between 8 and 30 then 'Active'
        else 'Inactive'
    end as customer_activity_status,
    case
        when contribution >= 1000 then 'High Value'
        else 'Low Value'
    end as customer_value_segment
from ranked
