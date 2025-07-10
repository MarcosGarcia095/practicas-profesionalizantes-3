-- Crear base de datos
CREATE DATABASE IF NOT EXISTS countries_db
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_bin;

USE countries_db;
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Crear tabla
CREATE TABLE country (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  capital VARCHAR(100) NOT NULL,
  language VARCHAR(100) NOT NULL,
  area FLOAT NOT NULL,
  population BIGINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Datos pre-cargados
INSERT INTO country (name, capital, language, area, population) VALUES
('Argentina', 'Buenos Aires', 'Spanish', 2780400, 45376763),
('Brazil', 'Brasília', 'Portuguese', 8515767, 213993437),
('Canada', 'Ottawa', 'English/French', 9984670, 38005238),
('Germany', 'Berlin', 'German', 357022, 83240525),
('France', 'Paris', 'French', 551695, 67848156),
('Italy', 'Rome', 'Italian', 301340, 59554023),
('Spain', 'Madrid', 'Spanish', 505990, 47450795),
('Mexico', 'Mexico City', 'Spanish', 1964375, 126014024),
('United States', 'Washington, D.C.', 'English', 9833517, 331893745),
('United Kingdom', 'London', 'English', 243610, 68207116),
('Australia', 'Canberra', 'English', 7692024, 25788217),
('Japan', 'Tokyo', 'Japanese', 377975, 125681593),
('China', 'Beijing', 'Chinese', 9596961, 1411750000),
('India', 'New Delhi', 'Hindi/English', 3287263, 1393409038),
('Russia', 'Moscow', 'Russian', 17098242, 146171015),
('South Africa', 'Pretoria', 'Zulu/English', 1219090, 60041996),
('Egypt', 'Cairo', 'Arabic', 1002450, 104123456),
('Turkey', 'Ankara', 'Turkish', 783562, 85152838),
('South Korea', 'Seoul', 'Korean', 100210, 51709098),
('Saudi Arabia', 'Riyadh', 'Arabic', 2149690, 35604648);

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- Procedimientos almacenados
DELIMITER //

CREATE PROCEDURE country_create (
  IN p_name VARCHAR(100),
  IN p_capital VARCHAR(100),
  IN p_language VARCHAR(100),
  IN p_area FLOAT,
  IN p_population BIGINT
)
BEGIN
  INSERT INTO country (name, capital, language, area, population)
  VALUES (p_name, p_capital, p_language, p_area, p_population);
END //

CREATE PROCEDURE country_get (
  IN p_id INT
)
BEGIN
  SELECT * FROM country WHERE id = p_id;
END //

CREATE PROCEDURE country_update (
  IN p_id INT,
  IN p_name VARCHAR(100),
  IN p_capital VARCHAR(100),
  IN p_language VARCHAR(100),
  IN p_area FLOAT,
  IN p_population BIGINT
)
BEGIN
  UPDATE country
  SET name = p_name,
      capital = p_capital,
      language = p_language,
      area = p_area,
      population = p_population
  WHERE id = p_id;
END //

CREATE PROCEDURE country_delete (
  IN p_id INT
)
BEGIN
  DELETE FROM country WHERE id = p_id;
END //

DELIMITER ;