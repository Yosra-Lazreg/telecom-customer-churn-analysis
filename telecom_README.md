# Telecom Customer Churn — Retention Analysis

End-to-end case study using SQL, Python and dashboard-style views to identify telecom subscribers most likely to churn and prioritize retention spend.

## Business question

**Which subscribers are most likely to leave, why, and what should the operator do with a limited retention budget?**

## Finding

The main issue is **contract structure and early tenure, not simply price**. Month-to-month customers churn at **42.7%**, compared with **2.8%** for two-year customers. The fiber-optic plus no-tech-support segment churns at **49.4%** based on 2,230 subscribers, and customers in their first 12 months churn at **47.4%**.

The dataset contains **7,043 subscribers** and about **$1.67M of annualized recurring revenue at risk** among observed churners.

## Modelling

Two classification baselines are included in the notebook

- Logistic regression with `class_weight='balanced'`
- Random forest with `class_weight='balanced'`

Both use a stratified train/test split and are compared using ROC-AUC and churn-class recall. The models are prioritization tools, not causal proof.

## Recommendation

Offer a targeted **two-month-free incentive for a 12-month commitment**, focused on high-risk month-to-month customers in the first year and on fiber customers without tech support. Treat the recommendation as a testable retention hypothesis and measure contract conversion, 90-day retention and protected MRR before claiming financial impact.

## Repository contents

- `sql/telecom_churn_analysis.sql` — PostgreSQL table definition and business queries
- `notebooks/telecom_churn_analysis.ipynb` — reproducible cleaning, segmentation, logistic regression and random forest comparison
- `dashboard_screenshots/dashboard_page_1_overview.png` — dashboard overview preview
- `dashboard_screenshots/dashboard_page_2_retention_playbook.png` — retention playbook preview
- `data/README.md` — public dataset link and download instructions

## Dataset

IBM Telco Customer Churn public dataset, 7,043 rows and 21 columns

Kaggle source

`https://www.kaggle.com/datasets/blastchar/telco-customer-churn`

Public mirror used for reproducibility

`https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv`

## Reproduce

```bash
pip install -r requirements.txt
jupyter notebook notebooks/telecom_churn_analysis.ipynb
```

## Dashboard note

The PNGs are rendered dashboard previews from the same cleaned dataset and KPI definitions. This repository does **not** claim to contain a native `.pbix` file. Add the Power BI file only after creating and validating it in Power BI Desktop.
