-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", 
-- с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello(cur_time TIME)
RETURNS TINYTEXT DETERMINISTIC
BEGIN
	CASE 
		WHEN cur_time >= '06:00:00' AND cur_time < '12:00:00' THEN RETURN 'Good morning';
		WHEN cur_time >= '12:00:00' AND cur_time < '18:00:00' THEN RETURN 'Good day';
		WHEN cur_time >= '18:00:00' AND cur_time <= '23:59:59' THEN RETURN 'Good evening';
		WHEN cur_time >= '00:00:00' AND cur_time < '06:00:00' THEN RETURN 'Good night';
	END CASE;
END //


DROP FUNCTION IF EXISTS hello;

DELIMITER //

CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC
BEGIN
	DECLARE cur_time TIME;
	SET cur_time = CURTIME();
	CASE 
		WHEN cur_time >= '06:00:00' AND cur_time < '12:00:00' THEN RETURN 'Good morning';
		WHEN cur_time >= '12:00:00' AND cur_time < '18:00:00' THEN RETURN 'Good day';
		WHEN cur_time >= '18:00:00' AND cur_time <= '23:59:59' THEN RETURN 'Good evening';
		WHEN cur_time >= '00:00:00' AND cur_time < '06:00:00' THEN RETURN 'Good night';
	END CASE;
END //
