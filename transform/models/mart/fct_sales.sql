select
    o.order_id_key,
    p.product_id_key,
    c.customer_id_key,
    oi.seller_id_key,
    oi.shipping_limit_date,
    oi.freight_value,
    oi.price,
    op.payment_value,
    op.payment_installments,
    op.payment_type
from {{ ref('stg_orders')}} as o
join {{ ref('stg_order_items')}} as oi
    on oi.order_id_key = o.order_id_key
join {{ ref('stg_products')}} as p
    on p.product_id_key = oi.product_id_key
join {{ ref('stg_order_payments')}} as op
    on op.order_id_key = o.order_id_key
join {{ ref('stg_customers')}} as c
    on c.customer_id_key = o.customer_id_key