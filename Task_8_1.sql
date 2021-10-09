-- 8.1. Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SET @target_user = 480;

SELECT from_user_id, users.firstname, users.lastname, count(messages.id) as number_of_msg
FROM messages
LEFT JOIN users ON messages.from_user_id = users.id
WHERE to_user_id = @target_user
GROUP BY 1
ORDER BY 4 DESC LIMIT 1;

-- +--------------+-----------+----------+---------------+
-- | from_user_id | firstname | lastname | number_of_msg |
-- +--------------+-----------+----------+---------------+
-- |          611 | Sallie    | Koss     |             4 |
-- |          429 | Vickie    | Carroll  |             3 |
-- |          554 | Rasheed   | Fadel    |             1 |
-- |          771 | Camryn    | Marvin   |             1 |
-- |          412 | Helen     | Volkman  |             1 |
-- +--------------+-----------+----------+---------------+
-- 5 rows in set (0,00 sec)