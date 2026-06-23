-- ============================================
-- Crop Cycles Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.crop_cycles (
    id              SERIAL          PRIMARY KEY,
    customer_id     INTEGER         NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    estate_id       INTEGER         NOT NULL REFERENCES mavhu.estates (id)   ON DELETE RESTRICT ON UPDATE CASCADE,
    user_id         INTEGER         NOT NULL REFERENCES mavhu.users (id)     ON DELETE RESTRICT ON UPDATE CASCADE,
    name            VARCHAR(255)    NOT NULL,
    start_date      TIMESTAMPTZ     NOT NULL,
    end_date        TIMESTAMPTZ     NOT NULL,
    audit_trail     TEXT,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Auto-update updated_at via trigger (UTC)
-- ============================================

DROP TRIGGER IF EXISTS crop_cycles_updated_at ON mavhu.crop_cycles;

CREATE TRIGGER crop_cycles_updated_at
    BEFORE UPDATE ON mavhu.crop_cycles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
