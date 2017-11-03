-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
create table Players (
       id serial primary key,
       name varchar(50) not null
);

create table Matches (
       player1 integer references Players (id),
       player2 integer references Players (id),
       winningPlayer integer references Players (id)
);

create view player_standing_view as
       select players.id, players.name,

       (select count(winningplayer) as wins
       from matches
       where players.id = matches.winningplayer),
       
       (select count(*) as matches
       from matches
       where players.id in (matches.player1, matches.player2))

       from players
       left join matches
       on players.id = matches.player1 and players.id = matches.player2
       order by wins desc;
