DROP DATABASE IF EXISTS Chess;
CREATE DATABASE IF NOT EXISTS Chess;
USE Chess;

CREATE TABLE GamesCSV(
    id VARCHAR (255),
    rated VARCHAR(255),
    created_at VARCHAR(255),
    last_move_at VARCHAR(255),
    turns VARCHAR(255),
    victory_status VARCHAR(255),
    winner VARCHAR(255),
    increment_code VARCHAR(255),
    white_id VARCHAR(255),
    white_rating VARCHAR(255),
    black_id VARCHAR(255),
    black_rating VARCHAR(255),
    moves TEXT(255),
    opening_eco VARCHAR(255),
    opening_name VARCHAR(255),
    opening_ply VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/games.csv' 
INTO TABLE GamesCSV 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- id,rated,created_at,last_move_at,victory_status,winner,increment_code,white_id,white_rating,black_id,black_rating,opening_ply

CREATE TABLE Games(
    id VARCHAR (255),
    rated VARCHAR(255),
    created_at VARCHAR(255),
    last_move_at VARCHAR(255),
    victory_status VARCHAR(255),
    winner VARCHAR(255),
    increment_code VARCHAR(255),
    white_id VARCHAR(255),
    white_rating VARCHAR(255),
    black_id VARCHAR(255),
    black_rating VARCHAR(255),
    opening_ply VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/gameMinimized.csv' 
INTO TABLE Games 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- CREATE TABLE Opening(
--     opening_eco VARCHAR(255),
--     opening_name VARCHAR(255)
-- );

-- LOAD DATA INFILE '/var/lib/mysql-files/opening.csv' 
-- INTO TABLE Opening 
-- FIELDS TERMINATED BY ',' 
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- CREATE TABLE Moves(
--     id VARCHAR (255),
--     move_num VARCHAR(255),
--     move VARCHAR(255)
-- );

-- LOAD DATA INFILE '/var/lib/mysql-files/move.csv' 
-- INTO TABLE Moves 
-- FIELDS TERMINATED BY ',' 
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;