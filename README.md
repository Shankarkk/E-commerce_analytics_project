# E-commerce Analytics Project (End-to-End Data Engineering)

## 🔍 Overview
This project showcases a complete e-commerce analytics pipeline using **Snowflake**, **dbt**, and **GitHub**, built to simulate a real-world online retail environment. It tracks key business metrics like customer orders, product frequency, inventory status, and more.

---

## 🛠 Tech Stack
- **Snowflake** (Data Warehouse)
- **dbt Cloud & dbt CLI**
- **GitHub** (Version control)
- **SQL** (Advanced scripting and logic)
- **CI/CD Concepts**
- **Power BI** (explored for dashboard layer)

---

## 🔄 Project Workflow

### ✅ Data Sources:
- Simulated raw e-commerce data (orders, payments, customers, inventory, etc.)
- Loaded into Snowflake as staging tables (external file / internal sample)

### 🧱 dbt Layers Implemented:
1. **Staging Models**: Cleaned raw inputs with naming conventions & columns standardization  
2. **Intermediate Models**: Business logic joins (orders with customers, product revenue, etc.)  
3. **Mart Models**: Final KPIs like:
   - Monthly & Weekly Sales Trend
   - Top-Selling Products
   - Repeat Customers
   - Low Inventory Products
   - Region-wise performance

### 🧪 Tests & Validations:
- dbt schema tests (`not null`, `unique`, `accepted_values`)
- Source freshness tests
- Manual data validation via Snowflake UI

---

## 🔁 CI/CD & GitHub Integration:
- Project initialized in dbt Cloud
- Connected with GitHub repo
- Branch creation, PR review, and merge flow tested
- Jobs created for dbt run, test & docs generation

---

## 📊 Dashboard Layer (Exploration):
- Explored Power BI for dashboarding on top of Snowflake
- Analyzed product performance, inventory, and order trends
- Also familiar with bank-like dashboards showing business KPIs, pending orders, etc.

---

## 💥 Key Impact
- Demonstrates end-to-end data engineering for analytics use cases
- Hands-on with **dbt development + GitHub branching + Snowflake optimization**
- Applied real-world business logic (repeat buyers, monthly trends, product ranks)
- Confident with integration troubleshooting and test-first development

---

## 🔗 Author
**Shankar Kamalakannan**  
[LinkedIn](https://www.linkedin.com/in/shankar-kamalakannan-kk) | GitHub: [Shankarkk](https://github.com/Shankarkk)