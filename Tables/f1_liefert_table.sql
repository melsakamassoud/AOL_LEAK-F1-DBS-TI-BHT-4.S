DROP TABLE IF EXISTS f1_liefert;
CREATE TABLE f1_liefert (
    query_id   INTEGER PRIMARY KEY,
    website_id INTEGER NOT NULL
);

INSERT INTO f1_liefert (query_id, website_id)
SELECT
    q.query_id,
    MIN(w.website_id) AS website_id
FROM f1_filtered f
JOIN f1_query q
    ON f.query = q.query_text
JOIN f1_website w
    ON f.clickurl = w.url
GROUP BY q.query_id;
