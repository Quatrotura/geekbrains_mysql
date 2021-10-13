-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, 
-- содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, 
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, 
-- который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	password VARCHAR(50) NOT NULL
);

INSERT INTO accounts VALUES 
(NULL, 'Ivan Ivanov', 'qwerty'),
(NULL, 'Boris Borisov', 'asdfg'),
(NULL, 'Mariya Vasilyeva', 'zxcvb');

CREATE VIEW username AS SELECT id, name FROM accounts;

CREATE USER user_read@localhost IDENTIFIED WITH sha256_password BY 'qwerty';
GRANT SELECT ON testing.username TO 'user_read'@'localhost';
