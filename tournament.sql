-- Table definitions for the tournament project.
-- Import this into the 'tournament' database in PostgreSQL
-- $ psql tournament
-- tournament = >\i tournament.sql

CREATE TABLE players (
	player_id		serial PRIMARY KEY,
	name			text NOT NULL
);

CREATE TABLE matches (
	match_id		serial PRIMARY KEY,
	winner_id		integer REFERENCES players(player_id),
	loser_id		integer REFERENCES players(player_id)
);


-- shows the number of losses for each player
-- Uses the matches table and counts every time a user shows up
-- in the loser_id column
CREATE VIEW losses_view AS
SELECT players.player_id, count(matches.loser_id) AS losses
FROM players
LEFT JOIN matches ON players.player_id=matches.loser_id
GROUP BY players.player_id;


-- shows the number of wins for each player
-- Uses the matches table and counts every time a user shows up
-- in the winner_id column
CREATE VIEW wins_view AS
SELECT players.player_id, count(matches.winner_id) AS wins
FROM players
LEFT JOIN matches ON players.player_id=matches.winner_id
GROUP BY players.player_id;


-- standings/rankings for all players
-- Combines players table with wins_view and losses_view
-- Shows each players id, name, number of wins, and total number of matches
-- Shows records for each player, sorted by number of wins
-- So player first in standings (most wins) shows first in this view
CREATE VIEW standings_view AS
SELECT players.player_id,
	   players.name,
       sum(wins_view.wins) AS wins,
       sum(wins_view.wins + losses_view.losses) AS matches
FROM players
LEFT JOIN losses_view ON players.player_id = losses_view.player_id
LEFT JOIN wins_view ON players.player_id = wins_view.player_id
GROUP BY players.player_id
ORDER BY wins DESC;


-- pairs players with closest win-rates together for matches
-- Uses the rankings view and selects 2 rows at a time
-- and pairs those players against each other
-- Uses 'WHERE' and row_number to filter results to
-- make sure each player appears only once in pairings
CREATE VIEW pairings AS
SELECT player_1_id , player_1_name, player_2_id, player_2_name
FROM ( SELECT player_id AS player_1_id, name as player_1_name,
              lead(player_id, 1) OVER (ORDER BY wins) AS player_2_id,
			  lead(name, 1) OVER (ORDER BY wins) AS player_2_name,
			  row_number() over (ORDER BY wins) AS row_num
	    FROM standings_view
	 ) standings
WHERE row_num % 2 = 1;
