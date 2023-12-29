Create database P1;
use p1;
select * from finance_merge123;
SELECT STR_TO_DATE(issue_d, '%Y-%m-%d %H:%i:%s') AS converted_datetime from finance_merge123;
# SELECT year(ISSUE_D) AS ISSUE_YEARS from finance_merge123;
# SELECT STR_TO_DATE(issue_d, '%d %M %Y') AS converted_date from finance_merge123;
SELECT YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS year_value FROM finance_merge123;

# KPI 1 - YEAR WISE LOAN AMOUNT STATUS

SELECT YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS year_value, 
SUM(LOAN_AMNT) AS TOTAL_AMOUNT 
FROM finance_merge123 
group by year_value
ORDER BY TOTAL_AMOUNT DESC;


# KPI-2  Grade and sub grade wise revol_bal

SELECT grade, sub_grade, AVG(revol_bal) AS avg_revol_bal
FROM finance_merge123
GROUP BY grade, sub_grade;


# KPI-3 Total Payment for Verified Status Vs Total Payment for Non Verified Status

SELECT verification_status,
       SUM(total_pymnt) AS total_payment
FROM finance_merge123
GROUP BY verification_status;

# KPI 4 - STATEWISE & MONTHWISE LOAN STATUS
SELECT ADDR_STATE AS STATE, LAST_PYMNT_D, LOAN_STATUS,
COUNT(*) AS LOAN_COUNT 
FROM finance_merge123
GROUP BY ADDR_STATE, last_pymnt_d, loan_status
ORDER BY ADDR_STATE, last_pymnt_d, loan_status;



# KPI 5 - HOME OWNERSHIP VS LAST PAYMENT DATE STATS


SELECT YEAR(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS PAYMENT_YEAR,
MONTHNAME(STR_TO_DATE(issue_d, '%d-%m-%Y')) AS PAYMENT_MONTH,
HOME_OWNERSHIP, COUNT(HOME_OWNERSHIP) AS HOME_OWNERSHIP FROM FINANCE_merge123 
WHERE HOME_OWNERSHIP IN ('RENT', 'MORTGAGE', 'OWN', 'OTHERS')
GROUP BY PAYMENT_YEAR, PAYMENT_MONTH, HOME_OWNERSHIP
ORDER BY PAYMENT_YEAR, HOME_OWNERSHIP DESC;


# KPI-6 Year wise Total Interest Received

SELECT YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')) AS PAYMENT_YEAR,
       SUM(total_rec_int) AS total_interest_received
FROM finance_merge123
GROUP BY payment_year;