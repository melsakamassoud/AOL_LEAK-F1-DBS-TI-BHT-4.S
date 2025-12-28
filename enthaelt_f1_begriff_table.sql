DROP TABLE IF EXISTS enthaelt_f1_begriff CASCADE;
CREATE TABLE enthaelt_f1_begriff (
    query_id BIGINT PRIMARY KEY
);

insert into enthaelt_f1_begriff select query_id from f1_query;

