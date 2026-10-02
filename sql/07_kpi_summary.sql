WITH d AS (
  SELECT order_id, customer_id, order_delivered_customer_date, order_estimated_delivery_date
  FROM orders WHERE order_status = 'delivered'),
rev AS (
  SELECT SUM(p.payment_value) AS revenue, COUNT(DISTINCT p.order_id) AS paid_orders
  FROM order_payments p JOIN d ON p.order_id = d.order_id),
rep AS (
  SELECT cu.customer_unique_id, COUNT(*) AS n
  FROM d JOIN customers cu ON d.customer_id = cu.customer_id GROUP BY 1)
SELECT (SELECT paid_orders FROM rev) AS total_orders,
       ROUND((SELECT revenue FROM rev)::numeric, 2) AS total_revenue,
       ROUND(((SELECT revenue FROM rev) / (SELECT paid_orders FROM rev))::numeric, 2) AS avg_order_value,
       ROUND(100.0 * (SELECT COUNT(*) FROM rep WHERE n > 1) / (SELECT COUNT(*) FROM rep), 2) AS repeat_rate_pct,
       ROUND(100.0 * (SELECT COUNT(*) FROM d WHERE order_delivered_customer_date::timestamp > order_estimated_delivery_date::timestamp)
             / (SELECT COUNT(*) FROM d WHERE order_delivered_customer_date IS NOT NULL), 2) AS late_pct;