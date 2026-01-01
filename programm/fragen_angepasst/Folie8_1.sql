-- Welche Muster/Wörter treten bei Formel-1 - Anfragen besonders häufig auf?

SELECT 
    word, 
    COUNT(*) AS anzahl
FROM (
    SELECT regexp_split_to_table(lower(query_text), '\s+') AS word
    FROM F1_Query
) AS word_list
WHERE LENGTH(word) > 3
GROUP BY word
ORDER BY anzahl DESC

LIMIT 20;
