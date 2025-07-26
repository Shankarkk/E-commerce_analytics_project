{{ config(
    materialized='view',
    tags=['staging']
) }}
with source as (

select
    product_id::varchar as product_id,
    product_name::varchar as product_name,
    category_id::varchar as category,
    brand::varchar as brand,
    cast(price as float) as unit_price,
    availability::varchar as availability
from {{ source('datafeed','raw_products') }}
)
select * from source