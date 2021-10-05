-- Проанализировать запросы, которые выполнялись на занятии,
-- определить возможные корректировки и/или улучшения (JOIN пока не применять).
use vk;
-- Запрос на чтение города и фото пользователя: у меня немного другая структура таблицы, в частности,
-- у меня отдельная таблица-справочник с городами и странами (country_city)
-- и отдельная таблица с айди пользователей+айди строки из таблицы стран-городов для родного города и места проживания

-- country_city (пример):
-- +----+------------------+-----------------+
-- | id | country_name     | city_name       |
-- +----+------------------+-----------------+
-- |  1 | Pakistan         | North Shanny    |
-- |  2 | Cyprus           | Port Jordon     |
-- |  3 | Saint Helena     | Bednarton       |
-- |  4 | Pakistan         | West Erickaport |
-- |  5 | Marshall Islands | North Rosanna   |
-- +----+------------------+-----------------+

-- user_country_city (пример):

-- +---------+----------------------+---------------------------+
-- | user_id | home_country_city_id | residence_country_city_id |
--  +---------+----------------------+---------------------------+
-- |     411 |                    9 |                         9 |
-- |     412 |                   10 |                        10 |
-- |     414 |                   11 |                        11 |
-- +---------+----------------------+---------------------------+

-- Соответственно, запрос у меня такой
-- также добавил переменные
SET @selected_user = 411;
SELECT firstname,lastname,
        (SELECT filename FROM media where id=
                                    (SELECT photo_id FROM profiles WHERE user_id = @selected_user)) 'photo',
       (SELECT country_name FROM country_city WHERE id =
                                    (SELECT home_country_city_id FROM user_country_city WHERE user_id = @selected_user)) 'country of birth',
       (SELECT city_name FROM country_city WHERE id =
                                    (SELECT home_country_city_id FROM user_country_city WHERE user_id = @selected_user)) 'city of birth',
       (SELECT country_name FROM country_city WHERE id =
                                    (SELECT residence_country_city_id FROM user_country_city WHERE user_id = @selected_user)) 'country of residence',
       (SELECT city_name FROM country_city WHERE id =
                                    (SELECT residence_country_city_id FROM user_country_city WHERE user_id = @selected_user)) 'city of residence'
FROM users
WHERE id = @selected_user;

-- в архив новостей можно добавить к примеру название типа медиа
SELECT (SELECT name FROM media_types WHERE id = (SELECT media_type_id FROM media LIMIT 1)) as media_type_name,
       MONTH(created_at) AS month_of_creation,
       COUNT(*) AS total

FROM media
GROUP BY media_type_name, month_of_creation
ORDER BY media_type_name, month_of_creation, total DESC;

-- в выборке друзей пользователя можно прикрутить переменную с номерами целевого пользователя, группировку по статусам
 -- и кол-во запросов по каждому статусу

SET @processing_user = 411;
SELECT status, GROUP_CONCAT(initiator_user_id, ' - ', target_user_id SEPARATOR ', ') AS friend_request , COUNT(*)
FROM friend_requests

WHERE
	initiator_user_id = @processing_user
	OR target_user_id = @processing_user
GROUP BY status
ORDER BY status;

-- в той же выборке можно побаловаться с айди пользователей,
-- мы же ищем друзей заданного пользователя, поэтому нам необязательно вывводить айди заданного пользователя
-- здесь же к друзьям заданного пользователя можно прикрутить данные по друзьям из users и profiles, а также возраст

SELECT status, IF(initiator_user_id = @processing_user, target_user_id, initiator_user_id) AS friend,
        (SELECT firstname FROM users WHERE id = friend) AS name,
        (SELECT lastname FROM users WHERE id = friend)  AS lastname,
        (SELECT birthday FROM profiles WHERE user_id = friend) AS birthday,
        (SELECT CASE (gender) WHEN 'm' THEN 'male' WHEN 'f' THEN 'female' END FROM profiles WHERE user_id = friend) AS gender_of_friend,
        (SELECT marriage_status FROM profiles WHERE user_id = friend) AS marriage_status_of_friend,
        (SELECT TIMESTAMPDIFF(YEAR, birthday,NOW()) FROM profiles WHERE user_id = friend) AS age
FROM friend_requests
WHERE
	(initiator_user_id = @processing_user
	OR target_user_id = @processing_user)
	-- заглушечка по статусу "подтвержденный" AND status = 'approved'
GROUP BY status, friend
ORDER BY 1, 2;

-- новости друзей
SELECT * FROM media WHERE user_id IN
(SELECT initiator_user_id FROM friend_requests WHERE target_user_id = @processing_user AND status = 'approved'
UNION
SELECT target_user_id FROM friend_requests WHERE initiator_user_id = @processing_user AND status = 'approved')
ORDER BY user_id;

-- по новостям друзей:
-- можно вывести статистику, добавить имена пользователей,указать наименования типов медиа,
-- сгруппировать по друзьям заданного пользователя и типу файлов
-- сортануть по размеру всех медиа файлов каждого друга заданного пользователя

SELECT user_id,
        (SELECT firstname FROM users WHERE id = media.user_id) AS friend_name,
        (SELECT lastname FROM users WHERE id = media.user_id) AS friend_surname,
        (SELECT name FROM media_types WHERE id = media.media_type_id) AS name_of_media_type,
        COUNT(id) AS number_of_media,
        SUM(size) AS weight_of_media
FROM media
WHERE user_id IN (SELECT initiator_user_id FROM friend_requests WHERE target_user_id = @processing_user AND status = 'approved'
                  UNION
                  SELECT target_user_id FROM friend_requests WHERE initiator_user_id = @processing_user AND status = 'approved')
GROUP BY 1,4
ORDER BY weight_of_media DESC;

