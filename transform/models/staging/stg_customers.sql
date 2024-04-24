with source as (
    select *
    from {{ source('store', 'raw_customers') }}
)
select * from source