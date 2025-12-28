DROP TABLE IF EXISTS f1_filtered;
CREATE TABLE f1_filtered as
SELECT *
FROM aol_leak
WHERE (
      -- Strong F1-only keywords (safe)
      QUERY ILIKE '%f1%'
   OR QUERY ILIKE '% GP %'
   OR QUERY ILIKE '%rennen%'
   OR QUERY ILIKE '%pitstop%'
   OR QUERY ILIKE '%formel 1%'
   OR QUERY ILIKE '%formula 1%'
   OR QUERY ILIKE '%formula1%'
   OR QUERY ILIKE '%formula one%'
   OR QUERY ILIKE '%drs zone%'
   OR QUERY ILIKE '%pit stop%'
   OR QUERY ILIKE '%formation lap%'
   OR QUERY ILIKE '%safety car%'
   OR QUERY ILIKE '%f1 podium%'
   OR QUERY ILIKE '%fastest lap%'
   OR QUERY ILIKE '%silverstone circuit%'
   OR QUERY ILIKE '%monaco grand prix%'
---------- Neu: Teams und Fahrer:
-- Renault
   OR QUERY ILIKE '%Mild Seven Renault F1 Team%' 
   OR QUERY ILIKE '%Renault%F1%Team%' 
   OR QUERY ILIKE '%F1%Renault%Team%'
   OR QUERY ILIKE '%Renault F1%' 
   OR QUERY ILIKE '%F1 %Renault%'
   OR QUERY ILIKE '%Mild Seven%'
   
   -- McLaren
   OR QUERY ILIKE '%Team McLaren Mercedes%' 
   OR QUERY ILIKE '%McLaren Mercedes%'
   OR QUERY ILIKE '%McLaren Mercedes%F1%' 
   OR QUERY ILIKE '%F1 %McLaren Mercedes%'
   
   -- Ferrari (inkl. Ausschlüsse)
   OR (QUERY ILIKE '%Scuderia Ferrari Marlboro%' 
       OR QUERY ILIKE '%Ferrari Marlboro%'
       OR QUERY ILIKE '%Ferrari% F1%' 
       OR QUERY ILIKE '%F1 %Ferrari%')
       AND NOT QUERY ILIKE '%360%' 
       AND NOT QUERY ILIKE '%spider%'
   
   -- Toyota
   OR QUERY ILIKE '%Panasonic Toyota Racing%' 
   OR QUERY ILIKE '%Toyota Racing%'
   OR QUERY ILIKE '%Toyota %f1%' 
   OR QUERY ILIKE '% F1 %Toyota%'
   
   -- Williams
   OR QUERY ILIKE '%Williams F1 Team%' 
   OR QUERY ILIKE '%Williams %F1%' 
   OR QUERY ILIKE '%F1 %Williams%'
   
   -- Honda
   OR QUERY ILIKE '%Lucky Strike Honda Racing F1 Team%' 
   OR QUERY ILIKE '%Honda Racing F1 Team%'
   OR QUERY ILIKE '%Lucky Strike Honda%' 
   OR QUERY ILIKE '%Honda %F1%' 
   OR QUERY ILIKE '%F1 %Honda%'
   
   -- Red Bull
   OR QUERY ILIKE '%Red Bull Racing%' 
   OR QUERY ILIKE '%Red Bull %F1%'
   OR QUERY ILIKE '%F1 %Red Bull%'
   
   -- BMW Sauber
   OR QUERY ILIKE '%BMW Sauber F1 Team%' 
   OR QUERY ILIKE '%BMW Sauber%' 
   OR QUERY ILIKE '%Sauber F1%'
   OR QUERY ILIKE '%F1 %Sauber%'
   OR QUERY ILIKE '%BMW F1%'
   OR QUERY ILIKE '%F1 % BMW%'
   
   -- Spyker
   OR QUERY ILIKE '%Spyker MF1 Team%'
   OR QUERY ILIKE '%Spyker MF1%'
   OR QUERY ILIKE '%Spyker F1 %'
   OR QUERY ILIKE '% F1 %Spyker%'
   
   -- Midland / MF1
   OR QUERY ILIKE '%MF1 Racing%' 
   OR QUERY ILIKE '%Midland F1 Racing%'
   OR QUERY ILIKE '%Midland F1 %'
   OR QUERY ILIKE '%F1 %Midland%'
   OR QUERY ILIKE '%Midland % Racing%'
   
   -- Toro Rosso
   OR QUERY ILIKE '%Scuderia Toro Rosso%'
   OR QUERY ILIKE '%Toro Rosso%'
   OR QUERY ILIKE '%F1%Toro Rosso%' 
   OR QUERY ILIKE '%Toro Rosso%F1%'
   
   -- Super Aguri
   OR QUERY ILIKE '%Super Aguri Formula 1%' 
   OR QUERY ILIKE '%Super Aguri%'
   OR QUERY ILIKE '%F1%Aguri%' 
   OR QUERY ILIKE '%Aguri%F1%'

-- Fernando Alonso
   OR QUERY ILIKE '%Fernando Alonso%'
   
   -- Giancarlo Fisichella
   OR QUERY ILIKE '%Fisichella%'
   
   -- Kimi Räikkönen
   OR QUERY ILIKE '%Räikkönen%'
   OR QUERY ILIKE '%Raikkonen%'
   OR QUERY ILIKE '%Kimi R%ikk%nen %'
   
   -- Juan Pablo Montoya
   OR QUERY ILIKE '%Juan Pablo Montoya%'
   OR QUERY ILIKE '%Pablo%Montoya%'
   OR QUERY ILIKE '%Juan%Montoya%'
   
   -- Pedro de la Rosa
   OR QUERY ILIKE '%Pedro de la Rosa%'
   
   -- Michael Schumacher
   OR QUERY ILIKE '%Michael Schumacher%'
   OR QUERY ILIKE '% M%Schumacher%'
   
   -- Felipe Massa
   OR QUERY ILIKE '%Felipe Massa%'
   
   -- Ralf Schumacher
   OR QUERY ILIKE '%Ralf Schumacher%'
   OR QUERY ILIKE '%Ralph Schumacher%'
   
   -- Jarno Trulli
   OR QUERY ILIKE '%Jarno Trulli%'
   
   -- Mark Webber
   OR QUERY ILIKE '%Mark Webber%'
   
   -- Nico Rosberg
   OR QUERY ILIKE '%Nico Rosberg%'
   OR QUERY ILIKE '%Niko Rosberg%'
   
   -- Rubens Barrichello
   OR QUERY ILIKE '%Barrichello%'
   
   -- Jenson Button
   OR QUERY ILIKE '%Jenson Button%'
   
   -- David Coulthard
   OR QUERY ILIKE '%David Coulthard%'
   
   -- Christian Klien
   OR QUERY ILIKE '%Christian Klien%'
   
   -- Robert Doornbos
   OR QUERY ILIKE '%Doornbos%'
   
   -- Nick Heidfeld
   OR QUERY ILIKE '%Heidfeld%'
   
   -- Jacques Villeneuve
   OR QUERY ILIKE '%J% Villeneuve%'
   
   -- Robert Kubica
   OR QUERY ILIKE '%Kubica%'
   
   -- Tiago Monteiro
   OR QUERY ILIKE '%Tiago Monteiro%'
   
   -- Christijan Albers
   OR QUERY ILIKE '%ristijan Albers%'
   
   -- Vitantonio Liuzzi
   OR QUERY ILIKE '% Vita% Liuzzi%'
   
   -- Scott Speed
   OR QUERY ILIKE '%Scott Speed%'
   
   -- Takuma Satō
   OR QUERY ILIKE '%Satō%'
   OR QUERY ILIKE '%Takuma Sat% %'
   
   -- Yūji Ide
   OR QUERY ILIKE '%Yūji Ide%'
   OR QUERY ILIKE '% Y%ji Ide %'
   
   -- Franck Montagny
   OR QUERY ILIKE '%Montagny%'
   
   -- Sakon Yamamoto
   OR QUERY ILIKE '%Sakon Yamamoto%'

----------

      -- F1-related websites
   OR CLICKURL LIKE 'http://www.formula1.com%'
   OR CLICKURL LIKE 'http://f1.racing-live.com%'
   OR CLICKURL LIKE 'http://www.f1-racing.org%'
   OR CLICKURL LIKE 'http://rc-racing.org.uk%'
   OR CLICKURL LIKE 'http://www.formula1-rc.com%'
   OR CLICKURL LIKE 'http://www.itv-f1.com%'
   OR CLICKURL LIKE 'http://www.mytsn.com%'
   OR CLICKURL LIKE 'http://www.planetf1.com%'
   OR CLICKURL LIKE 'http://formula1.about.com%'
   OR CLICKURL LIKE 'http://www.f1nutter.co.uk%'
   OR CLICKURL LIKE 'http://www.f1m.com%'
   OR CLICKURL LIKE 'http://www.f1-sales.com%'
   OR CLICKURL LIKE 'http://cars.grandprix.com.au%'
   OR CLICKURL LIKE 'http://www.7extrememotorsports.com%'
   OR CLICKURL LIKE 'http://www.f1racefactory.com%'
   OR CLICKURL LIKE 'http://www.na-motorsports.com%'
   OR CLICKURL LIKE 'http://www.f1racing.net%'

      -- Ambiguous terms only when paired with F1 context
   OR (
        QUERY ILIKE '%grand prix%'
        AND (
              QUERY ILIKE '%formula%'
           OR QUERY ILIKE '%f1%'
           OR QUERY ILIKE '%circuit%'
           OR QUERY ILIKE '%race%'   
		   OR QUERY ILIKE '%Bahrain%'
		   OR QUERY ILIKE '%Malaysia%'
		   OR QUERY ILIKE '%Australia%'
		   OR QUERY ILIKE '%Imola%'
		   OR QUERY ILIKE '%NÃ¼rburg%'
		   OR QUERY ILIKE '%Spain%'
		   OR QUERY ILIKE '%Monaco%'
		)
      )
)

-- Exclusions apply to all matches
AND QUERY NOT ILIKE '%pontiac%'
AND QUERY NOT ILIKE '%f150%'
AND QUERY NOT ILIKE '%ford%'
AND QUERY NOT ILIKE '%guitar%'
AND QUERY NOT ILIKE '%truck%'
AND QUERY NOT ILIKE '%jet%'
AND QUERY NOT ILIKE '%plane%'
AND QUERY NOT ILIKE '%tractor%'
AND QUERY NOT ILIKE '%tomcat%'
AND QUERY NOT ILIKE '%19%'           -- excludes F-19 / jets
AND QUERY NOT ILIKE '%sanus ff1%'
AND QUERY NOT ILIKE '%99%'
AND QUERY NOT ILIKE '%extingusher%'
AND QUERY NOT ILIKE '%canon%'
AND QUERY NOT ILIKE '%fujifilm%'
AND QUERY NOT ILIKE '%runnning%'
-- Neu: aus Fahrer und Teams:
AND QUERY NOT ILIKE '%spider%'
AND QUERY NOT ILIKE '%360%'

-- URL Exclusions
AND CLICKURL NOT ILIKE '%military%'
AND CLICKURL NOT ILIKE '%navy%'
AND CLICKURL NOT ILIKE '%alibaba%'
AND CLICKURL NOT ILIKE '%amazon%'
AND CLICKURL NOT ILIKE '%shop%'
AND CLICKURL NOT ILIKE '%golf%'
AND CLICKURL NOT ILIKE '%plane%'
AND CLICKURL NOT ILIKE '%fujifilm%'
AND CLICKURL NOT ILIKE '%ebay%';

