-- 6.2.Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
use vk;
SET @some_user = 611;

DESCRIBE messages;
-- +--------------+--------------------------------+------+-----+-------------------+-------------------+
-- | Field        | Type                           | Null | Key | Default           | Extra             |
-- +--------------+--------------------------------+------+-----+-------------------+-------------------+
-- | id           | bigint unsigned                | NO   | PRI | NULL              | auto_increment    |
-- | from_user_id | bigint unsigned                | NO   | MUL | NULL              |                   |
-- | to_user_id   | bigint unsigned                | NO   | MUL | NULL              |                   |
-- | body         | text                           | YES  |     | NULL              |                   |
-- | msg_status   | enum('sent','received','read') | NO   | MUL | NULL              |                   |
-- | created_at   | datetime                       | YES  | MUL | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
-- +--------------+--------------------------------+------+-----+-------------------+-------------------+
SELECT IF(from_user_id = @some_user, to_user_id, from_user_id) AS friend_wt_msg, count(id) AS cnt
FROM messages
WHERE (from_user_id = @some_user AND to_user_id IN
                                                (SELECT IF(initiator_user_id = @some_user, target_user_id, initiator_user_id) AS friend_of_some_user
                                                FROM friend_requests
                                                WHERE (initiator_user_id = @some_user OR target_user_id = @some_user) AND status = 'approved')) OR
      (to_user_id = @some_user AND from_user_id IN
                                                (SELECT IF(initiator_user_id = @some_user, target_user_id, initiator_user_id) AS friend_of_some_user
                                                FROM friend_requests
                                                WHERE (initiator_user_id = @some_user OR target_user_id = @some_user) AND status = 'approved'))
GROUP BY 1
ORDER BY cnt DESC LIMIT 1;
