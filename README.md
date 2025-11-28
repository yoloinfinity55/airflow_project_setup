# Airflow + dbt + Snowflake Pipeline

This project automates an ELT pipeline using Docker, Airflow, and dbt.

## Architecture
*   **Orchestration:** Apache Airflow (running in Docker)
*   **Transformation:** dbt (Data Build Tool)
*   **Data Warehouse:** Snowflake

## How to Run
1.  Clone the repo
2.  Create a `.env` file with your Snowflake credentials (see `.env.example`)
3.  Run `docker-compose up -d`