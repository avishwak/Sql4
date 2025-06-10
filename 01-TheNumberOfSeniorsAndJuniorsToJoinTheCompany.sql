-- Problem 1 : The Number of Seniors and Juniors to Join the Company	(https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/)

with cte as(
select *, sum(salary) over (partition by experience order by salary, employee_id) as 'rsum'
from candidates)
select 'Senior' as experience, count(*) as 'accepted_candidates'
from cte
where experience='Senior' and rsum <= 70000
union
select 'Junior' as experince, count(*) as 'accepted_candidates'
from cte 
where experience = 'Junior' and rsum <= (select 70000 - ifnull(max(rsum),0) from cte where experience='Senior' and rsum <= 70000)