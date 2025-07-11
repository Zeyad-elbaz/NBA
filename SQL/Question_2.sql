-- Question 2: Teams that won the game with lowest assist to field goals ratio:

-- Home Teams:


WITH ratio AS
(SELECT
game_id,
CAST (game_date AS DATE) AS game_date,
team_name_home,
team_name_away,
wl_home,
ast_home,
fgm_home,
(ast_home / fgm_home) AS home_ratio
FROM game)
SELECT*
FROM ratio
WHERE wl_home LIKE 'W' AND (home_ratio IS NOT NULL AND home_ratio <> 0)
ORDER BY home_ratio ASC


-- Away Teams:

WITH ratio AS
(SELECT
game_id,
CAST (game_date AS DATE) AS game_date,
team_name_home,
team_name_away,
wl_home,
ast_away,
fgm_away,
(ast_away / fgm_away) AS away_ratio
FROM game)
SELECT*
FROM ratio
WHERE wl_home LIKE 'L' AND (away_ratio IS NOT NULL AND away_ratio <> 0)
ORDER BY away_ratio ASC

