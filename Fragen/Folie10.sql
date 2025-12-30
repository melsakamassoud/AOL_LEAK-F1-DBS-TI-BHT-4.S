-- Wie viele Nutzer sind im Datensatz in Relation zu F1 mehr als einmal über die 3 Monate zu finden?

SELECT 'Wiederkehrend' AS status, COUNT(*) AS anzahl
FROM (SELECT anon_id FROM F1_Query GROUP BY anon_id HAVING COUNT(*) > 1) AS sub
UNION ALL
SELECT 'Einmalig' AS status, COUNT(*) AS anzahl
FROM (SELECT anon_id FROM F1_Query GROUP BY anon_id HAVING COUNT(*) = 1) AS sub
UNION ALL
SELECT 'Zweimal' AS status, COUNT(*) AS anzahl
FROM (SELECT anon_id FROM F1_Query GROUP BY anon_id HAVING COUNT(*) = 2) AS sub;
