{{ config(materialized='view', tags=['staging']) }}
with source as (

    select 
        category_id,
        category_name,
        {{ dbt_utils.generate_surrogate_key['category_id'] }} category_key
        from {{ source('datafeed','raw_categories') }}
)
        
select * from source
