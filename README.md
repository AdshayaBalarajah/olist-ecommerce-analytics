# Olist E-commerce Sales & Customer Analytics

SQL (PostgreSQL) analysis and Power BI dashboard of about 96K delivered orders from the Brazilian Olist marketplace (Jan 2017 to Aug 2018).

![Dashboard](dashboard/dashboard.png)

## Business questions

- How do sales and orders change over time?
- Which categories and states generate the most revenue?
- What is the average order value?
- How many customers buy again?
- How often are deliveries late?

## Data

[Olist Brazilian E-Commerce dataset (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce): 9 CSV files, licensed CC BY-NC-SA 4.0. Amounts are in Brazilian reais (R$). The data is not included in this repo (download it from Kaggle).

## Tools

PostgreSQL, SQL, Python (pandas, SQLAlchemy), Power BI

## Data checks and cleaning

- 99,441 orders, no duplicate order IDs
- 97% of orders are delivered; the analysis uses delivered orders only
- 2,965 orders have no delivery date; 610 products have no category (labelled "unknown")
- Dates were loaded as text and converted with `::timestamp`
- 2016 data is incomplete, so trends cover Jan 2017 to Aug 2018
- Repeat customers are identified with `customer_unique_id` (not `customer_id`, which changes with every order)
- Monthly revenue uses payment value (includes freight); category and state revenue use item price (excludes freight), so they are not directly comparable

## Key findings

1. Monthly orders grew about 9x, from 750 (Jan 2017) to 7,069 (Jan 2018).
2. November 2017 was the peak (7,289 orders, R$1.15M), then December fell about 24%. Growth flattened in 2018 at roughly 6,000 to 7,000 orders per month.
3. Average order value is R$159.86.
4. Top categories by revenue: health_beauty, watches_gifts, bed_bath_table.
5. Sao Paulo (SP) brings in about 38% of item revenue; SP, RJ and MG together about 63%.
6. Only 3.00% of customers (2,801 of 93,358) bought more than once.
7. 8.11% of delivered orders (7,826) arrived after the estimated date.

## Recommendations

1. Launch a retention program (loyalty offers, follow-up emails), because 97% of customers buy only once.
2. Focus marketing on SP, RJ and MG, and investigate why other regions are low.
3. Investigate the causes of late deliveries, especially in distant states.
4. Plan stock and promotions around the November peak.

## Repository

- `load_data.py`: loads the CSV files into PostgreSQL
- `sql/`: data checks and analysis queries
- `dashboard/`: Power BI file, exported CSVs and screenshot
