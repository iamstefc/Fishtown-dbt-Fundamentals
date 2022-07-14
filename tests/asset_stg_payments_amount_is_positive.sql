with payments as (
    select * from {{ ref('stg_payments')}}
)

-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.
select 
    order_id, 
    sum(amount) as total_amount
from stg_payments
group by order_id
having total_amount < 0 

-- another possible implementation
/*select
    order_id,
    sum(amount) as total_amount
from {{ ref('stg_payments') }}
group by 1
having not(total_amount >= 0)*/