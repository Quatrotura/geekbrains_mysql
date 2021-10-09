-- 8.2. Подсчитать общее количество лайков, 
-- которые получили пользователи младше 10 лет..


-- опеределяем возраст пользователей и фильтруем по возрасту (меньше 10 лет)

SELECT users.id, users.firstname, users.lastname, timestampdiff(YEAR,profiles.birthday, now()) AS age
FROM users
LEFT JOIN profiles ON users.id = profiles.user_id
HAVING age < 10
ORDER BY 4;


-- натягиваем кол-во лайков на пользователей

SELECT media.user_id, count(likes.id)
FROM media
JOIN likes ON media.id = likes.media_id
GROUP BY 1
ORDER BY 1;

-- соединяем в итоговый результат:

SELECT 
	users.id, users.firstname, users.lastname, timestampdiff(YEAR,profiles.birthday, now()) AS age, 
	count(likes.id) AS number_of_likes

FROM users
JOIN profiles ON users.id = profiles.user_id
JOIN media ON users.id = media.user_id
JOIN likes ON media.id = likes.media_id
GROUP BY 1 HAVING age < 10
ORDER BY 1;
