# Transaction Data Warehouse & ETL Pipeline

Data pipeline that extract raw transaction data, clean, transform, and load into PostgreSQL star schema for effiecient analytical querying.

Build with:
- Python (pandas + psycopg2)
- PostgreSQL

## Project Overview

This project implement a complete ETL Pipeline for transaction data following best practices in data warehousing:

- Star Schema modeling (2 facts + 3 dimensions)
- Data cleaning, deduplication, and feature engineering
- Seperation of phase: extract -> transform -> load

## Data Model

2 Facts table surrounded by dimensions for agent, time, transaction status.

### 

- `facts_transaction`
  - `id` (PK)
  - `agent_id` → FK to dim_agent
  - `product_id`
  - `status_id` → FK to dim_transaction_status
  - `registration_date` → FK to dim_date
  - `total_premi` (price for transaction)

- `facts_transaction_event`
  - `id` (PK)
  - `transaction_id` → FK to facts_transaction
  - `status_id` → FK to dim_transaction_status
  - `created_at` → FK to dim_date 

### Dimension Tables
| Table                     | Description                              | Key Fields                                      |
|---------------------------|------------------------------------------|-------------------------------------------------|
| `dim_date`                | Date dimension (time intelligence)       | full_date_timestamp, year, quarter, month, day  |
| `dim_agent`               | Agent/Customer                           | agent_id (PK), tier_id, join_date               |
| `dim_transaction_status`  | Transaction/payment status               | id (PK), status_name                            |


- Data Pipeline Step

1. **Extract**  
   Read source Excel/CSV worksheets → separate into raw DataFrames

2. **Transform**
    - Handle missing value and duplicate
    - Create derived column (registration_date)
    - Create facts and dimensions dataframe

3. **Load**
    - Create schema/tables following Star Schema
    - Insert data into facts and dimension table

**Tech stack**
- Python 3.10+  
- pandas, psycopg2
- PostgreSQL 15+