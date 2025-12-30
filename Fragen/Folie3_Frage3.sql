-- Welche Orte wurden mit Formel-1-Rennen in Verbindung gesucht?

SELECT 
    s.streckenname,
    s.ort,
    CASE 
        WHEN COUNT(sub.streckenname) > 0 THEN 'Ja'
        ELSE 'Nein'
    END AS ort_erwaehnt
FROM strecke s
LEFT JOIN (
    SELECT 
        CASE 
            WHEN query_text ILIKE '%Bahrain International Circuit%' 
              OR query_text ILIKE '%Sakhir%' THEN 'Bahrain International Circuit'
              
            WHEN query_text ILIKE '%Sepang International Circuit%' 
              OR query_text ILIKE '%Kuala Lumpur%' THEN 'Sepang International Circuit'
              
            WHEN query_text ILIKE '%Albert Park Circuit%' 
              OR query_text ILIKE '%Melbourne%' THEN 'Albert Park Circuit'
              
            WHEN query_text ILIKE '%Autodromo Enzo e Dino Ferrari%' 
              OR query_text ILIKE '%Imola%' THEN 'Autodromo Enzo e Dino Ferrari'
              
            WHEN query_text ILIKE '%N%rburgring%' 
              OR query_text ILIKE '%N%rburg%' THEN 'Nürburgring'
              
            WHEN query_text ILIKE '%Circuit de Catalunya%' 
              OR query_text ILIKE '%Montmel%' THEN 'Circuit de Catalunya'
              
            WHEN query_text ILIKE '%Circuit de Monaco%' 
              OR query_text ILIKE '%Monte-Carlo%'
			  OR query_text ILIKE '%Monte Carlo%' THEN 'Circuit de Monaco'
              
            WHEN query_text ILIKE '%Silverstone Circuit%' 
              OR query_text ILIKE '%Silverstone%' THEN 'Silverstone Circuit'
              
            WHEN query_text ILIKE '%Circuit Gilles Villeneuve%' 
              OR query_text ILIKE '%Montreal%' THEN 'Circuit Gilles Villeneuve'
              
            WHEN query_text ILIKE '%Indianapolis Motor Speedway%' 
              OR query_text ILIKE '%Speedway%' THEN 'Indianapolis Motor Speedway'
              
            WHEN query_text ILIKE '%Circuit de Nevers Magny-Cours%' 
              OR query_text ILIKE '%Magny-Cours%'
			  OR query_text ILIKE '%Magny Cours%' THEN 'Circuit de Nevers Magny-Cours'
              
            WHEN query_text ILIKE '%Hockenheimring%' 
              OR query_text ILIKE '%Hockenheim%' THEN 'Hockenheimring'
              
            WHEN query_text ILIKE '%Hungaroring%' 
              OR query_text ILIKE '%Mogyor%d%' THEN 'Hungaroring'
              
            WHEN query_text ILIKE '%Istanbul Park%' 
              OR query_text ILIKE '%Istanbul%' THEN 'Istanbul Park'
              
            WHEN query_text ILIKE '%Autodromo Nazionale di Monza%' 
              OR query_text ILIKE '%Monza%' THEN 'Autodromo Nazionale di Monza'
              
            WHEN query_text ILIKE '%Shanghai International Circuit%' 
              OR query_text ILIKE '%Shanghai%' THEN 'Shanghai International Circuit'
              
            WHEN query_text ILIKE '%Suzuka Circuit%' 
              OR query_text ILIKE '%Suzuka%' THEN 'Suzuka Circuit'
              
            WHEN query_text ILIKE '%Aut%dromo Jos% Carlos Pace%' 
              OR query_text ILIKE '%S%o Paulo%' THEN 'Autódromo José Carlos Pace'
              
            ELSE NULL
        END AS streckenname
    FROM f1_query
) AS sub ON s.streckenname = sub.streckenname
GROUP BY s.streckenname, s.ort
ORDER BY ort_erwaehnt ASC, s.streckenname ASC;
