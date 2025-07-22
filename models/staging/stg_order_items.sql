{{ config(
    materialized='view',
    tags=['staging']
) }}
with source as (
    select * from {{ source('datafeed', 'raw_order_items') }}
)

select
    order_item_id::varchar as order_item_id,
    order_id::varchar as order_id,
    product_id::varchar as product_id,
    cast(quantity as integer) as quantity,
    cast(unit_price as float) as unit_price
from source
