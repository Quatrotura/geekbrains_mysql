CREATE DATABASE vk;
use vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
 	password_hash VARCHAR(100) NOT NULL,
	phone BIGINT UNSIGNED NOT NULL UNIQUE, 
	
    INDEX users_firstname_lastname_idx (firstname, lastname)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name ENUM ('videos', 'photos', 'tracks', 'posts'),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
	size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender ENUM('f', 'm') NOT NULL,
    birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    marriage_status ENUM ('single', 'married','divorced', 'widowed') NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES media(id)
	);


DROP TABLE IF EXISTS country_city;
CREATE TABLE country_city (
	id SERIAL,
	country_name VARCHAR (150),
	city_name VARCHAR (100),
	
	INDEX country_city_list_idx (country_name, city_name)
	
);


DROP TABLE IF EXISTS user_country_city;
CREATE TABLE user_country_city (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	home_country_city_id BIGINT UNSIGNED NOT NULL,
	residence_country_city_id BIGINT UNSIGNED NOT NULL,	
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (home_country_city_id) REFERENCES country_city(id),
	FOREIGN KEY (residence_country_city_id) REFERENCES country_city(id)

);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    msg_status ENUM ('sent', 'received', 'read') NOT NULL,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке
	
    INDEX sender_idx (from_user_id),
    INDEX recipient_idx (to_user_id),
    INDEX msg_status_idx (msg_status),
    INDEX created_at_idx (created_at),
    
    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS communities;
CREATE TABLE communities(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx (name), -- индексу можно давать свое имя (communities_name_idx)
	foreign key (admin_user_id) references users(id)
);

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
    name ENUM ('videos', 'photos', 'tracks', 'posts'), -- записей мало, поэтому в индексе нет необходимости
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
	size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),

	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums (
	id SERIAL,
	name varchar(255) NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
	id SERIAL,
	album_id BIGINT UNSIGNED NULL,
	media_id BIGINT UNSIGNED NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS edu_institutions;
CREATE TABLE edu_institutions (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR (255),
	edu_level ENUM ('среднее', 'высшее', 'средне-профессиональное')
);

DROP TABLE IF EXISTS user_edu_institutions;
CREATE TABLE user_edu_institutions (
	user_id BIGINT UNSIGNED NOT NULL,
	edu_institutions_id BIGINT UNSIGNED NOT NULL,
	user_enroll_date DATETIME NOT NULL,
	user_graduation_date DATETIME NOT NULL,
	
	CONSTRAINT pk_edu PRIMARY KEY (user_id, edu_institutions_id, user_enroll_date, user_graduation_date),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (edu_institutions_id) REFERENCES edu_institutions(id)

);

DROP TABLE IF EXISTS music_playlists;
CREATE TABLE music_playlists (
	id SERIAL PRIMARY KEY,
	name VARCHAR (255) NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS music_tracks;
CREATE TABLE music_tracks (
	id SERIAL,
	playlist_id BIGINT UNSIGNED NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (playlist_id) REFERENCES music_playlists(id),
	FOREIGN KEY (media_id) REFERENCES media(id)

);

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (

	id SERIAL,
	author_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR (255) NOT NULL,
	body LONGTEXT,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

	
    FOREIGN KEY (author_id) REFERENCES users(id)		
);

DROP TABLE IF EXISTS liked_posts;
CREATE TABLE liked_posts (
	id SERIAL,
	liker_id BIGINT UNSIGNED NOT NULL,
	post_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),

	FOREIGN KEY (liker_id) REFERENCES users(id),
	FOREIGN KEY (post_id) REFERENCES posts(id)
	
);

DROP TABLE IF EXISTS liked_users;
CREATE TABLE liked_users (
	
	id SERIAL,
	liker_id BIGINT UNSIGNED NOT NULL,
	liked_user BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),

	FOREIGN KEY (liker_id) REFERENCES users(id),
	FOREIGN KEY (liked_user) REFERENCES users(id)

);


