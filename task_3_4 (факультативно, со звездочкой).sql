UPDATE IGNORE friend_requests, users SET friend_requests.target_user_id = (SELECT id FROM users ORDER BY rand() LIMIT 1) WHERE friend_requests.initiator_user_id = friend_requests.target_user_id;
SELECT COUNT(*) FROM friend_requests WHERE friend_requests.initiator_user_id = friend_requests.target_user_id;

-- если чек выдаст предупреждение с дубликатами можно еще раз прогнать update :-)
