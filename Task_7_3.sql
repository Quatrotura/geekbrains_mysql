-- 7.3. Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, 
-- поле name — русское. Выведите список рейсов flights с русскими названиями городов.

CREATE DATABASE airport;
CREATE TABLE flights (
	id SERIAL,
	`from` VARCHAR (150),
	`to` VARCHAR (150)
);

CREATE TABLE cities (
	label VARCHAR (150),
	name VARCHAR (150)
);

INSERT INTO flights VALUES 
(NULL, 'moscow', 'omsk'),
(NULL, 'novgorod', 'kazan'),
(NULL, 'irkutsk', 'moscow'),
(NULL, 'omsk', 'irkutsk'),
(NULL, 'moscow', 'kazan');

INSERT INTO cities VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');

SELECT 
flights.id, cities_1.name AS откуда, cities_2.name AS куда
FROM flights 
JOIN cities AS cities_1 ON flights.`from` = cities_1.label
JOIN cities AS cities_2 ON flights.`to` = cities_2.label
ORDER BY id;


-- или 

SELECT
	flights.id, 
	(SELECT name FROM cities WHERE flights.`from` = cities.label) AS откуда,
	(SELECT name FROM cities WHERE flights.`to` = cities.label) AS куда
FROM flights 
ORDER BY id;
