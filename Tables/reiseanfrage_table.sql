CREATE TABLE Reiseanfrage (
    ReiseanfragenID BIGSERIAL PRIMARY KEY,
    TimeStamp       TIMESTAMP,
    Reise_Ziel      TEXT,
    Ankunftsdatum   DATE,
    Anon_ID BIGINT REFERENCES "user"(anon_id),
    Query_ID        BIGINT REFERENCES Query(Query_ID)
);


INSERT INTO Reiseanfrage (TimeStamp, Anon_ID, Query_ID, Reise_Ziel, Ankunftsdatum)
SELECT
    q.TimeStamp,
    q.Anon_ID,
    q.Query_ID,
    q.Query_Text AS Reise_Ziel,
    (q.TimeStamp::DATE + INTERVAL '7 days')::DATE AS Ankunftsdatum
FROM Query q
WHERE
(
       q.Query_Text ILIKE '%bahrain%'
    OR q.Query_Text ILIKE '%sakhir%'
    OR q.Query_Text ILIKE '%malaysia%'
    OR q.Query_Text ILIKE '%sepang%'
    OR q.Query_Text ILIKE '%australia%'
    OR q.Query_Text ILIKE '%melbourne%'
    OR q.Query_Text ILIKE '%germany%'
    OR q.Query_Text ILIKE '%hockenheim%'
    OR q.Query_Text ILIKE '%san marino%'
    OR q.Query_Text ILIKE '%imola%'
    OR q.Query_Text ILIKE '%spain%'
    OR q.Query_Text ILIKE '%barcelona%'
    OR q.Query_Text ILIKE '%catalunya%'
    OR q.Query_Text ILIKE '%monaco%'
    OR q.Query_Text ILIKE '%silverstone%'
    OR q.Query_Text ILIKE '%britain%'
    OR q.Query_Text ILIKE '%england%'
    OR q.Query_Text ILIKE '%canada%'
    OR q.Query_Text ILIKE '%montreal%'
    OR q.Query_Text ILIKE '%usa%'
    OR q.Query_Text ILIKE '%indianapolis%'
    OR q.Query_Text ILIKE '%france%'
    OR q.Query_Text ILIKE '%magny%'
    OR q.Query_Text ILIKE '%nürburgring%'
    OR q.Query_Text ILIKE '%nurburg%'
    OR q.Query_Text ILIKE '%hungary%'
    OR q.Query_Text ILIKE '%budapest%'
    OR q.Query_Text ILIKE '%turkey%'
    OR q.Query_Text ILIKE '%istanbul%'
    OR q.Query_Text ILIKE '%italy%'
    OR q.Query_Text ILIKE '%monza%'
    OR q.Query_Text ILIKE '%china%'
    OR q.Query_Text ILIKE '%shanghai%'
    OR q.Query_Text ILIKE '%japan%'
    OR q.Query_Text ILIKE '%suzuka%'
    OR q.Query_Text ILIKE '%brazil%'
    OR q.Query_Text ILIKE '%interlagos%'
    OR q.Query_Text ILIKE '%hotel%'
    OR q.Query_Text ILIKE '% hotel %'
    OR q.Query_Text ILIKE '%hostel%'
    OR q.Query_Text ILIKE '%unterkunft%'
    OR q.Query_Text ILIKE '%übernachtung%'
    OR q.Query_Text ILIKE '%apartment%'
    OR q.Query_Text ILIKE '%airbnb%'
    OR q.Query_Text ILIKE '%zimmer%'
    OR q.Query_Text ILIKE '%flug%'
    OR q.Query_Text ILIKE '%flight%'
    OR q.Query_Text ILIKE '% travel %'
    OR q.Query_Text ILIKE '%travel%'
    OR q.Query_Text ILIKE '%reise%'
    OR q.Query_Text ILIKE '%trip%'
    OR q.Query_Text ILIKE '%ticket%'
    OR q.Query_Text ILIKE '%tickets%'
    OR q.Query_Text ILIKE '%grand prix ticket%'
    OR q.Query_Text ILIKE '%f1 ticket%'
);