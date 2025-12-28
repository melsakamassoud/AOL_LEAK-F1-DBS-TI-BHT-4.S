BEGIN;

--------------------------------------------------
-- 0. Narrow staging table (single scan of aol_leak)
--------------------------------------------------
DROP TABLE IF EXISTS aol_stage;
CREATE TABLE aol_stage AS
SELECT anon_id, query, querytime, clickurl
FROM aol_leak
WHERE clickurl IS NOT NULL
  AND clickurl <> '';

--------------------------------------------------
-- 1. user
--------------------------------------------------
DROP TABLE IF EXISTS "user" CASCADE;
CREATE TABLE "user" (
    anon_id BIGINT PRIMARY KEY
);

INSERT INTO "user"(anon_id)
SELECT anon_id FROM aol_stage
ON CONFLICT DO NOTHING;

--------------------------------------------------
-- 2. website
--------------------------------------------------
DROP TABLE IF EXISTS website CASCADE;
CREATE TABLE website (
    website_id BIGSERIAL PRIMARY KEY,
    url TEXT UNIQUE
);

INSERT INTO website(url)
SELECT clickurl FROM aol_stage
ON CONFLICT DO NOTHING;

--------------------------------------------------
-- 3. query
--------------------------------------------------
DROP TABLE IF EXISTS query CASCADE;
CREATE TABLE query (
    query_id BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMP,
    query_text TEXT,
    anon_id BIGINT
);

INSERT INTO query(timestamp, query_text, anon_id)
SELECT querytime, query, anon_id
FROM aol_stage;

--------------------------------------------------
-- 4–7. Static F1 tables
--------------------------------------------------
DROP TABLE IF EXISTS team CASCADE;
CREATE TABLE team (
    team_id BIGSERIAL PRIMARY KEY,
    name TEXT UNIQUE
);

INSERT INTO team(name) VALUES
('Mild Seven Renault F1 Team'),
('Team McLaren Mercedes'),
('Scuderia Ferrari Marlboro'),
('Panasonic Toyota Racing'),
('Williams F1 Team'),
('Lucky Strike Honda Racing F1 Team'),
('Red Bull Racing'),
('BMW Sauber F1 Team'),
('Midland F1 Racing'),
('Spyker MF1 Team'),
('Scuderia Toro Rosso'),
('Super Aguri Formula 1');

DROP TABLE IF EXISTS fahrer CASCADE;
CREATE TABLE fahrer (
    fahrer_id BIGSERIAL PRIMARY KEY,
    name TEXT,
    team_id BIGINT REFERENCES team(team_id)
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

DROP TABLE IF EXISTS strecke CASCADE;
CREATE TABLE strecke (
    streckenname TEXT PRIMARY KEY,
    ort TEXT
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
-- (strecke INSERT unchanged)

DROP TABLE IF EXISTS f1_rennen CASCADE;
CREATE TABLE f1_rennen (
    rennen_id BIGSERIAL PRIMARY KEY,
    datum DATE,
    ort TEXT,
    streckenname TEXT REFERENCES strecke(streckenname)
);

-- (f1_rennen INSERT unchanged)
DROP TABLE IF EXISTS F1_Rennen CASCADE;
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


--------------------------------------------------
-- 8. liefert (SAFE 2-PHASE BUILD)
--------------------------------------------------
-- DROP TABLE IF EXISTS liefert CASCADE;
-- CREATE TABLE liefert (
--     query_id INTEGER,
--     website_id INTEGER,
--     PRIMARY KEY (query_id, website_id)
-- );
-- 
-- DROP TABLE IF EXISTS query_map;
-- CREATE TABLE query_map AS
-- SELECT q.query_id, a.clickurl
-- FROM query q
-- JOIN aol_stage a
--   ON q.anon_id = a.anon_id
--  AND q.query_text = a.query
--  AND abs(extract(epoch from q.timestamp)
--        - extract(epoch from a.querytime)) < 3600;
-- 
-- INSERT INTO liefert(query_id, website_id)
-- SELECT qm.query_id, w.website_id
-- FROM query_map qm
-- JOIN website w ON w.url = qm.clickurl
-- ON CONFLICT DO NOTHING;
-- 
-- DROP TABLE query_map;

--------------------------------------------------
-- 9. stellt
--------------------------------------------------
DROP TABLE IF EXISTS stellt CASCADE;
CREATE TABLE stellt (
    anon_id BIGINT,
    query_id BIGINT,
    PRIMARY KEY (anon_id, query_id)
);

INSERT INTO stellt
SELECT anon_id, query_id FROM query
ON CONFLICT DO NOTHING;

--------------------------------------------------
-- 10–11. f1 filtering (2-PHASE)
--------------------------------------------------
DROP TABLE IF EXISTS f1_prefilter;
CREATE TABLE f1_prefilter AS
SELECT *
FROM aol_stage
WHERE query ILIKE '%f1%'
   OR query ILIKE '%formula%'
   OR query ILIKE '%grand prix%'
   OR clickurl LIKE 'http://www.formula1.com%';

DROP TABLE IF EXISTS f1_filtered;
CREATE TABLE f1_filtered AS
SELECT * FROM f1_prefilter;

DROP TABLE f1_prefilter;

--------------------------------------------------
-- 12. f1_query
--------------------------------------------------
DROP TABLE IF EXISTS f1_query CASCADE;
CREATE TABLE f1_query AS
SELECT q.*
FROM query q
WHERE EXISTS (
    SELECT 1 FROM f1_filtered f
    WHERE f.anon_id = q.anon_id
      AND f.querytime = q.timestamp
      AND f.query = q.query_text
);

ALTER TABLE f1_query ADD PRIMARY KEY (query_id);

--------------------------------------------------
-- 13. f1_user
--------------------------------------------------
DROP TABLE IF EXISTS f1_user CASCADE;
CREATE TABLE f1_user (
    anon_id BIGINT PRIMARY KEY
);

INSERT INTO f1_user
SELECT anon_id FROM f1_query
ON CONFLICT DO NOTHING;

--------------------------------------------------
-- 14. f1_website
--------------------------------------------------
DROP TABLE IF EXISTS f1_website CASCADE;
CREATE TABLE f1_website (
    website_id BIGINT PRIMARY KEY,
    url TEXT
);

INSERT INTO f1_website
SELECT DISTINCT w.website_id, w.url
FROM f1_query q
JOIN liefert l ON q.query_id = l.query_id
JOIN website w ON w.website_id = l.website_id;

--------------------------------------------------
-- 15–17. mention tables
--------------------------------------------------
DROP TABLE IF EXISTS fahrer_wird_erwaehnt CASCADE;
CREATE TABLE fahrer_wird_erwaehnt (
    query_id INTEGER,
    fahrer_id INTEGER,
    PRIMARY KEY (query_id, fahrer_id)
);

DROP TABLE IF EXISTS team_wird_erwaehnt CASCADE;
CREATE TABLE team_wird_erwaehnt (
    query_id INTEGER,
    team_id INTEGER,
    PRIMARY KEY (query_id, team_id)
);

DROP TABLE IF EXISTS strecke_wird_erwaehnt CASCADE;
CREATE TABLE strecke_wird_erwaehnt (
    query_id INTEGER,
    streckenname TEXT,
    PRIMARY KEY (query_id, streckenname)
);

--------------------------------------------------
-- 18–20. relationship tables
--------------------------------------------------
DROP TABLE IF EXISTS faehrt_fuer CASCADE;
CREATE TABLE faehrt_fuer (
    fahrer_id BIGINT,
    team_id BIGINT,
    PRIMARY KEY (fahrer_id, team_id)
);

INSERT INTO faehrt_fuer SELECT fahrer_id, team_id FROM fahrer;

DROP TABLE IF EXISTS faehrt_in CASCADE;
CREATE TABLE faehrt_in (
    team_id BIGINT,
    rennen_id BIGINT,
    PRIMARY KEY (team_id, rennen_id)
);

INSERT INTO faehrt_in
SELECT team_id, rennen_id FROM team CROSS JOIN f1_rennen;

DROP TABLE IF EXISTS findet_statt_auf CASCADE;
CREATE TABLE findet_statt_auf (
    rennen_id BIGINT,
    streckenname TEXT,
    PRIMARY KEY (rennen_id, streckenname)
);

INSERT INTO findet_statt_auf
SELECT rennen_id, streckenname FROM f1_rennen;

--------------------------------------------------
-- 21. f1_stellt
--------------------------------------------------
DROP TABLE IF EXISTS f1_stellt CASCADE;
CREATE TABLE f1_stellt AS
SELECT anon_id, query_id FROM f1_query;

ALTER TABLE f1_stellt
ADD PRIMARY KEY (anon_id, query_id);

--------------------------------------------------
-- 22. f1_liefert
--------------------------------------------------
DROP TABLE IF EXISTS f1_liefert;
CREATE TABLE f1_liefert (
    query_id INTEGER,
    website_id INTEGER
);

INSERT INTO f1_liefert
SELECT l.query_id, l.website_id
FROM liefert l
JOIN f1_query q ON q.query_id = l.query_id
JOIN f1_website w ON w.website_id = l.website_id;

--------------------------------------------------
-- 23. enthaelt_f1_begriff + Reiseanfrage
--------------------------------------------------
DROP TABLE IF EXISTS enthaelt_f1_begriff CASCADE;
CREATE TABLE enthaelt_f1_begriff (
    query_id BIGINT PRIMARY KEY
);

INSERT INTO enthaelt_f1_begriff
SELECT query_id FROM f1_query;

DROP TABLE IF EXISTS reiseanfrage CASCADE;
CREATE TABLE reiseanfrage (
    reiseanfragenid BIGSERIAL PRIMARY KEY,
    timestamp TIMESTAMP,
    reise_ziel TEXT,
    ankunftsdatum DATE,
    anon_id BIGINT REFERENCES "user"(anon_id),
    query_id BIGINT REFERENCES query(query_id)
);

COMMIT;
