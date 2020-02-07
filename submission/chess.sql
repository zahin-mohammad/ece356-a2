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

CREATE TABLE Games(
    game_id VARCHAR (255),
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
    opening_id VARCHAR(255),
    opening_ply VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/gameMinimized.csv' 
INTO TABLE Games 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Opening(
    opening_id VARCHAR(255),
    opening_eco VARCHAR(255),
    opening_name VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/opening.csv' 
INTO TABLE Opening 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Moves(
    game_id VARCHAR (255),
    move_num VARCHAR(255),
    move VARCHAR(255)
);

LOAD DATA INFILE '/var/lib/mysql-files/move.csv' 
INTO TABLE Moves 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Moves ADD PRIMARY KEY(game_id,move_num);
ALTER TABLE Opening ADD PRIMARY KEY(opening_id);
ALTER TABLE Games ADD PRIMARY KEY(game_id);

select game_id from Moves where game_id not in (select game_id from Games);

ALTER TABLE Moves
ADD FOREIGN KEY (game_id) REFERENCES Games(game_id);

ALTER TABLE Games
ADD FOREIGN KEY (opening_id) REFERENCES Opening(opening_id);


-- PYTHON CODE TO GENERATE THE CSV's
-- import csv

-- gamesHeaderMap = {
--     "id":0,
--     "rated":1,
--     "created_at":2,
--     "last_move_at":3,
--     "turns":4,
--     "victory_status":5,
--     "winner":6,
--     "increment_code":7,
--     "white_id":8,
--     "white_rating":9,
--     "black_id":10,
--     "black_rating":11,
--     "moves":12,
--     "opening_eco":13,
--     "opening_name":14,
--     "opening_ply":15
-- }

-- with open('./chess/games.csv') as csv_file:
--     csv_reader = csv.reader(csv_file, delimiter=',')
--     gameIDHashmap = {}
--     header = ""
--     for row in csv_reader:    
--         id = row[gamesHeaderMap["id"]]
--         if id in gameIDHashmap:
--             rated = row[gamesHeaderMap["id"]]
--             if rated.isupper():
--                 gameIDHashmap[id] = row
--         else:
--             gameIDHashmap[id] = row

--     with open('./chess/gamesCleaned.csv', 'w', newline='') as csvfile:
--         cleanCSV = csv.writer(csvfile, delimiter=',', quoting=csv.QUOTE_MINIMAL)
--         cleanCSV.writerow(header)
--         for value in gameIDHashmap.values():
--             cleanCSV.writerow(value)

-- openingMap = {}
-- with open('./chess/gamesCleaned.csv') as csv_file:
--     csv_reader = csv.reader(csv_file, delimiter=',')
--     line_count = -1
--     for row in csv_reader:
--         line_count += 1
--         if line_count == 0:            
--             continue
--         openingEco = row[gamesHeaderMap["opening_eco"]]
--         openingName = row[gamesHeaderMap["opening_name"]]
--         if (openingEco,openingName) not in openingMap:
--             openingMap[(openingEco,openingName)] = line_count

--     with open('./chess/opening.csv', 'w', newline='') as csvfile:
--         openingCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
--         header = ["opening_id","opening_eco","opening_name"]
--         openingCSV.writerow(header)
--         for row, id in openingMap.items():
--             openingCSV.writerow([id]+list(row))



-- with open('./chess/gamesCleaned.csv') as csv_file:
--     csv_reader = csv.reader(csv_file, delimiter=',')
--     moveTable = set()
--     for row in csv_reader:
--         if len(row)<=0 or row[0] == "id":
--             continue
--         movesList = row[gamesHeaderMap["moves"]].split()
--         gameID = row[gamesHeaderMap["id"]]

--         for i, move in enumerate(movesList):
--             if (gameID, i, move) in moveTable:
--                 print((gameID, i, moveTable))
--             moveTable.add((gameID,i,move))
    
--     with open('./chess/move.csv', 'w', newline='') as csvfile:
--         moveCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
--         header = ["id","move_num","move"]
--         moveCSV.writerow(header)
--         for value in moveTable:
--             moveCSV.writerow(value)

-- with open('./chess/gamesCleaned.csv') as csv_file:
--     csv_reader = csv.reader(csv_file, delimiter=',')
--     games = []
--     line_count = -1
--     for row in csv_reader:
--         if len(row) <=0:
--             continue

--         line_count +=1
--         if line_count == 0:
--             games.append([row[0],row[1],row[2],row[3],row[5],row[6],row[7],row[8],row[9],row[10],row[11],"opening_id",row[15]])
--             print(games[-1])
--         else:
--             openingEco = row[gamesHeaderMap["opening_eco"]]
--             openingName = row[gamesHeaderMap["opening_name"]]
--             opening_id = openingMap[(openingEco,openingName)]
--             games.append([row[0],row[1],row[2],row[3],row[5],row[6],row[7],row[8],row[9],row[10],row[11],opening_id,row[15]])
    
--     with open('./chess/gameMinimized.csv', 'w', newline='') as csvfile:
--         gameCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
--         for value in games:
--             gameCSV.writerow(value)
