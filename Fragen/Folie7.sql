--Gibt es Nutzer, die von Formel 1 zu Tickets oder Reiseanfragen wechseln?

WITH daily_queries AS (
    SELECT
        DATE(q.timestamp) AS tag,
        COUNT(*) AS count_reiseanfragen
    FROM Query q
    JOIN f1_user f1
      ON q.anon_id = f1.anon_id
    WHERE
           LOWER(q.query_text) LIKE '%hotel%'
        OR LOWER(q.query_text) LIKE '%hostel%'
        OR LOWER(q.query_text) LIKE '%motel%'
        OR LOWER(q.query_text) LIKE '%apartment%'
        OR LOWER(q.query_text) LIKE '%airbnb%'
        OR LOWER(q.query_text) LIKE '%resort%'
        OR LOWER(q.query_text) LIKE '%suite%'
        OR LOWER(q.query_text) LIKE '%booking%'
        OR LOWER(q.query_text) LIKE '%overnight%'
        OR LOWER(q.query_text) LIKE '%unterkunft%'
        OR LOWER(q.query_text) LIKE '%übernacht%'
        OR LOWER(q.query_text) LIKE '%zimmer%'
        OR LOWER(q.query_text) LIKE '% pension %'
        OR LOWER(q.query_text) LIKE '% flight %'
        OR LOWER(q.query_text) LIKE '% flights %'
        OR LOWER(q.query_text) LIKE '% travel %'
        OR LOWER(q.query_text) LIKE '% trip%'
        OR LOWER(q.query_text) LIKE '%vacation%'
        OR LOWER(q.query_text) LIKE '%holiday%'
        OR LOWER(q.query_text) LIKE '%reise%'
        OR LOWER(q.query_text) LIKE '%urlaub%'
        OR LOWER(q.query_text) LIKE '%buchung%'
        OR LOWER(q.query_text) LIKE '%reservation%'
        OR LOWER(q.query_text) LIKE '%reservierung%'
        OR LOWER(q.query_text) LIKE '%from % to %'
        OR LOWER(q.query_text) LIKE '%von % nach %'
        OR LOWER(q.query_text) LIKE '%nach %'
        OR LOWER(q.query_text) LIKE '%hin und zurück%'
        OR LOWER(q.query_text) LIKE '%round trip%'
        OR LOWER(q.query_text) LIKE '%one way%'
        OR LOWER(q.query_text) LIKE '%one-way%'
    GROUP BY DATE(q.timestamp)
)
SELECT
    d.tag,
    d.count_reiseanfragen,
    r.streckenname AS next_race,
    r.datum,
    r.datum - d.tag AS days_to_race
FROM daily_queries d
LEFT JOIN LATERAL (
    SELECT f1r.datum, f1r.streckenname
    FROM f1_rennen f1r
    WHERE f1r.datum >= d.tag
    ORDER BY f1r.datum
    LIMIT 1
) r ON true
ORDER BY d.tag;