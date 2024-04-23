import os
from dagster import EnvVar
from dagster_dbt import DbtCliResource
from dagster_snowflake import SnowflakeResource
from ..utils.db import DBConnection
from ..resources.postgres_resource import PostgresResource
from ..utils.constants import dbt_project_dir


dbt_resource = DbtCliResource(project_dir=os.fspath(dbt_project_dir))
# postgres_resource = PostgresResource(
#     DBConnection(
#         user=EnvVar("WAREHOUSE_USER", ""),
#         password=EnvVar("WAREHOUSE_PASSWORD", ""),
#         db=EnvVar("WAREHOUSE_DB", ""),
#         host=EnvVar("WAREHOUSE_HOST", ""),
#         port=int(EnvVar("WAREHOUSE_PORT", 5432)),
#     )
# )
snowflake_resource = SnowflakeResource(
    database=EnvVar("SNOWFLAKE_DATABASE"),
    account=EnvVar("SNOWFLAKE_ACCOUNT"),
    user=EnvVar("SNOWFLAKE_USER"),
    password=EnvVar("SNOWFLAKE_PASSWORD"),
    warehouse=EnvVar("SNOWFLAKE_WAREHOUSE"),
    schema=EnvVar("SNOWFLAKE_SCHEMA"),
    role=EnvVar("SNOWFLAKE_ROLE"),
)
