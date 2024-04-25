with source as (
    select *
    from {{ source('store', 'raw_sellers') }}
),
sellers as (
    select  
        {{ remove_double_quote('seller_id') }} as seller_id_key,
        {{ remove_double_quote('seller_zip_code_prefix') }} :: int as seller_zip_code_prefix_key, 
        seller_city, 
        seller_state,
        row_number() over(
                partition by seller_id
                order by seller_zip_code_prefix
        ) as rw_num
    from source
)
select 
    seller_id_key, 
    seller_zip_code_prefix_key, 
    seller_city, 
    seller_state
from sellers
where (seller_id_key, rw_num) in
(   select
        seller_id_key, 
        min(rw_num) 
    from sellers
    group by seller_id_key
)