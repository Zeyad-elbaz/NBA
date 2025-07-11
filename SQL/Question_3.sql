-- Question 3: Teams with most difference between their highest scoring quarter and lowest scoring quarter


-- Home teams


WITH difference_quarters AS
(SELECT
line_score.game_id,
CAST(game.game_date AS DATE) AS game_date,
CONCAT(line_score.team_city_name_home,' ', line_score.team_nickname_home) AS home_team,
CONCAT(line_score.team_city_name_away,' ', line_score.team_nickname_away) AS away_team,
(SELECT MAX (val)
 FROM (VALUES 
 (line_score.pts_qtr1_home), 
 (line_score.pts_qtr2_home), 
 (line_score.pts_qtr3_home), 
 (line_score.pts_qtr4_home)
 ) AS all_pts_max(val)
 ) AS max_quarter_score,
(SELECT MIN (val)
 FROM (VALUES 
 (line_score.pts_qtr1_home), 
 (line_score.pts_qtr2_home), 
 (line_score.pts_qtr3_home), 
 (line_score.pts_qtr4_home)
 ) AS all_pts_min(val)
 ) AS min_quarter_score,
 game.wl_home
FROM game
LEFT JOIN line_score
ON line_score.game_id = game.game_id)
SELECT*,
(max_quarter_score - min_quarter_score) AS difference_between_quarters
FROM difference_quarters
ORDER BY difference_between_quarters DESC


-- Away teams


WITH difference_quarters AS
(SELECT
line_score.game_id,
CAST(game.game_date AS DATE) AS game_date,
CONCAT(line_score.team_city_name_home,' ', line_score.team_nickname_home) AS home_team,
CONCAT(line_score.team_city_name_away,' ', line_score.team_nickname_away) AS away_team,
(SELECT MAX (val)
 FROM (VALUES 
 (line_score.pts_qtr1_away), 
 (line_score.pts_qtr2_away), 
 (line_score.pts_qtr3_away), 
 (line_score.pts_qtr4_away)
 ) AS all_pts_max(val)
 ) AS max_quarter_score,
(SELECT MIN (val)
 FROM (VALUES 
 (line_score.pts_qtr1_away), 
 (line_score.pts_qtr2_away), 
 (line_score.pts_qtr3_away), 
 (line_score.pts_qtr4_away)
 ) AS all_pts_min(val)
 ) AS min_quarter_score,
 game.wl_away
FROM game
LEFT JOIN line_score
ON line_score.game_id = game.game_id)
SELECT*,
(max_quarter_score - min_quarter_score) AS difference_between_quarters
FROM difference_quarters
ORDER BY difference_between_quarters DESC