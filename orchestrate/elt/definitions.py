import os

from dagster import Definitions
from dagster_dbt import DbtCliResource

from .assets.dbt import transform_dbt_assets
from .utils.constants import dbt_project_dir
from .schedules.schedules import schedules

defs = Definitions(
    assets=[transform_dbt_assets],
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)