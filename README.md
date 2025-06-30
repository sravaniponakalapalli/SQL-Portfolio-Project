# 📊 SQL Business Case Study: User & Session Analysis

This project involves solving advanced SQL questions using a simulated `users` and `logins` dataset. It demonstrates time-based analysis, user behavior tracking, and advanced reporting logic.

## 🗂 Tables Used
- **users**: Contains user ID, name, and status.
- **logins**: Contains login timestamps, session scores, and session metadata.

---

## ✅ Task Summaries

### 1. 🕒 Inactive Users in the Last 5 Months
**Objective**: Identify users who have **not logged in within the past 5 months**.  
**Output**: `user_name`  
**Logic**: Compared `MAX(login_timestamp)` per user to `DATEADD(MONTH, -5, GETDATE())`.

---

### 2. 📅 Quarterly Session Summary
**Objective**: Generate a **quarterly report** showing how many users and sessions occurred each quarter.  
**Output**: `quarter_start`, `user_cnt`, `session_cnt`  
**Logic**: Grouped logins by `DATETRUNC(QUARTER, login_timestamp)` and sorted from **newest to oldest**.

---

### 3. 🔄 Users Active in Jan 2024 But Not in Nov 2023  
**Objective**: Find users who logged in during **January 2024** but **not** in **November 2023**.  
**Output**: `user_id`  
**Logic**: Used `MONTH()` and `YEAR()` filters with `EXCEPT` or `NOT IN` logic.

---

### 4. 📈 Quarter-over-Quarter Session Growth  
**Objective**: Enhance Task 2 by adding the **previous quarter’s session count** and the **percentage change**.  
**Output**: `quarter_start`, `session_cnt`, `session_cnt_prev`, `session_percentage_change`  
**Logic**: Used `LAG()` window function to compute previous quarter and growth rate.

---

### 5. 🥇 Daily Top Session Scorer  
**Objective**: Show the user with the **highest session score per day**.  
**Output**: `date`, `user_name`, `score`  
**Logic**: Used subquery with `MAX(session_score)` grouped by date, joined to users.

---

### 6. 🌟 Power Users (Logged in Every Day Since First Login)  
**Objective**: Identify users who logged in **every single day** since their **first login**.  
**Output**: `user_id`  
**Logic**: Compared actual login dates per user to the expected range using `COUNT(*)`, `DATEDIFF()`, and `DISTINCT`.

---

### 7. 🚫 Days With No Logins  
**Objective**: List all dates in the calendar where there were **no logins at all**.  
**Output**: `login_date`  
**Logic**: Created a full calendar using a `CTE` and used `LEFT JOIN` to find dates missing in `logins`.

---

## 🛠 Tech Stack
- SQL Server
- Recursive CTEs
- Window Functions: `LAG()`, `ROW_NUMBER()`
- Date Functions: `DATEADD()`, `DATETRUNC()`, `DATEDIFF()`, `MONTH()`, `YEAR()`

---

## 🧠 Learning Outcomes
This project sharpened skills in:
- Time-series and quarterly reporting
- Conditional user segmentation
- Recursive logic and calendar creation
- Analytical SQL queries for real-world reporting

---

## 📌 Note
Ideal for showcasing your SQL skills in business intelligence, Power BI data prep, or analytics interviews.

