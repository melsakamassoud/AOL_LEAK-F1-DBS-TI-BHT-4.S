-- Mit welchen Begriffen in der Anfrage wurde am häufigsten auf die offizielle Seite formula1.com geklickt?
SELECT
    query,
    COUNT(*) AS query_count,
    'formula1.com' AS website
FROM f1_filtered
WHERE clickurl = 'http://www.formula1.com'
GROUP BY query
ORDER BY query_count DESC;
