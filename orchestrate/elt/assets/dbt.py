from dagster import AssetExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets
from ..utils.constants import dbt_manifest_path


@dbt_assets(manifest=dbt_manifest_path)
def transform_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()