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

select * from findet_statt_auf