-- Ausfüllen Von Tables
-- https://de.wikipedia.org/wiki/Formel-1-Weltmeisterschaft_2006
-- https://en.wikipedia.org/wiki/2006_Formula_One_World_Championship
	-- Team

DROP TABLE Team CASCADE;
CREATE TABLE Team (
    Team_ID BIGSERIAL PRIMARY KEY,
    Name TEXT
);

INSERT INTO Team (Name) VALUES
('Mild Seven Renault F1 Team'),
('Team McLaren Mercedes'),
('Scuderia Ferrari Marlboro'),
('Panasonic Toyota Racing'),
('Williams F1 Team'),
('Lucky Strike Honda Racing F1 Team'),
('Red Bull Racing'),
('BMW Sauber F1 Team'),
('Midland F1 Racing'), 	-- Selbest team!
('Spyker MF1 Team'), -- wie
('Scuderia Toro Rosso'),
('Super Aguri Formula 1');

DROP TABLE Fahrer CASCADE;
	-- Fahrer
CREATE TABLE Fahrer (
    Fahrer_ID BIGSERIAL PRIMARY KEY,
    Name TEXT,
	--Team TEXT,
    Team_ID BIGINT,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID)
);


INSERT INTO Fahrer (Name, Team_ID)
SELECT f.Name, t.Team_ID
FROM (VALUES
  ('Fernando Alonso', 'Mild Seven Renault F1 Team'),
  ('Giancarlo Fisichella', 'Mild Seven Renault F1 Team'),
  ('Kimi Räikkönen', 'Team McLaren Mercedes'),
  ('Juan Pablo Montoya', 'Team McLaren Mercedes'),
  ('Pedro de la Rosa', 'Team McLaren Mercedes'),
  ('Michael Schumacher', 'Scuderia Ferrari Marlboro'),
  ('Felipe Massa', 'Scuderia Ferrari Marlboro'),
  ('Ralf Schumacher', 'Panasonic Toyota Racing'),
  ('Jarno Trulli', 'Panasonic Toyota Racing'),
  ('Mark Webber',            'Williams F1 Team'),
  ('Nico Rosberg',           'Williams F1 Team'),
  
  ('Rubens Barrichello',     'Lucky Strike Honda Racing F1 Team'),
  ('Jenson Button',          'Lucky Strike Honda Racing F1 Team'),
  
  ('David Coulthard',        'Red Bull Racing'),
  ('Christian Klien',        'Red Bull Racing'),         
  ('Robert Doornbos',        'Red Bull Racing'),         
  
  ('Nick Heidfeld',          'BMW Sauber F1 Team'),
  ('Jacques Villeneuve',     'BMW Sauber F1 Team'),      
  ('Robert Kubica',          'BMW Sauber F1 Team'),      
  
  ('Tiago Monteiro',         'Midland F1 Racing'),             -- das Team hieß bis Ungarn MF1 Racing, danach Spyker
  ('Christijan Albers',      'Midland F1 Racing'),             -- gleicher Team-Name wie oben gewünscht
  ('Tiago Monteiro',         'Spyker MF1 Team'),         -- ab Spa wieder unter neuem Namen
  ('Christijan Albers',      'Spyker MF1 Team'),
  
  ('Vitantonio Liuzzi',      'Scuderia Toro Rosso'),
  ('Scott Speed',            'Scuderia Toro Rosso'),
  
  ('Takuma Satō',            'Super Aguri Formula 1'),
  ('Yūji Ide',               'Super Aguri Formula 1'),   
  ('Franck Montagny',        'Super Aguri Formula 1'),   
  ('Sakon Yamamoto',         'Super Aguri Formula 1')
  -- etc. für alle Fahrer
) AS f(Name, TeamName)
JOIN Team t ON f.TeamName = t.Name;

--INSERT INTO Fahrer (Name, Team) VALUES
--('Fernando Alonso',        'Mild Seven Renault F1 Team'),
--('Giancarlo Fisichella',   'Mild Seven Renault F1 Team'),
--
--('Kimi Räikkönen',        'Team McLaren Mercedes'),
--('Juan Pablo Montoya',     'Team McLaren Mercedes'),   
--('Pedro de la Rosa',       'Team McLaren Mercedes'),   
--
--('Michael Schumacher',     'Scuderia Ferrari Marlboro'),
--('Felipe Massa',           'Scuderia Ferrari Marlboro'),
--
--('Ralf Schumacher',        'Panasonic Toyota Racing'),
--('Jarno Trulli',           'Panasonic Toyota Racing'),
--
--('Mark Webber',            'Williams F1 Team'),
--('Nico Rosberg',           'Williams F1 Team'),
--
--('Rubens Barrichello',     'Lucky Strike Honda Racing F1 Team'),
--('Jenson Button',          'Lucky Strike Honda Racing F1 Team'),
--
--('David Coulthard',        'Red Bull Racing'),
--('Christian Klien',        'Red Bull Racing'),         
--('Robert Doornbos',        'Red Bull Racing'),         
--
--('Nick Heidfeld',          'BMW Sauber F1 Team'),
--('Jacques Villeneuve',     'BMW Sauber F1 Team'),      
--('Robert Kubica',          'BMW Sauber F1 Team'),      
--
--('Tiago Monteiro',         'Midland F1 Racing'),             -- das Team hieß bis Ungarn MF1 Racing, danach Spyker
--('Christijan Albers',      'Midland F1 Racing'),             -- gleicher Team-Name wie oben gewünscht
--('Tiago Monteiro',         'Spyker MF1 Team'),         -- ab Spa wieder unter neuem Namen
--('Christijan Albers',      'Spyker MF1 Team'),
--
--('Vitantonio Liuzzi',      'Scuderia Toro Rosso'),
--('Scott Speed',            'Scuderia Toro Rosso'),
--
--('Takuma Satō',            'Super Aguri Formula 1'),
--('Yūji Ide',               'Super Aguri Formula 1'),   
--('Franck Montagny',        'Super Aguri Formula 1'),   
--('Sakon Yamamoto',         'Super Aguri Formula 1');  


DROP TABLE Strecke CASCADE;
CREATE TABLE Strecke (
    StreckenName TEXT PRIMARY KEY,
    Ort TEXT
);
INSERT INTO Strecke (StreckenName, Ort) VALUES
('Bahrain International Circuit', 'Sakhir'),
('Sepang International Circuit', 'Kuala Lumpur'),
('Albert Park Circuit', 'Melbourne'),
('Autodromo Enzo e Dino Ferrari', 'Imola'),
('Nürburgring', 'Nürburg'),
('Circuit de Catalunya', 'Montmeló'),
('Circuit de Monaco', 'Monte-Carlo'),
('Silverstone Circuit', 'Silverstone'),
('Circuit Gilles Villeneuve', 'Montreal'),
('Indianapolis Motor Speedway', 'Speedway'),
('Circuit de Nevers Magny-Cours', 'Magny-Cours'),
('Hockenheimring', 'Hockenheim'),
('Hungaroring', 'Mogyoród'),
('Istanbul Park', 'Istanbul'),
('Autodromo Nazionale di Monza', 'Monza'),
('Shanghai International Circuit', 'Shanghai'),
('Suzuka Circuit', 'Suzuka'),
('Autódromo José Carlos Pace', 'São Paulo');




DROP TABLE F1_Rennen CASCADE;
CREATE TABLE F1_Rennen (
    Rennen_ID BIGSERIAL PRIMARY KEY,
    Datum DATE,
    Ort TEXT,
    StreckenName TEXT,
    FOREIGN KEY (StreckenName) REFERENCES Strecke(StreckenName)
);
INSERT INTO F1_Rennen (Datum, Ort, StreckenName) VALUES
('2006-03-12', 'Sakhir',          'Bahrain International Circuit'),
('2006-03-19', 'Kuala Lumpur',    'Sepang International Circuit'),
('2006-04-02', 'Melbourne',       'Albert Park Circuit'),
('2006-04-23', 'Imola',           'Autodromo Enzo e Dino Ferrari'),  
('2006-05-07', 'Nürburg',         'Nürburgring'),
('2006-05-14', 'Montmeló',        'Circuit de Catalunya'),
('2006-05-28', 'Monte-Carlo',     'Circuit de Monaco'),
('2006-06-11', 'Silverstone',     'Silverstone Circuit'),
('2006-06-25', 'Montreal',        'Circuit Gilles Villeneuve'),
('2006-07-02', 'Speedway',        'Indianapolis Motor Speedway'),
('2006-07-16', 'Magny-Cours',     'Circuit de Nevers Magny-Cours'),
('2006-07-30', 'Hockenheim',      'Hockenheimring'),
('2006-08-06', 'Mogyoród',        'Hungaroring'),
('2006-08-27', 'Istanbul',        'Istanbul Park'),
('2006-09-10', 'Monza',           'Autodromo Nazionale di Monza'),
('2006-10-01', 'Shanghai',        'Shanghai International Circuit'),
('2006-10-08', 'Suzuka',          'Suzuka Circuit'),
('2006-10-22', 'São Paulo',       'Autódromo José Carlos Pace');







