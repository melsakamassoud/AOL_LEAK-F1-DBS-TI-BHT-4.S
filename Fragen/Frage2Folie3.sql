-- Welche Webseiten wurden bei Formel-1-Anfragen angeklickt?
select 
clickurl,
count(*) as site_count
from f1_filtered
group by clickurl
order by site_count desc;
