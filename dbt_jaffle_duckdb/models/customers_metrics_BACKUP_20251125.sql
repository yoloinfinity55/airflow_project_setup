SELECT
    -- Select key customer attributes
    c.customer_id,
    c.first_name,
    c.last_name,

    -- Calculate lifetime metrics (using the 'orders' model)
    COUNT(o.order_id) AS lifetime_orders,
    SUM(o.amount) AS lifetime_spend
    
FROM {{ ref('customers') }} c  -- Reference the 'customers' model
LEFT JOIN {{ ref('orders') }} o  -- Reference the 'orders' model
    ON c.customer_id = o.customer_id
GROUP BY 1, 2, 3
ORDER BY lifetime_spend DESC