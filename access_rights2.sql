-- Source - https://stackoverflow.com/a/18193568
-- Posted by sealz, modified by community. See post 'Timeline' for change history
-- Retrieved 2025-12-21, License - CC BY-SA 3.0

GRANT USAGE ON SCHEMA public TO PUBLIC;

GRANT ALL PRIVILEGES
ON ALL TABLES IN SCHEMA public
TO PUBLIC;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO PUBLIC;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres
IN SCHEMA public
GRANT ALL PRIVILEGES
ON TABLES
TO PUBLIC;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres
IN SCHEMA public
GRANT USAGE, SELECT
ON SEQUENCES
TO PUBLIC;

SELECT
    tablename,
    tableowner
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;
