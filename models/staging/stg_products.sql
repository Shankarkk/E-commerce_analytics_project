{{ config(
    materialized='view',
    tags=['staging']
) }}
    
with source as (
    select * from {{ source('datafeed', 'raw_products') }}
)

select
    product_id::varchar as product_id,
    product_name::varchar as product_name,
    category::varchar as category,
    brand::varchar as brand,
    cast(unit_price as float) as unit_price,
    availability::varchar as availability
from source
