-- join mit table fahrewr machen...

SELECT 
    CASE 
        -- Fernando Alonso
        WHEN query_text ILIKE '%Fernando Alonso%' THEN 'Fernando Alonso'
        
        -- Giancarlo Fisichella
        WHEN query_text ILIKE '%Fisichella%' THEN 'Giancarlo Fisichella'
        
        -- Kimi Räikkönen
        WHEN query_text ILIKE '%Räikkönen%' 
          OR query_text ILIKE '%Raikkonen%' 
          OR query_text ILIKE '%Kimi R%ikk%nen %' THEN 'Kimi Räikkönen'
        
        -- Juan Pablo Montoya
        WHEN query_text ILIKE '%Juan Pablo Montoya%' 
          OR query_text ILIKE '%Pablo%Montoya%' 
          OR query_text ILIKE '%Juan%Montoya%' THEN 'Juan Pablo Montoya'
        
        -- Michael Schumacher
        WHEN query_text ILIKE '%Michael Schumacher%' 
          OR query_text ILIKE '% M%Schumacher%' THEN 'Michael Schumacher'
        
        -- Ralf Schumacher
        WHEN query_text ILIKE '%Ralf Schumacher%' 
          OR query_text ILIKE '%Ralph Schumacher%' THEN 'Ralf Schumacher'
        
        -- Nico Rosberg
        WHEN query_text ILIKE '%Nico Rosberg%' 
          OR query_text ILIKE '%Niko Rosberg%' THEN 'Nico Rosberg'
        
        -- Jacques Villeneuve
        WHEN query_text ILIKE '%J% Villeneuve%' THEN 'Jacques Villeneuve'
        
        -- Takuma Satō
        WHEN query_text ILIKE '%Satō%' 
          OR query_text ILIKE '%Takuma Sat% %' THEN 'Takuma Satō'
        
        -- Yūji Ide
        WHEN query_text ILIKE '%Yūji Ide%' 
          OR query_text ILIKE '% Y%ji Ide %' THEN 'Yūji Ide'
        
        -- Weitere Fahrer (Alphabetisch/Rest)
        WHEN query_text ILIKE '%Barrichello%' THEN 'Rubens Barrichello'
        WHEN query_text ILIKE '%Christian Klien%' THEN 'Christian Klien'
        WHEN query_text ILIKE '%David Coulthard%' THEN 'David Coulthard'
        WHEN query_text ILIKE '%Doornbos%' THEN 'Robert Doornbos'
        WHEN query_text ILIKE '%Felipe Massa%' THEN 'Felipe Massa'
        WHEN query_text ILIKE '%Heidfeld%' THEN 'Nick Heidfeld'
        WHEN query_text ILIKE '%Jarno Trulli%' THEN 'Jarno Trulli'
        WHEN query_text ILIKE '%Jenson Button%' THEN 'Jenson Button'
        WHEN query_text ILIKE '%Kubica%' THEN 'Robert Kubica'
        WHEN query_text ILIKE '%Mark Webber%' THEN 'Mark Webber'
        WHEN query_text ILIKE '%Montagny%' THEN 'Franck Montagny'
        WHEN query_text ILIKE '%Pedro de la Rosa%' THEN 'Pedro de la Rosa'
        WHEN query_text ILIKE '%ristijan Albers%' THEN 'Christijan Albers'
        WHEN query_text ILIKE '%Sakon Yamamoto%' THEN 'Sakon Yamamoto'
        WHEN query_text ILIKE '%Scott Speed%' THEN 'Scott Speed'
        WHEN query_text ILIKE '%Tiago Monteiro%' THEN 'Tiago Monteiro'
        WHEN query_text ILIKE '% Vita% Liuzzi%' THEN 'Vitantonio Liuzzi'

        ELSE 'Andere / Nicht zugeordnet'
    END AS fahrer,
    COUNT(*) AS anzahl_suchen
FROM f1_query
GROUP BY fahrer
ORDER BY anzahl_suchen DESC;