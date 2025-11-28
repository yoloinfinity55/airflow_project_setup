# Start from the Airflow base image (Move to Python 3.10 to support dbt 1.8)
FROM apache/airflow:2.7.3-python3.10

# Install dbt-snowflake and its necessary system dependencies
USER root
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the Airflow user
USER airflow

# Install dbt core and the Snowflake adapter (versions 1.8.4 require Python 3.9+)
RUN pip install --no-cache-dir \
    "dbt-core==1.8.4" \
    "dbt-snowflake==1.8.4"

# Set the Airflow working directory
WORKDIR /opt/airflow