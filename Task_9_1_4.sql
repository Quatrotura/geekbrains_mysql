-- 9.1.4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS any_table;
CREATE TABLE any_table (created_at DATETIME);

DROP PROCEDURE IF EXISTS dates_filling;
DELIMITER //
CREATE PROCEDURE dates_filling()
BEGIN
    DECLARE start_date DATETIME DEFAULT '2021-10-11';
    WHILE start_date != '2021-09-30' DO
	    INSERT INTO any_table VALUES (start_date);
	    SET start_date = start_date - INTERVAL 1 DAY;
    END WHILE;
    SELECT * FROM any_table ORDER BY 1;
END //
DELIMITER ;
CALL dates_filling();

SET @condition_for_deletion = CURDATE() - INTERVAL 5 DAY;
DELETE FROM any_table WHERE created_at <= @condition_for_deletion;
SELECT * FROM any_table;
