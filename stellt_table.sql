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