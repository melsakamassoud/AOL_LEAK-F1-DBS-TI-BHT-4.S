-- Wie viele Nutzer sind im Datensatz in Relation zu F1 mehr als einmal über die 3 Monate zu finden?


SELECT 
    COUNT(*) FILTER (WHERE query_count > 1) AS wiederkehrende_usr,
    COUNT(*) AS gesamt_usr,
    ROUND(
        (COUNT(*) FILTER (WHERE query_count > 1)::numeric / COUNT(*)) * 100, -- numeric sont trunk. bei .n 
        2 -- ROUND ()2 
    ) || '%' AS verhaeltnis_proz
FROM (
    SELECT anon_id, COUNT(*) AS query_count 
    FROM F1_Query
    GROUP BY anon_id
) AS user_stats;  -- Anz wie oft user gefunden


