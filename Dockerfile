FROM quay.io/astronomer/astro-runtime:12.1.0

# Create a virtual environment and install dbt there
# We verify the path to ensure it's usable
RUN python -m venv dbt_venv && \
    dbt_venv/bin/pip install --no-cache-dir \
    "dbt-duckdb>=1.8.0,<1.9.0" \
    "dbt-postgres>=1.8.0,<1.9.0"

# Install standard Airflow requirements
# (This runs separately and won't conflict with the dbt_venv)
COPY requirements.txt .
RUN /usr/local/bin/install-python-dependencies
