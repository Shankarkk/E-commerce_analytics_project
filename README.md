# 🛍️ E-Commerce Customer Analytics (dbt + Snowflake)

> **Project Type:** Analytics Engineering  
> **Tech Stack:** Snowflake | dbt | GitHub  
> **Domain:** E-Commerce Customer Segmentation

---

## 📁 Project Structure

```text
e_commerce_customer_analytics/
├── models/
│   ├── staging/             # Raw data cleaned and standardized
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── stg_payments.sql
│   │
│   ├── intermediate/        # Business logic & transformations
│   │   ├── int_order_metrics.sql
│   │   ├── int_rfm_calculation.sql
│   │   └── int_rfm_ranked.sql
│   │
│   └── marts/               # Final models for reporting
│       └── top_customers.sql
│
├── snapshots/               # (Optional) Historical data tracking
├── dbt_project.yml
└── README.md


---

🔄 ELT Workflow

[ Raw Tables (Snowflake) ]
        │
        ▼
[ staging/ ]
        │
        ▼
[ intermediate/ ]
        │
        ▼
[ marts/ ]
        │
        ▼
[ Dashboard / Reporting ]


---

🔍 Final Mart: Top 20 Customers

-- model: top_customers.sql
with ranked as (
  select * from {{ ref('int_rfm_ranked') }}
  where rno <= 20
)

select
  customer_id,
  contribution,
  recency,
  frequency,
  monetary,
  rno,
  case
    when recency <= 7 then 'Highly Active'
    when recency between 8 and 30 then 'Active'
    else 'Inactive'
  end as customer_activity_status,
  case
    when contribution >= 1000 then 'High Value'
    else 'Low Value'
  end as customer_value_segment,
  customer_activity_status || ' - ' || customer_value_segment as combined_segment
from ranked

> 💡 Business Insight: This mart helps identify high-value customers based on RFM metrics and activity recency, supporting strategic targeting and loyalty campaigns.




---

📊 Sample Output

customer_id	contribution	recency	frequency	monetary	rno	customer_activity_status	customer_value_segment	combined_segment

CUST101	1400	3	10	140	1	Highly Active	High Value	Highly Active - High Value
CUST107	900	20	6	150	6	Active	Low Value	Active - Low Value



---

🧪 Testing & Validation

✅ Layer-wise dbt tests added
✅ Each intermediate and mart model has unique / not null tests
✅ Validation done at UAT stage before productionizing


---

🚀 Future Enhancements

> ⬛️ You can extend this project with:



🗓️ Weekly/Monthly aggregates

🛍️ Product-wise and category-level RFM analysis

📈 Campaign performance segmentation

🧾 Snapshot testing (using snapshots/)

🔁 CI/CD integration (dbt Cloud or GitHub Actions)



---

👨‍💻 Author

Shankar Kamalakannan
Snowflake | dbt | Cloud Data Engineering
📧 [your-email@example.com]
🔗 [LinkedIn / Portfolio links optional]


---
