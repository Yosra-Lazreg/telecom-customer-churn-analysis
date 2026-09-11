-- Telecom Customer Churn — Retention Analysis
-- PostgreSQL

DROP TABLE IF EXISTS telco_customers;
CREATE TABLE telco_customers (
  customer_id TEXT PRIMARY KEY,
  gender TEXT, senior_citizen INT, partner TEXT, dependents TEXT, tenure INT,
  phone_service TEXT, multiple_lines TEXT, internet_service TEXT, online_security TEXT,
  online_backup TEXT, device_protection TEXT, tech_support TEXT, streaming_tv TEXT,
  streaming_movies TEXT, contract TEXT, paperless_billing TEXT, payment_method TEXT,
  monthly_charges NUMERIC(10,2), total_charges NUMERIC(12,2), churn TEXT
);

-- Load the CSV after replacing blank TotalCharges values with NULL.

-- Churn rate and monthly recurring revenue at risk by contract type
SELECT contract, COUNT(*) AS customers,
       ROUND(100.0 * AVG((churn = 'Yes')::int), 1) AS churn_rate_pct,
       ROUND(SUM(CASE WHEN churn = 'Yes' THEN monthly_charges ELSE 0 END), 0) AS mrr_lost
FROM telco_customers
GROUP BY contract
ORDER BY churn_rate_pct DESC;

-- First-year churn risk
SELECT CASE WHEN tenure <= 3 THEN '0-3 months' WHEN tenure <= 6 THEN '4-6 months'
            WHEN tenure <= 12 THEN '7-12 months' ELSE '13+ months' END AS tenure_band,
       COUNT(*) AS customers, ROUND(100.0 * AVG((churn='Yes')::int),1) AS churn_rate_pct
FROM telco_customers
GROUP BY 1 ORDER BY MIN(tenure);

-- High-risk fiber customers without tech support
SELECT internet_service, tech_support, COUNT(*) AS customers,
       ROUND(100.0 * AVG((churn='Yes')::int),1) AS churn_rate_pct
FROM telco_customers
GROUP BY internet_service, tech_support
ORDER BY churn_rate_pct DESC;

-- Revenue at risk by payment method
SELECT payment_method, COUNT(*) AS customers,
       ROUND(SUM(CASE WHEN churn='Yes' THEN monthly_charges ELSE 0 END),0) AS mrr_lost
FROM telco_customers GROUP BY payment_method ORDER BY mrr_lost DESC;
