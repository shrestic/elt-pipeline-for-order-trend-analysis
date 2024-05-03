with source as (
    select *
    from {{ source('store', 'raw_order_items') }}
),
order_items as (
    select
        {{ remove_double_quote('order_id') }} as order_id_key,
        {{ remove_double_quote('order_item_id') }} as order_item_id_key,
        {{ remove_double_quote('product_id') }} as product_id_key,
        {{ remove_double_quote('seller_id') }} as seller_id_key,
        shipping_limit_date :: timestamp as shipping_limit_date, 
        price :: float as price, 
        freight_value :: float as freight_value,        
    from source
)
select * from order_items
