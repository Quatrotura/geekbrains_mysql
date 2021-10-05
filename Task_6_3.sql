-- 6.3 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- достаем возраст пользователей и получаем 10 самых молодых
SELECT user_id, TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age FROM profiles ORDER BY 2 LIMIT 10;

-- достаем айди  пользователей чьим медиа ставили лайки и общее кол-во лайков
SELECT (SELECT user_id FROM media WHERE id = likes.media_id) AS user_wh_likes, COUNT(*) AS qty_of_liked_media FROM likes
GROUP BY 1
ORDER BY 1;


-- добавляем возраст в предыдущий запрос
SELECT (SELECT user_id FROM media WHERE id = likes.media_id) AS user_wh_likes,
        COUNT(*) AS qty_of_liked_media,
        (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age FROM profiles WHERE user_id = user_wh_likes) AS age
FROM likes
GROUP BY 1
ORDER BY 3 LIMIT 10;

