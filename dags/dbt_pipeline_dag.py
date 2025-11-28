from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Define default arguments
default_args = {
    'owner': 'airflow',
    'start_date': datetime(2025, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# The path *inside the Airflow container* where the dbt project is mounted
DBT_PROJECT_DIR = '/opt/airflow/dbt'

# Define the DAG
with DAG(
    dag_id='dbt_snowflake_production_pipeline',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    tags=['dbt', 'production'],
) as dag:

    # Task 1: Run the entire dbt production script (dbt run + dbt test)
    run_dbt_pipeline = BashOperator(
        task_id='run_and_test_dbt_models',
        bash_command=f'{DBT_PROJECT_DIR}/run_production_pipeline.sh',
        cwd=DBT_PROJECT_DIR,
    )
    # CRITICAL FIX: Stops Airflow from trying to render 'cwd' path before execution
    run_dbt_pipeline.template_fields = []

    # Task 2: Dummy task to signify pipeline completion
    bi_refresh_complete = BashOperator(
        task_id='bi_refresh_complete',
        bash_command='echo "Data pipeline finished. BI dashboards are fresh."',
    )

    # Set dependency
    run_dbt_pipeline >> bi_refresh_complete