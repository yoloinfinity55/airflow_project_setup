-- models/customers_metrics.sql

with base as (
        select * from {{ ref('int_orders_with_customers') }}
),

add_first_order_date as (
    select *,
    min(order_date) over (partition by customer_id) as first_order_date
    from base
),

customer_aggregate as (
    select customer_id,
    first_order_date,
    count(order_id)  as total_orders,
    sum(10) as lifetime_spend_placeholder
    from add_first_order_date
    group by 1,2
)

select * from customer_aggregate
