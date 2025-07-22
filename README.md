# 🛒 E-commerce Customer Analytics Project
e_commerce_customer_analytics/ ├── models/ │   ├── staging/             # Raw staging models (customers, orders, products) │   ├── intermediate/        # Business logic models (RFM scoring, aggregations) │   ├── marts/               # Final models for segmentation, top customers │ ├── snapshots/               # Optional: Snapshot models for SCD handling ├── macros/                  # Reusable macros (e.g., percent_rank, days_diff) ├── tests/                   # Data quality & schema tests ├── dbt_project.yml

---

## 📊 Use Case Summary

**Business Scenario**:  
E-commerce company wants to track and analyze customer behavior using RFM (Recency, Frequency, Monetary) model, identify top customers, and detect churn risk segments.

---

## ⚙️ Model Flow Overview

Raw → Staging → Intermediate → Mart

### 1. **Staging Layer**
- Cleanses and standardizes data from `customers`, `orders`, `products`.

### 2. **Intermediate Layer**
- Calculates:
  - `recency`, `frequency`, `monetary` per customer
  - `rfm_score` & `ranking`
  
### 3. **Mart Layer**
- Combines all logic for business reporting:
  - `customer_segmentation_mart.sql`: RFM, churn, behavioral segments
  - `top_customers_mart.sql`: Top 20 contributors, active status

---

## 📌 Key Features

| Feature                          | Included   |
|----------------------------------|----------
| 🔢 RFM Score Computation         | ✅        |
| 🧠 Behavioral Segmentation       | ✅        |
| 🔁 Churn Status Tagging          | ✅        |
| ⭐ Top Customer Identification   | ✅        |
| 📦 Data Quality Tests            | ✅        |
| 📸 Snapshots (SCD Ready)         | ✅ Optional |
| 🧩 Custom Macros                 | ✅        |
| 🔁 Incremental Model Logic       | ✅ (If needed) |
| 🚀 CI/CD via GitHub Actions      | ✅ Optional |

---

## 🧠 Sample Business Questions Answered

- Who are the **top 20 high-value customers**?
- Which customers are **churned** or **at risk**?
- How many customers are **loyal high spenders**?
- What’s the RFM segment of each customer?

---

## 📈 Output Sample (dbt Mart Models)

| customer_id | rfm_score | churn_status | behavioral_segment | combined_segment               |
|-------------|-----------|---------------|---------------------|------------------------------|
| CUST101     | 543       | At Risk       | Loyal Customer      | At Risk - Loyal Customer     |
| CUST212     | 555       | Active        | Loyal High Spender  | Active - Loyal High Spender  |
| CUST333     | 311       | Churned       | Occasional          | Churned - Occasional         |

---

## 🛠️ CI/CD & Testing (Optional)

You can integrate this project with:

- ✅ **dbt Cloud + GitHub**
- ✅ GitHub Actions or Azure DevOps pipelines
- ✅ Run `dbt test` on every pull request
- ✅ Alerts on test failure or job failure (email/slack)

---

## 🌱 Future Enhancements

You can extend this project with:

- 📊 **Weekly/Monthly aggregates**
- 🛍️ **Product-wise insights**
- 🎯 **Campaign targeting dashboard (e.g., churn winback)**
- 📥 Automate via **Snowflake Tasks + Streams**
- 🔄 **Full SCD Type 2 via Snapshots**
- 🧠 **Advanced ML model integration** (Propensity, LTV)

---

## 👨‍💻 Author

**Shankar Kamalakannan**  
Snowflake + dbt Developer | Real-time Data Projects  
GitHub: [@Shankarkk](https://github.com/Shankarkk)

---

## 📎 License

This project is open for educational use and real-time interview demonstration. Reach out for collaboration or freelance integration help ✌️


---
