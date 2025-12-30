-- Wann waren die Spitzen der Formel-1-Suchanfragen?

SELECT 
    timestamp::DATE AS tag, 
    COUNT(*) AS anzahl_queries
FROM 
    F1_Query
GROUP BY 
    tag
ORDER BY 
    tag ASC;