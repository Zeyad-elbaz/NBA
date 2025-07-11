-- Correcting a wrong value


UPDATE line_score
SET pts_qtr1_away = 20
WHERE game_id = 25400268


-- Removing All-Star Games to exclude them from the analysis


DELETE FROM game
WHERE season_type LIKE '%All%'


-- Removing duplicates in the tables


WITH Duplicates as
(SELECT*,
ROW_NUMBER () OVER ( PARTITION BY game_ID ORDER BY (SELECT NULL) ) AS RN
FROM game_info
)
DELETE FROM Duplicates 
WHERE RN > 1


WITH Duplicates as
(SELECT*
ROW_NUMBER () OVER ( PARTITION BY game_ID ORDER BY (SELECT NULL) ) AS RN
FROM game_summary
)
DELETE FROM Duplicates 
WHERE RN > 1


WITH Duplicates as
(SELECT*,
ROW_NUMBER () OVER ( PARTITION BY game_id ORDER BY (SELECT NULL) ) AS RN
FROM line_score
)
DELETE FROM Duplicates
WHERE RN > 1


WITH Duplicates as
(SELECT*,
ROW_NUMBER () OVER ( PARTITION BY game_id ORDER BY (SELECT NULL) ) AS RN
FROM other_stats
)
DELETE FROM Duplicates
WHERE RN > 1


-- Selecting game_id as the Primary Key


ALTER TABLE game
ADD CONSTRAINT pk_game PRIMARY KEY (game_id)


ALTER TABLE game_info
ADD CONSTRAINT pk_game_info PRIMARY KEY (game_id)


ALTER TABLE game_summary
ADD CONSTRAINT pk_game_summary PRIMARY KEY (game_id)


ALTER TABLE line_score
ADD CONSTRAINT pk_line_score PRIMARY KEY (game_id)


ALTER TABLE other_stats
ADD CONSTRAINT pk_other_stats PRIMARY KEY (game_id)
