-- Step 1: Create the empty table with the specified columns
DROP TABLE IF EXISTS f1_liefert;
CREATE TABLE f1_liefert (
    query_id INTEGER,
    website_id INTEGER
);

-- Step 2: Populate it with filtered data from liefert
INSERT INTO f1_liefert (query_id, website_id)
SELECT l.query_id, l.website_id
FROM liefert l
WHERE EXISTS (
    SELECT 1 FROM f1_query q WHERE q.query_id = l.query_id
)
AND EXISTS (
    SELECT 1 FROM f1_website w WHERE w.website_id = l.website_id
);
