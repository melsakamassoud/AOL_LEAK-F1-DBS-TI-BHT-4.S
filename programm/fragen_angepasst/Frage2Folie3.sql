-- Welche Webseiten wurden bei Formel-1-Anfragen am meisten angeklickt?
SELECT
    w.url,
    COUNT(*) AS site_count
FROM f1_liefert l
JOIN f1_website w
    ON w.website_id = l.website_id
GROUP BY w.url
ORDER BY site_count DESC
LIMIT 30;
