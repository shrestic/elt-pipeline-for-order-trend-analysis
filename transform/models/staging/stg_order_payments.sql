with source as (
    select *
    from {{ source('store', 'raw_order_payments') }}
),
order_payments as (
    select
        {{ remove_double_quote('order_id') }} as order_id,
        payment_sequential :: int as payment_sequential, 
        payment_type, 
        payment_installments :: int as payment_installments, 
        payment_value :: float as payment_value,
        row_number() over(
            partition by order_id
            order by payment_value desc
        ) as rw_num
    from source
)
select 
    order_id, 
    payment_sequential, 
    payment_type, 
    payment_installments, 
    payment_value
from order_payments
where (order_id, rw_num) in (
        select 
        order_id,
        min(rw_num)
        from order_payments
        group by order_id
    ) 