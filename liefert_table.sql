DROP TABLE IF EXISTS liefert CASCADE;
CREATE TABLE liefert (
    query_id     INTEGER,
    website_id   INTEGER,
    PRIMARY KEY (query_id, website_id),
    FOREIGN KEY (query_id)   REFERENCES query(query_id),
    FOREIGN KEY (website_id) REFERENCES website(website_id)
);

INSERT INTO liefert (query_id, website_id)
SELECT DISTINCT
    q.query_id,
    w.website_id
FROM aol_leak a
JOIN query q
    ON q.query_text = a.query
JOIN website w
    ON w.url = a.clickurl
WHERE a.clickurl IS NOT NULL
  AND a.clickurl <> '';
