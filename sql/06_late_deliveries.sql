SELECT COUNT(*) AS delivered_orders,
       COUNT(*) FILTER (
         WHERE order_delivered_customer_date::timestamp > order_estimated_delivery_date::timestamp
       ) AS late_orders,
       ROUND(100.0 * COUNT(*) FILTER (
         WHERE order_delivered_customer_date::timestamp > order_estimated_delivery_date::timestamp
       ) / COUNT(*), 2) AS late_pct
FROM orders
WHERE order_status = 'delivered' AND order_delivered_customer_date IS NOT NULL;