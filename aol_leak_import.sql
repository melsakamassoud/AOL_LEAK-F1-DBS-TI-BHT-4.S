DROP TABLE IF EXISTS aol_leak;
CREATE TABLE aol_leak (
    id        BIGSERIAL PRIMARY KEY,
    anon_id   INTEGER NOT NULL,
    query     TEXT NOT NULL,
    querytime TIMESTAMP NOT NULL,
    itemrank INTEGER,
    clickurl TEXT
);

COPY aol_leak (anon_id, query, querytime, itemrank, clickurl)
FROM 'C:\\Users\\Mustafa M\\source\\repos\\TI-BHT-4.S\\Datenbanksysteme\\AOL_search_data_leak_2006\\AOL-user-ct-collection\\aol_leak_test.txt'
WITH (
    FORMAT csv,
    DELIMITER E'\t',
    HEADER true,
    NULL ''
);
