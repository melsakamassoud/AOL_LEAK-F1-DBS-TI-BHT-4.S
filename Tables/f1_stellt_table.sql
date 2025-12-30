-- Create the table by selecting distinct pairs from f1_query
DROP TABLE IF EXISTS f1_stellt CASCADE;
CREATE TABLE f1_stellt AS
SELECT DISTINCT anon_id, query_id
FROM f1_query;

-- Add the composite primary key
ALTER TABLE f1_stellt
ADD PRIMARY KEY (anon_id, query_id);