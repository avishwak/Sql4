-- Problem 3 : Sales Person (https://leetcode.com/problems/sales-person/ )

-- using cte
with cte as (
select order_id, o.com_id, name as c_name, sales_id
from company c
join orders o on c.com_id = o.com_id
)
select sp.name
from salesperson sp 
left join cte c on sp.sales_id=c.sales_id
group by sp.sales_id
having sum(case when c.c_name='RED' then 1 else 0 end) = 0 

-- more straight forward
select name from salesperson 
where sales_id not in (
select sales_id
from company c
join orders o on c.com_id = o.com_id
where c.name = 'RED')