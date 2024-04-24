with source as (
    select *
    from {{ source('store', 'raw_orders') }}
)
select * from source