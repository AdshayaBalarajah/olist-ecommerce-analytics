SELECT ROUND((SUM(p.payment_value) / COUNT(DISTINCT o.order_id))::numeric, 2) AS avg_order_value
FROM orders o
JOIN order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';