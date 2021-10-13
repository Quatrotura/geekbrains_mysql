-- 9.1.2. Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.


CREATE OR REPLACE VIEW products_wh_cat (product_name, catalog_name) AS
SELECT products.name, catalogs.name FROM products LEFT JOIN catalogs ON products.catalog_id = catalogs.id;

SELECT * FROM products_wh_cat;

-- +-------------------------+----------------------+
-- | product_name            | catalog_name         |
-- +-------------------------+----------------------+
-- | Intel Core i3-8100      | Процессоры           |
-- | Intel Core i5-7400      | Процессоры           |
-- | AMD FX-8320E            | Процессоры           |
-- | AMD FX-8320             | Процессоры           |
-- | ASUS ROG MAXIMUS X HERO | Мат. платы           |
-- | Gigabyte H310M S2H      | Мат. платы           |
-- | MSI B250M GAMING PRO    | Мат. платы           |
-- +-------------------------+----------------------+
