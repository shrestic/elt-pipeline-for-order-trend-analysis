from dagster import job
from ..ops import extract_load_graph


@job
def extract_load_job():
    extract_load_graph()
