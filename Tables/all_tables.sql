DROP TABLE IF EXISTS "user" CASCADE;
CREATE TABLE "user" (
Anon_ID BIGINT PRIMARY KEY
);

INSERT INTO "user" (Anon_ID)
SELECT anon_id as Anon_ID
FROM aol_leak
group by anon_id;

DROP TABLE IF EXISTS website CASCADE;
CREATE TABLE Website (
    Website_ID BIGSERIAL PRIMARY KEY,
    URL TEXT
);

INSERT INTO website (URL)
SELECT clickurl as URL
FROM aol_leak
group by clickurl;

DROP TABLE IF EXISTS query CASCADE;
CREATE TABLE Query (
    Query_ID BIGSERIAL PRIMARY KEY,
    TimeStamp TIMESTAMP,
    Query_Text TEXT,
	  Anon_ID BIGINT
);

INSERT INTO Query (TimeStamp, Query_Text, Anon_ID)
SELECT
    querytime,
    query,
    anon_id
FROM aol_leak;



-- Ausfüllen Von Tables
-- https://de.wikipedia.org/wiki/Formel-1-Weltmeisterschaft_2006
-- https://en.wikipedia.org/wiki/2006_Formula_One_World_Championship
	-- Team

DROP TABLE IF EXISTS Team CASCADE;
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

DROP TABLE IF EXISTS Fahrer CASCADE;
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

DROP TABLE IF EXISTS Strecke CASCADE;
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

DROP TABLE IF EXISTS liefert CASCADE;
CREATE TABLE liefert (
    query_id     INTEGER,
    website_id   INTEGER,
    PRIMARY KEY (query_id, website_id),
    FOREIGN KEY (query_id)   REFERENCES query(query_id),
    FOREIGN KEY (website_id) REFERENCES website(website_id)
);

INSERT INTO liefert (query_id, website_id)
SELECT 
    q.query_id,
    w.website_id
FROM 
    query q
    JOIN aol_leak a 
        ON q.anon_id = a.anon_id 
       AND q.query_text = a.query
       AND ABS(
           EXTRACT(EPOCH FROM q.timestamp)
         - EXTRACT(EPOCH FROM a.querytime)
       ) < 3600
    JOIN website w 
        ON w.url = a.clickurl
WHERE 
    a.clickurl IS NOT NULL
    AND a.clickurl <> ''
ON CONFLICT (query_id, website_id) DO NOTHING;

DROP TABLE IF EXISTS stellt CASCADE;
CREATE TABLE stellt (
	anon_id BIGINT,
	query_id BIGINT,
	PRIMARY KEY (query_id, anon_id),
    FOREIGN KEY (query_id)   REFERENCES query(query_id),
    FOREIGN KEY (anon_id) REFERENCES "user"(anon_id)
);

INSERT INTO stellt (anon_id, query_id)
SELECT
    al.anon_id,
    q.query_id
FROM aol_leak al
JOIN "user" u
    ON u.anon_id = al.anon_id
JOIN "query" q
    ON q.query_text = al.query
GROUP BY
    al.anon_id,
    q.query_id;


DROP TABLE IF EXISTS f1_filtered;
CREATE TABLE f1_filtered as
SELECT *
FROM aol_leak
WHERE (
      -- Strong F1-only keywords (safe)
      QUERY ILIKE '%f1%'
   OR QUERY ILIKE '% GP %'
   OR QUERY ILIKE '%rennen%'
   OR QUERY ILIKE '%pitstop%'
   OR QUERY ILIKE '%formel 1%'
   OR QUERY ILIKE '%formula 1%'
   OR QUERY ILIKE '%formula1%'
   OR QUERY ILIKE '%formula one%'
   OR QUERY ILIKE '%drs zone%'
   OR QUERY ILIKE '%pit stop%'
   OR QUERY ILIKE '%formation lap%'
   OR QUERY ILIKE '%safety car%'
   OR QUERY ILIKE '%f1 podium%'
   OR QUERY ILIKE '%fastest lap%'
   OR QUERY ILIKE '%silverstone circuit%'
   OR QUERY ILIKE '%monaco grand prix%'
---------- Neu: Teams und Fahrer:
-- Renault
   OR QUERY ILIKE '%Mild Seven Renault F1 Team%' 
   OR QUERY ILIKE '%Renault%F1%Team%' 
   OR QUERY ILIKE '%F1%Renault%Team%'
   OR QUERY ILIKE '%Renault F1%' 
   OR QUERY ILIKE '%F1 %Renault%'
   OR QUERY ILIKE '%Mild Seven%'
   
   -- McLaren
   OR QUERY ILIKE '%Team McLaren Mercedes%' 
   OR QUERY ILIKE '%McLaren Mercedes%'
   OR QUERY ILIKE '%McLaren Mercedes%F1%' 
   OR QUERY ILIKE '%F1 %McLaren Mercedes%'
   
   -- Ferrari (inkl. Ausschlüsse)
   OR (QUERY ILIKE '%Scuderia Ferrari Marlboro%' 
       OR QUERY ILIKE '%Ferrari Marlboro%'
       OR QUERY ILIKE '%Ferrari% F1%' 
       OR QUERY ILIKE '%F1 %Ferrari%')
       AND NOT QUERY ILIKE '%360%' 
       AND NOT QUERY ILIKE '%spider%'
   
   -- Toyota
   OR QUERY ILIKE '%Panasonic Toyota Racing%' 
   OR QUERY ILIKE '%Toyota Racing%'
   OR QUERY ILIKE '%Toyota %f1%' 
   OR QUERY ILIKE '% F1 %Toyota%'
   
   -- Williams
   OR QUERY ILIKE '%Williams F1 Team%' 
   OR QUERY ILIKE '%Williams %F1%' 
   OR QUERY ILIKE '%F1 %Williams%'
   
   -- Honda
   OR QUERY ILIKE '%Lucky Strike Honda Racing F1 Team%' 
   OR QUERY ILIKE '%Honda Racing F1 Team%'
   OR QUERY ILIKE '%Lucky Strike Honda%' 
   OR QUERY ILIKE '%Honda %F1%' 
   OR QUERY ILIKE '%F1 %Honda%'
   
   -- Red Bull
   OR QUERY ILIKE '%Red Bull Racing%' 
   OR QUERY ILIKE '%Red Bull %F1%'
   OR QUERY ILIKE '%F1 %Red Bull%'
   
   -- BMW Sauber
   OR QUERY ILIKE '%BMW Sauber F1 Team%' 
   OR QUERY ILIKE '%BMW Sauber%' 
   OR QUERY ILIKE '%Sauber F1%'
   OR QUERY ILIKE '%F1 %Sauber%'
   OR QUERY ILIKE '%BMW F1%'
   OR QUERY ILIKE '%F1 % BMW%'
   
   -- Spyker
   OR QUERY ILIKE '%Spyker MF1 Team%'
   OR QUERY ILIKE '%Spyker MF1%'
   OR QUERY ILIKE '%Spyker F1 %'
   OR QUERY ILIKE '% F1 %Spyker%'
   
   -- Midland / MF1
   OR QUERY ILIKE '%MF1 Racing%' 
   OR QUERY ILIKE '%Midland F1 Racing%'
   OR QUERY ILIKE '%Midland F1 %'
   OR QUERY ILIKE '%F1 %Midland%'
   OR QUERY ILIKE '%Midland % Racing%'
   
   -- Toro Rosso
   OR QUERY ILIKE '%Scuderia Toro Rosso%'
   OR QUERY ILIKE '%Toro Rosso%'
   OR QUERY ILIKE '%F1%Toro Rosso%' 
   OR QUERY ILIKE '%Toro Rosso%F1%'
   
   -- Super Aguri
   OR QUERY ILIKE '%Super Aguri Formula 1%' 
   OR QUERY ILIKE '%Super Aguri%'
   OR QUERY ILIKE '%F1%Aguri%' 
   OR QUERY ILIKE '%Aguri%F1%'

-- Fernando Alonso
   OR QUERY ILIKE '%Fernando Alonso%'
   
   -- Giancarlo Fisichella
   OR QUERY ILIKE '%Fisichella%'
   
   -- Kimi Räikkönen
   OR QUERY ILIKE '%Räikkönen%'
   OR QUERY ILIKE '%Raikkonen%'
   OR QUERY ILIKE '%Kimi R%ikk%nen %'
   
   -- Juan Pablo Montoya
   OR QUERY ILIKE '%Juan Pablo Montoya%'
   OR QUERY ILIKE '%Pablo%Montoya%'
   OR QUERY ILIKE '%Juan%Montoya%'
   
   -- Pedro de la Rosa
   OR QUERY ILIKE '%Pedro de la Rosa%'
   
   -- Michael Schumacher
   OR QUERY ILIKE '%Michael Schumacher%'
   OR QUERY ILIKE '% M%Schumacher%'
   
   -- Felipe Massa
   OR QUERY ILIKE '%Felipe Massa%'
   
   -- Ralf Schumacher
   OR QUERY ILIKE '%Ralf Schumacher%'
   OR QUERY ILIKE '%Ralph Schumacher%'
   
   -- Jarno Trulli
   OR QUERY ILIKE '%Jarno Trulli%'
   
   -- Mark Webber
   OR QUERY ILIKE '%Mark Webber%'
   
   -- Nico Rosberg
   OR QUERY ILIKE '%Nico Rosberg%'
   OR QUERY ILIKE '%Niko Rosberg%'
   
   -- Rubens Barrichello
   OR QUERY ILIKE '%Barrichello%'
   
   -- Jenson Button
   OR QUERY ILIKE '%Jenson Button%'
   
   -- David Coulthard
   OR QUERY ILIKE '%David Coulthard%'
   
   -- Christian Klien
   OR QUERY ILIKE '%Christian Klien%'
   
   -- Robert Doornbos
   OR QUERY ILIKE '%Doornbos%'
   
   -- Nick Heidfeld
   OR QUERY ILIKE '%Heidfeld%'
   
   -- Jacques Villeneuve
   OR QUERY ILIKE '%J% Villeneuve%'
   
   -- Robert Kubica
   OR QUERY ILIKE '%Kubica%'
   
   -- Tiago Monteiro
   OR QUERY ILIKE '%Tiago Monteiro%'
   
   -- Christijan Albers
   OR QUERY ILIKE '%ristijan Albers%'
   
   -- Vitantonio Liuzzi
   OR QUERY ILIKE '% Vita% Liuzzi%'
   
   -- Scott Speed
   OR QUERY ILIKE '%Scott Speed%'
   
   -- Takuma Satō
   OR QUERY ILIKE '%Satō%'
   OR QUERY ILIKE '%Takuma Sat% %'
   
   -- Yūji Ide
   OR QUERY ILIKE '%Yūji Ide%'
   OR QUERY ILIKE '% Y%ji Ide %'
   
   -- Franck Montagny
   OR QUERY ILIKE '%Montagny%'
   
   -- Sakon Yamamoto
   OR QUERY ILIKE '%Sakon Yamamoto%'

----------

      -- F1-related websites
   OR CLICKURL LIKE 'http://www.formula1.com%'
   OR CLICKURL LIKE 'http://f1.racing-live.com%'
   OR CLICKURL LIKE 'http://www.f1-racing.org%'
   OR CLICKURL LIKE 'http://rc-racing.org.uk%'
   OR CLICKURL LIKE 'http://www.formula1-rc.com%'
   OR CLICKURL LIKE 'http://www.itv-f1.com%'
   OR CLICKURL LIKE 'http://www.mytsn.com%'
   OR CLICKURL LIKE 'http://www.planetf1.com%'
   OR CLICKURL LIKE 'http://formula1.about.com%'
   OR CLICKURL LIKE 'http://www.f1nutter.co.uk%'
   OR CLICKURL LIKE 'http://www.f1m.com%'
   OR CLICKURL LIKE 'http://www.f1-sales.com%'
   OR CLICKURL LIKE 'http://cars.grandprix.com.au%'
   OR CLICKURL LIKE 'http://www.7extrememotorsports.com%'
   OR CLICKURL LIKE 'http://www.f1racefactory.com%'
   OR CLICKURL LIKE 'http://www.na-motorsports.com%'
   OR CLICKURL LIKE 'http://www.f1racing.net%'

      -- Ambiguous terms only when paired with F1 context
   OR (
        QUERY ILIKE '%grand prix%'
        AND (
              QUERY ILIKE '%formula%'
           OR QUERY ILIKE '%f1%'
           OR QUERY ILIKE '%circuit%'
           OR QUERY ILIKE '%race%'   
		   OR QUERY ILIKE '%Bahrain%'
		   OR QUERY ILIKE '%Malaysia%'
		   OR QUERY ILIKE '%Australia%'
		   OR QUERY ILIKE '%Imola%'
		   OR QUERY ILIKE '%NÃ¼rburg%'
		   OR QUERY ILIKE '%Spain%'
		   OR QUERY ILIKE '%Monaco%'
		)
      )
)

-- Exclusions apply to all matches
AND QUERY NOT ILIKE '%pontiac%'
AND QUERY NOT ILIKE '%f150%'
AND QUERY NOT ILIKE '%ford%'
AND QUERY NOT ILIKE '%guitar%'
AND QUERY NOT ILIKE '%truck%'
AND QUERY NOT ILIKE '%jet%'
AND QUERY NOT ILIKE '%plane%'
AND QUERY NOT ILIKE '%tractor%'
AND QUERY NOT ILIKE '%tomcat%'
AND QUERY NOT ILIKE '%19%'           -- excludes F-19 / jets
AND QUERY NOT ILIKE '%sanus ff1%'
AND QUERY NOT ILIKE '%99%'
AND QUERY NOT ILIKE '%extingusher%'
AND QUERY NOT ILIKE '%canon%'
AND QUERY NOT ILIKE '%fujifilm%'
AND QUERY NOT ILIKE '%runnning%'
-- Neu: aus Fahrer und Teams:
AND QUERY NOT ILIKE '%spider%'
AND QUERY NOT ILIKE '%360%'

-- URL Exclusions
AND CLICKURL NOT ILIKE '%military%'
AND CLICKURL NOT ILIKE '%navy%'
AND CLICKURL NOT ILIKE '%alibaba%'
AND CLICKURL NOT ILIKE '%amazon%'
AND CLICKURL NOT ILIKE '%shop%'
AND CLICKURL NOT ILIKE '%golf%'
AND CLICKURL NOT ILIKE '%plane%'
AND CLICKURL NOT ILIKE '%fujifilm%'
AND CLICKURL NOT ILIKE '%ebay%';

DROP TABLE IF EXISTS F1_Query CASCADE;
CREATE TABLE F1_Query AS
SELECT q.query_id, q.timestamp, q.query_text, q.anon_id
FROM query q
WHERE EXISTS (
    SELECT 1
    FROM f1_filtered f
    WHERE q.anon_id = f.anon_id
    AND q.timestamp = f.querytime
    AND q.query_text = f.query
);

ALTER TABLE F1_Query
ADD PRIMARY KEY (query_id);

DROP TABLE IF EXISTS F1_user CASCADE;
CREATE TABLE f1_user (
    anon_id BIGINT PRIMARY KEY
);

INSERT INTO f1_user (anon_id) 
select anon_id 
from f1_query
group by anon_id

DROP TABLE IF EXISTS F1_Website CASCADE;
CREATE TABLE F1_Website (
    Website_ID BIGINT PRIMARY KEY,
    URL TEXT
);

-- Populate the table with distinct websites associated with queries in f1_query
INSERT INTO f1_website (website_id, url)
SELECT w.website_id, w.url
FROM f1_query q
JOIN liefert l ON q.query_id = l.query_id
JOIN website w ON l.website_id = w.website_id
GROUP BY w.website_id, w.url;

-- Drivers mentioned in the query
DROP TABLE IF EXISTS fahrer_wird_erwaehnt CASCADE;
CREATE TABLE fahrer_wird_erwaehnt (
    query_id    INTEGER REFERENCES f1_query(query_id),
    fahrer_id   INTEGER REFERENCES fahrer(fahrer_id),
    PRIMARY KEY (query_id, fahrer_id)
);

-- Teams mentioned in the query
DROP TABLE IF EXISTS team_wird_erwaehnt CASCADE;
CREATE TABLE team_wird_erwaehnt (
    query_id    INTEGER REFERENCES f1_query(query_id),
    team_id     INTEGER REFERENCES team(team_id),
    PRIMARY KEY (query_id, team_id)
);

-- Tracks mentioned in the query
DROP TABLE IF EXISTS strecke_wird_erwaehnt CASCADE;
CREATE TABLE strecke_wird_erwaehnt (
    query_id       INTEGER REFERENCES f1_query(query_id),
    streckenname   TEXT REFERENCES strecke(streckenname),
    PRIMARY KEY (query_id, streckenname)
);

---- Races mentioned in the query
--DROP TABLE IF EXISTS f1_rennen_wird_erwaehnt;
--CREATE TABLE f1_rennen_wird_erwaehnt (
--    query_id       INTEGER REFERENCES f1_query(query_id),
--	rennen_id 	INTEGER REFERENCES f1_rennen(rennen_id),
--    PRIMARY KEY (query_id, rennen_id)
--);

INSERT INTO fahrer_wird_erwaehnt (query_id, fahrer_id)
SELECT q.query_id, f.fahrer_id
FROM f1_query q
JOIN fahrer f ON ((
       (f.name = 'Fernando Alonso'            AND (
             q.query_text ILIKE '%alonso%' OR q.query_text ILIKE '%fernando%' ))
    OR (f.name = 'Giancarlo Fisichella'        AND (
             q.query_text ILIKE '%fisichella%' OR q.query_text ILIKE '%fisico%' ))
    OR (f.name = 'Kimi Räikkönen'              AND (
             q.query_text ILIKE '%räikkönen%' OR q.query_text ILIKE '%raikkonen%' OR q.query_text ILIKE '%kimi%' ))
    OR (f.name = 'Juan Pablo Montoya'          AND (
             q.query_text ILIKE '%montoya%' OR q.query_text ILIKE '%juan pablo%' ))
    OR (f.name = 'Pedro de la Rosa'            AND (
             q.query_text ILIKE '%de la rosa%' OR q.query_text ILIKE '%pedro rosa%' ))
    OR (f.name = 'Michael Schumacher'          AND (
             q.query_text ILIKE '%michael schumacher%' OR q.query_text ILIKE '%schumacher%' OR q.query_text ILIKE '%schumi%' ))
    OR (f.name = 'Felipe Massa'                AND (
             q.query_text ILIKE '%massa %' OR q.query_text ILIKE '%felipe%' ))
    OR (f.name = 'Ralf Schumacher'             AND (
             q.query_text ILIKE '%ralf schumacher%' OR q.query_text ILIKE '%ralf%' ))
    OR (f.name = 'Jarno Trulli'                AND (
             q.query_text ILIKE '%trulli%' ))
    OR (f.name = 'Mark Webber'                 AND (
             q.query_text ILIKE '%webber%' ))
    OR (f.name = 'Nico Rosberg'                AND (
             q.query_text ILIKE '%rosberg%' OR q.query_text ILIKE '%nico%' ))
    OR (f.name = 'Rubens Barrichello'          AND (
             q.query_text ILIKE '%barrichello%' OR q.query_text ILIKE '%rubens%' OR q.query_text ILIKE '%barrichelo%' ))
    OR (f.name = 'Jenson Button'               AND (
             q.query_text ILIKE '%button%' OR q.query_text ILIKE '%jenson%' ))
    OR (f.name = 'David Coulthard'             AND (
             q.query_text ILIKE '%coulthard%' ))
    OR (f.name = 'Christian Klien'             AND (
             q.query_text ILIKE '%klien%' ))
    OR (f.name = 'Robert Doornbos'             AND (
             q.query_text ILIKE '%doornbos%' ))
    OR (f.name = 'Nick Heidfeld'               AND (
             q.query_text ILIKE '%heidfeld%' ))
    OR (f.name = 'Jacques Villeneuve'          AND (
             q.query_text ILIKE '%villeneuve%' OR q.query_text ILIKE '%jacques%' ))
    OR (f.name = 'Robert Kubica'               AND (
             q.query_text ILIKE '%kubica%' ))
    OR (f.name = 'Tiago Monteiro'              AND (
             q.query_text ILIKE '%monteiro%' ))
    OR (f.name = 'Christijan Albers'           AND (
             q.query_text ILIKE '%albers%' OR q.query_text ILIKE '%christian albers%' ))
    OR (f.name = 'Vitantonio Liuzzi'           AND (
             q.query_text ILIKE '%liuzzi%' OR q.query_text ILIKE '%vitantonio%' ))
    OR (f.name = 'Scott Speed'                 AND (
             q.query_text ILIKE '%scott speed%'))
    OR (f.name = 'Takuma Satō'                 AND (
             q.query_text ILIKE '%takuma sato%' OR q.query_text ILIKE '%sato%' ))
    OR (f.name = 'Yūji Ide'                    AND (
             q.query_text ILIKE '%yuji ide%' OR q.query_text ILIKE '%ide%' ))
    OR (f.name = 'Franck Montagny'             AND (
             q.query_text ILIKE '%montagny%' ))
    OR (f.name = 'Sakon Yamamoto'              AND (
             q.query_text ILIKE '%yamamoto%' OR q.query_text ILIKE '%sakon%' )))
	AND NOT(
		q.query_text ILIKE '%spider%' OR
		q.query_text ILIKE '%bridesmaids%' OR
		q.query_text ILIKE '%speedway%' OR
		q.query_text ILIKE '%race%' OR
		q.query_text ILIKE '%video%'
	)
)
ON CONFLICT DO NOTHING;


INSERT INTO team_wird_erwaehnt (query_id, team_id)
SELECT q.query_id, t.team_id
FROM f1_query q
JOIN team t ON (
       ((t.name = 'Mild Seven Renault F1 Team'          AND (
             q.query_text ILIKE '%renault%' OR q.query_text ILIKE '%mild seven%' ))
    OR (t.name = 'Team McLaren Mercedes'               AND (
             q.query_text ILIKE '%mclaren%' OR q.query_text ILIKE '%mercedes%' OR q.query_text ILIKE '%team mclaren%' ))
    OR (t.name = 'Scuderia Ferrari Marlboro'           AND (
             q.query_text ILIKE '%ferrari%' OR q.query_text ILIKE '%scuderia ferrari%' OR q.query_text ILIKE '%marlboro%' ))
    OR (t.name = 'Panasonic Toyota Racing'             AND (
             q.query_text ILIKE '%toyota%' OR q.query_text ILIKE '%panasonic%' ))
    OR (t.name = 'Williams F1 Team'                    AND (
             q.query_text ILIKE '%williams%' ))
    OR (t.name = 'Lucky Strike Honda Racing F1 Team'   AND (
             q.query_text ILIKE '%honda%' OR q.query_text ILIKE '%lucky strike%'))
    OR (t.name = 'Red Bull Racing'                     AND (
             q.query_text ILIKE '%red bull%' OR q.query_text ILIKE '% rbr %' ))
    OR (t.name = 'BMW Sauber F1 Team'                  AND (
             q.query_text ILIKE '%bmw sauber%'))
    OR (t.name = 'Midland F1 Racing'                   AND (
             q.query_text ILIKE '%midland f1%' ))
    OR (t.name = 'Spyker MF1 Team'                     AND (
             q.query_text ILIKE '%spyker%'))
    OR (t.name = 'Scuderia Toro Rosso'                 AND (
             q.query_text ILIKE '%toro rosso%' OR q.query_text ILIKE '% str %' OR q.query_text ILIKE '%rosso%' ))
    OR (t.name = 'Super Aguri Formula 1'               AND (
             q.query_text ILIKE '%super aguri%' OR q.query_text ILIKE '%aguri%' ))) 
	AND NOT (
    q.query_text ILIKE '%drag%strip%' OR
	q.query_text ILIKE '%spider%'
	--q.query_text ILIKE '[0-9&&[^1]]'
	)
)
ON CONFLICT DO NOTHING;

INSERT INTO strecke_wird_erwaehnt (query_id, streckenname)
SELECT q.query_id, s.streckenname
FROM f1_query q
JOIN strecke s ON (
       (s.streckenname = 'Bahrain International Circuit'      AND (
              q.query_text ILIKE '%bahrain%' ))
    OR (s.streckenname = 'Sepang International Circuit'        AND (
              q.query_text ILIKE '%sepang%' ))
    OR (s.streckenname = 'Albert Park Circuit'                 AND (
              q.query_text ILIKE '%albert park%' OR q.query_text ILIKE '%melbourne%' ))
    OR (s.streckenname = 'Autodromo Enzo e Dino Ferrari'       AND (
              q.query_text ILIKE '%imola%' OR q.query_text ILIKE '%enzo%' OR q.query_text ILIKE '%ferrari circuit%' ))
    OR (s.streckenname = 'Nürburgring'                         AND (
              q.query_text ILIKE '%nürburgring%' OR q.query_text ILIKE '%nurburgring%' OR q.query_text ILIKE '%nuerburgring%' OR q.query_text ILIKE '%nurburg%' ))
    OR (s.streckenname = 'Circuit de Catalunya'                AND (
              q.query_text ILIKE '%catalunya%' OR q.query_text ILIKE '%barcelona%' ))
    OR (s.streckenname = 'Circuit de Monaco'                   AND (
              q.query_text ILIKE '%monaco%' OR q.query_text ILIKE '%monte carlo%' ))
    OR (s.streckenname = 'Silverstone Circuit'                 AND (
              q.query_text ILIKE '%silverstone%' ))
    OR (s.streckenname = 'Circuit Gilles Villeneuve'           AND (
              q.query_text ILIKE '%gilles villeneuve%' OR q.query_text ILIKE '%montreal%' ))
    OR (s.streckenname = 'Indianapolis Motor Speedway'         AND (
              q.query_text ILIKE '%indianapolis%' OR q.query_text ILIKE '%indy%' ))
    OR (s.streckenname = 'Circuit de Nevers Magny-Cours'       AND (
              q.query_text ILIKE '%magny%' OR q.query_text ILIKE '%nevers%' ))
    OR (s.streckenname = 'Hockenheimring'                      AND (
              q.query_text ILIKE '%hockenheim%' ))
    OR (s.streckenname = 'Hungaroring'                         AND (
              q.query_text ILIKE '%hungaroring%' OR q.query_text ILIKE '%budapest%' ))
    OR (s.streckenname = 'Istanbul Park'                       AND (
              q.query_text ILIKE '%istanbul%' ))
    OR (s.streckenname = 'Autodromo Nazionale di Monza'        AND (
              q.query_text ILIKE '%monza%' ))
    OR (s.streckenname = 'Shanghai International Circuit'      AND (
              q.query_text ILIKE '%shanghai%' ))
    OR (s.streckenname = 'Suzuka Circuit'                      AND (
              q.query_text ILIKE '%suzuka%' ))
    OR (s.streckenname = 'Autódromo José Carlos Pace'          AND (
              q.query_text ILIKE '%interlagos%' OR q.query_text ILIKE '%jose carlos pace%' OR q.query_text ILIKE '%autodromo%' ))
)
ON CONFLICT DO NOTHING;

-- SELECT *
-- FROM f1_query
-- WHERE query_id IN (
--     SELECT query_id
--     FROM strecke_wird_erwaehnt
-- );

-- komninierter prim key

--DROP TABLE faehrt_fuer CASCADE;

DROP TABLE IF EXISTS faehrt_fuer CASCADE;
CREATE TABLE faehrt_fuer (
    Fahrer_ID BIGINT,
    Team_ID BIGINT,
    PRIMARY KEY (Fahrer_ID, Team_ID),
    FOREIGN KEY (Fahrer_ID) REFERENCES Fahrer(Fahrer_ID) ON DELETE CASCADE,
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID) ON DELETE CASCADE
);

INSERT INTO faehrt_fuer (Fahrer_ID, Team_ID)
SELECT Fahrer_ID, Team_ID
FROM Fahrer;

--SELECT * From faehrt_fuer

--
--DROP TABLE faehrt_in CASCADE;

DROP TABLE IF EXISTS faehrt_in CASCADE;
CREATE TABLE faehrt_in (
    Team_ID BIGINT,
    Rennen_ID BIGINT,
    PRIMARY KEY (Team_ID, Rennen_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
    FOREIGN KEY (Rennen_ID) REFERENCES F1_Rennen(Rennen_ID)
);

	-- kartesisches produkt. alle teams in allen rennen
INSERT INTO faehrt_in (Team_ID, Rennen_ID)
SELECT t.Team_ID, r.Rennen_ID
FROM Team t
CROSS JOIN F1_Rennen r;

--SELECT * From faehrt_in


--DROP TABLE findet_statt_auf CASCADE;

DROP TABLE IF EXISTS findet_statt_auf CASCADE;
CREATE TABLE findet_statt_auf (
    Rennen_ID BIGINT,
    Streckenname TEXT,
    PRIMARY KEY (Rennen_ID, Streckenname),
    FOREIGN KEY (Rennen_ID) REFERENCES F1_Rennen(Rennen_ID),
    FOREIGN KEY (Streckenname) REFERENCES Strecke(StreckenName)
);

INSERT INTO findet_statt_auf (Rennen_ID, Streckenname)
SELECT Rennen_ID, StreckenName
FROM F1_Rennen;

--SELECT * FROM findet_statt_auf

-- Create the table by selecting distinct pairs from f1_query
DROP TABLE IF EXISTS f1_stellt CASCADE;
CREATE TABLE f1_stellt AS
SELECT
    anon_id,
    query_id
FROM f1_query
GROUP BY
    anon_id,
    query_id;

-- Add the composite primary key
ALTER TABLE f1_stellt
ADD PRIMARY KEY (anon_id, query_id);

-- Step 1: Create the empty table with the specified columns
DROP TABLE IF EXISTS f1_liefert;
CREATE TABLE f1_liefert (
    query_id INTEGER,
    website_id INTEGER
);

-- Step 2: Populate it with filtered data from liefert
INSERT INTO f1_liefert (query_id, website_id)
SELECT l.query_id, l.website_id
FROM liefert l
WHERE EXISTS (
    SELECT 1 FROM f1_query q WHERE q.query_id = l.query_id
)
AND EXISTS (
    SELECT 1 FROM f1_website w WHERE w.website_id = l.website_id
);

DROP TABLE IF EXISTS enthaelt_f1_begriff CASCADE;
CREATE TABLE enthaelt_f1_begriff (
    query_id BIGINT PRIMARY KEY
);

insert into enthaelt_f1_begriff select query_id from f1_query;


DROP TABLE IF EXISTS Reiseanfrage CASCADE;
CREATE TABLE Reiseanfrage (
    ReiseanfragenID BIGSERIAL PRIMARY KEY,
    TimeStamp       TIMESTAMP,
    Reise_Ziel      TEXT,
    Ankunftsdatum   DATE,
    Anon_ID BIGINT REFERENCES "user"(anon_id),
    Query_ID        BIGINT REFERENCES Query(Query_ID)
);

