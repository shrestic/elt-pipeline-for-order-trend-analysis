from typing import Tuple
from dagster import Any, AssetExecutionContext, AssetOut, Output, graph_asset, multi_asset
from dagster_dbt import DbtCliResource, dbt_assets
from dagster_snowflake import SnowflakeResource
from ..ops import upload_files_to_stages
from ..utils.constants import dbt_manifest_path


def __build_copy_into_query(name):
    query = f"""
        COPY INTO {name} FROM @%{name}
        FILE_FORMAT = mycsvformat
        ON_ERROR = SKIP_FILE_10
        PURGE = TRUE ;
    """
    return query


@dbt_assets(manifest=dbt_manifest_path)
def transform_data_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["run"], context=context).stream()


@graph_asset()
def extract_load_data():
    return upload_files_to_stages()


@multi_asset(
    deps=[extract_load_data],
    outs={
        "raw_customers": AssetOut(),
        "raw_geolocation": AssetOut(),
        "raw_order_items": AssetOut(),
        "raw_order_payments": AssetOut(),
        "raw_orders": AssetOut(),
        "raw_products": AssetOut(),
        "raw_sellers": AssetOut(),
    },
)

def raw_data_source(snowflake: SnowflakeResource):
    source_dict = {
        "raw_customers": __build_copy_into_query("raw_customers"),
        "raw_geolocation": __build_copy_into_query("raw_geolocation"),
        "raw_order_items": __build_copy_into_query("raw_order_items"),
        "raw_order_payments": __build_copy_into_query("raw_order_payments"),
        "raw_orders": __build_copy_into_query("raw_orders"),
        "raw_products": __build_copy_into_query("raw_products"),
        "raw_sellers": __build_copy_into_query("raw_sellers"),
    }

    with snowflake.get_connection() as conn:
        asset_keys = (key for key in source_dict.keys())
        for _, query in source_dict.items():
            conn.cursor().execute(query)
    return tuple(list(asset_keys))
