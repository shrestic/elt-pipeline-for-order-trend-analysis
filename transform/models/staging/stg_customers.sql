with source as (
    select *
    from {{ source('store', 'raw_customers') }}
),
customer as (
    select  {{ remove_double_quote('customer_id') }} as customer_id_key, 
            {{ remove_double_quote('customer_unique_id') }} as customer_unique_id, 
            {{ remove_double_quote('customer_zip_code_prefix') }} :: int  as customer_zip_code_prefix_key, 
            customer_city, 
            customer_state,
            ROW_NUMBER() OVER(
                PARTITION BY customer_id_key,customer_unique_id
                ORDER BY customer_id_key,customer_unique_id
            ) as rw_num
    from source
)
select  
        customer_id_key, 
        customer_unique_id, 
        customer_zip_code_prefix_key, 
        customer_city, 
        customer_state
from customer
where (customer_id_key,customer_unique_id, rw_num) IN (
        select customer_id_key,customer_unique_id,
            min(rw_num)
        from customer
        group by customer_id_key,customer_unique_id
    )