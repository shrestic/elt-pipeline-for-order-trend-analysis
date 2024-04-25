with source as (
    select *
    from {{ source('store', 'raw_products') }}
),
products as (
    select  
        {{ remove_double_quote('product_id') }} as product_id,
        product_category_name, 
        product_name_lenght :: int as product_name_length, 
        product_description_lenght :: int as product_description_length, 
        product_photos_qty :: int as product_photos_qty, 
        product_weight_g :: int as product_weight, 
        product_length_cm :: int as product_length, 
        product_height_cm :: int as product_height, 
        product_width_cm :: int as product_width,
        row_number() over(
                partition by product_id
                order by product_id
        ) as rw_num
    from source
)
select 
    product_id, 
    product_category_name, 
    product_name_length, 
    product_description_length, 
    product_photos_qty, 
    product_weight, 
    product_length, 
    product_height, 
    product_width
from products
where (product_id, rw_num) in
(   select
        product_id, 
        min(rw_num) 
    from products
    group by product_id
)