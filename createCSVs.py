import csv

gamesHeaderMap = {
    "id":0,
    "rated":1,
    "created_at":2,
    "last_move_at":3,
    "turns":4,
    "victory_status":5,
    "winner":6,
    "increment_code":7,
    "white_id":8,
    "white_rating":9,
    "black_id":10,
    "black_rating":11,
    "moves":12,
    "opening_eco":13,
    "opening_name":14,
    "opening_ply":15
}

with open('./chess/games.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    gameIDHashmap = {}
    header = ""
    for row in csv_reader:    
        id = row[gamesHeaderMap["id"]]
        if id in gameIDHashmap:
            rated = row[gamesHeaderMap["id"]]
            if rated.isupper():
                gameIDHashmap[id] = row
        else:
            gameIDHashmap[id] = row

    with open('./chess/gamesCleaned.csv', 'w', newline='') as csvfile:
        cleanCSV = csv.writer(csvfile, delimiter=',', quoting=csv.QUOTE_MINIMAL)
        cleanCSV.writerow(header)
        for value in gameIDHashmap.values():
            cleanCSV.writerow(value)


with open('./chess/gamesCleaned.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = -1
    openingMap = set()
    for row in csv_reader:
        line_count += 1
        if line_count == 0:            
            continue
        openingEco = row[gamesHeaderMap["opening_eco"]]
        openingName = row[gamesHeaderMap["opening_name"]]
        openingMap.add((openingEco,openingName))
    
    with open('./chess/opening.csv', 'w', newline='') as csvfile:
        openingCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
        header = ["opening_eco", "opening_name"]
        openingCSV.writerow(header)
        for value in openingMap:
            openingCSV.writerow(value)



with open('./chess/gamesCleaned.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = -1
    moveTable = set()
    for row in csv_reader:
        line_count += 1
        if line_count == 0:            
            continue
        movesList = row[gamesHeaderMap["moves"]].split()
        gameID = row[gamesHeaderMap["id"]]

        for i, move in enumerate(movesList):
            if (gameID, i, move) in moveTable:
                print((gameID, i, moveTable))
            moveTable.add((gameID,i,move))
    
    with open('./chess/move.csv', 'w', newline='') as csvfile:
        moveCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
        header = ["id","move_num","move"]
        moveCSV.writerow(header)
        for value in moveTable:
            moveCSV.writerow(value)

with open('./chess/gamesCleaned.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    games = []
    for row in csv_reader:
        if len(row) <=0:
            continue
        games.append([row[0],row[1],row[2],row[3],row[5],row[6],row[7],row[8],row[9],row[10],row[11],row[15]])
        print(games[-1])
    
    with open('./chess/gameMinimized.csv', 'w', newline='') as csvfile:
        gameCSV = csv.writer(csvfile, delimiter=',',  quoting=csv.QUOTE_MINIMAL)
        for value in games:
            gameCSV.writerow(value)