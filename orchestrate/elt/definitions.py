from dagster import Definitions
from .jobs import extract_load_job
from .schedules import schedules
from .resources import dbt_resource, snowflake_resource

defs = Definitions(
    jobs=[extract_load_job],
    schedules=schedules,
    resources={
        "dbt": dbt_resource,
        "snowflake": snowflake_resource
    },
)
