-- Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop

CREATE USER shop_read@localhost IDENTIFIED WITH sha256_password BY 'qwerty';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';

CREATE USER shop@localhost IDENTIFIED WITH sha256_password BY 'qwerty';
GRANT ALL ON shop.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop.* TO 'shop'@'localhost';

-- mysql> select User,Host from mysql.user;
-- +------------------+-----------+
-- | User             | Host      |
-- +------------------+-----------+
-- | mysql.infoschema | localhost |
-- | mysql.session    | localhost |
-- | mysql.sys        | localhost |
-- | root             | localhost |
-- | shop             | localhost |
-- | shop_read        | localhost |
-- +------------------+-----------+
-- 6 rows in set, 1 warning (0,01 sec)

-- mysql> show grants for shop@localhost;
-- +--------------------------------------------------------------------------+
-- | Grants for shop@localhost                                                |
-- +--------------------------------------------------------------------------+
-- | GRANT USAGE ON *.* TO "shop"@"localhost"                                 |
-- | GRANT ALL PRIVILEGES ON "shop".* TO "shop"@"localhost" WITH GRANT OPTION |
-- +--------------------------------------------------------------------------+
-- 2 rows in set (0,00 sec)

-- mysql> show grants for shop_read@localhost;
-- +-----------------------------------------------------+
-- | Grants for shop_read@localhost                      |
-- +-----------------------------------------------------+
-- | GRANT USAGE ON *.* TO "shop_read"@"localhost"       |
-- | GRANT SELECT ON "shop".* TO "shop_read"@"localhost" |
-- +-----------------------------------------------------+
-- 2 rows in set (0,01 sec)
