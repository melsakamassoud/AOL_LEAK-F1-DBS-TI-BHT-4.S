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

SELECT *
FROM f1_query
WHERE query_id IN (
    SELECT query_id
    FROM strecke_wird_erwaehnt
);

