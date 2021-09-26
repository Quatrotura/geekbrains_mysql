-- 3. Подсчитайте произведение чисел в столбце таблицы.
use testing;
CREATE TABLE tbl3 (id SERIAL, value1 INT, value2 INT);
INSERT INTO tbl3 VALUES
(null,1,5),
(null,2,4),
(null,3,3),
(null,4,2),
(null,5,1);
SELECT * FROM tbl3;
# +----+--------+--------+
# | id | value1 | value2 |
# +----+--------+--------+
# |  1 |      1 |      5 |
# |  2 |      2 |      4 |
# |  3 |      3 |      3 |
# |  4 |      4 |      2 |
# |  5 |      5 |      1 |
# +----+--------+--------+

SELECT ROUND(exp(sum(ln(value1)))) AS value1_product_of_num FROM tbl3;

# +-----------------------+
# | value1_product_of_num |
# +-----------------------+
# |                   120 |
# +-----------------------+
# 1 row in set (0,01 sec)