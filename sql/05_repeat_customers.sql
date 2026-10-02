WITH c AS (
  SELECT cu.customer_unique_id, COUNT(DISTINCT o.order_id) AS n
  FROM orders o
  JOIN customers cu ON o.customer_id = cu.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY 1)
SELECT COUNT(*) AS total_customers,
       COUNT(*) FILTER (WHERE n > 1) AS repeat_customers,
       ROUND(100.0 * COUNT(*) FILTER (WHERE n > 1) / COUNT(*), 2) AS repeat_rate_pct
FROM c;