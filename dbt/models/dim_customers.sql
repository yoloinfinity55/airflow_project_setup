-- Dimension table for customers
{{ config(materialized='table') }}

SELECT 
    customer_id,
    customer_name,
    email,
    created_at
FROM {{ ref('stg_customers') }}
