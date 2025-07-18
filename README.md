# E_commerce_analytics_project

📊 End-to-End E-commerce Data Analytics with Snowflake + dbt**

This project simulates a real-world e-commerce analytics pipeline using Snowflake and dbt. It captures customer behavior, order trends, and payment insights across multiple model layers.

---


📦 e_commerce_customer_analytics/  
├── models/  
│   ├── staging/  
│   ├── intermediate/  
│   ├── marts/  
├── snapshots/  
├── tests/  
├── macros/  
├── dbt_project.yml  
├── packages.yml  
└── README.md

---

## 📌 Key Features

- ✅ dbt `ref()` and `source()` model chaining
- ✅ Use of incremental models for large datasets
- ✅ YML schema testing and documentation
- ✅ Joins between customer, order, and payment layers
- ✅ Ready for CI/CD and dbt Cloud scheduling

---

## 🛠️ Tech Stack

- **dbt Core + dbt Cloud**
- **Snowflake** (data warehouse)
- **GitHub** (version control)
- **Jinja** (templating and macros)

---

## 📚 Learnings & Outcomes

- Practiced multi-layer dbt modeling (`stg → int → mart`)
- Designed analytical queries like customer LTV, order frequency
- Debugged schema and logic issues using dbt run/test
- Learned project modularity and macro reusability

---

## 🔗 Related Projects

-[`mortgage-psdt`](https://github.com/Shankarkk/mortgage-psdt) – Mortgage post-sanction documentation tracker
-[`dbt_practice_pro`](https://github.com/Shankarkk/dbt_practice_pro) – Hands-on dbt practice from 45-day training

---

📌 *This project strengthened real-time analytics building skills with dbt + Snowflake stack.*


