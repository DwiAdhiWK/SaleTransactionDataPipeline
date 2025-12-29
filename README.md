- Data Warehouse Schema
The Data Warehouse follows the STAR Scheme and consist of 
1 Fact Table (facts_transaction)
3 Dimension Table(dim_agents, dim_transaction, dim_transaction_event)

facts_transaction consists of:
- id Integer
- agent_id Integer
- product_id Integer
- total_premi FLOAT

dim_agents consist of:
- agent_id INT and the PRIMARY KEY
- tier_id INT
- join_date DATE
- one to many relationship with facts_transaction

dim_transcation consist of:
- transaction_id INT and the PRIMARY KEY
- payment_status VARCHAR
- registration_date DATE
- registration_month INTEGER
- one to many relationship with facts_transaction

dim_transaction event consist of:
- transaction_event_id INTEGER and the PRIMARY KEY
- transaction_id FOREIGN KEY 
- status VARCHAR
- created_at DATE
- One to many relationship with dim_transaction



- Data Pipeline Step
The following project consist several steps of data pipeline. These steps are:
Extract: Seperating each worksheet into individual dataframe
Transformation: Transformation of the data such as cleaning by handling missing value, duplicate, and errors as well as adding new features (Registration Month)
Loading: Creating the database and table through python script and insert the clean data into the fact and dimension tables.


- Running The Project
This project use python for the ETL pipeline and Postgresql for the database. To run the project, create an empty database beforehand then run each code in the cell.