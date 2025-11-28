-- Simple test model to verify dbt is working
SELECT 
    1 as id,
    'Test Record' as name,
    CURRENT_TIMESTAMP() as created_at
