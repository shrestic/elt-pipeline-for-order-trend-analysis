CREATE OR REPLACE TABLE raw_customers(
	customer_id varchar(50) NULL,
	customer_unique_id varchar(50) NULL,
	customer_zip_code_prefix varchar(100) NULL,
	customer_city varchar(50) NULL,
	customer_state varchar(50) NULL
);

CREATE OR REPLACE TABLE raw_geolocation(
	geolocation_zip_code_prefix varchar(100) NULL,
	geolocation_lat float8 NULL,
	geolocation_lng  float8 NULL,
	geolocation_city varchar(50) NULL,
	geolocation_state varchar(50) NULL
);

CREATE OR REPLACE TABLE  raw_order_items(
	order_id varchar(50) NULL,
	order_item_id varchar(100) NULL,
	product_id varchar(50) NULL,
	seller_id varchar(50) NULL,
	shipping_limit_date varchar(50) NULL,
	price float4 NULL,
	freight_value float4 NULL
) ;

CREATE OR REPLACE TABLE raw_order_payments(
	order_id varchar(50) NULL,
	payment_sequential varchar(100) NULL,
	payment_type varchar(50) NULL,
	payment_installments varchar(100) NULL,
	payment_value float4 NULL
);

CREATE OR REPLACE TABLE  raw_orders(
	order_id varchar(50) NULL,
	customer_id varchar(50) NULL,
	order_status varchar(50) NULL,
	order_purchase_timestamp varchar(50) NULL,
	order_approved_at varchar(50) NULL,
	order_delivered_carrier_date varchar(50) NULL,
	order_delivered_customer_date varchar(50) NULL,
	order_estimated_delivery_date varchar(50) NULL
) ;

CREATE OR REPLACE TABLE  raw_products(
	product_id varchar(50) NULL,
	product_category_name varchar(50) NULL,
	product_name_lenght varchar(100) NULL,
	product_description_lenght varchar(100) NULL,
	product_photos_qty varchar(100) NULL,
	product_weight_g varchar(100) NULL,
	product_length_cm varchar(100) NULL,
	product_height_cm varchar(100) NULL,
	product_width_cm varchar(100) NULL
);

CREATE OR REPLACE TABLE raw_sellers(
	seller_id varchar(50) NULL,
	seller_zip_code_prefix varchar(100) NULL,
	seller_city varchar(50) NULL,
	seller_state varchar(50) NULL
);


CREATE OR REPLACE FILE FORMAT mycsvformat
   TYPE = 'CSV'
   FIELD_DELIMITER = ','
   SKIP_HEADER = 1;

