with source as (
    select *
    from {{ source('store', 'raw_geolocation') }}
)
select * from source