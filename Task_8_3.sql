-- Определить кто больше поставил лайков (всего): мужчины или женщины.


SELECT gender, count(likes.id) AS number_of_likes
FROM profiles
JOIN media ON profiles.user_id = media.user_id
JOIN likes ON media.id = likes.media_id
GROUP BY 1
ORDER BY 2 DESC LIMIT 1;
