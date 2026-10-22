# 🛒 E-Commerce Customer Retention & RFM Segmentation Analysis

An end-to-end customer analytics project designed to evaluate customer purchasing patterns, churn risks, and behavioral metrics in an e-commerce environment. This project leverages **SQL (SQLite)** for data modeling, window functions, and RFM scoring, **Python** for data pipeline orchestration, and **Tableau** for interactive business reporting.

---

## 🔗 Interactive Dashboard
👉 **[View Live Tableau Dashboard](https://us-east-1.online.tableau.com/#/site/johnaxelor04-6b197cf4e4/workbooks/5798118?:origin=card_share_link)**

---

## 📌 Executive Summary

* **Business Problem:** The platform exhibits varying levels of customer inactivity, with significant risk of revenue loss concentrated in non-gold membership tiers.
* **Objective:** Segment customers using an **RFM (Recency, Frequency, Monetary)** framework to identify high-value users, detect inactive accounts, and deliver data-driven retention recommendations.
* **Key Findings:**
  1. **Tier Loyalty Disparity:** **Gold** members show low inactivity (**5.13% at risk**), high average spend (**$1,311.14**), and high satisfaction. Conversely, **Silver** and **Bronze** tiers exhibit an at-risk rate above **49%** and **51%**, respectively.
  2. **RFM Segmentation Distribution:** Out of 350 total customers, **174 users (~49.7%)** fall into the **`At Risk / Need Attention`** (115 users) or **`Lost / Hibernating`** (59 users) categories, requiring targeted re-engagement strategies.
  3. **Satisfaction Impact:** Customer inactivity strongly correlates with lower satisfaction levels (`Unsatisfied` / `Neutral`), particularly within Bronze and Silver tiers.

---

## 🛠️ Tech Stack & Methodology

* **Database & Querying:** SQL (SQLite) — CTEs, Window Functions (`NTILE`), Conditional Aggregations (`CASE WHEN`).
* **Data Pipeline & Orchestration:** Python (`pandas`, `sqlite3`).
* **Data Visualization & BI:** Tableau Cloud / Tableau Public.
* **Version Control:** Git & GitHub.

---

## 📊 Analytics Workflow & SQL Techniques

```text
E_Commerce_Dataset.csv 
       │
       ▼
[Python ETL & SQLite Engine] ──► SQLite DB (ecommerce_churn.db)
       │
       ▼
[Advanced SQL Queries] ───────► RFM Segmentation & Risk Calculation
       │
       ▼
[Enriched Export] ────────────► ecommerce_rfm_segments.csv ──► [Tableau Dashboard]
