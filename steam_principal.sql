-- CRIAÇÃO DAS TABELAS

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


COPY steam_description_data (steam_appid, detailed_description, about_the_game, short_description)
FROM '/home/steam_description_data.csv'
DELIMITER ','
CSV HEADER

SELECT * FROM steam_description_data


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

-- CONSULTAS

-- 1. Principais publicadoras (publishers)
select "game publishers", count(appid) as "Quantidade de jogos"
from (
select appid, unnest(string_to_array("publisher", ';')) as "game publishers"
from steam
) as game_publishers
group by "game publishers"
order by count(appid) desc
limit 10

-- 2. Top 10 preços mais frequentes no steam
select price, count() as "quantidade"
from steam
group by price
order by count() desc
limit 10;

-- 3. Quais categorias dos jogos mais caros;
select "Categorias", sum(price)
from (
select appid, categories, unnest(string_to_array("categories", ';')) as "Categorias", price
from steam
) as "categorias_steam"
group by "Categorias"
order by sum(price) desc
limit 10;

-- 4. Quais sistemas operacionais mais usados;
select "Sistema Operacional", count(*) as "Quantidade de Jogos"
from (
select platforms, unnest(string_to_array("platforms", ';')) as "Sistema Operacional"
from steam
) as so
group by "Sistema Operacional";

-- 5. Top 10 gêneros maiores generos;
-- TOP 10 jogos ação
select steamspy_tag_data.appid, steam.name, steamspy_tag_data.action
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.action <> 0
order by steamspy_tag_data.action desc
limit 10;

-- Quantidade de jogos ação
select count(*) as "Quantidade de Jogos Ação"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.action <> 0

-- TOP 10 jogos e-sports
select steamspy_tag_data.appid, steam.name, steamspy_tag_data.e_sports
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.e_sports <> 0
order by steamspy_tag_data.e_sports desc
limit 10

-- Quantidade de jogos e-sports
select count(*) as "Quantidade de Jogos E_Sports"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.e_sports <> 0

-- TOP 10 jogos moba
select steamspy_tag_data.appid, steam.name, steamspy_tag_data.moba
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.moba <> 0
order by steamspy_tag_data.moba desc
limit 10

-- Quantidade de jogos moba
select count(*) as "Quantidade de Jogos de moba"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.moba <> 0

-- TOP 10 jogos indie
select steamspy_tag_data.appid, steam.name, steamspy_tag_data.indie
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.indie <> 0
order by steamspy_tag_data.indie desc
limit 10

-- Quantidade de jogos indie
select count(*) as "Quantidade de Jogos de indie"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.indie <> 0

-- TOP 10 jogos fps
select steamspy_tag_data.appid, steam.name, steamspy_tag_data.fps
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.fps <> 0
order by steamspy_tag_data.fps desc
limit 10

-- Quantidade de jogos fps
select count(*) as "Quantidade de Jogos de FPS"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.fps <> 0

select steamspy_tag_data.appid, steam.name, steamspy_tag_data.adventure
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.adventure <> 0
order by steamspy_tag_data.adventure desc
limit 10

-- Quantidade de jogos Aventura
select count(*) as "Quantidade de Jogos de Aventura"
from steamspy_tag_data
join steam on steam.appid = steamspy_tag_data.appid
where steamspy_tag_data.adventure <> 0


-- 6. Top 10 maiores categorias de jogos (categories);
select "Categorias", count(appid) as "Quantidade de Produtos"
from (
select appid, categories, unnest(string_to_array("categories", ';')) as "Categorias"
from steam
) as "categorias_steam"
group by "Categorias"
order by count(appid) desc
limit 10

-- 7. Idade permitida de cada jogo
select required_age as "Idade requerida", count(appid) as "Quantidade de jogos"
from steam
group by required_age
order by count(appid) desc

-- 8. Quantos jogos tem o idioma inglês, e quantos não tem;
SQL:
SELECT
CASE
WHEN english = 1 THEN 'Idioma Inglês'
ELSE 'Outro Idioma'
END AS idioma,
COUNT(appid) AS "Quantidade de jogos" FROM steam
GROUP BY idioma;

-- 9. Top 10 jogos com maior avaliação positiva (positive_ratings)
select appid, name, positive_ratings
from steam
order by positive_ratings desc
limit 10;

-- 10. Top 10 jogos com maior avaliação negativa (negativa_ratings)
select appid, name, negative_ratings
from steam
order by negative_ratings desc
limit 10;

-- 11. Quais jogos mais jogados (average_playtime)
select appid, name, average_playtime from steam
order by average_playtime desc
limit 10;

-- 12. Quais anos tem maior numero de lançamento de  jogos (release_date)
-- Quais anos tem maior numero de lançamento de jogos
select "year_release_date" as "Ano de lançamento", count(*) as "Quantidade de Jogos"
from
(
select appid, extract(year from release_date)::varchar as "year_release_date"
from steam
) as "games_year_release_date"
group by "year_release_date"
order by "Quantidade de Jogos" desc
limit 10;

-- 13. Principais developers;
select "Desenvolvedoras de jogos", count(appid) as "Quantidade de jogos"
from (
select appid, unnest(string_to_array("developer", ';')) as "Desenvolvedoras de jogos"
from steam
) as game_publishers
group by "Desenvolvedoras de jogos"
order by count(appid) desc
limit 10;

-- 14. Quantidade de jogos por mês de lançamento
select
TO_CHAR(TO_DATE ("month_release_date"::text, 'MM'), 'Month') as "Mês de lançamento",
count(*) as "Quantidade de Jogos"
from
(
select appid, release_date, extract(month from release_date) as "month_release_date"
from steam
) as "games_month_release_date"
group by "month_release_date"
order by "Quantidade de Jogos" desc

-- 15. Top 10 maiores categorias de jogos
select "Categorias", count(appid) as "Quantidade de Produtos"
from (
select appid, categories, unnest(string_to_array("categories", ';')) as "Categorias"
from steam
) as "categorias_steam"
group by "Categorias"
order by count(appid) desc
limit 10

-- 16. Top 10 produtos mais caros
Comando pra obter o resultado.
select name, price from steam
order by price desc limit 10

