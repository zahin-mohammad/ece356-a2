## New Tables + Functional Dependencies

### Games 

**Games**| 
-----|-----
game_id|
rated|
created|
last_move_at|
victory_status|
winner|
increment_code|
white_id|
white_rating|
black_id|
black_rating|
opening_id|
opening_ply|

Functional Dependencies: 
- {id} -> {rated, created, last_move_at, turns, victory_status, winner, increment_code, white_id, white_rating, black_id, black_rating, opening_eco, opening_ply}
- {id, white_id} -> {white_rating}
- {id, black_id} -> {black_rating}

### Moves

**Moves**| 
-----|-----
game_id|
move_num|
move|

Functional Dependencies:
- {game_id, move_num} -> {move}

### Opening

**Opening**| 
-----|-----
opening_id|
opening_eco|
opening_name|

Functional Dependencies
- {opening_eco} -> {opening_name}

## Design Changes
Turns where removed from the database as this was redundant data. This information can be found by doing a `count` aggregate on the new  `Moves` table.