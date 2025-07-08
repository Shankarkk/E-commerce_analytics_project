# E-Commerce Analytics Project (Freelance)

This project showcases an end-to-end analytics pipeline built as a freelance initiative using **Snowflake**, **dbt**, **SQL**, and **AWS S3**.

## 🔧 Tech Stack:
- **Snowflake**: Data warehouse, Stream & Task automation
- **dbt**: Transformations, model layering, schema testing
- **SQL**: Window functions, CTEs, incremental logic
- **AWS S3**: Raw data staging via external stage

## 📈 Business KPIs Delivered:
- Total Sales by Month & Region
- Customer Login Frequency & Segmentation
- Repeat Orders Analysis
- Late Delivery Insights

## 🧱 Data Pipeline Overview:
1. **Raw Data Ingestion** via AWS S3 → Snowpipe
2. **Change Tracking** with Streams on raw tables
3. **Task Automation** for layered movement (raw → stage → intermediate)
4. **dbt Models** for transformations and mart generation
5. **CI/CD Setup** via dbt Cloud + GitHub

## 🧪 Testing
- Applied `not_null`, `unique`, and `accepted_values` tests in schema.yml
- Added custom test: `amount > 0`

## 🧵 Orchestration
- Created DAG with parent-child Task structure for automation

## 📊 Output
- Business-ready marts connected to dashboards for insights

---

📌 **Note**: This is a hands-on project, not tied to a paid company. Demo available on request.
