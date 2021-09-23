# 2. Таблица users была неудачно спроектирована. 
# Записи created_at и updated_at 
# были заданы типом VARCHAR 
# и в них долгое время помещались 
# значения в формате 20.10.2017 8:10. 
# Необходимо преобразовать поля к типу DATETIME, 
# сохранив введённые ранее значения.

DROP TABLE IF EXISTS users2;
CREATE TABLE users2(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
);

INSERT INTO users2 VALUES
	(null, 'Mark', '20.10.2017 8:10', '20.10.2017 8:10'), 
	(null, 'Gregory', '15.02.2001 22:10', '15.02.2001 22:10'), 
	(null, 'John', '20.10.2017 8:10', '20.10.2017 8:10'), 
	(null, 'Ben', '20.10.2017 8:10', '20.10.2017 8:10');
	
SELECT * FROM users2;

# +----+---------+------------------+------------------+
# | id | name    | created_at       | updated_at       |
# +----+---------+------------------+------------------+
# |  1 | Mark    | 20.10.2017 8:10  | 20.10.2017 8:10  |
# |  2 | Gregory | 15.02.2001 22:10 | 15.02.2001 22:10 |
# |  3 | John    | 20.10.2017 8:10  | 20.10.2017 8:10  |
# |  4 | Ben     | 20.10.2017 8:10  | 20.10.2017 8:10  |
# +----+---------+------------------+------------------+
# 4 rows in set (0,00 sec)

UPDATE users2 
SET created_at = CONCAT(substring(created_at,7,4),'-', substring(created_at,4,2),'-',substring(created_at,1,2),' ', substring(created_at,12,5),':00');

UPDATE users2 
SET updated_at = CONCAT(substring(updated_at,7,4),'-', substring(updated_at,4,2),'-',substring(updated_at,1,2),' ', substring(updated_at,12,5),':00');

ALTER TABLE users2 CHANGE created_at created_at DATETIME;
ALTER TABLE users2 CHANGE updated_at updated_at DATETIME;

SELECT * FROM users2;

# +----+---------+---------------------+---------------------+
# | id | name    | created_at          | updated_at          |
# +----+---------+---------------------+---------------------+
# |  1 | Mark    | 2017-10-20 08:10:00 | 2017-10-20 08:10:00 |
# |  2 | Gregory | 2001-02-15 22:10:00 | 2001-02-15 22:10:00 |
# |  3 | John    | 2017-10-20 08:10:00 | 2017-10-20 08:10:00 |
# |  4 | Ben     | 2017-10-20 08:10:00 | 2017-10-20 08:10:00 |
# +----+---------+---------------------+---------------------+
# 4 rows in set (0,00 sec)

DESCRIBE users2;

# +------------+-----------------+------+-----+---------+----------------+
# | Field      | Type            | Null | Key | Default | Extra          |
# +------------+-----------------+------+-----+---------+----------------+
# | id         | bigint unsigned | NO   | PRI | NULL    | auto_increment |
# | name       | varchar(100)    | NO   |     | NULL    |                |
# | created_at | datetime        | YES  |     | NULL    |                |
# | updated_at | datetime        | YES  |     | NULL    |                |
# +------------+-----------------+------+-----+---------+----------------+
# 4 rows in set (0,00 sec)
