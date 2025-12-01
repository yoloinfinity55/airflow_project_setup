#!/bin/bash

# --- dbt Production Pipeline Script ---
# This script executes the daily dbt run, tests, and documentation generation against Snowflake.

echo "Starting dbt production run against Snowflake target..."

# 1. Run the models (Build tables/views)
dbt run --target snowflake
if [ $? -ne 0 ]; then
    echo "DBT RUN FAILED! Stopping pipeline."
    exit 1
fi

echo "DBT RUN SUCCESSFUL."

# 2. Run the tests (Check data quality)
dbt test --target snowflake
if [ $? -ne 0 ]; then
    echo "DBT TESTS FAILED! Alerting data owners."
    # In a real pipeline, you would add an email/Slack notification here.
fi

echo "DBT TESTS COMPLETE."

# 3. Generate documentation (Update the data catalog)
dbt docs generate --target snowflake

echo "DBT DOCUMENTATION GENERATED."

echo "dbt Pipeline execution complete."