DROP TABLE IF EXISTS f1_website CASCADE;
CREATE TABLE F1_Website (
    Website_ID BIGINT PRIMARY KEY,
    URL TEXT
);

-- Populate the table with distinct websites associated with queries in f1_query
INSERT INTO f1_website (website_id, url)
SELECT DISTINCT
       w.website_id,
       w.url
FROM f1_filtered f
JOIN website w
  ON f.clickurl = w.url;
-- select * from website where 

SELEct * from f1_website where url ilike '%formula1%';