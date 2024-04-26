SELECT
  DATE(do.order_purchase_timestamp) AS order_date,
  SUM(fs.payment_value) AS total_sales
FROM {{ ref('fct_sales') }} as fs
INNER JOIN {{ ref('dim_orders') }} as do ON fs.order_id_key = do.order_id_key
GROUP BY DATE(do.order_purchase_timestamp)
ORDER BY order_date