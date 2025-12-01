from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

DBT_COMMAND = """
cd /usr/local/airflow/dbt_jaffle_duckdb && \
dbt clean && \
dbt deps && \
dbt seed --full-refresh --profiles-dir . && \
dbt run --profiles-dir . && \
dbt test --profiles-dir .
"""

with DAG(
    'dbt_snowflake_production_pipeline',
    start_date=datetime(2025, 1, 1),
    schedule_interval='@daily',
    catchup=False,
) as dag:

    run_dbt = BashOperator(
        task_id='run_and_test_dbt_models',
        bash_command=DBT_COMMAND
    )
