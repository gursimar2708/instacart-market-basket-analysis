-- Instacart Market Basket Analysis
-- SQL + Tableau Portfolio Project

-- Check that all 6 tables imported correctly (row counts)

SELECT 'orders' AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'order_products__train', COUNT(*) FROM order_products__train
UNION ALL
SELECT 'order_products__prior', COUNT(*) FROM order_products__prior
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'aisles', COUNT(*) FROM aisles
UNION ALL
SELECT 'departments', COUNT(*) FROM departments;


-- Data Quality Checks

-- Check for orphaned product_ids (products referenced in orders
-- but missing from the products table) — expect 0
SELECT COUNT(*) AS orphaned_rows
FROM order_products__train op
LEFT JOIN products p ON op.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Check order_dow only contains expected values (0-6)
SELECT DISTINCT order_dow FROM orders ORDER BY order_dow;

-- Check reordered only contains expected values (0, 1)
SELECT DISTINCT reordered FROM order_products__train ORDER BY reordered;

-- Check for duplicate order_ids — expect no rows returned
SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Preview each table to understand structure

SELECT * FROM orders LIMIT 5;

SELECT * FROM products LIMIT 5;


-- Busiest day-of-week + hour-of-day combinations for orders

SELECT order_dow, order_hour_of_day, COUNT(*) AS num_orders
FROM orders
GROUP BY order_dow, order_hour_of_day
ORDER BY num_orders DESC
LIMIT 10;


-- Total orders by day of week (zoomed-out view)

SELECT order_dow, COUNT(*) AS num_orders
FROM orders
GROUP BY order_dow
ORDER BY num_orders DESC;


-- Total items ordered by department (using JOINs across 3 tables)

SELECT d.department, COUNT(*) AS num_items_ordered
FROM order_products__train op
JOIN products p ON op.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY num_items_ordered DESC
LIMIT 10;


-- Products with the highest reorder rate (min 100 orders to avoid small-sample noise)
SELECT p.product_name, COUNT(*) AS times_ordered,
       SUM(op.reordered) AS times_reordered,
       ROUND(SUM(op.reordered) * 100.0 / COUNT(*), 1) AS reorder_rate_pct
FROM order_products__train op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_name
HAVING times_ordered >= 100
ORDER BY reorder_rate_pct DESC
LIMIT 10;


-- Average number of days between orders (customer return frequency)
SELECT ROUND(AVG(days_since_prior_order), 1) AS avg_days_between_orders
FROM orders
WHERE days_since_prior_order IS NOT NULL;


-- Average number of items per order
SELECT ROUND(AVG(item_count), 1) AS avg_items_per_order
FROM (
    SELECT order_id, COUNT(*) AS item_count
    FROM order_products__train
    GROUP BY order_id
);


-- Reorder rate by department (category-level loyalty)
SELECT d.department,
       COUNT(*) AS total_items,
       SUM(op.reordered) AS total_reordered,
       ROUND(SUM(op.reordered) * 100.0 / COUNT(*), 1) AS reorder_rate_pct
FROM order_products__train op
JOIN products p ON op.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
ORDER BY reorder_rate_pct DESC;


-- Average order size by day of week
SELECT o.order_dow,
       ROUND(AVG(item_count), 1) AS avg_items_per_order
FROM orders o
JOIN (
    SELECT order_id, COUNT(*) AS item_count
    FROM order_products__train
    GROUP BY order_id
) op_counts ON o.order_id = op_counts.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;