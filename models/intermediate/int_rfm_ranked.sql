{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['intermediate']
) }}


with rfm as (
    select
        customer_id,
        max(order_date) as last_order_date,
        datediff('day', max(order_date), current_date) as recency,
        count(order_id) as frequency,
        sum(amount) as monetary,
        sum(amount) as contribution
    from {{ ref('stg_orders') }}
    group by customer_id
)

select
    *,
    row_number() over (order by contribution desc) as rno
from rfm
