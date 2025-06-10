-- Problem 2 : League Statistics		(https://leetcode.com/problems/league-statistics/ )

with cte as (
select home_team_id as team_id, home_team_goals as goal_for, away_team_goals as goal_against
from matches 
union all 
select away_team_id as team_id, away_team_goals as goal_for, home_team_goals as goal_against
from matches)
select team_name, 
count(cte.team_id) as matches_played, 
sum(
    case 
        when goal_for > goal_against then 3
        when goal_for = goal_against then 1
        else 0
    end
)
 as points, 
sum(goal_for) as goal_for, sum(goal_against) as goal_against, 
sum(goal_for) - sum(goal_against) as goal_diff
from teams
join cte on teams.team_id=cte.team_id
group by cte.team_id
order by points desc, goal_diff desc, team_name


/*
just for my future reference! i could come up with the following solution at 1st which works but is too verbose and 
unreadable. BUT I looked at the following solution and generated the above. so, it is a good reference for future
*/
with matches_mod as(
select *, 
(case 
when home_team_goals > away_team_goals then 3
when home_team_goals = away_team_goals then 1
else 0
end) as
home_team_points, 
(case 
when home_team_goals < away_team_goals then 3
when home_team_goals = away_team_goals then 1
else 0
end)
away_team_points
from matches),
cte as (
select home_team_id as team_id, home_team_points as points, home_team_goals as goal_for, away_team_goals as goal_against
from matches_mod 
union all 
select away_team_id as team_id, away_team_points as points, away_team_goals as goal_for, home_team_goals as goal_against
from matches_mod )

select team_name, count(cte.team_id) as matches_played, sum(points) as points, sum(goal_for) as goal_for, sum(goal_against) as goal_against, 
sum(goal_for) - sum(goal_against) as goal_diff
from teams
join cte on teams.team_id=cte.team_id
group by cte.team_id
order by points desc, goal_diff desc, team_name
