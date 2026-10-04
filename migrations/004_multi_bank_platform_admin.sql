-- ============================================
-- Migration 004: Multi-bank ESG platform + MAvHU admin console
--
-- The cbz_* tables were built for a single client (CBZ). This makes them
-- multi-tenant so the MAvHU team can onboard more banks and view each
-- bank's dashboard:
--   * every subsidiary (cbz_entities) belongs to a bank
--   * risk and audit rows can sit at "GROUP" level, so they carry bank_id too
--   * banks get an onboarding status and the dashboard modules they licence
--   * members can be deactivated instead of deleted (audit trail stays intact)
--   * reporting periods can be locked per bank (RFP F19/F38 assurance workflow)
-- ============================================

-- Banks: onboarding status + licensed dashboard modules
ALTER TABLE mavhu.banks
    ADD COLUMN IF NOT EXISTS status  VARCHAR(20) NOT NULL DEFAULT 'active',
    ADD COLUMN IF NOT EXISTS modules TEXT[]      NOT NULL DEFAULT ARRAY[
        'snapshot', 'portfolio', 'insurance', 'risk', 'predictive',
        'workflow', 'entity', 'data-entry', 'members'
    ];

ALTER TABLE mavhu.banks DROP CONSTRAINT IF EXISTS banks_status_check;
ALTER TABLE mavhu.banks
    ADD CONSTRAINT banks_status_check CHECK (status IN ('onboarding', 'active', 'suspended'));

-- CBZ was the only tenant before this migration; make sure its bank row exists.
INSERT INTO mavhu.banks (name, country, email, identifier)
SELECT 'CBZ Bank Limited', 'Zimbabwe', 'contact@cbz.co.zw', 'CBZ-ZW-001'
WHERE NOT EXISTS (SELECT 1 FROM mavhu.banks WHERE identifier = 'CBZ-ZW-001');

-- Subsidiaries belong to a bank
ALTER TABLE mavhu.cbz_entities
    ADD COLUMN IF NOT EXISTS bank_id INTEGER REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE;

UPDATE mavhu.cbz_entities
SET bank_id = (SELECT id FROM mavhu.banks WHERE identifier = 'CBZ-ZW-001')
WHERE bank_id IS NULL;

ALTER TABLE mavhu.cbz_entities ALTER COLUMN bank_id SET NOT NULL;
CREATE INDEX IF NOT EXISTS idx_cbz_entities_bank_id ON mavhu.cbz_entities (bank_id);

-- Risk entries and audit rows can be linked to 'GROUP', so they carry the bank directly
ALTER TABLE mavhu.cbz_risk_entries
    ADD COLUMN IF NOT EXISTS bank_id INTEGER REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE;
UPDATE mavhu.cbz_risk_entries
SET bank_id = (SELECT id FROM mavhu.banks WHERE identifier = 'CBZ-ZW-001')
WHERE bank_id IS NULL;
CREATE INDEX IF NOT EXISTS idx_cbz_risk_entries_bank_id ON mavhu.cbz_risk_entries (bank_id);

ALTER TABLE mavhu.cbz_audit_log
    ADD COLUMN IF NOT EXISTS bank_id INTEGER REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE;
UPDATE mavhu.cbz_audit_log
SET bank_id = (SELECT id FROM mavhu.banks WHERE identifier = 'CBZ-ZW-001')
WHERE bank_id IS NULL;
CREATE INDEX IF NOT EXISTS idx_cbz_audit_log_bank_id ON mavhu.cbz_audit_log (bank_id);

-- Members: deactivate rather than delete
ALTER TABLE mavhu.cbz_members
    ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE;

-- Reporting periods: a locked period rejects new or advanced emission records
CREATE TABLE IF NOT EXISTS mavhu.cbz_reporting_periods (
    id          SERIAL          PRIMARY KEY,
    bank_id     INTEGER         NOT NULL REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    period      VARCHAR(20)     NOT NULL,
    status      VARCHAR(10)     NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'locked')),
    locked_by   VARCHAR(255),
    locked_at   TIMESTAMPTZ,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_cbz_reporting_period UNIQUE (bank_id, period)
);
DROP TRIGGER IF EXISTS cbz_reporting_periods_updated_at ON mavhu.cbz_reporting_periods;
CREATE TRIGGER cbz_reporting_periods_updated_at BEFORE UPDATE ON mavhu.cbz_reporting_periods FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Reference columns narrower than the ids they point at: the API generates 36-char UUIDs, so
-- adding a loan for a new borrower, putting a member in a new department, or a member created
-- in the app submitting/approving emissions all failed with "value too long".
ALTER TABLE mavhu.cbz_financed_positions ALTER COLUMN counterparty_id TYPE VARCHAR(40);
ALTER TABLE mavhu.cbz_members            ALTER COLUMN department_id   TYPE VARCHAR(40);
ALTER TABLE mavhu.cbz_esg_emissions      ALTER COLUMN submitted_by    TYPE VARCHAR(40);
ALTER TABLE mavhu.cbz_esg_emissions      ALTER COLUMN approved_by     TYPE VARCHAR(40);
