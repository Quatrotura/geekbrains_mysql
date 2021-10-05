# 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)

USE testing;
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	birth_month VARCHAR (20) NOT NULL
	
);

INSERT INTO users VALUES
	(null, 'Mark', 'May'), 
	(null, 'Gregory', 'January'), 
	(null, 'John', 'December'), 
	(null, 'Ben', 'March'),
	(null, 'Steve', 'May'),
	(null, 'Michael', 'April'), 
	(null, 'Ronald', 'July'), 
	(null, 'Bradford', 'October'),
	(null, 'Nathan', 'November'), 
	(null, 'Garry', 'September'), 
	(null, 'Matt', 'June'), 
	(null, 'Sarah', 'May'),
	(null, 'Elizabeth', 'February'), 
	(null, 'Olivia', 'August'), 
	(null, 'Silvio', 'October'), 
	(null, 'Eugene', 'April'),
	(null, 'Margaret', 'August'), 
	(null, 'Sergio', 'February'), 
	(null, 'Oscar', 'June'), 
	(null, 'Edward', 'May');
	
SELECT * FROM users;
# +----+-----------+-------------+
# | id | name      | birth_month |
# +----+-----------+-------------+
# |  1 | Mark      | May         |
# |  2 | Gregory   | January     |
# |  3 | John      | December    |
# |  4 | Ben       | March       |
# |  5 | Steve     | May         |
# |  6 | Michael   | April       |
# |  7 | Ronald    | July        |
# |  8 | Bradford  | October     |
# |  9 | Nathan    | November    |
# | 10 | Garry     | September   |
# | 11 | Matt      | June        |
# | 12 | Sarah     | May         |
# | 13 | Elizabeth | February    |
# | 14 | Olivia    | August      |
# | 15 | Silvio    | October     |
# | 16 | Eugene    | April       |
# | 17 | Margaret  | August      |
# | 18 | Sergio    | February    |
# | 19 | Oscar     | June        |
# | 20 | Edward    | May         |
# +----+-----------+-------------+
# 20 rows in set (0,00 sec)

SELECT name, birth_month FROM users WHERE birth_month IN ('May', 'August') ORDER BY birth_month DESC;
# +----------+-------------+
# | name     | birth_month |
# +----------+-------------+
# | Mark     | May         |
# | Steve    | May         |
# | Sarah    | May         |
# | Edward   | May         |
# | Olivia   | August      |
# | Margaret | August      |
# +----------+-------------+
# 6 rows in set (0,00 sec)
