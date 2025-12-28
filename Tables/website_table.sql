DROP TABLE IF EXISTS Website CASCADE;
CREATE TABLE Website (s
    Website_ID BIGSERIAL PRIMARY KEY,
    URL TEXT
);

WITH temp_table AS (
    SELECT DISTINCT clickurl AS URL
    FROM aol_leak
)
INSERT INTO website (URL)
SELECT URL
FROM temp_table;