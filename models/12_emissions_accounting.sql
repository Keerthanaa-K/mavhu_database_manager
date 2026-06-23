-- ============================================
-- Emissions Accounting Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.emissions_accounting (
    id              SERIAL          PRIMARY KEY,
    customer_id     INTEGER         NOT NULL REFERENCES mavhu.customers (id)        ON DELETE RESTRICT ON UPDATE CASCADE,
    estate_id       INTEGER         NOT NULL REFERENCES mavhu.estates (id)          ON DELETE RESTRICT ON UPDATE CASCADE,
    user_id         INTEGER         NOT NULL REFERENCES mavhu.users (id)            ON DELETE RESTRICT ON UPDATE CASCADE,
    crop_cycle_id   INTEGER         NOT NULL REFERENCES mavhu.crop_cycles (id)      ON DELETE RESTRICT ON UPDATE CASCADE,
    emission_id     INTEGER         NOT NULL REFERENCES mavhu.emission_factors (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    quantity        DECIMAL(10,4)   NOT NULL,
    start_date      TIMESTAMPTZ     NOT NULL,
    end_date        TIMESTAMPTZ     NOT NULL,
    ton_co2e        DECIMAL(10,4),  -- quantity * emission_factors.factor / 1000
    scope           INTEGER         NOT NULL CHECK (scope BETWEEN 1 AND 3),
    audit_trail     TEXT,
    note            TEXT,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS emissions_accounting_updated_at ON mavhu.emissions_accounting;

CREATE TRIGGER emissions_accounting_updated_at
    BEFORE UPDATE ON mavhu.emissions_accounting
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();