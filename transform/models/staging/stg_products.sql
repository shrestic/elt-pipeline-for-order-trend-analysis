with source as (
    select *
    from {{ source('store', 'raw_products') }}
)
select * from source