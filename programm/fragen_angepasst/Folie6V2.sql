-- Nach welchem Team wurde am öftesten gesucht?

SELECT 
    t.team_id,
    t.name AS team_name,
    COUNT(sub.t_id) AS anzahl_suchen
FROM team t
LEFT JOIN (
    SELECT 
        CASE 
            -- Renault
            WHEN query_text ILIKE '%Mild%Seven%Renault%F1%Team%' 
              OR query_text ILIKE '%Renault%F1%Team%' 
              OR query_text ILIKE '%F1%Renault%Team%'
              OR query_text ILIKE '%Renault%F1%' 
              OR query_text ILIKE '%F1%Renault%'
              OR query_text ILIKE '%Mild Seven%' THEN 1

            -- McLaren
            WHEN query_text ILIKE '%Team McLaren Mercedes%' 
              OR query_text ILIKE '%McLaren Mercedes%'
              OR query_text ILIKE '%McLaren Mercedes%F1%' 
              OR query_text ILIKE '%F1 %McLaren Mercedes%' THEN 2

            -- Ferrari
            WHEN (query_text ILIKE '%Scuderia Ferrari Marlboro%' 
              OR query_text ILIKE '%Ferrari Marlboro%'
              OR query_text ILIKE '%Ferrari% F1%' 
              OR query_text ILIKE '%F1 %Ferrari%')
              AND query_text NOT ILIKE '%360%' 
              AND query_text NOT ILIKE '%spider%' THEN 3

            -- Toyota
            WHEN query_text ILIKE '%Panasonic Toyota Racing%' 
              OR query_text ILIKE '%Toyota Racing%'
              OR query_text ILIKE '%Toyota %f1%' 
              OR query_text ILIKE '% F1 %Toyota%' THEN 4

            -- Williams
            WHEN query_text ILIKE '%Williams F1 Team%' 
              OR query_text ILIKE '%Williams %F1%' 
              OR query_text ILIKE '%F1 %Williams%' THEN 5

            -- Honda
            WHEN query_text ILIKE '%Lucky Strike Honda Racing F1 Team%' 
              OR query_text ILIKE '%Honda Racing F1 Team%'
              OR query_text ILIKE '%Lucky Strike Honda%' 
              OR query_text ILIKE '%Honda %F1%' 
              OR query_text ILIKE '%F1 %Honda%' THEN 6

            -- Red Bull
            WHEN query_text ILIKE '%Red Bull Racing%' 
              OR query_text ILIKE '%Red Bull %F1%'
              OR query_text ILIKE '%F1 %Red Bull%' THEN 7

            -- BMW Sauber
            WHEN query_text ILIKE '%BMW%Sauber%F1%Team%' 
              OR query_text ILIKE '%BMW%Sauber%' 
              OR query_text ILIKE '%Sauber%F1%'
              OR query_text ILIKE '%F1%Sauber%'
              OR query_text ILIKE '%BMW%F1%'
              OR query_text ILIKE '%F1%BMW%' THEN 8

            -- Midland & Spyker (Beide auf ID 9)
            WHEN query_text ILIKE '%Spyker%MF1%Team%'
              OR query_text ILIKE '%Spyker%MF1%'
              OR query_text ILIKE '%SpykerF1%'
              OR query_text ILIKE '%F1%Spyker%'
              OR query_text ILIKE '%MF1%Racing%' 
              OR query_text ILIKE '%Midland%F1%Racing%'
              OR query_text ILIKE '%Midland%F1%'
              OR query_text ILIKE '%F1%Midland%'
              OR query_text ILIKE '%Midland%%Racing%' THEN 9

            -- Toro Rosso
            WHEN query_text ILIKE '%Scuderia Toro Rosso%'
              OR query_text ILIKE '%Toro Rosso%'
              OR query_text ILIKE '%F1%Toro Rosso%' 
              OR query_text ILIKE '%Toro Rosso%F1%' THEN 10

            -- Super Aguri
            WHEN query_text ILIKE '%Super Aguri Formula 1%' 
              OR query_text ILIKE '%Super Aguri%'
              OR query_text ILIKE '%F1%Aguri%' 
              OR query_text ILIKE '%Aguri%F1%' THEN 11

            ELSE NULL
        END AS t_id
    FROM f1_query
) AS sub ON t.team_id = sub.t_id
GROUP BY t.team_id, t.name

ORDER BY anzahl_suchen DESC;
