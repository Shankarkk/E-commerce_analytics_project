-- models/intermediate/int_rfm_ranked.sql

with base as (
    select * from {{ ref('int_rfm') }}
),

rfm_scored as (
    select
        customer_id,
        most_recent_order,
        recency,
        frequency,
        contribution,

        -- R, F, C scoring logic (example: 1 to 5 scale)
        case
            when recency <= 30 then 5
            when recency <= 60 then 4
            when recency <= 90 then 3
            when recency <= 120 then 2
            else 1
        end as r_score,

        case
            when frequency >= 10 then 5
            when frequency >= 7 then 4
            when frequency >= 4 then 3
            when frequency >= 2 then 2
            else 1
        end as f_score,

        case
            when contribution >= 1000 then 5
            when contribution >= 750 then 4
            when contribution >= 500 then 3
            when contribution >= 250 then 2
            else 1
        end as c_score

    from base
)

select *
from rfm_scored
