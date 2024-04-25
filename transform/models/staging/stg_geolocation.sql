with source as (
    select *
    from {{ source('store', 'raw_geolocation') }}
),
geolocation as (
    select  
        {{ remove_double_quote('geolocation_zip_code_prefix') }} :: int as geolocation_zip_code_prefix, 
        geolocation_lat, 
        geolocation_lng, 
        geolocation_city, 
        geolocation_state,
        row_number() over(
                partition by geolocation_lat,geolocation_lng
                order by geolocation_zip_code_prefix
        ) as rw_num
    from source
    where geolocation_zip_code_prefix is not null
)
select 
    geolocation_zip_code_prefix, 
    geolocation_lat, 
    geolocation_lng, 
    geolocation_city, 
    geolocation_state,
from geolocation
where (geolocation_zip_code_prefix, rw_num) in
(   select
        geolocation_zip_code_prefix, 
        min(rw_num) 
    from geolocation
    group by geolocation_zip_code_prefix
)