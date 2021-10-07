-- 7.2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT prod.name, cat.name
FROM products as prod JOIN catalogs as cat
ON prod.catalog_id = cat.id;

-- или

SELECT prod.name, cat.name
FROM products as prod LEFT JOIN catalogs as cat
ON prod.catalog_id = cat.id;

-- или

SELECT prod.name, cat.name
FROM catalogs as cat RIGHT JOIN products as prod
ON prod.catalog_id = cat.id;

-- или

SELECT name, (SELECT name FROM catalogs WHERE id = products.catalog_id)
FROM products;
