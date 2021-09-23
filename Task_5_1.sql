# 1. Пусть в таблице users поля created_at и 
# updated_at оказались незаполненными. 
# Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users2;
CREATE TABLE users2(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	created_at DATETIME,
	updated_at DATETIME
);
INSERT INTO users2(id,name) VALUES
	(null, 'Mark'), 
	(null, 'Gregory'), 
	(null, 'John'), 
	(null, 'Ben');

SELECT * FROM users2;

# +----+---------+------------+------------+
# | id | name    | created_at | updated_at |
# +----+---------+------------+------------+
# |  1 | Mark    | NULL       | NULL       |
# |  2 | Gregory | NULL       | NULL       |
# |  3 | John    | NULL       | NULL       |
# |  4 | Ben     | NULL       | NULL       |
# +----+---------+------------+------------+
# 4 rows in set (0,00 sec)


UPDATE users2 
SET 
	created_at = now(),
	updated_at = now();

SELECT * FROM users2;

# +----+---------+---------------------+---------------------+
# | id | name    | created_at          | updated_at          |
# +----+---------+---------------------+---------------------+
# |  1 | Mark    | 2021-09-23 00:37:31 | 2021-09-23 00:37:31 |
# |  2 | Gregory | 2021-09-23 00:37:31 | 2021-09-23 00:37:31 |
# |  3 | John    | 2021-09-23 00:37:31 | 2021-09-23 00:37:31 |
# |  4 | Ben     | 2021-09-23 00:37:31 | 2021-09-23 00:37:31 |
# +----+---------+---------------------+---------------------+
# 4 rows in set (0,00 sec)