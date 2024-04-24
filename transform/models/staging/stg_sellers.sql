with source as (
    select *
    from {{ source('store', 'raw_sellers') }}
)
select * from source