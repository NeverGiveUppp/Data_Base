DROP DATABASE IF EXISTS you_tubchick;
CREATE DATABASE you_tubchick;
USE you_tubchick;

-- --------------------------------------------------------------------------- users (пользователь)
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	signed_up_at TIMESTAMP DEFAULT now(),
	username VARCHAR(50) UNIQUE,
	email VARCHAR(100) UNIQUE,
	phone_number BIGINT UNSIGNED UNIQUE,
	birthday DATETIME DEFAULT NOW(),
	password_hash VARCHAR(100)
);

INSERT INTO users VALUES
('1', '2000-01-18 04:54:01','Ratke', 'trey62@example.net', '89676723604', '1996-05-18',  'ergtergerger'),
('2', '2001-01-18 00:54:01', 'Fritsch','rrolfson@example.org','89339101296','2015-04-25', 'wergwergwer8'),
('3', '2002-01-18 03:54:01','Jerde','stone96@example.com','89802518644','1974-02-07', 'esrfergh'),
('4', '2003-01-18 08:52:03','Lynch', 'feil@example.com','89397268208','1971-02-07', 'HDFGHВsdfsdf'),
('5', '2010-01-18 03:54:04','Kunde','ckuhic@example.org','89344268108','2015-04-25', 'HDFGsdfdfsdf'),
('6', '2010-01-18 03:51:01','Schumm','syost@example.org','89125986482','1992-05-05', 'HDfgsdfgsd'),
('7', '2004-01-18 05:54:01','Prosacco','malvina.toy@example.net','89334895548','1995-10-05', 'HsdfsdfПА'),
('8', '2005-01-18 03:50:02','Lea','adelia91@example.com','89838377175','2013-07-10', 'HDsdfvgrthrtyА'),
('9', '2006-01-18 13:54:01','Tre','alphonso71@example.com','89777246849','2013-07-10', 'HDFGrtyerftbd'),
('10', '2002-01-18 11:54:01','Luisa','esipes@example.net','89230775666','1993-05-22', 'HDpiopuiyrghdgА')
;



-- --------------------------------------------------------------------------- user_profiles (профиль пользователя)

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BIGINT unsigned,
	updated_at TIMESTAMP DEFAULT now(),

	avatar BIGINT UNSIGNED DEFAULT 1,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	gender enum('f', 'm'),
	
	INDEX user_name_idx (first_name, last_name),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	
);	

INSERT INTO profiles VALUES 
('1', '2000-01-18 04:54:01', '1', 'Ratke', 'Gerhold', 'f'),
('2', '2001-01-18 00:54:01','2', 'Fritsch','Weimann','m'),
('3', '2002-01-18 03:54:01','3','Jerde','Hahn','f'),
('4', '2003-01-18 08:52:03','4','Lynch', 'Monahan','m'),
('5', '2010-01-18 03:54:04','5','Kunde','Yundt','f'),
('6', '2010-01-18 03:51:01','6','Schumm','Dickens','f'),
('7', '2004-01-18 05:54:01','7','Prosacco','Spencer','m'),
('8', '2005-01-18 03:50:02','8','Lea','Daniel','m'),
('9', '2006-01-18 13:54:01','9','Tre','Satterfield','f'),
('10', '2002-01-18 11:54:01','10','Luisa','Shields','f')
;

-- --------------------------------------------------------------------------- media (видео на сайте)

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255), 	
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (user_id) REFERENCES users (id)	
);

INSERT INTO media (id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,1,'Est aut aliquid est.','name1',5,NULL,'1991-11-16 08:14:38.000','2019-06-19 18:11:58.000'),
(2,2,'Laborum dolorem magni unde vero sit hic.', 'name2', 4510, NULL, '1986-12-10 19:34:26.000', '2019-06-19 18:11:58.000'),
(3,3,'A quam ea ullam reiciendis vel et reiciendis.','name3',763116,NULL,'1978-09-18 17:07:49.000','2019-06-19 18:11:58.000'),
(4,4,'Velit commodi in veniam occaecati.','name4',740,NULL,'1984-10-21 04:41:15.000','2019-06-19 18:11:58.000'),
(5,5,'Est eaque est qui et omnis rerum.','name5',40813,NULL,'2014-06-20 03:34:11.000','2019-06-19 18:11:58.000'),
(6,6,'Atque et nam nulla et aliquid.','name6',119422,NULL,'1991-11-02 07:50:45.000','2019-06-19 18:11:58.000'),
(7,1,'Nihil ut et reprehenderit et.','name7',704558,NULL,'1988-09-17 20:56:38.000','2019-06-19 18:11:58.000'),
(8,1,'Sint quod fugit molestiae dolore repellendus est.','name7',65108,NULL,'1995-10-07 10:19:53.000','2019-06-19 18:11:58.000'),
(9,1,'Optio sed aperiam veniam eum.','name8',83717449,NULL,'2003-08-05 05:55:25.000','2019-06-19 18:11:58.000'),
(10,9,'Facere nostrum facilis aperiam quisquam dolor.','name9',75,NULL,'1984-05-17 07:37:30.000','2019-06-19 18:11:58.000')
;


-- --------------------------------------------------------------------------- FOLLOWERS (подписчики)

DROP TABLE IF EXISTS follow_user;
CREATE TABLE follow_user (
	id SERIAL PRIMARY KEY,
	follower_id BIGINT UNSIGNED NOT NULL,
	target_id BIGINT UNSIGNED NOT NULL,
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),

	FOREIGN KEY (follower_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (target_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO follow_user VALUES 
('1', '2', '1', '2000-01-18 04:54:01', '2000-01-18 04:54:01'),
('2', '3', '1',  '2001-01-18 00:54:01','2001-01-18 00:54:01'),
('3', '2', '2', '2002-01-18 03:54:01','2020-01-18 11:54:01'),
('4', '2', '3', '2003-01-18 08:52:03','2020-01-18 11:54:02'),
('5', '2', '4', '2010-01-18 03:54:04','2020-01-18 11:54:03'),
('6', '3', '5', '2010-01-18 03:51:01','2020-01-18 11:54:04'),
('7', '4', '6', '2004-01-18 05:54:01','2020-01-18 11:54:05'),
('8', '9', '7', '2005-01-18 03:50:02','2020-01-18 11:54:06'),
('9', '8', '7', '2006-01-18 13:54:01','2020-01-18 11:54:01'),
('10', '10', '1', '2002-01-18 11:54:01','2020-01-18 11:54:09')
;

-- --------------------------------------------------------------------------- likes (лайки)

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

INSERT INTO likes VALUES 
('1','1','1','1988-10-14 18:47:39'),
('2','2','1','1988-09-04 16:08:30'),
('3','3','1','1994-07-10 22:07:03'),
('4','4','1','1991-05-12 20:32:08'),
('5','5','2','1978-09-10 14:36:01'),
('6','6','7','1992-04-15 01:27:31'),
('7','7','7','2003-02-03 04:56:27'),
('8','8','8','2017-04-24 09:30:19'),
('9','9','9','1974-02-07 20:53:55'),
('10','10','10','1973-05-11 03:21:40'),
('11','2','2','2003-02-03 04:56:27'),
('12','4','9','2017-04-24 09:30:19'),
('13','5','9','1974-02-07 07:23:55'),
('14','6','8','1978-05-11 05:22:40'),
('15','3','1','1948-05-11 05:22:40')
;
-- --------------------------------------------------------------------------- dislikes (дизлайки)

DROP TABLE IF EXISTS dislikes;
CREATE TABLE dislikes (

	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

 INSERT INTO dislikes VALUES 
('1','1','1','1988-10-14 18:41:39'),
('2','2','1','1988-09-04 16:02:30'),
('3','3','1','1994-07-10 22:02:03'),
('4','4','7','1991-05-12 20:33:08'),
('5','5','7','1978-09-10 14:34:01'),
('6','6','7','1992-04-15 01:22:31'),
('7','7','7','2003-02-03 04:54:27'),
('8','8','8','2017-04-24 09:36:19'),
('9','9','6','1974-02-07 20:51:55'),
('10','10','6','1973-05-11 02:21:40')
;   
-- --------------------------------------------------------------------------- comments(комментарии)

  DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id),

    FOREIGN KEY (media_id) REFERENCES media(id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);    
    
  INSERT INTO comments VALUES 
('1','1','1','Voluptatem ut quaerat quia.', '1988-10-14 18:41:39'),
('2','2','1','Sint dolores et debitis est ducimus.', '1988-09-04 16:02:30'),
('3','3','1','Sed mollitia quo sequi nisi est tenetur at rerum.', '1994-07-10 22:02:03'),
('4','4','7','Quod dicta omnis placeat id et officiis et.', '1991-05-12 20:33:08'),
('5','5','7','Voluptas omnis enim quia porro debitis facilis eaque ut.', '1978-09-10 14:34:01'),
('6','6','7','Rerum labore culpa et laboriosam eum totam.', '1992-04-15 01:22:31'),
('7','7','7','Perspiciatis temporibus doloribus debitis.', '2003-02-03 04:54:27'),
('8','8','8','Molestiae laudantium quibusdam porro est alias placeat assumenda. Ut consequatur rerum officiis exercitationem eveniet.', '2017-04-24 09:36:19'),
('9','9','6','Suscipit labore error ducimus quaerat distinctio quae quasi.', '1974-02-07 20:51:55'),
('10','10','6','Sint id quasi et cumque qui minima ut quo', '1973-05-11 02:21:40')
;     
  
    
    
-- --------------------------------------------------------------------------- view_history (история просмотров)

DROP TABLE IF EXISTS view_history;
CREATE TABLE view_history (
	id SERIAL PRIMARY KEY,
	title_id BIGINT UNSIGNED,
	user_id BIGINT UNSIGNED,
	is_seen BIT DEFAULT 0,    
	created_at TIMESTAMP DEFAULT now(),
	updated_at TIMESTAMP DEFAULT now(),
	
	FOREIGN KEY (title_id) REFERENCES media(id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


INSERT INTO view_history(title_id, user_id, is_seen)
VALUES
	('1', '1', 1),
	('5', '2', 1),
	('2', '3', 1),
	('6', '4', 1),
	('3', '5', 0),
	('4', '6', 1),
	('7', '7', 0),
	('8', '8', 0),
	('9', '9', 0),
	('10', '10', 0)
;



-- --------------------------------------------------------------------------- user_lists

DROP TABLE IF EXISTS user_lists;
CREATE TABLE user_lists (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED,
	list_name VARCHAR(50) DEFAULT ' ',
	description VARCHAR(100) DEFAULT ' ',
	created_at TIMESTAMP DEFAULT now(),
		updated_at TIMESTAMP DEFAULT now(),
		
	INDEX (list_name),
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE RESTRICT
		ON UPDATE cascade
		

);


INSERT INTO user_lists(user_id, list_name, description)
VALUES
	('1', 'Kuhn, Ziemann and Davis', 'Fully-configurable dedicated circuit'),	
	('1', 'Baumbach-Franecki', 'Inverse content-based hub'),	
	('1', 'Hoeger-Boyer', 'Realigned multi-tasking alliance'),	
	('2', 'Kub LLC', 'Universal secondary projection'),	
	('3', 'Hirthe LLC', 'Enterprise-wide logistical capacity'),	
	('3', 'Gleichner', 'Kshlerin and Ankunding'),	
	('4', 'Schumm-Orn', 'Upgradable intangible pricingstructure'),	
	('5', 'Anderson-Waelchi', 'Enterprise-wide local success'),	
	('3', 'Pouros PLC', 'User-centric radical productivity'),	
	('2', 'Fadel Inc', 'Future-proofed discrete standardization'),	
	('5', 'Metz Ltd', 'Function-based upward-trending benchmark'),	
	('6', 'Jaskolski', 'Price and Stokes'),
	('9', 'OKon PLC', 'Cross-group real-time customerloyalty'),	
	('10', 'Jakubowski-OConner', 'Multi-layered encompassing GraphicalUserInterface'),	
	('10', 'Grimes Group', 'Advanced national project');







-- **********************************************************Представления*************************************************


-- ---------------------------------------------------------------------------количество видео на сайте

DROP VIEW IF EXISTS count_media;
CREATE VIEW count_media
AS
SELECT count(*) 'Количество медиафайлов на сайте'
FROM media m;
SELECT * FROM count_media;




-- ---------------------------------------------------------------------------Список медиафайлов определенного пользователя с количеством лайков
DROP VIEW IF EXISTS user_media_top;
CREATE VIEW user_media_top
AS
SELECT media.filename 'Медиафайл',
count(*) as 'Количество лайков'
FROM media
    JOIN likes ON media.id = likes.media_id
    JOIN users ON users.id = media.user_id
WHERE users.id = 1
GROUP BY media.id;
SELECT * FROM user_media_top;


-- **********************************************************Тригеры*************************************************

-- Корректировка при вводе даты рождения в будующем времени на сегодня:

DROP TRIGGER if exists check_user_aget;
DELIMITER //
CREATE TRIGGER check_user_age BEFORE INSERT ON users
FOR EACH ROW
begin
IF NEW.birthday > CURRENT_DATE() THEN
SET NEW.birthday = CURRENT_DATE();
END IF;
END//
DELIMITER ;


-- ---------------------------------------------------------------------------Замена NULL в столбцах названия файла и описания к нему:

DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON media
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.filename)) THEN
		SET NEW.filename = 'No Name';
	END IF;
	IF(ISNULL(NEW.body)) THEN
		SET NEW.body = 'No body';
	END IF;
END //
delimiter ;


INSERT INTO media (id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES -- для проверки
(11,5, NULL, NULL,15,NULL,'1992-11-16 08:14:38.000','2019-06-19 18:11:58.000')
;





-- **********************************************************Процедуры*************************************************

-- ---------------------------------------------------------------------------Поиск пользователя с большим числом лайков

DROP PROCEDURE IF EXISTS top_users_likes;  

DELIMITER $$
CREATE PROCEDURE top_users_likes()
BEGIN
	SELECT 
		users.id,
		username,
		profiles.first_name,
		count(*) AS likes_count
	FROM users
JOIN profiles on users.id = profiles.user_id
JOIN media ON users.id = media.user_id
JOIN likes ON media.id = likes.media_id
  	GROUP BY users.id
  	ORDER BY likes_count DESC
  	LIMIT 1;
		
END $$
DELIMITER ;
CALL top_users_likes();



-- ---------------------------------------------------------------------------Количество пользователей сайта
DROP PROCEDURE IF EXISTS count_users;    

DELIMITER $$
CREATE PROCEDURE count_users()
BEGIN
		SELECT count(*)
		FROM users id;
END $$
DELIMITER ;
CALL count_users();


