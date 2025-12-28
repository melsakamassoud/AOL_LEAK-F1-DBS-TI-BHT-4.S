CREATE TABLE "user" (
Anon_ID BIGINT PRIMARY KEY
);
WITH temp_table AS (
SELECT DISTINCT anon_id AS Anon_ID
FROM aol_leak
)
INSERT INTO "user" (Anon_ID)
SELECT Anon_ID
FROM temp_table;