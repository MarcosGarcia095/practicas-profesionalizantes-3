
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS countries_db
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_bin;

USE countries_db;

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


-- Crear tabla country
CREATE TABLE IF NOT EXISTS country (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  capital VARCHAR(100) NOT NULL,
  language VARCHAR(100) NOT NULL,
  area FLOAT NOT NULL,
  population BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Crear tabla city
CREATE TABLE IF NOT EXISTS city (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  population BIGINT NOT NULL,
  area FLOAT NOT NULL,
  postal_code VARCHAR(20),
  is_coastal BOOLEAN NOT NULL,
  id_country INT NOT NULL,
  FOREIGN KEY (id_country) REFERENCES country(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Procedimientos country
DELIMITER //
CREATE PROCEDURE country_create(IN p_name VARCHAR(100), IN p_capital VARCHAR(100), IN p_language VARCHAR(100), IN p_area FLOAT, IN p_population BIGINT)
BEGIN
  INSERT INTO country (name, capital, language, area, population)
  VALUES (p_name, p_capital, p_language, p_area, p_population);
END //

CREATE PROCEDURE country_get(IN p_id INT)
BEGIN
  SELECT * FROM country WHERE id = p_id;
END //

CREATE PROCEDURE country_update(IN p_id INT, IN p_name VARCHAR(100), IN p_capital VARCHAR(100), IN p_language VARCHAR(100), IN p_area FLOAT, IN p_population BIGINT)
BEGIN
  UPDATE country
  SET name = p_name,
      capital = p_capital,
      language = p_language,
      area = p_area,
      population = p_population
  WHERE id = p_id;
END //

CREATE PROCEDURE country_delete(IN p_id INT)
BEGIN
  DELETE FROM country WHERE id = p_id;
END //

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Procedimientos city
CREATE PROCEDURE city_create(IN p_name VARCHAR(100), IN p_population BIGINT, IN p_area FLOAT, IN p_postal_code VARCHAR(20), IN p_is_coastal BOOLEAN, IN p_id_country INT)
BEGIN
  INSERT INTO city (name, population, area, postal_code, is_coastal, id_country)
  VALUES (p_name, p_population, p_area, p_postal_code, p_is_coastal, p_id_country);
END //

CREATE PROCEDURE city_get(IN p_id INT)
BEGIN
  SELECT * FROM city WHERE id = p_id;
END //

CREATE PROCEDURE city_update(IN p_id INT, IN p_name VARCHAR(100), IN p_population BIGINT, IN p_area FLOAT, IN p_postal_code VARCHAR(20), IN p_is_coastal BOOLEAN, IN p_id_country INT)
BEGIN
  UPDATE city
  SET name = p_name,
      population = p_population,
      area = p_area,
      postal_code = p_postal_code,
      is_coastal = p_is_coastal,
      id_country = p_id_country
  WHERE id = p_id;
END //

CREATE PROCEDURE city_delete(IN p_id INT)
BEGIN
  DELETE FROM city WHERE id = p_id;
END //

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Consultas especiales
CREATE PROCEDURE country_most_populated_city()
BEGIN
  SELECT c.name AS country_name
  FROM city ci
  JOIN country c ON ci.id_country = c.id
  ORDER BY ci.population DESC
  LIMIT 1;
END //

CREATE PROCEDURE country_coastal_cities_over_million()
BEGIN
  SELECT DISTINCT c.name AS country_name
  FROM city ci
  JOIN country c ON ci.id_country = c.id
  WHERE ci.is_coastal = TRUE AND ci.population > 1000000;
END //

CREATE PROCEDURE city_highest_density()
BEGIN
  SELECT ci.name AS city_name, c.name AS country_name, (ci.population / ci.area) AS density
  FROM city ci
  JOIN country c ON ci.id_country = c.id
  ORDER BY density DESC
  LIMIT 1;
END //
DELIMITER ;

--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Datos de prueba: 10 países y 20 ciudades
INSERT INTO country (name, capital, language, area, population) VALUES
('Argentina', 'Buenos Aires', 'Spanish', 2780400, 45376763),
('Brazil', 'Brasilia', 'Portuguese', 8515767, 213993437),
('Japan', 'Tokyo', 'Japanese', 377975, 125960000),
('France', 'Paris', 'French', 551695, 67848156),
('Germany', 'Berlin', 'German', 357022, 83240525),
('USA', 'Washington D.C.', 'English', 9833517, 331893745),
('Canada', 'Ottawa', 'English/French', 9984670, 38005238),
('Italy', 'Rome', 'Italian', 301340, 59554023),
('India', 'New Delhi', 'Hindi/English', 3287263, 1393409038),
('South Korea', 'Seoul', 'Korean', 100210, 51709098);

INSERT INTO city (name, population, area, postal_code, is_coastal, id_country) VALUES
('Buenos Aires', 3054300, 203, 'C1000', TRUE, 1),
('Córdoba', 1391000, 576, 'X5000', FALSE, 1),
('Rio de Janeiro', 6748000, 1200, '20000-000', TRUE, 2),
('São Paulo', 12330000, 1521, '01000-000', FALSE, 2),
('Tokyo', 13960000, 2190, '100-0001', TRUE, 3),
('Osaka', 2725000, 225, '530-0001', TRUE, 3),
('Paris', 2161000, 105, '75000', FALSE, 4),
('Marseille', 861635, 240, '13000', TRUE, 4),
('Berlin', 3769000, 891, '10115', FALSE, 5),
('Hamburg', 1841000, 755, '20095', TRUE, 5),
('New York', 8419600, 783, '10001', TRUE, 6),
('Los Angeles', 3980400, 1302, '90001', TRUE, 6),
('Toronto', 2950000, 630, 'M5H', TRUE, 7),
('Vancouver', 675218, 114, 'V5K', TRUE, 7),
('Rome', 2873000, 1285, '00100', FALSE, 8),
('Milan', 1378689, 181, '20100', FALSE, 8),
('Mumbai', 20411000, 603, '400001', TRUE, 9),
('Delhi', 19000000, 1484, '110001', FALSE, 9),
('Seoul', 9765000, 605, '04524', FALSE, 10),
('Busan', 3448737, 770, '60000', TRUE, 10);

--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Consultas equivalentes a procedimientos especiales
-- 1. Nombre del país con la ciudad más poblada
-- (equivalente a CALL country_most_populated_city();)
SELECT c.name AS country_name
FROM city ci
JOIN country c ON ci.id_country = c.id
ORDER BY ci.population DESC
LIMIT 1;

--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 2. Conjunto de países con ciudades costeras con más de 1 millón de habitantes
-- (equivalente a CALL country_coastal_cities_over_million();)
SELECT DISTINCT c.name AS country_name
FROM city ci
JOIN country c ON ci.id_country = c.id
WHERE ci.is_coastal = TRUE AND ci.population > 1000000;

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 3. País y ciudad con mayor densidad de población
-- (equivalente a CALL city_highest_density();)
SELECT ci.name AS city_name,
       c.name AS country_name,
       ROUND(ci.population / ci.area, 2) AS density
FROM city ci
JOIN country c ON ci.id_country = c.id
ORDER BY density DESC
LIMIT 1;