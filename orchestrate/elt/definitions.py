from dagster import Definitions
from .assets import transform_data_assets, extract_load_data, raw_data_source
from .schedules import schedules
from .resources import dbt_resource, snowflake_resource

defs = Definitions(
    assets=[extract_load_data, transform_data_assets, raw_data_source],
    schedules=schedules,
    resources={
        "dbt": dbt_resource,
        "snowflake": snowflake_resource
    },
)
