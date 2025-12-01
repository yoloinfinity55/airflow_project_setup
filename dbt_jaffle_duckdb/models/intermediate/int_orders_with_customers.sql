-- models/intermediate/int_orders_with_customers.sql

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

orders_with_customers as (
    select o.*,c.first_name, c.last_name
    from orders o
    left join customers c on o.customer_id = c.customer_id
)

select 
 order_id,
 customer_id,
 order_date,
 first_name,
 last_name
from orders_with_customers
