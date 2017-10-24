--Players that didnt make it in the league or are not in the Players table 
SELECT *
FROM Group1.Draft as D
LEFT JOIN Group1.Players as P
ON D.fullName = P.playerName
WHERE P.playerID IS NULL

--Players that did make it in the league or are in the players table Draft and Player
SELECT *
FROM Group1.Draft as D
INNER JOIN Group1.Players as P
ON D.fullName = P.playerName

SELECT *
FROM Group1.Draft

--insert into draft so that we can get playerid from group1.players table (INCORRECT?)

INSERT INTO Group1.Draft (draftYear, draftRound, draftSelection, draftOverall
						  ,tmID, firstName, lastName, fullName, suffixName, playerID,
						  draftFrom, lgID, playedPro, notes, pickRoute)
SELECT draftYear, draftRound, draftSelection, draftOverall
		,D.tmID, firstName, lastName, fullName, suffixName, P.playerID,
		draftFrom, D.lgID, playedPro, notes, pickRoute
FROM Group1.Draft as D
INNER JOIN Group1.Players as P
ON D.fullName = P.playerName


--||||||||||||||||||||||||||||||||||||||||||||||||||||
--Draft and master aka players 636 rows/players
--MASTER DOES NOT CONTAIN PLAYERS THAT ARE IN THE DRAFT THAT DIDNT MAKE IT IN THE LEAGUE
SELECT *
FROM Group1.Master AS M
INNER JOIN
Group1.Draft as D
ON M.bioID = D.playerID
where bioID != ' ' OR playerID != ' ' 

SELECT distinct * FROM Group1.Draft --1575 rows in the draft(INCORRECT)

SELECT * FROM Group1.Master --893 rows in the master consists of players and coaches

SELECT * FROM Group1.Coaches --84 rows in the coach

SELECT * FROM Group1.Players --818 rows in the players (DOUBLE CHECKED)

-- 818 + 84 = 902 this doesnt add up because master only has 893 rows 
--assumtion is that there are some coaches who were players, 902 - 893 = 9 coaches who were players


-- players who were both coach and player 9 rows, so my assumption was proven correct
SELECT *
FROM Group1.Coaches as C
INNER JOIN 
Group1.Players as P
ON C.coachID = P.playerID







--Example of player who is in draft but not in master
SELECT *
FROM Group1.Master
WHERE nameGiven = 'Jesse Hicks'



--||||||||||||||||||||||||||||||||||||||||||||||||||||

--1575 rows players in draft
SELECT * 
FROM Group1.Draft

--636 rows players made it pro
SELECT distinct *
FROM Group1.Master AS M
INNER JOIN Group1.Draft AS D
ON M.bioID = D.playerID

--818 players in master

-- 1575 - 818 = 757
-- 757 players were busts
--OR
-- 1575 - 636 = 939
-- 939 players were busts



SELECT *
--INTO Group1.DraftBusts
FROM Group1.Draft as D
LEFT JOIN Group1.Players as P
ON D.fullName = P.playerName
WHERE P.playerID IS NULL 

SELECT  *
FROM Group1.Draft
WHERE playerid = ' '
