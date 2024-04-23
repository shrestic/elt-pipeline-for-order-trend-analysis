from dagster import In, Nothing, graph, op
from dagster_snowflake import SnowflakeResource


def __build_load_data_query(file_path, stage_name):
    query = f"""
        PUT file://{file_path} @%{stage_name};
    """
    return query


def __build_copy_into_query(name):
    query = f"""
        COPY INTO {name} FROM @%{name}
        ON_ERROR = SKIP_FILE_10;
    """
    return query


@op
def upload_files_to_stages(snowflake: SnowflakeResource):
    customers_query = __build_load_data_query(
        '/Users/nguyenphong/local/customers_dataset.csv', 'customers')
    geolocation_query = __build_load_data_query(
        '/Users/nguyenphong/local/geolocation_dataset.csv', 'geolocation')
    order_items_query = __build_load_data_query(
        '/Users/nguyenphong/local/order_items_dataset.csv', 'order_items')
    order_payments_query = __build_load_data_query(
        '/Users/nguyenphong/local/order_payments_dataset.csv', 'order_payments')
    orders_query = __build_load_data_query(
        '/Users/nguyenphong/local/orders_dataset.csv', 'orders')
    products_query = __build_load_data_query(
        '/Users/nguyenphong/local/products_dataset.csv', 'products')
    sellers_query = __build_load_data_query(
        '/Users/nguyenphong/local/sellers_dataset.csv', 'sellers')

    queries = [
        customers_query,
        geolocation_query,
        order_items_query,
        order_payments_query,
        orders_query,
        products_query,
        sellers_query
    ]
    with snowflake.get_connection() as conn:
        for query in queries:
            conn.cursor().execute(query)


@op(ins={"start": In(Nothing)})
def copy_files_into_tables(snowflake: SnowflakeResource):
    customers_query = __build_copy_into_query('customers')
    geolocation_query = __build_copy_into_query('geolocation')
    order_items_query = __build_copy_into_query('order_items')
    order_payments_query = __build_copy_into_query('order_payments')
    orders_query = __build_copy_into_query('orders')
    products_query = __build_copy_into_query('products')
    sellers_query = __build_copy_into_query('sellers')

    queries = [
        customers_query,
        geolocation_query,
        order_items_query,
        order_payments_query,
        orders_query,
        products_query,
        sellers_query
    ]
    with snowflake.get_connection() as conn:
        for query in queries:
            conn.cursor().execute(query)


@graph
def extract_load_graph():
    copy_files_into_tables(start=upload_files_to_stages())
