# Crazy NBA stats using SQL Analysis

## Objective:

This project aims at generating some uncommon stats that is not commonly referred to while exploring NBA historical data

------------------------------------------------------------------------

## Data used:

**Source**: <https://www.kaggle.com/datasets/wyattowalsh/basketball>\
**License:** CC BY-SA 4.0\
**Files used:**\
- game.csv\
- line_score.csv

> **Note:** Data was clean and transformed during the analysis with regard to every question. See the `/sql/` folder for the full transformation steps.

[Script for data manipulation done](SQL/Data_cleaning.sql)

------------------------------------------------------------------------

## Questions:

Here is a list of the questions answered

### Question 1: Teams that won the game while losing 3 of the 4 quarters

#### Goal:

While it is not very uncommon to win a game while losing 3 of the 4 quarters, the highest winning margins were explored in this question.

#### Approach:

-   Used *CTE* and *CASE* statements to compare scores and filter teams that won the game while losing 3 quarters.
-   Used *LEFT JOIN* to join the two tables in question.
-   Calculated the point differential at the end of the game and sorting by the highest win margin.
-   Analyzed for both teams that did it at home, and teams that did it on road, as home court advantage is known to make a big difference in NBA.

#### SQL Script:

[SQL script for question 1](SQL/Question_1.sql)

#### Results:

As mentioned above, there were massive number of incidents where a team has won the game although losing 3 of the 4 quarters. However, after sorting it by the largest score margin, the following was found:\
**Top 3 (Home teams):**\
- New York Knicks VS St. Louis Hawks (1965), Won by **19**\
- Ft. Wayne Zollner Pistons VS Boston Celtics (1954), Won by **17**\
- Detriot Pistons VS Chicago Bulls (1985), Won by **17**

**Top 3 (Away teams):**\
- Detroit Pistons \@ Portland Trail Blazers (2015), Won by **17**\
- Boston Celtics \@ Cleveland Cavaliers (2000), Won by **15**\
- Toronto Raptors \@ Los Angeles Lakers (2018), Won by **14**

------------------------------------------------------------------------

### Question 2: Teams that won the games with the lowest Assist to Field Goal Made ratio

#### Goal:

Good ball movement is crucial for winning, but that was an attempt to explore what teams relied on isolation play, and still won the game.

#### Approach:

-   Used *CTE* to calculate the ratio of the assist to FGM for both home and away teams.\
-   Sorted based on the lowest ratio while filtering teams that won the game, for both home and away teams.

#### SQL Script:

[SQL script for question 2](SQL/Question_2.sql)

#### Results:

The results were somehow interesting, especially for away teams, with\
**Lowest 3 (Home teams):** \
- Indiana Pacers VS Cleveland Cavaliers (1982), Ratio = **0.146**\
- Philadelphia Warriors VS Providence Steamrollers (1947), Ratio = **0.185**\
- New Jersey Nets VS Miami Heat (1989), Ratio = **0.219**

**Lowest 3 (Away teams):**\
- New York Knicks \@ Philadelphia Warriors (1947), Ratio = **0.094**\
- St. Louis Bombers \@ Philadelphia Warriors (1947), Ratio = **0.154**\
- New York Knicks \@ Philadelphia Warriors (1947), Ratio = **0.17**

It seems Philadelphia Warriors were vulnerable against isolation plays in 1947, with New York Knicks beating them twice in 1 month span, using the same approach.

------------------------------------------------------------------------

### Question 3: Teams with most difference between their highest scoring quarter and lowest scoring quarter

#### Goal:

Sometimes a team have an outlier quarter performance, either in a good or disappointing away. But what about both of them in the same game?

#### Approach:

-   Used *CTE* statements and *Subquery* to determine the highest and the lowest scoring quarter for each team in each game.

#### SQL Script:

[SQL script for question 3](SQL/Question_3.sql)

#### Results:

The results brought me to an interesting fact that there is a mistake in the score of a quarter on the official website of NBA, which I added a code to modify at the SQL script for cleaning. The original mistake was that the game score for a team was added as the score of the 1st quarter.\
**Top 3 (Home teams):**\
- New York Knicks VS Botson Celtics (1950), Difference = **42**\
- Phoenix Suns VS Los Angeles Clippers (2022), Difference = **39**\
- Los Angeles Lakers VS New York Knicks (2014), Difference = **37**

**Top 3 (Away teams):**\
- Boston Celtics \@ New York Knicks (1950), Difference = **46**\
- Buffalo Braves \@ Boston Celtics (1972), Difference = **44**\
- Tri-Cities Blackhawks \@ Anderson Packers (1949), Difference = **37**

------------------------------------------------------------------------

## Folder Structure

-   `/sql/`: SQL scripts used for data cleaning and answering each question
-   `/data/`: Raw data files used in the analysis
-   `/README.md`: Project overview, questions, and results
