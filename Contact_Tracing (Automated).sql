-- CTE Tryouts

-- getting asymptomtic period for patient 0 (i.e. 14 days before 09/05/2020)
-- CREATE TABLE statement was added after CTEs were written and queried to be correct.
CREATE TABLE infected_suspects AS (
WITH asymp_period AS (
SELECT shelter_id, person_id, login_date, logout_date
FROM shelter_entry
WHERE login_date and logout_date BETWEEN '2020-04-25 00:00' AND '2020-05-09 23:59'
ORDER BY login_date ASC),

-- Show the patient 0 with login and logout datetime and shelter
patient_0 AS (
SELECT shelter_id, person_id, login_date, logout_date
FROM asymp_period
WHERE person_id= '1'),

-- People that got infected in shelter 1 by patient 0 and person 2 from 22/04/2020
infected_in_shelter_1 AS (
SELECT shelter_id, person_id, login_date, logout_date
FROM asymp_period
WHERE shelter_id = 1
	AND (login_date >= '2020-04-22 09:00'
    OR logout_date <= '2020-04-30 07:00')
ORDER BY login_date ASC),

-- People that got infected in shelter 1 by patient 0 from 09/05/2020
infected_in_shelter_3 AS (
SELECT shelter_id, person_id, login_date, logout_date
FROM asymp_period
WHERE shelter_id = 3
	AND (login_date >= '2020-05-09 13:00'
    OR logout_date >= '2020-05-09 13:00') 
ORDER BY login_date ASC),

-- People that got infected from shelter 4 by person 3 from 02/05/2020
infected_in_shelter_4 AS (
SELECT shelter_id, person_id, login_date, logout_date
FROM asymp_period
WHERE shelter_id = 4
	AND login_date >= '2020-05-02 20:00'
)

-- Results of query showing; 
-- 1. Suspected persons infected with covid-19 by patient 0
-- 2. Suspected persons infected by contact with other persons
-- 3. Shelters and time periods in which patient 0 and other suspects stayed

-- Assumptions during query
-- 1. Any person can only be infected while in contact with patient 0
-- 2. Further infection can only occur while contact inside shelter after initial contact with patient 0
-- 3. All infection started from patient 0

SELECT * FROM infected_in_shelter_1
UNION
SELECT * FROM infected_in_shelter_3
UNION
SELECT * FROM infected_in_shelter_4);

USE contact_tracing;
SELECT person_id AS 'Infected Person/Suspect',
	shelter_id AS 'Last Visited Shelter',
    logout_date AS 'Last Date Recorded'
FROM infected_suspects
WHERE person_id= 1
ORDER BY logout_date DESC
LIMIT 1;

-- Creating stored procedure to automate process.
-- input person ID will give if the person is infected.
DELIMITER //
CREATE PROCEDURE spInfectedPersons(IN person INT)
BEGIN
SELECT person_id AS 'Infected Person/Suspect',
	shelter_id AS 'Last Visited Shelter',
    logout_date AS 'Last Date Recorded'
FROM infected_suspects
WHERE person_id = person
ORDER BY logout_date DESC
LIMIT 1;
END //
DELIMITER ;

-- Creating Stored Procedure to show time or period of infected persons.
DELIMITER //
CREATE PROCEDURE spInfectionDates (IN logperiod DATE)
BEGIN
SELECT person_id AS 'Infected Person/Suspect',
	shelter_id AS 'Last Visited Shelter',
    logout_date AS 'Last Date Recorded'
FROM infected_suspects
WHERE logout_date >= logperiod
ORDER BY logout_date DESC;
END //
DELIMITER ;

-- Input person ID into this query to bring results that show if person is a suspect or not.
-- If result is null, person is not a suspect.
CALL contact_tracing.spInfectedPersons(10);
CALL contact_tracing.spInfectedPersons(13);

-- Input date into this query to print results showing dates last seen after infection
CALL contact_tracing.spInfectionDates('2020-05-02');