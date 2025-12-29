-- Mit welchen Begriffen in der Anfrage wurde am häufigsten 
-- auf die offizielle Seite formula1.com geklickt?
-- select * from f1_website where url = 'http://www.formula1.com'
-- -> website_id von http://www.formula1.com ist 27001

SELECT
    q.query_text,
    COUNT(*) AS query_count,
    'formula1.com' AS website
FROM f1_liefert l
JOIN f1_query q
    ON l.query_id = q.query_id
WHERE l.website_id = 27001
GROUP BY q.query_text
ORDER BY query_count DESC;
