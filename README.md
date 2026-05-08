# 📊 Insurance Analytics Dashboard Project
### DA_P1251 | Group 2 | ExcelR

## 📌 Project Overview
This project showcases the creation of comprehensive Insurance Analytics dashboards
using Excel, Power BI, and Tableau, along with MySQL-based KPI validation.

It replicates real-world analytics workflows where insights are verified across
multiple tools to ensure accuracy, reliability, and data consistency.

---

## 🏢 Problem Statement
The insurance business faced challenges such as:

- Lack of defined KPIs to evaluate policy performance and financial health
- Difficulty tracking payment failures, claim status, and premium trends
- Absence of unified dashboards for management-level decision-making

This project addresses these issues by delivering interactive dashboards and
SQL validation queries that enable data-driven insurance insights.

---

## 🎯 Key KPIs Implemented

| KPI | Description |
|-----|-------------|
| Total Policies | Total number of insurance policies across all statuses — 5,000 |
| Total Customers | Unique customers holding one or more policies — 3,148 |
| Age Bucket Wise Policy Count | Policy distribution across 6 age groups (18-25 to 65+) |
| Gender Wise Policy Count | Policy adoption split by Female, Male and Other |
| Policy Type Wise Count | Breakdown across Health, Property, Life and Auto |
| Policies Expiring in 2026 | Policies due for renewal this year — 453 |
| Premium Growth Rate | Year-over-year premium revenue trend (2015–2024) |
| Claim Status Wise Count | Approved, Pending and Denied claim counts |
| Payment Status Wise Count | Successful vs Failed — 49.7% Failed (Critical) |
| Total Claim Amount | Total financial exposure — ₹251.38 Million |

---

## 📈 Dashboard Requirements
The dashboards visualize insurance data across different perspectives:

- **Age Bucket Distribution** – Policy count grouped by customer age brackets
- **Gender Wise Policies** – Gender-based policy adoption comparison
- **Policy Type Breakdown** – Health, Property, Life, Auto distribution
- **Premium Growth Trend** – Year-over-year revenue growth from 2015–2024
- **Claim Status Analysis** – Approved, Pending and Denied claim tracking
- **Payment Status** – Critical 49.7% payment failure rate identified
- **Policies Expiring 2026** – 453 policies requiring immediate renewal outreach
- **Total Claim Amount** – ₹251.38 Million financial exposure by policy type

---

## 🛠️ Tools & Technologies

- **MySQL 8.0** – For KPI table creation and data validation
- **Microsoft Excel** – For data cleaning, pivot tables and interactive dashboard
- **Power BI Desktop** – For interactive dashboards with dynamic visuals and slicers
- **Tableau Public** – For storytelling dashboards and deeper data exploration

---

## 📂 Project Workflow

1. **Data Collection & Cleaning** – Imported and cleaned 5,000 insurance records
   across 5 sheets. Zero duplicates found. 1,555 null Settlement Dates confirmed
   as logically valid for pending and denied claims.

2. **SQL Validation** – Created `insurance_db` with 5 raw data tables and 10 KPI
   result tables. Wrote advanced queries using JOIN, CASE WHEN, ROLLUP, COALESCE,
   LAG window function and CONCAT.

3. **Dashboard Development**
   - **Excel**: Built interactive dashboard using Pivot Tables, VLOOKUP, IF formulas
     and slicers covering all 10 KPIs.
   - **Power BI**: Developed dynamic dashboards connected directly to MySQL with
     KPI cards, cross-filtering slicers and DAX measures.
   - **Tableau**: Designed visual storytelling dashboards with 10 individual
     worksheets combined into one interactive dashboard.

4. **Insights & Reporting** – Analyzed payment failures, premium trends, claim
   status and policy expiry to derive actionable business recommendations.

---

## 📊 Dashboards

### 🔹 Excel Dashboard
Quick exploratory analysis using Pivot Tables, VLOOKUP, IF formulas and interactive slicers.

![Excel Dashboard](excel_dashboard.jpg)

### 🔹 Power BI Dashboard
Interactive dashboard connected directly to MySQL with KPI cards, cross-filtering
slicers and DAX calculated measures.

![Power BI Dashboard](powerbi_dashboard.jpg)

### 🔹 Tableau Dashboard
Storytelling-based dashboard with 10 individual worksheets combined into one
interactive dashboard with dynamic filters.

![Tableau Dashboard](tableau_dashboard.jpg)

*(All screenshots and dashboard files are included in this repository.)*

---

## 💾 SQL Validation Queries
All KPIs were validated using MySQL queries inside `insurance_db` to ensure
data accuracy and consistency.

| KPI / Chart | SQL Technique Used |
|-------------|-------------------|
| Total Policies | COALESCE + GROUP BY WITH ROLLUP |
| Total Customers | WHERE IN subquery — customers with at least one policy |
| Age Bucket Wise | CASE WHEN + INNER JOIN + ROLLUP |
| Gender Wise | JOIN + GROUP BY Gender WITH ROLLUP |
| Policy Type Wise | IFNULL + ROLLUP + ORDER BY CASE WHEN |
| Expiring 2026 | YEAR(Policy_End_Date) = 2026 filter |
| Premium Growth Rate | LAG() window function for year-over-year % change |
| Claim Status | IFNULL + GROUP BY Claim_Status WITH ROLLUP |
| Payment Status | GROUP BY Payment_Status WITH ROLLUP |
| Total Claim Amount | CONCAT + ROUND(SUM/1,000,000) → ₹251.38 Million |

---

## 🔍 Key Insights

- ⚠️ **49.7% Payment Failure Rate** — 2,484 of 5,000 payments failed. Critical financial risk requiring immediate action.
- 📉 **Premium Revenue Declining** — Down -9.39% in 2023 and -6.70% in 2024 after peaking at +7.53% in 2022.
- 👴 **65+ Age Group Dominates** — Largest segment at 1,408 policies (28.2%). Youth segment (18–25) has only 572 — huge opportunity.
- 🔔 **453 Policies Expiring in 2026** — Immediate renewal campaigns required, especially Property (134).
- 💰 **₹251.38 Million Total Claims** — Only 34.2% approved. 1,650 pending claims need faster resolution.
- ✅ **Balanced Policy Types** — Health (1,316), Property (1,236), Life (1,234), Auto (1,214).

---

## 👥 Team Members — Group 2 | DA_P1251

| # | Name |
|---|------|
| 1 | Ponnaboini Sumanth |
| 2 | Prateek T Jacob |
| 3 | Laxmi K |
| 4 | Suresh Vishnoi |
| 5 | Dabbugottu Maneesh |

---

## ⭐ About
Created with 💡 by Group 2 — ExcelR Data Analytics Training | DA_P1251

This project demonstrates an end-to-end Insurance Analytics solution, combining
data cleaning, MySQL database management, SQL KPI validation, and interactive
dashboard development across Excel, Power BI and Tableau.

---

*Tools: Excel | MySQL 8.0 | Power BI Desktop | Tableau Public*
