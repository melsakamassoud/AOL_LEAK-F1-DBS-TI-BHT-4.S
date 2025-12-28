DROP TABLE IF EXISTS Query CASCADE;
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