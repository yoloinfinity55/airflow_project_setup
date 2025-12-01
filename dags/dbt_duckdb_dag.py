from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# ============================================================
# Configuration
# ============================================================

DBT_PROJECT_DIR = "/usr/local/airflow/dbt_jaffle_duckdb"
PROFILES_DIR = DBT_PROJECT_DIR
DBT_EXECUTABLE = "/usr/local/airflow/dbt_venv/bin/dbt"

# ============================================================
# dbt commands
# ============================================================

# Add the Seed command
DBT_SEED_CMD = f"""
    cd {DBT_PROJECT_DIR} && \
    {DBT_EXECUTABLE} seed --profiles-dir {PROFILES_DIR} --profile duckdb_local
"""

DBT_RUN_CMD = f"""
    cd {DBT_PROJECT_DIR} && \
    {DBT_EXECUTABLE} run --profiles-dir {PROFILES_DIR} --profile duckdb_local
"""

DBT_TEST_CMD = f"""
    cd {DBT_PROJECT_DIR} && \
    {DBT_EXECUTABLE} test --profiles-dir {PROFILES_DIR} --profile duckdb_local
"""

with DAG(
    dag_id='local_duckdb_pipeline',
    start_date=datetime(2025, 1, 1),
    schedule_interval='@daily',
    catchup=False,
    tags=['local', 'duckdb', 'docker'],
) as dag:

    # Define the seed task
    seed_data = BashOperator(
        task_id='dbt_seed',
        bash_command=DBT_SEED_CMD
    )

    run_models = BashOperator(
        task_id='dbt_run',
        bash_command=DBT_RUN_CMD
    )

    test_models = BashOperator(
        task_id='dbt_test',
        bash_command=DBT_TEST_CMD
    )

    # Set the dependency order: Seed -> Run -> Test
    seed_data >> run_models >> test_models
