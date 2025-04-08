CREATE DATABASE crime_data_analysis;

USE crime_data_analysis;

CREATE TABLE Crimes (
  crime_id INT PRIMARY KEY,
  crime_type VARCHAR(50),
  crime_date DATE,
  crime_time TIME,
  location VARCHAR(100)
);
  SELECT * FROM Crimes
INSERT INTO Crimes (crime_id, crime_type, crime_date, crime_time, location)
VALUES
  (1, 'Theft', '2022-01-01', '12:00:00', '123 Main St'),
  (2, 'Assault', '2022-01-05', '15:00:00', '456 Elm St'),
  (3, 'Burglary', '2022-01-10', '02:00:00', '789 Oak St'),
  (4, 'Robbery', '2022-01-15', '10:00:00', '901 Maple St'),
  (5, 'Vandalism', '2022-01-20', '18:00:00', '234 Pine St');
 
  
  CREATE TABLE Victims (
  victim_id INT PRIMARY KEY,
  crime_id INT,
  victim_name VARCHAR(50),
  victim_age INT,
  victim_gender VARCHAR(10),
  FOREIGN KEY (crime_id) REFERENCES Crimes(crime_id)
);
INSERT INTO Victims (victim_id, crime_id, victim_name, victim_age, victim_gender)
VALUES
  (1, 1, 'John Doe', 30, 'Male'),
  (2, 1, 'Jane Smith', 25, 'Female'),
  (3, 2, 'Bob Johnson', 40, 'Male'),
  (4, 3, 'Sarah Lee', 28, 'Female'),
  (5, 4, 'Michael Brown', 35, 'Male'),
  (6, 5, 'Emily Davis', 22, 'Female');
SELECT * FROM Victims;

CREATE TABLE Suspects (
  suspect_id INT PRIMARY KEY,
  crime_id INT,
  suspect_name VARCHAR(50),
  suspect_age INT,
  suspect_gender VARCHAR(10),
  FOREIGN KEY (crime_id) REFERENCES Crimes(crime_id)
);
INSERT INTO Suspects (suspect_id, crime_id, suspect_name, suspect_age, suspect_gender)
VALUES
  (1, 1, 'David White', 32, 'Male'),
  (2, 1, 'Olivia Martin', 29, 'Female'),
  (3, 2, 'Kevin Thompson', 38, 'Male'),
  (4, 3, 'Ava Harris', 26, 'Female'),
  (5, 4, 'James Wilson', 42, 'Male'),
  (6, 5, 'Sophia Garcia', 24, 'Female'),
  (7, 1, 'Michael Davis', 35, 'Male'),
  (8, 2, 'Emily Chen', 30, 'Female');
  SELECT * FROM Suspects;
  
  CREATE TABLE Arrests (
  arrest_id INT PRIMARY KEY,
  crime_id INT,
  suspect_id INT,
  arrest_date DATE,
  arrest_time TIME,
  FOREIGN KEY (crime_id) REFERENCES Crimes(crime_id),
  FOREIGN KEY (suspect_id) REFERENCES Suspects(suspect_id)
);
SELECT * FROM Arrests
INSERT INTO Arrests (arrest_id, crime_id, suspect_id, arrest_date, arrest_time)
VALUES
  (1, 1, 1, '2022-01-05', '10:00:00'),
  (2, 1, 2, '2022-01-05', '11:00:00'),
  (3, 2, 3, '2022-01-10', '14:00:00'),
  (4, 3, 4, '2022-01-15', '12:00:00'),
  (5, 4, 5, '2022-01-20', '16:00:00'),
  (6, 5, 6, '2022-01-25', '18:00:00'),
  (7, 1, 7, '2022-01-30', '10:00:00'),
  (8, 2, 8, '2022-02-01', '12:00:00');
   
   
   CREATE TABLE Investigations (
  investigation_id INT PRIMARY KEY,
  crime_id INT,
  investigator_name VARCHAR(50),
  investigation_date DATE,
  investigation_notes TEXT,
  FOREIGN KEY (crime_id) REFERENCES Crimes(crime_id)
);
INSERT INTO Investigations (investigation_id, crime_id, investigator_name, investigation_date, investigation_notes)
VALUES
  (1, 1, 'Detective James', '2022-01-01', 'Initial investigation revealed suspicious activity'),
  (2, 1, 'Detective James', '2022-01-05', 'Arrest made and evidence collected'),
  (3, 2, 'Detective Rodriguez', '2022-01-10', 'Victim statement taken and witnesses interviewed'),
  (4, 3, 'Detective Lee', '2022-01-15', 'Forensic analysis revealed DNA evidence'),
  (5, 4, 'Detective Brown', '2022-01-20', 'Surveillance footage reviewed and suspect identified'),
  (6, 5, 'Detective Davis', '2022-01-25', 'Investigation ongoing, awaiting lab results'),
  (7, 1, 'Detective James', '2022-02-01', 'Case closed, suspect convicted'),
  (8, 2, 'Detective Rodriguez', '2022-02-05', 'Case closed, suspect acquitted');
   SELECT * FROM Investigations
   
CREATE VIEW crime_summary As
SELECT 
  c.crime_id,
  c.crime_type,
  c.crime_date,
  v.victim_name,
  s.suspect_name
FROM 
  crimes c
  JOIN victims v ON c.crime_id = v.crime_id
  JOIN suspects s ON c.crime_id = s.crime_id;
  
   SELECT * FROM Crime_summary

CREATE VIEW crime_trends AS
SELECT 
  c.crime_type,
  COUNT(c.crime_id) AS num_crimes,
  SUM(CASE WHEN c.crime_date BETWEEN '2022-01-01' AND '2022-01-31' THEN 1 ELSE 0 END) AS january_crimes,
  SUM(CASE WHEN c.crime_date BETWEEN '2022-02-01' AND '2022-02-28' THEN 1 ELSE 0 END) AS february_crimes
FROM 
  crimes c
GROUP BY 
  c.crime_type;
  SELECT * FROM Crime_trends
  
CREATE VIEW crime_hotspots AS
SELECT 
  c.location,
  COUNT(c.crime_id) AS num_crimes
FROM 
  crimes c
GROUP BY 
  c.location
ORDER BY 
  num_crimes DESC;
SELECT * FROM Crime_hotspots

CREATE VIEW victim_info AS
SELECT 
  v.victim_id,
  v.victim_name,
  v.victim_age,
  v.victim_gender,
  c.crime_type,
  c.crime_date
FROM 
  victims v
  JOIN crimes c ON v.crime_id = c.crime_id;
  SELECT * FROM victim_info
  
CREATE VIEW suspect_info AS
SELECT 
  s.suspect_id,
  s.suspect_name,
  s.suspect_age,
  s.suspect_gender,
  c.crime_type,
  c.crime_date
FROM 
  suspects s
  JOIN crimes c ON s.crime_id = c.crime_id;
  SELECT * FROM suspect_info
  
CREATE VIEW arrest_info AS
SELECT 
  a.arrest_id,
  a.arrest_date,
  a.arrest_time,
  s.suspect_name,
  c.crime_type,
  c.crime_date
FROM 
  arrests a
  JOIN suspects s ON a.suspect_id = s.suspect_id
  JOIN crimes c ON a.crime_id = c.crime_id;
  SELECT * FROM arrest_info
  
CREATE VIEW investigation_info AS
SELECT 
  i.investigation_id,
  i.investigator_name,
  i.investigation_date,
  c.crime_type,
  c.crime_date
FROM 
  investigations i
  JOIN crimes c ON i.crime_id = c.crime_id;
  SELECT * FROM investigation_info
  
  DELIMITER //

CREATE PROCEDURE sp_insert_crime_data(
  IN crime_id INT,
  IN crime_type VARCHAR(50),
  IN crime_date DATE,
  IN crime_time TIME,
  IN location VARCHAR(100)
)
BEGIN
  INSERT INTO crimes (crime_id, crime_type, crime_date, crime_time, location)
  VALUES (crime_id, crime_type, crime_date, crime_time, location);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_update_victim_info(
  IN victim_id INT,
  IN victim_name VARCHAR(50),
  IN victim_age INT,
  IN victim_gender VARCHAR(10)
)
BEGIN
  UPDATE victims
  SET victim_name = victim_name,
      victim_age = victim_age,
      victim_gender = victim_gender
  WHERE victim_id = victim_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_delete_suspect_info(
  IN suspect_id INT
)
BEGIN
  DELETE FROM suspects
  WHERE suspect_id = suspect_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_get_crime_trends()
BEGIN
  SELECT 
    c.crime_type,
    COUNT(c.crime_id) AS num_crimes,
    SUM(CASE WHEN c.crime_date BETWEEN '2022-01-01' AND '2022-01-31' THEN 1 ELSE 0 END) AS january_crimes,
    SUM(CASE WHEN c.crime_date BETWEEN '2022-02-01' AND '2022-02-28' THEN 1 ELSE 0 END) AS february_crimes
  FROM 
    crimes c
  GROUP BY 
    c.crime_type;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_get_crime_hotspots()
BEGIN
  SELECT 
    c.location,
    COUNT(c.crime_id) AS num_crimes
  FROM 
    crimes c
  GROUP BY 
    c.location
  ORDER BY 
    num_crimes DESC;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_get_victim_info(
  IN victim_id INT
)
BEGIN
  SELECT 
    v.victim_id,
    v.victim_name,
    v.victim_age,
    v.victim_gender,
    c.crime_type,
    c.crime_date
  FROM 
    victims v
    JOIN crimes c ON v.crime_id = c.crime_id
  WHERE 
    v.victim_id = victim_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_get_suspect_info(
  IN suspect_id INT
)
BEGIN
  SELECT 
    s.suspect_id,
    s.suspect_name,
    s.suspect_age,
    s.suspect_gender,
    c.crime_type,
    c.crime_date
  FROM 
    suspects s
    JOIN crimes c ON s.crime_id = c.crime_id
  WHERE 
    s.suspect_id = suspect_id;
END //

DELIMITER ;