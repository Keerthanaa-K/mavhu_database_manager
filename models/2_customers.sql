-- ============================================
-- Customers Table
-- ============================================

-- Create ENUM type for identifier (PostgreSQL requires this separately)
CREATE TYPE customer_identifier AS ENUM (
    'BANK',
    'AGROBUSINESS'
    -- Add more values later with: ALTER TYPE customer_identifier ADD VALUE 'NEW_VALUE';
);

-- Create the customers table
CREATE TABLE IF NOT EXISTS  mavhu.customers (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(255)        NOT NULL,
    hectares        INTEGER             NOT NULL CHECK (hectares > 0),
    country         VARCHAR(255)        NOT NULL,
    email           VARCHAR(255)        UNIQUE NOT NULL,
    phone_number    VARCHAR(255),
    identifier      customer_identifier NOT NULL,
    created_at      TIMESTAMPTZ         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ         NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS customer_updated_at ON mavhu.customers;

CREATE TRIGGER customer_updated_at
    BEFORE UPDATE ON mavhu.customers
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
