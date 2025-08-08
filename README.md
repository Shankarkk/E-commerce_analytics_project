![Snowflake](https://img.shields.io/badge/Snowflake-Data--Warehouse-blue)
![dbt](https://img.shields.io/badge/dbt-Data--Build--Tool-orange)
![CI/CD](https://img.shields.io/badge/CI%2FCD-Automation-green)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen)
---

# 🛒 E-commerce ELT Pipeline – Snowflake + dbt

A real-world data engineering project to build a clean, production-grade ELT pipeline using **Snowflake**, **dbt**, and **CI/CD automation**.

---

## 🔧 Tech Stack

- **Snowflake** – Data warehouse  
- **dbt (Data Build Tool)** – Transformation layer  
- **Git** – Version control & branching  
- **dbt Cloud Jobs** – Scheduling & CI/CD  
- **Jinja Macros** – Reusable logic  
- **Azure Data Factory (ADF)** – Orchestration (optional)  
- **Amazon S3** – External file stage

---

## 🔁 ELT Pipeline Flow

Raw Data → Staging Models → Intermediate Models → Mart Models → Business Dashboards

- `staging/` – Cleans and casts raw data  
- `intermediate/` – Applies joins, metrics logic, and aggregations  
- `marts/` – Business-focused models (top customers, order trends)  
- Supports **incremental loading** using `is_incremental()`  
- Automated with **dbt Cloud Jobs** or **Snowflake Streams + Tasks**

---

## 🧱 Folder Structure

dbt_project/ │ ├── models/ │   ├── staging/ │   ├── intermediate/ │   ├── marts/ │   └── snapshots/ (planned) │ ├── macros/ ├── seeds/ ├── tests/ ├── dbt_project.yml └── packages.yml

---

## 📊 Business Use Cases

- Identify top customers by **monthly/weekly revenue**  
- Track product sales trends  
- Monitor order frequency per customer  
- Enable marketing ROI insights  
- Ensure freshness using CI/CD and alerts

---

## 🧪 Testing & Quality

- dbt built-in tests:
  - `unique`, `not_null`, `relationships`
- Modular SQL using **Jinja macros**
- Incremental model validation using:
```sql
{% if is_incremental() %}
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}


---

📎 Resources

📄 Project Snapshot PDF
📂 GitHub Repo
📃 Resume (Markdown Version)


---

💬 About Me

I'm Shankar Kamalakannan, a freelance Snowflake + dbt developer focused on delivering clean data pipelines with test-driven logic, Git-based CI/CD, and real business alignment.

Let’s connect:
📧 shankar.freelance.dataengineer@gmail.com
🔗 LinkedIn

---
