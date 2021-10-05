-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

--  Критерии отбора:

-- наименьшее кол-во друзей
-- наименшее кол-во групп, в которых состоит пользователь
-- наименьшее кол-во медиа
-- наименьшее кол-во лайков полученных и лайков поставленных
-- наименьшее кол-во сообщений

SELECT id,
        (SELECT count(*) FROM friend_requests WHERE (initiator_user_id = users.id OR target_user_id = id) AND status = 'approved') AS number_of_friends,
        (SELECT count(*) FROM users_communities WHERE user_id = users.id) AS number_of_communities,
        (SELECT count(id) FROM media WHERE user_id = users.id) AS number_of_media,
        (SELECT count(id) FROM likes
                                WHERE likes.media_id IN (SELECT id FROM media WHERE users.id = user_id))
                                AS number_of_likes_received,
        (SELECT count(*) FROM likes WHERE users.id = likes.user_id) AS number_of_likes_set,
        (SELECT count(*) FROM messages WHERE from_user_id = users.id OR to_user_id = users.id) AS number_of_messages
FROM users
ORDER BY 4,6,7,5,3,2
LIMIT 10;

-- ниже для справки:

-- наименьшее кол-во друзей
SELECT id, (SELECT count(*) FROM friend_requests WHERE (initiator_user_id = users.id OR target_user_id = id) AND status = 'approved') AS number_of_friends
FROM users
ORDER BY 2
LIMIT 10;



-- наименьшее кол-во групп, в которых состоит пользователь
SELECT id, (SELECT count(*) FROM users_communities WHERE user_id = users.id) FROM users ORDER BY 2 LIMIT 10;

-- наименьшее кол-во медиа

SELECT id, (SELECT count(id) FROM media WHERE user_id = users.id)
FROM users
ORDER BY 2 LIMIT 10;

-- наименьшее кол-во лайков полученных
SELECT id, (SELECT count(id) FROM likes
                                WHERE likes.media_id IN (SELECT id FROM media WHERE users.id = user_id))
                                AS number_of_likes_received
FROM users
GROUP BY 1
ORDER BY 2 LIMIT 10;

-- наименьшее кол-во лайков  поставленных

SELECT id, (SELECT count(*) FROM likes WHERE users.id = likes.user_id) AS number_of_likes_set
FROM users
GROUP BY 1
ORDER BY 2 LIMIT 10;

-- наименьшее кол-во сообщений

SELECT id, (SELECT count(*) FROM messages WHERE from_user_id = users.id OR to_user_id = users.id) AS number_of_messages
FROM users
ORDER BY 2 LIMIT 10;
