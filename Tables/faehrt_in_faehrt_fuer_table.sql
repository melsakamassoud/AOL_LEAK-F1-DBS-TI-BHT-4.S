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

