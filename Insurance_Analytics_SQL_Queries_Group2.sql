CREATE DATABASE insurance_db;
USE insurance_db;

CREATE TABLE customers (
  Customer_ID VARCHAR(20) PRIMARY KEY,
  Name VARCHAR(100),
  Gender VARCHAR(10),
  Age INT,
  Occupation VARCHAR(100),
  Marital_Status VARCHAR(20),
  Address VARCHAR(200)
); 



CREATE TABLE policies (
  Policy_ID VARCHAR(20) PRIMARY KEY,
  Policy_Type VARCHAR(20),
  Coverage_Amount DECIMAL(10,2),
  Premium_Amount DECIMAL(10,2),
  Policy_Start_Date DATE,
  Policy_End_Date DATE,
  Payment_Frequency VARCHAR(20),
  Status VARCHAR(20),
  Customer_ID VARCHAR(20)
);



CREATE TABLE claims (
  Claim_ID VARCHAR(20) PRIMARY KEY,
  Date_of_Claim DATE,
  Claim_Amount DECIMAL(10,2),
  Claim_Status VARCHAR(20),
  Reason_for_Claim VARCHAR(300),
  Settlement_Date DATE,
  Policy_ID VARCHAR(20)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CLAIMSCSV.csv'
INTO TABLE claims
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Claim_ID, Date_of_Claim, Claim_Amount, Claim_Status, Reason_for_Claim, @settlement, Policy_ID)
SET Settlement_Date = NULLIF(@settlement, '');

SELECT COUNT(*) FROM claims 
WHERE Settlement_Date IS NULL;


CREATE TABLE payments (
  Payment_ID VARCHAR(20) PRIMARY KEY,
  Date_of_Payment DATE,
  Amount_Paid DECIMAL(10,2),
  Payment_Method VARCHAR(20),
  Payment_Status VARCHAR(20),
  Policy_ID VARCHAR(20)
);

CREATE TABLE additional_fields (
  Agent_ID VARCHAR(20),
  Renewal_Status VARCHAR(20),
  Policy_Discounts INT,
  Risk_Score INT,
  Policy_ID VARCHAR(20)
);







/* KPI 1: Total Policies
Definition: Total number of policies in the system (active and inactive).
Purpose: Provides an overall view of policy volume */

CREATE TABLE kpi1_total_policies AS
SELECT 
  COALESCE(Status, 'Grand Total') AS Status,
  COUNT(*) AS Policy_Count
FROM policies
GROUP BY Status WITH ROLLUP;

SELECT * FROM kpi1_total_policies;

/* KPI 2: Total Customers
Definition: Total count of customers who hold one or more policies.
Purpose: Indicates customer base size and engagement */

CREATE TABLE kpi2_total_customers AS
SELECT COUNT(*) AS Total_Customers
FROM customers
WHERE Customer_ID IN (
    SELECT Customer_ID 
    FROM policies
);

SELECT * FROM kpi2_total_customers;


/* KPI 3: Age Bucket Wise Policy Count
 Definition: Policies grouped by customer age brackets (e.g., 18-25, 26-35).
Purpose: Analyzes policy distribution across different age groups */

CREATE TABLE kpi3_age_bucket AS
SELECT
  IFNULL(Age_Bucket, 'Grand Total') AS Age_Bucket,
  COUNT(*) AS Policy_Count
FROM (
  SELECT
    CASE
      WHEN c.Age BETWEEN 18 AND 25 THEN '18-25'
      WHEN c.Age BETWEEN 26 AND 35 THEN '26-35'
      WHEN c.Age BETWEEN 36 AND 45 THEN '36-45'
      WHEN c.Age BETWEEN 46 AND 55 THEN '46-55'
      WHEN c.Age BETWEEN 56 AND 65 THEN '56-65'
      ELSE '65+'
    END AS Age_Bucket
  FROM customers c
  INNER JOIN policies p 
    ON c.Customer_ID = p.Customer_ID
) t
GROUP BY Age_Bucket WITH ROLLUP;

select * from kpi3_age_bucket;


/* KPI 4: Gender Wise Policy Count
Definition: Number of policies categorized by gender (male, female, other).
Purpose: Identifies trends and gaps in policy adoption by gender */

create table kpi4_gender
SELECT 
  IFNULL(c.Gender, 'Grand Total') AS Gender,
  COUNT(p.Policy_ID) AS Policy_Count
FROM customers c
JOIN policies p 
  ON c.Customer_ID = p.Customer_ID
GROUP BY c.Gender WITH ROLLUP;

select * from kpi4_gender;


/* KPI 5: Policy Type Wise Policy Count
Definition: Number of policies distributed by policy type
Purpose: Tracks which policy categories are most popular */

create table kpi5_policy_type as 
SELECT *
FROM (
  SELECT 
    IFNULL(Policy_Type, 'Grand Total') AS Policy_Type,
    COUNT(*) AS Policy_Count
  FROM policies
  GROUP BY Policy_Type WITH ROLLUP
) t
ORDER BY 
  CASE 
    WHEN Policy_Type = 'Grand Total' THEN 2
    ELSE 1
  END,
  Policy_Count DESC;
  
  select * from kpi5_policy_type;


/* KPI 6: Policies Expiring This Year (2026)
Definition: Count of policies set to expire within the current calendar year.
Purpose: Helps focus on renewal opportunities */

CREATE TABLE kpi6_expiring_2026 AS
SELECT COUNT(*) AS Policies_Expiring_2026
FROM policies
WHERE YEAR(Policy_End_Date) = 2026;

SELECT * FROM kpi6_expiring_2026;


/* KPI 7: Premium Growth Rate
Definition: Percentage increase in premium revenue over a specific time period.
Purpose: Measures business growth from premiums */

CREATE TABLE kpi7_premium_growth As
SELECT
  Year,

  CONCAT(ROUND(Total_Premium / 1000, 2), ' K') AS Total_Premium,

  CASE 
    WHEN LAG(Total_Premium) OVER (ORDER BY Year) IS NULL THEN 'N/A'
    ELSE ROUND(
      ((Total_Premium - LAG(Total_Premium) OVER (ORDER BY Year))
      / LAG(Total_Premium) OVER (ORDER BY Year)) * 100
    , 2)
  END AS Growth_Pct

FROM (
  SELECT
    YEAR(Policy_Start_Date) AS Year,
    SUM(Premium_Amount) AS Total_Premium
  FROM policies
  GROUP BY Year
) t
ORDER BY Year;


select * from kpi7_premium_growth;

/* KPI 8: Claim Status Wise Policy Count
Definition: Count of policies grouped by claim status (e.g., approved, rejected, pending).
Purpose: Tracks claim processing efficiency */

drop table if exists kpi8_claim_status;
CREATE TABLE kpi8_claim_status AS
SELECT 
  IFNULL(Claim_Status, 'Grand Total') AS Claim_Status,
  COUNT(*) AS Claim_Count
FROM claims
GROUP BY Claim_Status WITH ROLLUP;


select * from kpi8_claim_status;


/* KPI 9: Payment Status Wise Count
Definition: Policies categorized by payment status (e.g., paid, overdue, pending).
Purpose: Monitors financial health and payment compliance */

create TABLE kpi9_payment_status AS
SELECT 
  IFNULL(Payment_Status, 'Grand Total') AS Payment_Status,
  COUNT(*) AS Policy_Count
FROM payments
GROUP BY Payment_Status WITH ROLLUP;

select * from kpi9_payment_status;


/* KPI 10: Total Claim Amount
Definition: Total amount paid for claims across all policies.
Purpose: Tracks the financial impact of claims on the business */


create table kpi10_total_claim_amount as 
SELECT CONCAT('₹ ', ROUND(SUM(Claim_Amount) / 1000000, 2), ' Million') AS Total_Claim_Amount
FROM claims;

SELECT * FROM kpi10_total_claim_amount;