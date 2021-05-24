CREATE TABLE steam_description_data (
	steam_appid SERIAL PRIMARY KEY,
	detailed_description TEXT NOT NULL,
	about_the_game TEXT NOT NULL,
	short_description TEXT NOT NULL
);

CREATE TABLE steam (
	appid SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	release_date DATE NOT NULL,
	english INT NOT NULL,
	developer VARCHAR(255) NOT NULL,
	publisher VARCHAR(255) NOT NULL,
	platforms VARCHAR(255) NOT NULL,
	required_age INT NOT NULL,
	categories TEXT NOT NULL,
	genres VARCHAR(255) NOT NULL,
	steamspy_tags VARCHAR(255) NOT NULL,
	achievements INT NOT NULL,
	positive_ratings INT NOT NULL,
	negative_ratings INT NOT NULL,
	average_playtime INT NOT NULL,
	median_playtime INT NOT NULL,
	owners VARCHAR(255) NOT NULL,
	price DECIMAL (10, 2) NOT NULL
);

CREATE TABLE steam_requirements_data (
	steam_appid SERIAL PRIMARY KEY,
	pc_requirements TEXT,
	mac_requirements TEXT,
	linux_requirements TEXT,
	minimum TEXT,
	recommended TEXT
);

create table steamspy_tag_data (
	appid SERIAL PRIMARY KEY,
	action INT,
	adventure INT,
	fps INT,
	horror INT,
	indie INT,
	mmorpg INT,
	moba INT,
	simulation INT,
	survival INT,
	zombies INT,
	e_sports INT
);

--docker cp C:\Users\Thiago\Documents\steam_description_data.csv postgres:/home
-- Comando Copy
COPY steam_description_data (steam_appid, detailed_description, about_the_game, short_description)
FROM '/home/steam_description_data.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM steam_description_data

--docker cp C:\Users\Thiago\Documents\steam.csv postgres:/home
COPY steam (appid,
	name,
	release_date,
	english,
	developer,
	publisher,
	platforms,
	required_age,
	categories,
	genres,
	steamspy_tags,
	achievements,
	positive_ratings,
	negative_ratings,
	average_playtime,
	median_playtime,
	owners,
	price)
FROM '/home/steam.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM steam

--docker cp C:\Users\Thiago\Documents\steam_requirements_data.csv postgres:/home
-- Comando Copy
COPY steam_requirements_data (steam_appid,
	pc_requirements,
	mac_requirements,
	linux_requirements,
	minimum,
	recommended)
FROM '/home/steam_requirements_data.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM steam_requirements_data


--docker cp C:\Users\Thiago\Documents\steamspy_tag_data.csv postgres:/home
-- Comando Copy
COPY steamspy_tag_data (appid,
	action,
	adventure,
	fps,
	horror,
	indie,
	mmorpg,
	moba,
	simulation,
	survival,
	zombies,
	e_sports)
FROM '/home/aline/steamspy_tag_data.csv'
DELIMITER ','
CSV HEADER

select * from steamspy_tag_data;



