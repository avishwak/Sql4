-- Friend Requests II (https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ )

-- using cte 
with cte as (
    select requester_id as id from RequestAccepted
    union all
    select accepter_id as id from RequestAccepted
),
friend_count as (
    select id, count(id) as num 
    from cte 
    group by id
)
select id, num
from friend_count
where num = (select max(num) from friend_count) -- it will also work if there are multiple people with max friends

-- another appraoch
select id, count(id) as num 
from (
    select requester_id as id from RequestAccepted
    union all 
    select accepter_id as id from RequestAccepted
) as temp
group by id
order by num desc 
limit 1 -- works because only one person has the most friends       