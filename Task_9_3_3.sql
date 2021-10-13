-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS fibonacci;
DELIMITER //

CREATE FUNCTION fibonacci(x INT)
	RETURNS INT DETERMINISTIC
	BEGIN
		DECLARE i INT DEFAULT 0;
		DECLARE a INT DEFAULT 1;
		DECLARE b INT DEFAULT 0;
		DECLARE result INT DEFAULT 0;
		
		WHILE i <= x-1 DO

			SET result = a + b;
			SET a = b;
			SET b = result;
			SET i = i + 1;
		END WHILE;

		RETURN result;
	END //
