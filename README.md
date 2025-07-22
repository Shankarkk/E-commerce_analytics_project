🛍️ E-commerce Analytics Project with dbt + Snowflake

This project focuses on building a scalable, modular analytics pipeline using dbt (Data Build Tool) on Snowflake for a hypothetical e-commerce platform. It transforms raw customer, order, and product data into actionable insights through RFM segmentation, churn analysis, and behavioral profiling.


---

📁 Project Structure

e_commerce_analytics/
├── models/
│   ├── staging/                # Raw data cleaning & type casting
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_payments.sql
│   │
│   ├── intermediate/          # Business logic transformation
│   │   ├── int_order_payments.sql
│   │   ├── int_customer_orders.sql
│   │   └── int_rfm_ranked_customers.sql
│   │
│   ├── marts/                 # Final reporting models
│   │   ├── customer_segmentation_mart.sql
│   │   └── top_customers_mart.sql
│
├── snapshots/                 # (Optional) Snapshots for SCD tracking
│
├── dbt_project.yml            # Project-level configuration
└── README.md                  # Project documentation (this file)


---

🧠 Business Goals

Track customer behavior based on recency, frequency, and monetary metrics.

Identify customer churn early to take retention action.

Segment customers into actionable groups (e.g., loyal, high spender).

Identify top contributing customers.



---

🔄 Data Flow

Source Tables (assumed loaded into Snowflake):

raw_customers

raw_orders

raw_payments


1. Staging Layer (stg_*)

Clean column names

Convert date formats

Standardize data types

Filter invalid records if any


2. Intermediate Layer (int_*)

Join orders with payments

Calculate total spend, number of orders per customer

Derive RFM (Recency, Frequency, Monetary) scores and rankings


3. Marts Layer (*_mart)

Final outputs used by dashboards & business teams

Includes:

customer_segmentation_mart: RFM + churn + behavior logic

top_customers_mart: Top 20 customers ranked by contribution




---

📊 Model Descriptions

✅ customer_segmentation_mart.sql

RFM scoring and segmentation

Churn logic based on recency

Behavioral segmentation based on frequency & spend

Combined segment (e.g., Active - High Spender)


> Config:



{{ config(
    materialized='table',
    schema='marts',
    tags=['customer_segmentation', 'rfm', 'churn_analysis']
) }}


---

✅ top_customers_mart.sql

Ranks customers based on total contribution

Extracts Top 20

Adds customer activity (recency-based) and value (monetary) segments

Includes combined_segment column for easy grouping


> Config:



{{ config(
    materialized='table',
    schema='marts',
    tags=['top_customers', 'rfm', 'ranking']
) }}


---

🧪 Tests & Validations

dbt tests for:

not_null

unique on customer_id

Value range checks on recency, frequency, monetary


UAT was conducted at every layer before promotion to marts



---

📌 Assumptions

Data is already ingested into Snowflake from upstream sources like S3/ADF.

All monetary values are in the same currency.

Recency is calculated using current_date - last_order_date.



---

👤 Author

Shankar Kamalakannan
Snowflake | dbt | Cloud Data Engineer
📧 shankar@example.com
🔗 GitHub: Shankarkk


---
