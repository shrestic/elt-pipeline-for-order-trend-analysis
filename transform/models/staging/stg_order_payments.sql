with source as (
    select distinct order_id, payment_sequential, payment_type, payment_installments, payment_value
    from {{ source('store', 'raw_order_payments') }}
)
select * from source