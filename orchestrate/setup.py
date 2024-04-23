from setuptools import find_packages, setup

setup(
    name="elt",
    version="0.0.1",
    packages=find_packages(),
    install_requires=[
        "dagster",
        "dagster-cloud",
        "dagster-dbt",
        "dbt-snowflake",
        "dagster-postgres",
        "psycopg2"
    ],
    extras_require={
        "dev": [
            "dagster-webserver",
        ]
    },
)