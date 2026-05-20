# Google Analytics 4 (GA4) E-commerce Data Analysis in BigQuery

## Project Overview
This project focuses on querying and analyzing complex, nested Google Analytics 4 (GA4) e-commerce datasets using Google BigQuery. The main goal was to unpack and flatten highly nested data structures (`ARRAY` and `STRUCT`), evaluate e-commerce product performance, track user behavior trends across partitioned tables, and analyze session-start funnels using advanced SQL techniques.

## Tools & Technologies
- **Platform:** Google Cloud Platform (GCP) / BigQuery Console
- **Dialect:** Standard SQL
- **Dataset:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce`
- **Key SQL Concepts:** Nested Data Flattening (`UNNEST`), Array Manipulation (`ARRAY_LENGTH`, `EXISTS`), Table Wildcards (`_TABLE_SUFFIX`), Window Functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`), and Conditional Aggregations.

## Analytical Workflow & Project Structure
The analysis is structured into 10 logical parts covering four core analytics areas:
1. **Unpacking Nested Structures (Q1–Q3, Q5):** Flattened `event_params` and `items` arrays to map nested user parameters and item-level details into tabular representations.
2. **Product & Category Analysis (Q6–Q7):** Built summary tables aggregating total quantity and revenue per item, and implemented precise array filtering using `EXISTS` to isolate specific categories.
3. **Time-Series & Partitioning (Q4, Q8):** Used wildcard tables (`_TABLE_SUFFIX`) to aggregate daily unique users, event volume, and conversion metrics over time.
4. **User Ranking & Session Funnels (Q9–Q10):** Calculated life-time value (LTV) per user to rank top customers via comparative window components, and extracted `ga_session_id` parameters to uncover the most frequent entry points that start user sessions.

## Key Technical Highlights
- Successfully handled nested telemetry data structures without causing performance-heavy cross-joins by using optimized `UNNEST` execution.
- Extracted dynamic integer/string variants within event parameter objects to isolate session identifiers (`ga_session_id`).
- Implemented analytical window configurations to identify user behavior sequences at the individual session level.
