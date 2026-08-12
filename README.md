# Instacart Customer Behavior Analysis

This is my second portfolio project. After the churn analysis in 
Python, I wanted to work with something closer to how data actually 
exists in real companies: spread across multiple related tables, 
requiring real SQL joins to answer anything useful. A single flat 
CSV is a good learning exercise but it doesn't reflect what most 
analyst jobs actually look like day to day.

## The Problem

Instacart is a grocery delivery platform. Like any repeat purchase 
business, understanding customer behavior matters: when do people 
shop, what do they buy, and which products bring them back? Getting 
those answers right means better recommendations, smarter inventory 
decisions, and stronger retention.

## The Dataset

[Instacart Market Basket Analysis on Kaggle](https://www.kaggle.com/competitions/instacart-market-basket-analysis)

6 relational tables covering 3.4 million orders from over 200,000 
customers, with 32 million order product records and 49,688 unique 
products across aisles and departments. No single table answers 
anything on its own. Everything requires joining across at least 
two or three tables, which is the point.

## Tools

SQL via SQLite and DB Browser for SQLite for all analysis and 
aggregation. Tableau Public for visualization.

## Process

Loaded all 6 CSV files into a local SQLite database. Before any 
analysis, ran data quality checks covering referential integrity, 
duplicate detection, and value range validation. Everything came 
back clean, which is worth confirming rather than assuming.

All analysis was done in SQL. Results were exported as CSVs and 
brought into Tableau to build an interactive story with one 
visualization per insight.

## What I Found

**Order Timing**
- Sunday is the single busiest day with 600,905 orders, roughly 
  41% above the weekly average
- Monday follows closely at 587,478 orders
- Peak shopping window across all days is 9AM to 2PM, with Sunday 
  and Monday showing the heaviest concentration in that slot
- Customers order on average every 11.1 days

**Order Size**
- Average basket is 10.6 items per order
- Sunday averages 11.8 items per order vs Thursday's 9.7
- This means weekends are not just busier, the orders are bigger 
  too, confirming big weekly shop behavior rather than just more 
  frequent small top ups

**What People Buy**
- Produce accounts for 29.55% of all items ordered, nearly double 
  the next department
- Dairy Eggs comes second at 15.68%
- These two departments together make up close to half of all order 
  volume

**Customer Loyalty**
- Dairy Eggs has the highest department level reorder rate at 67.5%, 
  with Produce close behind at 66.5%
- At the product level, Organic Low Fat Milk leads at 91.3% reorder 
  rate
- Banana is the most interesting finding: 18,726 total orders and 
  an 88.4% reorder rate. High volume and high loyalty together is 
  rare and makes it a strong anchor product

## Recommendations

- Concentrate promotional and operational effort on Sunday and Monday 
  mornings. That is when order volume and basket size both peak at 
  the same time
- Use fresh produce and dairy as the core loyalty categories. These 
  are what customers come back for most reliably, making them the 
  right anchor for retention offers
- High reorder products like bananas and organic milk are natural 
  candidates for cross selling and bundle recommendations since 
  customers are already returning for them consistently
- The 11 day average between orders suggests a weekly or bi weekly 
  reminder cadence could be effective for re engagement

## Files in This Repo

`instacart_analysis.sql` contains all SQL queries with comments. 
The `exports` folder has the 6 CSV files used in Tableau.

## Tableau Story

[View the interactive visualization here](https://public.tableau.com/app/profile/gursimar.kour/viz/InstacartCustomerBehaviorAnalysis_17865314249950/InstacartAnalysis)


## About Me

Gursimar Kour. Second project in my data analyst portfolio. 
The first was a customer churn analysis using Python, pandas, 
and seaborn.
