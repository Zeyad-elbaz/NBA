-- Question 1: List of teams that won the game while losing 3 of the 4 quarters (Including OT wins) (TOP 5 in score margin)

-- Home Wins


With score_1 AS
(SELECT
game.game_id,
CAST(game.game_date AS DATE) AS game_date,
game.team_name_home,
game.team_name_away,
game.wl_home,
line.pts_qtr1_home,
line.pts_qtr2_home,
line.pts_qtr3_home,
line.pts_qtr4_home,
line.pts_qtr1_away,
line.pts_qtr2_away,
line.pts_qtr3_away,
line.pts_qtr4_away
FROM game
LEFT JOIN line_score AS line
ON game.game_id = line.game_id),
score_2 AS(
SELECT
game_id,
game_date,
wl_home,
team_name_home,
team_name_away,
(pts_qtr1_home-pts_qtr1_away) AS home_minus_away_Q1,
(pts_qtr2_home-pts_qtr2_away) AS home_minus_away_Q2,
(pts_qtr3_home-pts_qtr3_away) AS home_minus_away_Q3,
(pts_qtr4_home-pts_qtr4_away) AS home_minus_away_Q4
FROM score_1),
score_3 AS
(SELECT*,
(
 CASE WHEN home_minus_away_Q1 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q2 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q3 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q4 < 0 THEN 1 ELSE 0 END
 ) AS home_quarters_loss,
 (
 CASE WHEN home_minus_away_Q1 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q2 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q3 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q4 > 0 THEN 1 ELSE 0 END
 ) AS away_quarters_loss,
 (home_minus_away_Q1 + home_minus_away_Q2 + home_minus_away_Q3 + home_minus_away_Q4) AS home_score_margin
 FROM score_2)
SELECT*
FROM score_3
WHERE (wl_home LIKE 'W' AND home_quarters_loss = 3)
ORDER BY home_score_margin DESC


-- AWAY Wins


With score_1 AS
(SELECT
game.game_id,
CAST(game.game_date AS DATE) AS game_date,
game.team_name_home,
game.team_name_away,
game.wl_home,
line.pts_qtr1_home,
line.pts_qtr2_home,
line.pts_qtr3_home,
line.pts_qtr4_home,
line.pts_qtr1_away,
line.pts_qtr2_away,
line.pts_qtr3_away,
line.pts_qtr4_away
FROM game
LEFT JOIN line_score AS line
ON game.game_id = line.game_id),
score_2 AS(
SELECT
game_id,
game_date,
wl_home,
team_name_home,
team_name_away,
(pts_qtr1_home - pts_qtr1_away) AS home_minus_away_Q1,
(pts_qtr2_home - pts_qtr2_away) AS home_minus_away_Q2,
(pts_qtr3_home - pts_qtr3_away) AS home_minus_away_Q3,
(pts_qtr4_home - pts_qtr4_away) AS home_minus_away_Q4
FROM score_1),
score_3 AS
(SELECT*,
(
 CASE WHEN home_minus_away_Q1 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q2 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q3 < 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q4 < 0 THEN 1 ELSE 0 END
 ) AS home_quarters_loss,
 (
 CASE WHEN home_minus_away_Q1 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q2 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q3 > 0 THEN 1 ELSE 0 END +
 CASE WHEN home_minus_away_Q4 > 0 THEN 1 ELSE 0 END
 ) AS away_quarters_loss,
 (home_minus_away_Q1 + home_minus_away_Q2 + home_minus_away_Q3 + home_minus_away_Q4) AS home_score_margin
 FROM score_2)
SELECT*
FROM score_3
WHERE (wl_home LIKE 'L' AND away_quarters_loss = 3)
ORDER BY home_score_margin ASC