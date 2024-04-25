with source as (
    select *
    from {{ source('store', 'raw_orders') }}
),
orders as (
    select
        {{ remove_double_quote('order_id') }} as order_id_key,
        {{ remove_double_quote('customer_id') }} as customer_id_key,
        order_status, 
        order_purchase_timestamp :: timestamp as order_purchase_timestamp, 
        order_approved_at :: timestamp as order_approved_at, 
        order_delivered_carrier_date :: timestamp as order_delivered_carrier_date, 
        order_delivered_customer_date :: timestamp as order_delivered_customer_date, 
        order_estimated_delivery_date :: timestamp as order_estimated_delivery_date,  
        row_number() over(
            partition by order_id
            order by order_purchase_timestamp desc
        ) as rw_num
    from source
)
select 
    order_id_key, 
    customer_id_key, 
    order_status, 
    order_purchase_timestamp, 
    order_approved_at, 
    order_delivered_carrier_date, 
    order_delivered_customer_date, 
    order_estimated_delivery_date
from orders
where (order_id_key, rw_num) in (
        select 
        order_id_key,
        min(rw_num)
        from orders
        group by order_id_key
) 