/*1. What range of years for baseball games played does the provided database cover? 1871-2016.*/ 
/*SELECT *
FROM homegames;*/

/*2. Find the name and height of the shortest player in the database. Eddie Gaedel, aka Edward Carl, 43 inches.*/ 
/*SELECT playerid, namefirst, namelast, namegiven, height
FROM people
ORDER BY height;*/
/*How many games did he play in? 1 */
/*SELECT *
FROM appearances
WHERE playerid = 'gaedeed01';*/
/*What is the name of the team for which he played? SLA = St. Louis Browns */
/*SELECT teamid, name
FROM teams
WHERE teamid = 'SLA';/*

/*3. Find all players in the database who played at Vanderbilt University (schoolid = 'vandy').*/
/*SELECT *
FROM schools
WHERE schoolname LIKE 'Vanderbilt%';*/

/*Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors? David Taylor earned the most: $245,553,888. */
/*SELECT DISTINCT c.playerid, c.schoolid, p.namegiven, SUM(s.salary) AS total_salary
FROM collegeplaying AS c
JOIN people AS p
ON c.playerid = p.playerid
JOIN salaries AS s
ON c.playerid = s.playerid
WHERE c.schoolid = 'vandy'
GROUP BY c.playerid, c.schoolid, p.namegiven
ORDER BY total_salary DESC;*/

/*4. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.
Infield: 58,934
Battery: 41,424
Outfield: 29,560 */
/*SELECT SUM(po),
	CASE WHEN pos='OF' THEN 'Outfield'
        WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
		WHEN pos IN ('P', 'C') THEN 'Battery' END AS position
FROM fielding
WHERE yearid = 2016
GROUP BY position
ORDER BY SUM(po) DESC;*/ 

/*5. NEED TO USE TEAMS TABLE - REVISE THIS. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?*/
/*
SELECT ROUND(AVG(so), 2),
		ROUND(AVG(hr), 2),
CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
	WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
	WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
	WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
	WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
	WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
	WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
	WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
	WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
	WHEN yearid BETWEEN 2010 AND 2019 THEN '2010s'
	END AS decade
FROM batting
WHERE yearid >= 1920
GROUP BY decade
ORDER BY decade;
*/

/*6. Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases. ANSWER: Christ Owings */
/*
SELECT b.playerid, p.namefirst, p.namelast, (b.SB+b.CS) AS total_attempts, ROUND(SUM(b.SB)*100.0 / NULLIF(SUM(b.SB+b.CS), 0), 2) AS percent_success 
FROM batting AS b
JOIN people AS p
ON p.playerid = b.playerid
WHERE (SB+CS) >=20 AND yearid=2016
GROUP BY b.playerid, p.namefirst, p.namelast, total_attempts
ORDER BY percent_success DESC;
*/

/*7. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 114 wins */
/*SELECT teamid, yearid, wswin, SUM(w) AS total_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND wswin='Y'
GROUP BY teamid, yearid, wswin
ORDER BY total_wins DESC;*/
/*What is the smallest number of wins for a team that did win the world series? 63 wins */ 
/*SELECT teamid, yearid, wswin, SUM(w) AS total_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND wswin='Y'
GROUP BY teamid, yearid, wswin
ORDER BY total_wins;*/

/*Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?*/

SELECT teamid, yearid, wswin, SUM(w) AS total_wins
FROM teams
WHERE yearid BETWEEN 1970 AND 2016 AND wswin='Y'
GROUP BY teamid, yearid, wswin
ORDER BY total_wins DESC;

/*8. Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.

10. Find all players who hit their career highest number of home runs in 2016. Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016. Report the players' first and last names and the number of home runs they hit in 2016.*/