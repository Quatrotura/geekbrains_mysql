-- 7.1. Составьте список пользователей users,
-- которые осуществили хотя бы один заказ orders в интернет магазине.



SELECT u.id, u.name, count(o.id) FROM users AS u, orders AS o WHERE u.id = o.user_id GROUP BY 1 ORDER BY 1;

-- или

SELECT o.user_id, u.name, count(o.id)
FROM orders AS o, users AS u
WHERE o.user_id = u.id
GROUP BY 1
ORDER BY 1;

-- или с джойнами

SELECT u.id, u.name FROM orders AS o JOIN users AS u ON u.id = o.user_id GROUP BY 1;

-- или c RIGHT JOIN

SELECT u.id, u.name FROM users AS u RIGHT JOIN orders AS o ON u.id = o.user_id GROUP BY 1;














