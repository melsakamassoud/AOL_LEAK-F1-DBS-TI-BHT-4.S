DROP TABLE IF EXISTS f1_user CASCADE;
CREATE TABLE f1_user (
    anon_id BIGINT PRIMARY KEY
);

INSERT INTO f1_user (anon_id) select distinct anon_id from f1_query;