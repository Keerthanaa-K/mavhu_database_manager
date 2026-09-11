-- ============================================
-- Banks Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.banks (
    id              SERIAL              PRIMARY KEY,
    name            VARCHAR(255)        NOT NULL,
    country         VARCHAR(255)        NOT NULL,
    email           VARCHAR(255)        NOT NULL UNIQUE,
    phone_number    VARCHAR(255),
    identifier      VARCHAR(255)        NOT NULL,
    created_at      TIMESTAMPTZ         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_deleted      BOOLEAN             NOT NULL DEFAULT FALSE
);


CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS banks_updated_at ON mavhu.banks;

CREATE TRIGGER banks_updated_at
    BEFORE UPDATE ON mavhu.banks
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();