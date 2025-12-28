-- Welche Orte wurden mit Formel-1-Rennen in Verbindung gesucht?

SELECT query
FROM f1_filtered f
WHERE
(	   query ILIKE '%Bahrain%'
    OR query ILIKE '%Malaysia%'
    OR query ILIKE '%Australia%'
    OR query ILIKE '%Imola%'
    OR query ILIKE '%Nurburg%'
    OR query ILIKE '%Spain%'
    OR query ILIKE '%Monaco%'
)
AND (
    query ILIKE '%grand prix%'
    OR		   query ILIKE '%race%'
        OR query ILIKE '%Bahrain%'
        OR query ILIKE '%Malaysia%'
        OR query ILIKE '%Australia%'
        OR query ILIKE '%Imola%'
        OR query ILIKE '%Nurburg%'
        OR query ILIKE '%Spain%'
        OR query ILIKE '%Monaco%'
    );
