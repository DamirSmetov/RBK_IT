# 🛒 Ecommerce Sales Database Generator

A YAML-configurable Python engine for generating synthetic, relational e-commerce databases — designed for SQL training, analytics storytelling, and realistic pipeline testing. This system goes beyond raw data: it simulates a full customer journey from browsing session to purchase, builds linked tables with referential integrity, and includes configurable messiness and built-in QA test suites to mirror real-world data challenges.

---

### 📊 Database Overview

| Table Name        | Key Fields                                  | Purpose                                    |
| ----------------- | ------------------------------------------- | ------------------------------------------ |
| `orders`          | `order_id`, `customer_id`                   | Completed transactions and shipping costs  |
| `order_items`     | `order_item_id`, `order_id`, `product_id`   | Line-level product sales per order         |
| `returns`         | `return_id`, `order_id`, `return_reason`    | Return metadata per order                  |
| `return_items`    | `return_item_id`, `return_id`, `product_id` | Refunded products with values              |
| `shopping_carts`  | `cart_id`, `customer_id`, `status`          | Tracks cart activity (open, abandoned)     |
| `cart_items`      | `cart_item_id`, `cart_id`, `product_id`     | Products added to cart pre-purchase        |
| `product_catalog` | `product_id`, `product_name`, `unit_price`  | SKU definitions and margin proxy           |
| `customers`       | `customer_id`, `signup_date`                | Customer profiles and acquisition channels |

> 📌 View the full reference: [`database_schema_reference.md`](database_schema_reference.md)

<summary><strong> ✨ Key Simulation Features </strong></summary>
<br>

This generator goes beyond simple row creation by simulating a complete, interconnected e-commerce ecosystem.

- **Full Sales Funnel**: Models the entire customer journey from browsing to purchase. It generates a large volume of `shopping_carts` and then "converts" a small, configurable percentage into `orders`, realistically simulating cart abandonment.
- **Time-Aware Customer Behavior**: Simulates customer return visits over a one-year period. The likelihood of a repeat purchase is tied to `loyalty_tier`, and the time between visits is randomized, creating rich data for cohort analysis.
- **Nuanced Cart Abandonment**: The simulation distinguishes between carts that are abandoned with items still in them and carts that are explicitly emptied by the user, providing deeper insight into user intent.
- **Detailed Cart Lifecycle**: Each cart and cart item now includes `created_at`, `updated_at`, and `added_at` timestamps, allowing for granular analysis of shopping session duration and user behavior within the cart.
- **Dynamic Returns**: The number of returns is not fixed but is generated as a percentage of total orders, ensuring that return volumes scale realistically with sales.
- **Contextual Messiness**: The messiness engine can inject not just random noise but also contextual issues, like biased return reasons based on product category or seasonal sales spikes during holiday months.
- **Channel-Specific Behavior**: Models distinct customer behavior based on their acquisition channel (`signup_channel`), influencing their purchase frequency, return rates, and even product category preferences.
- **Earned Customer Value**: Customer `loyalty_tier` and `clv_bucket` are not pre-assigned but are calculated and "earned" based on their cumulative spending over time, creating a realistic progression of customer value.
- **Long-Tail Churn & Reactivation**: The simulation now includes logic for long-term customer churn and a configurable probability for dormant customers to reactivate after a long period, adding valuable edge cases for analysis.

</details>

<details>

<summary><strong>🗺️ About the Project Ecosystem</strong></summary>

This repository is one part of a larger, interconnected set of projects. Here’s how they fit together:

This repository is one part of a larger, interconnected set of projects. Here’s how they fit together:

- **[`ecom_sales_data_generator`](https://github.com/G-Schumacher44/ecom_sales_data_generator)** `(The Engine - This repository)`  
  Generates realistic, relational ecommerce datasets. This extension imports it and keeps that repo focused on synthesis.
- **[`ecom-datalake-exten`](https://github.com/G-Schumacher44/ecom-datalake-exten)** `(The Lake Layer)`  
  Converts generator output to Parquet, attaches lineage, and publishes to raw/bronze buckets.
- **[`sql_stories_skills_builder`](https://github.com/G-Schumacher44/sql_stories_skills_builder)** `(Learning Lab)`  
  Publishes the story modules and exercises that use these datasets for hands-on practice.
- **[`sql_stories_portfolio_demo`](https://github.com/G-Schumacher44/sql_stories_portfolio_demo/tree/main)** `(The Showcase)`  
  Curates the best case studies into a polished portfolio for professional storytelling.
- **gcs-automation-project** `(In Development · The Orchestrator)`  
  Planned orchestration layer for scheduling backlog runs, triggering BigQuery loads/merges, and coordinating downstream DAGs.

</details>

<details>

<summary>⚙️ Project Structure</summary>

```
ecom_sales_data_generator/
├── config/                          # YAML config templates for data generation
│   └── ecom_sales_gen_template.yaml
├── output/                          # Output folder for generated CSVs (ignored by Git)
├── src/                             # Main package source
│   ├── __init__.py
│   ├── ecomgen                      # CLI entrypoint
│   ├── generators/                 # Core row generators (orders, returns, etc.)
│   ├── pytests/                    # Pytest-based unit tests
│   │   ├── test_config_integrity.py
│   │   ├── test_config_linting.py
│   │   └── test_data_quality_rules.py
│   ├── tests/                      # CLI-based test modules
│   │   ├── big_audit.py
│   │   ├── mess_audit.py
│   │   └── qa_tests.py
│   └── utils/                      # Shared utilities (config loading, date helpers, etc.)
├── build/                           # Local build artifacts (ignored)
├── pyproject.toml                  # Build system and project metadata
├── environment.yml                 # Conda environment for dev setup
├── requirements.txt                # Optional pip requirements (mirrors env)
├── README.md
├── LICENSE
└── .gitignore
```

</details>

<details>
