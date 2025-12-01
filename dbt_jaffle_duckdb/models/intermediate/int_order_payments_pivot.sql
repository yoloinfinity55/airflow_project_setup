-- models/intermediate/int_order_payments_pivot.sql

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with payments as (
    select * from {{ ref('stg_payments') }}
),

order_payments as (
    select order_id,
    {% for payment_method in payment_methods -%}
    sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
    {% endfor -%}
    sum(amount) as total_amount
    from payments
    group by 1
)   

select * from order_payments
