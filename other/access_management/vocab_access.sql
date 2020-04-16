-- Give all current and future users SELECT rights on all current and future tables in the vocab schema
-- This needs to be executed only once
GRANT USAGE ON SCHEMA vocab TO PUBLIC;
GRANT SELECT ON ALL TABLES IN SCHEMA vocab TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA vocab GRANT SELECT ON TABLES TO PUBLIC;

