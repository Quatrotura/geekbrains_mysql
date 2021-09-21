use vk;


INSERT INTO users (`id`,`firstname`, `lastname`,`email`,`password_hash`,`phone`) VALUES (NULL, 'Julio','Juarito','onionsinburitto@gmail.com','adlkjfgdlaskj939i','9384934');

-- INSERT INTO users (`firstname`,`lastname`,`email`,`password_hash`,`phone`) VALUES ('Rita','Nunes','ridersonthestorm@mexicana.com','9394jjj9w93~~-)','9393094040');

INSERT INTO users VALUES
	(NULL, 'Johny', 'Cash', 'ringthegodsdoor@yahoo.com', '93939lksdlkfdsfj', '1313131313'),
	(NULL, 'Noah', 'Heisenberg','checkmylab@gmail.com', '93939lksdlkfdsfj', '1934948848'),
	(NULL, 'Oleksy', 'Bereza', 'glorytoheros@ukraine.ru', '93939lksdlkfdsfj', '939482003'),
	(1,'Matt','Springfield','getmygun@redneck.com', '93938940))--jdjdj', '9393884940');

INSERT INTO users
SET
	firstname  = 'William',
	lastname  = 'Shakespear',
	email = 'tasteless_cakes@gmail.com',
	password_hash = 'kfjgi94939---=`)',
	phone = '19848483903';
	
INSERT INTO users (`firstname`, `lastname`,`email`,`password_hash`,`phone`)
SELECT `firstname`, `lastname`,`email`,`password_hash`,`phone` 
FROM shop.users_exp
WHERE firstname = 'Ramon';

SELECT 'Hello,world!' AS `text` FROM DUAL;
SELECT firstname, lastname FROM users WHERE id > 400 AND id < 450;
select distinct firstname, lastname from users;

SELECT * FROM users LIMIT 1 OFFSET 10;

SELECT * FROM users WHERE id IN (1, 411, 478, 567);

SELECT * FROM users WHERE id BETWEEN 400 AND 500; -- начало и конец заданного диапазона включаются в выборку

SELECT * FROM users WHERE id BETWEEN 411 AND 420 LIMIT 2 OFFSET 3;

UPDATE friend_requests 
SET 
	status = 'approved',
	updated_at = now()
WHERE initiator_user_id = 667 and target_user_id  = 673 and status = 'requested';

DELETE FROM messages
WHERE from_user_id = 712 AND to_user_id = 418;

TRUNCATE likes;

INSERT INTO profiles VALUES (801, 'm', '1987-04-01', NULL, NOW(), 'single');
INSERT INTO profiles VALUES (807, 'm', '1972-01-11', NULL, NOW(), 'single');
INSERT INTO profiles VALUES (808, 'm', '1992-04-12', NULL, NOW(), 'widowed');
INSERT INTO profiles VALUES (809, 'm', '1980-05-09', NULL, NOW(), 'widowed');
INSERT INTO profiles VALUES (811, 'm', '1983-10-30', NULL, NOW(), 'divorced');
INSERT INTO profiles VALUES (812, 'm', '1983-10-30', NULL, NOW(), 'married');
INSERT INTO profiles VALUES (1, 'm', '1983-08-02', NULL, NOW(), 'married');
