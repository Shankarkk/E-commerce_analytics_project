{{ config(
    materialized='view'
) }}

with source as (
    select
        category_id,
        category_name,
        created_at,
        {{ dbt_utils.generate_surrogate_key(['category_id']) }} as category_key
    from {{ source('datafeed', 'raw_categories') }}
)

select * from source