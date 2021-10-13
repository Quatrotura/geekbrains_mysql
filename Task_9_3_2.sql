-- В таблице products есть два текстовых поля: 
-- name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.


DROP TRIGGER IF EXISTS check_insert_name_descr;

DELIMITER //

CREATE TRIGGER check_insert_name_descr BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Either name or description columns shall not be NULL or empty';
	END IF;
END //

--  тогда и для UPDATE надо сделать

DROP TRIGGER IF EXISTS check_upd_name_descr;

DELIMITER //

CREATE TRIGGER check_upd_name_descr BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Either name or description columns shall not be NULL or empty';
	END IF;
END //
