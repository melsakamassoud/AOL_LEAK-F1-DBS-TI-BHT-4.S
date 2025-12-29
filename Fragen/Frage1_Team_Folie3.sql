-- Welche Webseiten wurden bei Formel-1-Anfragen angeklickt?

SELECT 
    t.name AS team_name,
    CASE 
        WHEN COUNT(sub.t_id) > 0 THEN 'Ja' 
        ELSE 'Nein' 
    END AS wurde_erwaehnt
FROM team t
LEFT JOIN (
    SELECT 
        CASE 
            WHEN query_text ILIKE '%Mild Seven Renault F1 Team%' 
              OR query_text ILIKE '%Renault%F1%Team%' 
              OR query_text ILIKE '%F1%Renault%Team%'
              OR query_text ILIKE '%Renault F1%' 
              OR query_text ILIKE '%F1 %Renault%'
              OR query_text ILIKE '%Mild Seven%' THEN 1
            WHEN query_text ILIKE '%Team McLaren Mercedes%' 
              OR query_text ILIKE '%McLaren Mercedes%'
              OR query_text ILIKE '%McLaren Mercedes%F1%' 
              OR query_text ILIKE '%F1 %McLaren Mercedes%' THEN 2
            WHEN (query_text ILIKE '%Scuderia Ferrari Marlboro%' 
              OR query_text ILIKE '%Ferrari Marlboro%'
              OR query_text ILIKE '%Ferrari% F1%' 
              OR query_text ILIKE '%F1 %Ferrari%')
              AND query_text NOT ILIKE '%360%' 
              AND query_text NOT ILIKE '%spider%' THEN 3
            WHEN query_text ILIKE '%Panasonic Toyota Racing%' 
              OR query_text ILIKE '%Toyota Racing%'
              OR query_text ILIKE '%Toyota %f1%' 
              OR query_text ILIKE '% F1 %Toyota%' THEN 4
            WHEN query_text ILIKE '%Williams F1 Team%' 
              OR query_text ILIKE '%Williams %F1%' 
              OR query_text ILIKE '%F1 %Williams%' THEN 5
            WHEN query_text ILIKE '%Lucky Strike Honda Racing F1 Team%' 
              OR query_text ILIKE '%Honda Racing F1 Team%'
              OR query_text ILIKE '%Lucky Strike Honda%' 
              OR query_text ILIKE '%Honda %F1%' 
              OR query_text ILIKE '%F1 %Honda%' THEN 6
            WHEN query_text ILIKE '%Red Bull Racing%' 
              OR query_text ILIKE '%Red Bull %F1%'
              OR query_text ILIKE '%F1 %Red Bull%' THEN 7
            WHEN query_text ILIKE '%BMW Sauber F1 Team%' 
              OR query_text ILIKE '%BMW Sauber%' 
              OR query_text ILIKE '%Sauber F1%'
              OR query_text ILIKE '%F1 %Sauber%'
              OR query_text ILIKE '%BMW F1%'
              OR query_text ILIKE '%F1 % BMW%' THEN 8
            WHEN query_text ILIKE '%Spyker MF1 Team%'
              OR query_text ILIKE '%Spyker MF1%'
              OR query_text ILIKE '%Spyker F1 %'
              OR query_text ILIKE '% F1 %Spyker%'
              OR query_text ILIKE '%MF1 Racing%' 
              OR query_text ILIKE '%Midland F1 Racing%'
              OR query_text ILIKE '%Midland F1 %'
              OR query_text ILIKE '%F1 %Midland%'
              OR query_text ILIKE '%Midland % Racing%' THEN 9
            WHEN query_text ILIKE '%Scuderia Toro Rosso%'
              OR query_text ILIKE '%Toro Rosso%'
              OR query_text ILIKE '%F1%Toro Rosso%' 
              OR query_text ILIKE '%Toro Rosso%F1%' THEN 10
            WHEN query_text ILIKE '%Super Aguri Formula 1%' 
              OR query_text ILIKE '%Super Aguri%'
              OR query_text ILIKE '%F1%Aguri%' 
              OR query_text ILIKE '%Aguri%F1%' THEN 11
            ELSE NULL
        END AS t_id
    FROM f1_query
) AS sub ON t.team_id = sub.t_id
GROUP BY t.team_id, t.name

ORDER BY wurde_erwaehnt ASC, t.name ASC;
