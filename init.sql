-- ============================================
-- PostgreSQL New Database Setup Script
-- ============================================

-- 1. Create a dedicated role/user for the database
CREATE ROLE mavhu_admin WITH
    LOGIN
    PASSWORD 'MAvHU123!'
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    CONNECTION LIMIT 100;

-- 2. Create the database
CREATE DATABASE mavhu_db
    WITH
    OWNER = mavhu_admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = -1;

-- 3. Add a comment/description
COMMENT ON DATABASE mavhu_db IS 'Primary database for MAvHU application';

-- 4. Connect to the new database before running the rest
\c mavhu_db

-- 5. Create a dedicated schema (instead of using public)
CREATE SCHEMA IF NOT EXISTS mavhu AUTHORIZATION mavhu_admin;

-- Set default search path for the user
ALTER ROLE mavhu_admin SET search_path TO mavhu, public;

-- 6. Grant privileges
GRANT CONNECT ON DATABASE mavhu_db TO mavhu_admin;
GRANT USAGE ON SCHEMA mavhu TO mavhu_admin;
GRANT CREATE ON SCHEMA mavhu TO mavhu_admin;

-- Grant on future tables/sequences automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA mavhu
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO mavhu_admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA mavhu
    GRANT USAGE, SELECT ON SEQUENCES TO mavhu_admin;

-- 7. Revoke public schema defaults (security best practice)
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON DATABASE mavhu_db FROM PUBLIC;

-- 8. Enable commonly used extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";    -- UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";     -- Cryptographic functions
CREATE EXTENSION IF NOT EXISTS "pg_trgm";      -- Trigram text search
-- CREATE EXTENSION IF NOT EXISTS "postgis";   -- Geospatial (later if needed)




