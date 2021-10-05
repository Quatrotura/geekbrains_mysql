-- 6.4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- в моей базе - женщины :-)
SELECT (SELECT gender FROM profiles WHERE user_id IN (SELECT user_id FROM media WHERE id = likes.media_id)) AS user_wh_likes,
        COUNT(*) AS qty_of_liked_media
FROM likes
GROUP BY 1
ORDER BY 2 DESC;

-- +---------------+--------------------+
-- | user_wh_likes | qty_of_liked_media |
-- +---------------+--------------------+
-- | f             |               1911 |
-- | m             |               1826 |
-- +---------------+--------------------+
-- 2 rows in set (0,02 sec)

