import os
from dagster import EnvVar
from dagster_dbt import DbtCliResource
from dagster_snowflake import SnowflakeResource
from ..utils.constants import dbt_project_dir


dbt_resource = DbtCliResource(project_dir=os.fspath(dbt_project_dir))

snowflake_resource = SnowflakeResource(
    database=EnvVar("SNOWFLAKE_DATABASE"),
    account=EnvVar("SNOWFLAKE_ACCOUNT"),
    user=EnvVar("SNOWFLAKE_USER"),
    password=EnvVar("SNOWFLAKE_PASSWORD"),
    warehouse=EnvVar("SNOWFLAKE_WAREHOUSE"),
    schema=EnvVar("SNOWFLAKE_SCHEMA"),
    role=EnvVar("SNOWFLAKE_ROLE"),
)
