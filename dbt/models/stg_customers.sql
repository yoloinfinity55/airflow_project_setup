-- Staging model for customers
{{ config(materialized='view') }}

SELECT 
    1 as customer_id,
    'John Doe' as customer_name,
    'john@example.com' as email,
    CURRENT_TIMESTAMP() as created_at
    
UNION ALL

SELECT 
    2 as customer_id,
    'Jane Smith' as customer_name,
    'jane@example.com' as email,
    CURRENT_TIMESTAMP() as created_at
