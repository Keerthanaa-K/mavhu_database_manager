-- ============================================
-- Estates Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.estates (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(255)    NOT NULL,
    hectares        INTEGER         NOT NULL CHECK (hectares > 0),
    customer_id     INTEGER         NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    country         VARCHAR(255)    NOT NULL,
    email           VARCHAR(255)    UNIQUE NOT NULL,
    phone_number    VARCHAR(255),
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Auto-update updated_at via trigger
-- (reuses the update_updated_at() function already created)
-- ============================================
DROP TRIGGER IF EXISTS estates_updated_at ON mavhu.estates;

CREATE TRIGGER estates_updated_at
    BEFORE UPDATE ON mavhu.estates
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
