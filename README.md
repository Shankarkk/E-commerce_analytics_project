# 🛍️ E-commerce Customer Analytics Project

A real-world data pipeline project built using Snowflake and dbt, focusing on customer behavior, order trends, and business-focused analytics.

---

## 🎯 Objective

To deliver actionable insights into customer retention, repeat purchases, and lifetime value using a modular and scalable analytics pipeline powered by dbt on Snowflake.

---

## 📁 Project Structure

e_commerce_customer_analytics/ │ ├── models/ │   ├── staging/             # Raw source layer (orders, customers, products) │   ├── intermediate/        # Business logic layer (RFM, joins, aggregations) │   ├── marts/               # Final analytics-ready tables │ ├── snapshots/               # Snapshot setup (for future SCD tracking) │ ├── dbt_project.yml          # Project config ├── README.md                # Project documentation

---

## 🧠 Use Cases Covered

- RFM (Recency, Frequency, Monetary) Scoring
- Repeat vs First-time Customer Analysis
- Top N Customers by Lifetime Value
- Weekly and Monthly Revenue Trends
- Customer Purchase Gap & Retention Pattern
- Active vs Inactive Customer Segmentation

---

## 📆 Time-Based Logic Applied

- `DATE_TRUNC()` used for week/month slicing
- `LAG()` applied for calculating gaps between purchases
- Order filters using date ranges (`BETWEEN`, `>`, `<=`)
- Current active customers derived using date diff logic

---

## ⚙️ dbt Features & Configuration

- `incremental` materialization for scalable builds
- Unique key definitions for merge logic
- Data tests (`not_null`, `unique`, `relationships`) added
- Snapshot scaffolding for future SCD tracking
- Modular structure aligned with best practices (`staging → intermediate → marts`)

---

## 🧾 Snapshots Setup

- Folder created under `/snapshots/`
- Future plan:
  - Track slowly changing customer/product attributes
  - Maintain historical views using SCD Type 2
  - Add `dbt snapshot` logic when SCD changes are required

---

## 📌 Future Enhancements

- Product category-level performance tracking
- Campaign and marketing dashboard integration
- Advanced customer segmentation using clustering
- CI/CD pipeline using dbt Cloud + GitHub Actions
- Integration with Metabase/Tableau for visualization

---

## 🛠️ Tools & Technologies

| Area                  | Tool / Platform      |
|-----------------------|----------------------|
| Data Warehouse        | Snowflake            |
| Transformation Logic  | dbt (Core)           |
| Version Control       | GitHub               |
| Visualization (opt.)  | Metabase / Tableau   |

---

## 🙌 Credits

Project developed as part of a real-time portfolio to demonstrate cloud data engineering skills using dbt and Snowflake in an e-commerce analytics context.
