SELECT 
    f.fahrer_id,
    f.name AS fahrer_name,
    t.name AS team_name,
    COUNT(sub.f_id) AS anzahl_suchen -- Zählt nur die tatsächlichen Treffer
FROM fahrer f
JOIN team t ON f.team_id = t.team_id
LEFT JOIN (
    SELECT 
        CASE 
            WHEN query_text ILIKE '%Fernando Alonso%'       THEN 2
            WHEN query_text ILIKE '%Fisichella%'            THEN 1
            WHEN query_text ILIKE '%Räikkönen%' 
              OR query_text ILIKE '%Raikkonen%' 
              OR query_text ILIKE '%Kimi R%ikk%nen %'       THEN 5
            WHEN query_text ILIKE '%Juan Pablo Montoya%'
              OR query_text ILIKE '%Pablo%Montoya%'  
              OR query_text ILIKE '%Juan%Montoya%'          THEN 4
            WHEN query_text ILIKE '%Pedro de la Rosa%'      THEN 3
            WHEN query_text ILIKE '%Michael Schumacher%' 
              OR query_text ILIKE '% M%Schumacher%'         THEN 7
            WHEN query_text ILIKE '%Felipe Massa%'          THEN 6
            WHEN query_text ILIKE '%Ralf Schumacher%' 
              OR query_text ILIKE '%Ralph Schumacher%'      THEN 9
            WHEN query_text ILIKE '%Jarno Trulli%'          THEN 8
            WHEN query_text ILIKE '%Mark Webber%'           THEN 11
            WHEN query_text ILIKE '%Nico Rosberg%' 
              OR query_text ILIKE '%Niko Rosberg%'          THEN 10
            WHEN query_text ILIKE '%Barrichello%'           THEN 13
            WHEN query_text ILIKE '%Jenson Button%'         THEN 12
            WHEN query_text ILIKE '%David Coulthard%'       THEN 16
            WHEN query_text ILIKE '%Christian Klien%'       THEN 15
            WHEN query_text ILIKE '%Doornbos%'              THEN 14
            WHEN query_text ILIKE '%Heidfeld%'              THEN 19
            WHEN query_text ILIKE '%J% Villeneuve%'         THEN 18
            WHEN query_text ILIKE '%Kubica%'                THEN 17
            WHEN query_text ILIKE '%Tiago Monteiro%'         THEN 21
            WHEN query_text ILIKE '%ristijan Albers%'       THEN 20
            WHEN query_text ILIKE '% Vita% Liuzzi%'         THEN 23
            WHEN query_text ILIKE '%Scott Speed%'           THEN 22
            WHEN query_text ILIKE '%Satō%' 
              OR query_text ILIKE '%Takuma Sat% %'          THEN 27
            WHEN query_text ILIKE '%Yūji Ide%' 
              OR query_text ILIKE '% Y%ji Ide %'            THEN 26
            WHEN query_text ILIKE '%Montagny%'              THEN 25
            WHEN query_text ILIKE '%Sakon Yamamoto%'        THEN 24
            ELSE NULL
        END AS f_id
    FROM f1_query
) AS sub ON f.fahrer_id = sub.f_id
GROUP BY f.fahrer_id, f.name, t.name
ORDER BY anzahl_suchen DESC, f.name ASC;