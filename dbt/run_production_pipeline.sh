#!/bin/bash

# Use '--profiles-dir .' to ensure dbt looks for project configuration
# in the current working directory, which is /opt/airflow/dbt.

echo "Starting dbt run..."
dbt run --profile jaffle_shop --target prod --profiles-dir .

if [ $? -ne 0 ]; then
  echo "dbt run failed! Exiting."
  exit 1
fi

echo "Starting dbt test..."
dbt test --profile jaffle_shop --target prod --profiles-dir .

if [ $? -ne 0 ]; then
  echo "dbt test failed! Exiting."
  exit 1
fi

echo "dbt pipeline completed successfully."