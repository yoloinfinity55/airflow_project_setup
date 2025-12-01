-- models/orders.sql

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_payments as (
    select * from {{ ref('int_order_payments_pivot') }}
),

final as (
    select 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,

    {% for payment_method in ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}
    op.{{ payment_method }}_amount as {{ payment_method }}_amount,
    {% endfor -%}
    op.total_amount as amount
    from orders o
    left join order_payments op on o.order_id = op.order_id
)

select * from final
