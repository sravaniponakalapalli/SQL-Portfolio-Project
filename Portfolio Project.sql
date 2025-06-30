create database project
use project
drop table if exists users
CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);
-- Users Table
INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');

drop table if exists logins
CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- Logins Table 
INSERT INTO LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);


-- 2024 Q1
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);

INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);

select *
from users
select *
from logins

--1. Management wants to see all the users that did not login in the past 5 months
-- return: Username

select USER_ID,USER_NAME
from users
where USER_ID in(
select USER_ID
from logins
group by USER_ID
having MAX(login_timestamp) < DATEADD(month,-5,cast('2024-06-28' as date))
)

SELECT u.USER_NAME
FROM users u
LEFT JOIN (
    SELECT USER_ID, MAX(LOGIN_TIMESTAMP) AS LAST_LOGIN
    FROM logins
    GROUP BY USER_ID
) l ON u.USER_ID = l.USER_ID
WHERE l.LAST_LOGIN < DATEADD(MONTH, -5, CAST('2024-06-28' AS DATE));

--2. for the business units quartely analysis, calculate how many users and how many sessions were at each quarter order by quarter from newest to oldest.
--return: first day of the quarter,user_cnt,session_cnt.
select *
from users
select *
from logins

select DATETRUNC(quarter,login_timestamp) as first_day_quarter,COUNT(distinct user_id) as user_cnt,COUNT(SESSION_ID) as session_cnt
from logins
group by DATETRUNC(quarter,login_timestamp)
order by DATETRUNC(quarter,login_timestamp) desc

--3. Display userid's that login in january 2024 and did not login in november 2023
--return: user_id
select *
from logins

with cte1 as(
select *
from logins
where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31'
),
cte2 as(
select distinct USER_ID
from logins
where USER_ID not in (
select USER_ID
from logins
where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30'
)
)
select distinct cte1.user_id
from cte1
join cte2
on cte1.user_id = cte2.user_id

-- or --
select distinct USER_ID
from logins
where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31' and
USER_ID not in (
select USER_ID
from logins
where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30'
)

--4. Add to the query from 2 the percentage change in session from last quarter.
--return: first day of the quarter, session_cnt, session_cnt_prev, session_percentage_change.

--2. for the business units quartely analysis, calculate how many users and how many sessions were at each quarter order by quarter from newest to oldest.

select *
from logins

with cte1 as(
select DATETRUNC(quarter,LOGIN_TIMESTAMP) as first_day_quarter,COUNT(session_id) as session_cnt,LAG(COUNT(session_id),1) over(order by DATETRUNC(quarter,LOGIN_TIMESTAMP)) as session_cnt_prev
from logins
group by DATETRUNC(quarter,LOGIN_TIMESTAMP)
)
select *,round(cast((session_cnt - session_cnt_prev) as float)*100/session_cnt_prev,2) as session_percentage_change
from cte1

--5. Display the user that had the highest session score(max) for each day
--return: date, username, score.
select *
from users
select *
from logins

select date,u.USER_NAME,highest_score
from users u
join (
select cast(LOGIN_TIMESTAMP as date) as date,MAX(session_score) as highest_score,USER_ID
from logins
group by cast(LOGIN_TIMESTAMP as date),USER_ID
) as l
on u.USER_ID = l.USER_ID
order by date
--If you want only one user per day, even if there's a tie, we can use ROW_NUMBER().

with cte as(
select USER_ID,CAST(login_timestamp as date) as date,sum(session_score) as session_scores
from logins
group by USER_ID,CAST(login_timestamp as date)
),
cte2 as(
select *,RANK() over(partition by date order by session_scores) as rn
from cte
)
select date,u.USER_NAME,case when rn=1 then session_scores end as highest_score
from users u
join cte2 c2
on u.USER_ID = c2.USER_ID

--6. To identify our best users - Return the users that had a session on every single day since their first login
--(make assumptions if needed).
--Return: user_id
select *
from logins
order by USER_ID

with cte as(
select USER_ID,MIN(login_timestamp) as first_login,MAX(login_timestamp) as last_login,DATEDIFF(day,MIN(login_timestamp),MAX(login_timestamp))+1 as datediffs,
COUNT(*) as session
from logins
group by USER_ID
)
select USER_ID
from cte
where datediffs=session

--7. On what dates there were no login at all?
--return: Login_dates
select *
from logins

select MIN(login_timestamp),MAX(login_timestamp)
from logins

with r_cte as(
select MIN(login_timestamp) as f_date,MAX(login_timestamp) as l_date
from logins
union all
select DATEADD(day,1,f_date) as f_date ,l_date
from r_cte
where f_date<l_date
)
select f_date
from r_cte
where f_date not in(
select distinct login_timestamp
from logins
)
option(maxrecursion 500)