# Project Overview
The project builds an ELT pipeline to collect e-commerce data from different data sources and joins them together to analyze sale by order date over time.
## Dagster Graph Design
<img width="1123" alt="image" src="https://github.com/shrestic/e_commerce_elt_pipeline/assets/60643737/0e92e666-5ff0-4365-8082-27f489a745c1">

## Architecture

![elt_pipeline](https://github.com/shrestic/e_commerce_elt_pipeline/assets/60643737/1b0d85ba-1cb4-401b-b2c1-d19324ac0a63)
#### 1. Source: Local CSV File

The data resides in a local CSV file for initial processing.
#### 2. Extract & Transform (Local):
 * Read the CSV data.
 * Perform transformations (cleaning, deriving new columns, validation).
#### 3. Load (Snowflake):

* Connect to Snowflake using SnowSQL or a Python library (Snowflake-Connector-Python).
* Stage the transformed data in a temporary table.
* Use `COPY INTO` to load data from staging into the final destination table.
#### 4. Transform (dbt):

* Create dbt models for further data transformations within Snowflake.
* dbt models enable complex calculations, aggregations, and data joins.
* This separates transformation logic from the initial data loading script.
#### 5. Visualization (Metabase):
* Connect Metabase to your Snowflake warehouse.
* Build dashboards and visualizations using the transformed data.
* Metabase allows for interactive data exploration and analysis.
#### 6. Orchestration (Dagster):
* Define a Dagster pipeline with steps for each ELT stage.
* Utilize Dagster solids to encapsulate data processing logic.
* Schedule the pipeline for periodic execution using Dagster's scheduling capabilities.

## Visualize
<h2 align="center">Sales Performance Analysis by Order Date</h2>
<p align="center">
<img width="706" alt="image" src="https://github.com/shrestic/e_commerce_elt_pipeline/assets/60643737/1739e325-b985-4b60-a1ca-bcc223ae0bcb">
</p>





## Authors
- [Phong Nguyen](https://github.com/shrestic)

