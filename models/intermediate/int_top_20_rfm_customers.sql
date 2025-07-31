{{ config(
    materialized='table',
    unique_key='customer_id',
    tags=['rfm','intermediate']
) }}

with rfm_data as (
    select *        
      from {{ ref('int_rfm_rank_calc') }}
),

top_20 as (
    select 
        customer_id,
        recency_days,
        frequency,
        monetary,
        recency_score,
        frequency_score,
        rfm_score,
        row_number()over (order by rfm_score desc) as rfm_rank
    from rfm_data
    order by rfm_score desc
    limit 20
)        
select * from top_20