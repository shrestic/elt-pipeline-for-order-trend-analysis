from dagster import  Out, op
from dagster_snowflake import SnowflakeResource


def __build_load_data_query(file_path, stage_name):
    query = f"""
        PUT file://{file_path} @%{stage_name} OVERWRITE = True ;
    """
    return query


@op()
def upload_files_to_stages(snowflake: SnowflakeResource):
    customers_query = __build_load_data_query(
        "/Users/nguyenphong/local/customers_dataset.csv", "raw_customers"
    )
    geolocation_query = __build_load_data_query(
        "/Users/nguyenphong/local/geolocation_dataset.csv", "raw_geolocation"
    )
    order_items_query = __build_load_data_query(
        "/Users/nguyenphong/local/order_items_dataset.csv", "raw_order_items"
    )
    order_payments_query = __build_load_data_query(
        "/Users/nguyenphong/local/order_payments_dataset.csv", "raw_order_payments"
    )
    orders_query = __build_load_data_query(
        "/Users/nguyenphong/local/orders_dataset.csv", "raw_orders"
    )
    products_query = __build_load_data_query(
        "/Users/nguyenphong/local/products_dataset.csv", "raw_products"
    )
    sellers_query = __build_load_data_query(
        "/Users/nguyenphong/local/sellers_dataset.csv", "raw_sellers"
    )

    queries = [
        customers_query,
        geolocation_query,
        order_items_query,
        order_payments_query,
        orders_query,
        products_query,
        sellers_query,
    ]
    with snowflake.get_connection() as conn:
        for query in queries:
            conn.cursor().execute(query)


