DROP TABLE IF EXISTS f1_query CASCADE;
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