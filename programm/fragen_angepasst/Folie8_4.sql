-- Welche Muster/Wörter treten bei Formel-1 - Anfragen besonders häufig auf?

SELECT 
    word1 || ' ' || word2 || ' ' || word3 || ' ' || word4 AS wort_muster, 
    COUNT(*) AS anzahl
FROM (
    SELECT 
        word AS word1, 
        LEAD(word, 1) OVER (PARTITION BY query_id ORDER BY pos) AS word2,
        LEAD(word, 2) OVER (PARTITION BY query_id ORDER BY pos) AS word3,
        LEAD(word, 3) OVER (PARTITION BY query_id ORDER BY pos) AS word4
    FROM (
        SELECT 
            query_id,
            val AS word,
            ordinality AS pos
        FROM 
            F1_Query,
            regexp_split_to_table(lower(query_text), '\s+') WITH ORDINALITY AS val
    ) AS tokens
) AS quadgrams
WHERE word4 IS NOT NULL
GROUP BY wort_muster
ORDER BY anzahl DESC

LIMIT 20;
