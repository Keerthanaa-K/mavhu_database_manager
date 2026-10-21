-- ============================================
-- Migration 006: RFP readiness features
--
-- Schema
--   * Tamper-evident audit trail (F18): sequence, SHA-256 hash chain, before/after values,
--     and a trigger that makes the log append-only.
--   * Evidence repository (F38): files stored with their SHA-256, linked to any record.
--   * Published disclosures (F44/F45): immutable, hashed snapshots built from approved data.
--   * Registers (F21, F23-F26, F31, F34-F36, F40): one table, validated per register by the API.
--   * Sustainable-finance taxonomy tags on counterparties (F22/F33) and a link from a
--     borrower to its MAvHU MRV customer (A3-A6).
--   * Review notes on emissions (rejections in the F19 workflow).
--   * Agri field verification (A2).
--   * New dashboard modules licensed to every existing bank.
-- Demo data (ALL SYNTHETIC; at least 2 rows of everything for every bank)
--   * Monthly operational emissions from Jan 2024 (P13 backfill; real series for F28/F47),
--     with 2024 locked for assurance.
--   * Register entries, taxonomy tags, MRV-linked agri borrowers per bank.
--   * Agri MRV: emission factors, monthly satellite NDVI/carbon series, crop cycles,
--     emissions accounting and field visits for all four estates; agri users per customer.
--   * Two MAvHU platform auditors; bank-portal accounts for CBZ staff who only had
--     platform logins.
-- Safe to re-run.
-- ============================================

-- ── Audit trail: hash chain + before/after + append-only ─────────────────────
ALTER TABLE mavhu.cbz_audit_log
    ADD COLUMN IF NOT EXISTS seq       BIGSERIAL,
    ADD COLUMN IF NOT EXISTS before    JSONB,
    ADD COLUMN IF NOT EXISTS after     JSONB,
    ADD COLUMN IF NOT EXISTS prev_hash VARCHAR(64),
    ADD COLUMN IF NOT EXISTS hash      VARCHAR(64);
CREATE UNIQUE INDEX IF NOT EXISTS uq_cbz_audit_log_seq ON mavhu.cbz_audit_log (seq);

-- Rows are never edited or deleted. The only permitted update is the API sealing a row that
-- has no hash yet (rows written before this migration are sealed once, in order).
CREATE OR REPLACE FUNCTION mavhu.cbz_audit_log_append_only() RETURNS trigger AS $fn$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'cbz_audit_log is append-only: rows cannot be deleted';
    END IF;
    IF OLD.hash IS NULL AND NEW.hash IS NOT NULL
       AND (NEW.id, NEW.timestamp, NEW.actor, NEW.action, NEW.entity_code, NEW.target_type, NEW.target_id, NEW.detail, NEW.bank_id)
           IS NOT DISTINCT FROM
           (OLD.id, OLD.timestamp, OLD.actor, OLD.action, OLD.entity_code, OLD.target_type, OLD.target_id, OLD.detail, OLD.bank_id)
       AND NEW.before IS NOT DISTINCT FROM OLD.before
       AND NEW.after IS NOT DISTINCT FROM OLD.after THEN
        RETURN NEW;
    END IF;
    RAISE EXCEPTION 'cbz_audit_log is append-only: rows cannot be changed';
END;
$fn$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS cbz_audit_log_append_only ON mavhu.cbz_audit_log;
CREATE TRIGGER cbz_audit_log_append_only BEFORE UPDATE OR DELETE ON mavhu.cbz_audit_log
    FOR EACH ROW EXECUTE FUNCTION mavhu.cbz_audit_log_append_only();

-- ── Evidence repository ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS mavhu.cbz_evidence (
    id            VARCHAR(40)   PRIMARY KEY,
    bank_id       INTEGER       NOT NULL REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    entity_code   VARCHAR(20)   REFERENCES mavhu.cbz_entities (code),
    target_type   VARCHAR(40)   NOT NULL,
    target_id     VARCHAR(60),
    file_name     VARCHAR(255)  NOT NULL,
    mime_type     VARCHAR(120)  NOT NULL,
    size_bytes    INTEGER       NOT NULL,
    sha256        VARCHAR(64)   NOT NULL,
    content       BYTEA         NOT NULL,
    description   TEXT          NOT NULL DEFAULT '',
    uploaded_by   VARCHAR(255)  NOT NULL,
    uploaded_at   TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_cbz_evidence_target ON mavhu.cbz_evidence (bank_id, target_type, target_id);

-- ── Published disclosures ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS mavhu.cbz_disclosures (
    id            VARCHAR(40)   PRIMARY KEY,
    bank_id       INTEGER       NOT NULL REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    framework     VARCHAR(40)   NOT NULL,
    period        VARCHAR(20)   NOT NULL,
    version       INTEGER       NOT NULL,
    title         VARCHAR(255)  NOT NULL,
    snapshot      JSONB         NOT NULL,
    hash          VARCHAR(64)   NOT NULL,
    published_by  VARCHAR(255)  NOT NULL,
    published_at  TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_cbz_disclosure_version UNIQUE (bank_id, framework, period, version)
);

CREATE OR REPLACE FUNCTION mavhu.cbz_disclosures_immutable() RETURNS trigger AS $fn$
BEGIN
    RAISE EXCEPTION 'Published disclosures are immutable; publish a new version instead';
END;
$fn$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS cbz_disclosures_immutable ON mavhu.cbz_disclosures;
CREATE TRIGGER cbz_disclosures_immutable BEFORE UPDATE OR DELETE ON mavhu.cbz_disclosures
    FOR EACH ROW EXECUTE FUNCTION mavhu.cbz_disclosures_immutable();

-- ── Registers ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS mavhu.cbz_register_items (
    id            VARCHAR(40)   PRIMARY KEY,
    bank_id       INTEGER       NOT NULL REFERENCES mavhu.banks (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    register      VARCHAR(40)   NOT NULL,
    entity_code   VARCHAR(20),
    data          JSONB         NOT NULL,
    created_by    VARCHAR(255)  NOT NULL,
    updated_by    VARCHAR(255),
    created_at    TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_cbz_register_items_bank ON mavhu.cbz_register_items (bank_id, register);
DROP TRIGGER IF EXISTS cbz_register_items_updated_at ON mavhu.cbz_register_items;
CREATE TRIGGER cbz_register_items_updated_at BEFORE UPDATE ON mavhu.cbz_register_items FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ── Counterparties: taxonomy tags + MRV customer link; emissions: review note ─
ALTER TABLE mavhu.cbz_counterparties
    ADD COLUMN IF NOT EXISTS taxonomy          VARCHAR(40),
    ADD COLUMN IF NOT EXISTS taxonomy_category VARCHAR(120),
    ADD COLUMN IF NOT EXISTS taxonomy_status   VARCHAR(20),
    ADD COLUMN IF NOT EXISTS customer_id       INTEGER REFERENCES mavhu.customers (id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE mavhu.cbz_esg_emissions ADD COLUMN IF NOT EXISTS review_note TEXT;

-- ── Agri field verification ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS mavhu.agri_field_verifications (
    id              SERIAL        PRIMARY KEY,
    customer_id     INTEGER       NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    estate_id       INTEGER       NOT NULL REFERENCES mavhu.estates (id)   ON DELETE RESTRICT ON UPDATE CASCADE,
    visit_date      DATE          NOT NULL,
    officer         VARCHAR(255)  NOT NULL,
    method          VARCHAR(100)  NOT NULL,
    findings        TEXT          NOT NULL,
    ndvi_confirmed  BOOLEAN       NOT NULL DEFAULT TRUE,
    status          VARCHAR(20)   NOT NULL DEFAULT 'Submitted' CHECK (status IN ('Submitted', 'Verified', 'Disputed')),
    created_by      INTEGER       REFERENCES mavhu.users (id) ON DELETE SET NULL ON UPDATE CASCADE,
    created_at      TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ   NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS agri_field_verifications_updated_at ON mavhu.agri_field_verifications;
CREATE TRIGGER agri_field_verifications_updated_at BEFORE UPDATE ON mavhu.agri_field_verifications FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ── New dashboard modules for every bank ─────────────────────────────────────
UPDATE mavhu.banks b
SET modules = (
    SELECT array_agg(DISTINCT m ORDER BY m) FROM unnest(b.modules || ARRAY[
        'sustainable-finance', 'scenarios', 'appetite', 'targets', 'decarbonisation', 'environment',
        'social', 'materiality', 'stakeholders', 'suppliers', 'data-ownership', 'disclosures', 'evidence'
    ]) AS m
);
ALTER TABLE mavhu.banks ALTER COLUMN modules SET DEFAULT ARRAY[
    'snapshot', 'portfolio', 'insurance', 'risk', 'predictive', 'workflow', 'entity', 'data-entry', 'members',
    'sustainable-finance', 'scenarios', 'appetite', 'targets', 'decarbonisation', 'environment',
    'social', 'materiality', 'stakeholders', 'suppliers', 'data-ownership', 'disclosures', 'evidence'
];

-- =============================================================================
-- DEMO DATA (synthetic)
-- =============================================================================

-- Per-bank seed context: two subsidiaries and the members used as submitter / approver.
DROP TABLE IF EXISTS pg_temp.seed_banks;
CREATE TEMP TABLE seed_banks AS
SELECT * FROM (VALUES
    ('CBZ-ZW-001',     'CBZ', 'CBZBANK',  'CBZAGRO',  'USR-CONTRIB-BANK', 'USR-APPROVER-BANK', 'Tafara Chikwanha',  1.00),
    ('STANBIC-ZW-001', 'STB', 'STANBANK', 'STANWLTH', 'STB-USR-3',        'STB-USR-2',         'Rumbidzai Ndlovu',  0.80),
    ('FBC-ZW-001',     'FBB', 'FBCBANK',  'FBCINS',   'FBB-USR-3',        'FBB-USR-2',         'Tsitsi Chinoda',    0.65)
) AS v(identifier, prefix, e1, e2, contributor, approver, approver_name, scale);
ALTER TABLE seed_banks ADD COLUMN bank_id INTEGER;
UPDATE seed_banks s SET bank_id = b.id FROM mavhu.banks b WHERE b.identifier = s.identifier;
DELETE FROM seed_banks WHERE bank_id IS NULL;

-- ── Monthly emissions history, Jan 2024 – Jul 2026 ───────────────────────────
INSERT INTO mavhu.cbz_esg_emissions (
    id, entity_code, site, period, scope, dataset_type, fuel_type, activity_data, unit,
    emission_factor_kg_per_unit, emissions_kg_co2e, emissions_tco2e, method, data_quality,
    status, source_ref, submitted_by, submitted_at, approved_by, approved_at
)
SELECT
    s.prefix || '-H-' || x.ent || '-' || x.ds || '-' || to_char(m.month, 'YYYYMM'),
    x.code,
    x.site,
    to_char(m.month, 'YYYY-MM'),
    x.scope,
    x.dataset_type,
    x.fuel_type,
    round(a.activity, 2),
    x.unit,
    x.ef,
    round(a.activity * x.ef, 4),
    round(a.activity * x.ef / 1000, 6),
    'activity-based',
    2,
    CASE WHEN m.month < DATE '2025-01-01' THEN 'locked' ELSE 'approved' END,
    x.code || '_' || upper(x.scope) || '_HISTORY_' || to_char(m.month, 'YYYY-MM') || '_v1.csv',
    s.contributor,
    m.month + INTERVAL '35 days',
    s.approver,
    m.month + INTERVAL '40 days'
FROM seed_banks s
CROSS JOIN generate_series(DATE '2024-01-01', DATE '2026-07-01', INTERVAL '1 month') AS m(month)
CROSS JOIN LATERAL (VALUES
    ('E1', 'F', s.e1, 'Head office', 'scope1', 'Fleet fuel', 'Diesel', 'litres', 2.68::numeric, 2100::numeric),
    ('E1', 'G', s.e1, 'Head office', 'scope2', 'Grid electricity (location-based)', NULL, 'kWh', 0.65::numeric, 61000::numeric),
    ('E2', 'F', s.e2, 'Main office', 'scope1', 'Fleet fuel', 'Diesel', 'litres', 2.68::numeric, 640::numeric),
    ('E2', 'G', s.e2, 'Main office', 'scope2', 'Grid electricity (location-based)', NULL, 'kWh', 0.65::numeric, 18500::numeric)
) AS x(ent, ds, code, site, scope, dataset_type, fuel_type, unit, ef, base)
CROSS JOIN LATERAL (
    SELECT (x.base * s.scale
        -- slow efficiency gain: about 6% a year
        * (1 - 0.005 * ((EXTRACT(YEAR FROM m.month) - 2024) * 12 + EXTRACT(MONTH FROM m.month) - 1))
        -- seasonality: more air-conditioning in the hot months, more travel at year end
        * (1 + 0.08 * sin(2 * pi() * (EXTRACT(MONTH FROM m.month) - 1) / 12))
        -- one real anomaly per bank for the detector to find: a fuel spike in July 2025
        * CASE WHEN x.ds = 'F' AND x.ent = 'E1' AND m.month = DATE '2025-07-01' THEN 2.6 ELSE 1 END
        )::numeric AS activity
) a
ON CONFLICT (id) DO NOTHING;

-- 2024 is closed and assured: lock its quarters for every demo bank.
INSERT INTO mavhu.cbz_reporting_periods (bank_id, period, status, locked_by, locked_at)
SELECT s.bank_id, q.period, 'locked', 'tendai.moyo@mavhu.africa', TIMESTAMPTZ '2025-03-31 17:00+02'
FROM seed_banks s
CROSS JOIN (VALUES ('2024-Q1'), ('2024-Q2'), ('2024-Q3'), ('2024-Q4')) AS q(period)
ON CONFLICT (bank_id, period) DO NOTHING;

-- ── Sustainable-finance taxonomy tags ────────────────────────────────────────
UPDATE mavhu.cbz_counterparties SET taxonomy = 'ICMA GBP', taxonomy_category = 'Renewable energy', taxonomy_status = 'Aligned'
WHERE id IN ('CP-004', 'CP-005', 'STB-CP-5', 'FBB-CP-5', 'STW-CP-5', 'FBI-CP-5') AND taxonomy IS NULL;
UPDATE mavhu.cbz_counterparties SET taxonomy = 'ICMA GBP', taxonomy_category = 'Green buildings', taxonomy_status = 'Aligned'
WHERE id IN ('CP-017') AND taxonomy IS NULL;
UPDATE mavhu.cbz_counterparties SET taxonomy = 'AfDB', taxonomy_category = 'Access to clean energy', taxonomy_status = 'Aligned'
WHERE id IN ('CP-018') AND taxonomy IS NULL;
UPDATE mavhu.cbz_counterparties SET taxonomy = 'AfDB', taxonomy_category = 'Climate-smart agriculture', taxonomy_status = 'Under review'
WHERE id IN ('CP-001', 'STB-CP-1', 'FBB-CP-1') AND taxonomy IS NULL;
UPDATE mavhu.cbz_counterparties SET taxonomy = 'ICMA SBP', taxonomy_category = 'Affordable housing', taxonomy_status = 'Eligible'
WHERE id IN ('STB-CP-2', 'FBB-CP-2') AND taxonomy IS NULL;

-- ── MRV-linked agri borrowers (A3-A6) ────────────────────────────────────────
INSERT INTO mavhu.cbz_counterparties (id, name, sector, listed_status, asset_class, subsidiary, financials, total_emissions_tco2e, dq_score, mrv_enhanced, customer_id, taxonomy, taxonomy_category, taxonomy_status)
SELECT v.id, c.name, 'Agriculture', 'Unlisted', 'business_loans_unlisted_equity', v.subsidiary,
       jsonb_build_object('totalEquityDebt', v.ted, 'totalRevenue', v.ted * 1.3), v.emissions, 2, TRUE, c.id,
       'AfDB', 'Climate-smart agriculture', 'Eligible'
FROM (VALUES
    ('AGR-CBZ-CHIPINGE',  'CBZAGRO',  6, 3800000, 1640),
    ('AGR-CBZ-MARONDERA', 'CBZAGRO',  7, 5200000, 2310),
    ('AGR-CBZ-CHIREDZI',  'CBZAGRO',  8, 9100000, 4870),
    ('AGR-STB-NYANGA',    'STANBANK', 9, 2400000,  720),
    ('AGR-FBB-MARONDERA', 'FBCBANK',  7, 3100000, 2310)
) AS v(id, subsidiary, customer_id, ted, emissions)
JOIN mavhu.customers c ON c.id = v.customer_id
WHERE EXISTS (SELECT 1 FROM mavhu.cbz_entities e WHERE e.code = v.subsidiary)
ON CONFLICT (id) DO NOTHING;

INSERT INTO mavhu.cbz_financed_positions (id, counterparty_id, outstanding_amount_usd, period)
SELECT 'FE-' || cp.id, cp.id, round((cp.financials->>'totalEquityDebt')::numeric * 0.35, 2), '2026-Q3'
FROM mavhu.cbz_counterparties cp
WHERE cp.id LIKE 'AGR-%'
ON CONFLICT (id) DO NOTHING;

-- ── Registers (2-4 entries of each per bank) ─────────────────────────────────
INSERT INTO mavhu.cbz_register_items (id, bank_id, register, entity_code, data, created_by)
SELECT s.prefix || '-' || r.code, s.bank_id, r.register,
       CASE r.entity WHEN 'E1' THEN s.e1 WHEN 'E2' THEN s.e2 ELSE NULL END,
       r.data, 'Seed (synthetic demo data)'
FROM seed_banks s
CROSS JOIN LATERAL (VALUES
    -- Targets (F21/F46): progress is computed live from the metric code.
    ('TGT-1', 'targets', 'GROUP', jsonb_build_object('name', 'Cut Scope 1+2 emissions 30% by 2030', 'metricCode', 'SCOPE12_TCO2E', 'baselineYear', 2024, 'targetYear', 2030, 'targetValue', 0.7, 'targetIsRatio', true, 'unit', 'tCO2e', 'direction', 'reduce', 'owner', s.approver_name, 'framework', 'IFRS S2 §33-36')),
    ('TGT-2', 'targets', 'GROUP', jsonb_build_object('name', 'Portfolio PCAF data quality ≤ 3.0 by 2027', 'metricCode', 'WEIGHTED_DQ', 'baselineYear', 2025, 'baselineValue', 4.0, 'targetYear', 2027, 'targetValue', 3.0, 'unit', 'score', 'direction', 'reduce', 'owner', s.approver_name, 'framework', 'PCAF Part A')),
    ('TGT-3', 'targets', 'GROUP', jsonb_build_object('name', 'Women at least 45% of workforce by 2027', 'metricCode', 'FEMALE_SHARE', 'baselineYear', 2025, 'baselineValue', 0.42, 'targetYear', 2027, 'targetValue', 0.45, 'unit', '%', 'direction', 'increase', 'owner', 'Head of HR', 'framework', 'GRI 405-1')),
    -- Risk appetite (F31): current value is computed live; a breach can be escalated.
    ('APP-1', 'risk-appetite', 'GROUP', jsonb_build_object('metric', 'Financed emissions intensity', 'metricCode', 'FINANCED_INTENSITY', 'unit', 'tCO2e per US$m', 'warning', 300, 'limit', 400, 'direction', 'max', 'owner', 'Chief Risk Officer', 'escalateTo', 'Board Risk Committee')),
    ('APP-2', 'risk-appetite', 'GROUP', jsonb_build_object('metric', 'Exposure to high transition-risk sectors', 'metricCode', 'HIGH_TRANSITION_SHARE', 'unit', '% of outstanding', 'warning', 0.15, 'limit', 0.25, 'direction', 'max', 'owner', 'Chief Credit Officer', 'escalateTo', 'ALCO')),
    ('APP-3', 'risk-appetite', 'GROUP', jsonb_build_object('metric', 'Portfolio weighted PCAF DQ score', 'metricCode', 'WEIGHTED_DQ', 'unit', 'score', 'warning', 3.5, 'limit', 4.0, 'direction', 'max', 'owner', 'Head of Sustainability', 'escalateTo', 'Group ESG Committee')),
    ('ESC-1', 'escalations', 'GROUP', jsonb_build_object('metric', 'Portfolio weighted PCAF DQ score', 'value', 4.1, 'limit', 4.0, 'raisedBy', s.approver_name, 'raisedAt', '2026-06-30', 'status', 'Closed', 'note', 'MRV uplift on agri book agreed; DQ back within appetite')),
    ('ESC-2', 'escalations', 'GROUP', jsonb_build_object('metric', 'Financed emissions intensity', 'value', 352, 'limit', 400, 'raisedBy', s.approver_name, 'raisedAt', '2026-09-15', 'status', 'Open', 'note', 'Warning threshold crossed after mining exposure growth')),
    -- Materiality (F24, TNFD LEAP for F12)
    ('MAT-1', 'material-topics', 'GROUP', jsonb_build_object('topic', 'Climate risk in the loan book', 'pillar', 'Environmental', 'impactScore', 5, 'financialScore', 5, 'stakeholders', 'Regulator, investors', 'frameworkRef', 'IFRS S2; GRI 201-2', 'tnfdLeap', 'Assess', 'owner', 'Chief Risk Officer')),
    ('MAT-2', 'material-topics', 'GROUP', jsonb_build_object('topic', 'Biodiversity and land use in agri lending', 'pillar', 'Environmental', 'impactScore', 4, 'financialScore', 3, 'stakeholders', 'Communities, DFIs', 'frameworkRef', 'TNFD; GRI 304', 'tnfdLeap', 'Evaluate', 'owner', 'Head of Agribusiness')),
    ('MAT-3', 'material-topics', 'GROUP', jsonb_build_object('topic', 'Financial inclusion', 'pillar', 'Social', 'impactScore', 4, 'financialScore', 3, 'stakeholders', 'Customers, RBZ', 'frameworkRef', 'GRI FS7; SDG 1, 5', 'tnfdLeap', '', 'owner', 'Head of Retail')),
    ('MAT-4', 'material-topics', 'GROUP', jsonb_build_object('topic', 'Data privacy and cyber security', 'pillar', 'Governance', 'impactScore', 3, 'financialScore', 5, 'stakeholders', 'Customers, regulator', 'frameworkRef', 'GRI 418; SASB FN-CB-230a', 'tnfdLeap', '', 'owner', 'CISO')),
    -- Stakeholders and engagement (F23)
    ('STK-1', 'stakeholders', 'GROUP', jsonb_build_object('name', 'Reserve Bank of Zimbabwe', 'group', 'Regulator', 'influence', 5, 'interest', 5, 'contact', 'Bank Supervision', 'owner', 'Head of Compliance')),
    ('STK-2', 'stakeholders', 'GROUP', jsonb_build_object('name', 'DFI green credit line partner', 'group', 'Investor', 'influence', 4, 'interest', 4, 'contact', 'Portfolio manager', 'owner', 'Treasurer')),
    ('STK-3', 'stakeholders', 'GROUP', jsonb_build_object('name', 'Mutare farming community association', 'group', 'Community', 'influence', 2, 'interest', 4, 'contact', 'Association chair', 'owner', 'Head of Agribusiness')),
    ('ENG-1', 'engagements', 'GROUP', jsonb_build_object('stakeholder', 'Reserve Bank of Zimbabwe', 'date', '2026-07-14', 'channel', 'Meeting', 'topics', 'Climate risk guideline implementation', 'outcome', 'Agreed quarterly progress reporting', 'followUp', 'Submit Q3 progress pack', 'owner', 'Head of Compliance')),
    ('ENG-2', 'engagements', 'GROUP', jsonb_build_object('stakeholder', 'Mutare farming community association', 'date', '2026-08-22', 'channel', 'Community forum', 'topics', 'Water use and irrigation loans', 'outcome', 'Borehole maintenance fund proposed', 'followUp', 'Feasibility note by October', 'owner', 'Head of Agribusiness')),
    -- Suppliers (F26): risk score is computed from the three dimension scores.
    ('SUP-1', 'suppliers', 'GROUP', jsonb_build_object('name', 'Harare Fuel Distributors', 'category', 'Fleet fuel', 'country', 'Zimbabwe', 'spendUsd', 420000, 'environmentalRisk', 4, 'socialRisk', 2, 'governanceRisk', 2, 'esgScreened', true, 'localSupplier', true, 'lastAssessment', '2026-05-30')),
    ('SUP-2', 'suppliers', 'GROUP', jsonb_build_object('name', 'Southern IT Solutions', 'category', 'IT hardware', 'country', 'South Africa', 'spendUsd', 310000, 'environmentalRisk', 2, 'socialRisk', 3, 'governanceRisk', 2, 'esgScreened', true, 'localSupplier', false, 'lastAssessment', '2026-03-12')),
    ('SUP-3', 'suppliers', 'GROUP', jsonb_build_object('name', 'CleanPro Facilities', 'category', 'Cleaning & security', 'country', 'Zimbabwe', 'spendUsd', 95000, 'environmentalRisk', 1, 'socialRisk', 4, 'governanceRisk', 3, 'esgScreened', false, 'localSupplier', true, 'lastAssessment', '2025-11-02')),
    -- Decarbonisation programmes (F35)
    ('DEC-1', 'decarbonisation', 'E1', jsonb_build_object('programme', 'Branch solarisation', 'initiative', 'Head office rooftop PV (250 kWp)', 'milestone', 'Commissioning', 'dueDate', '2026-12-15', 'status', 'In progress', 'expectedReductionTco2e', 180, 'owner', 'Facilities Manager')),
    ('DEC-2', 'decarbonisation', 'E1', jsonb_build_object('programme', 'Fleet transition', 'initiative', 'Replace 20 diesel pool cars with hybrids', 'milestone', 'Procurement approved', 'dueDate', '2027-03-31', 'status', 'Planned', 'expectedReductionTco2e', 95, 'owner', 'Fleet Manager')),
    ('DEC-3', 'decarbonisation', 'E2', jsonb_build_object('programme', 'Paperless operations', 'initiative', 'Digital statements for all retail customers', 'milestone', 'Rolled out', 'dueDate', '2026-06-30', 'status', 'Done', 'expectedReductionTco2e', 12, 'owner', 'Head of Digital')),
    -- Data ownership (F36)
    ('OWN-1', 'data-owners', 'E1', jsonb_build_object('dataset', 'Scope 1 fleet fuel', 'function', 'Facilities', 'owner', 'Facilities Manager', 'backupOwner', 'Fleet Manager', 'sourceSystem', 'Fuel card portal', 'frequency', 'Monthly')),
    ('OWN-2', 'data-owners', 'E1', jsonb_build_object('dataset', 'Loan book (PCAF inputs)', 'function', 'Credit Risk', 'owner', s.approver_name, 'backupOwner', 'Credit Analyst', 'sourceSystem', 'Core banking', 'frequency', 'Quarterly')),
    ('OWN-3', 'data-owners', 'E2', jsonb_build_object('dataset', 'Workforce metrics', 'function', 'Human Resources', 'owner', 'Head of HR', 'backupOwner', 'HR Officer', 'sourceSystem', 'Payroll', 'frequency', 'Quarterly')),
    -- Community investment (F25)
    ('COM-1', 'community-investment', 'E1', jsonb_build_object('programme', 'University bursaries (STEM)', 'location', 'Harare', 'spendUsd', 85000, 'beneficiaries', 40, 'volunteerHours', 120, 'sdg', 'SDG 4', 'period', '2026-Q3')),
    ('COM-2', 'community-investment', 'E2', jsonb_build_object('programme', 'Borehole drilling for rural schools', 'location', 'Masvingo', 'spendUsd', 42000, 'beneficiaries', 1600, 'volunteerHours', 60, 'sdg', 'SDG 6', 'period', '2026-Q2')),
    -- Environmental resources (F40)
    ('RES-1', 'resource-use', 'E1', jsonb_build_object('site', 'Head office', 'period', '2026-Q2', 'electricityKwh', round(183000 * s.scale), 'dieselLitres', round(6300 * s.scale), 'waterM3', round(2400 * s.scale), 'wasteTonnes', round(14.5 * s.scale, 1), 'recycledShare', 0.38)),
    ('RES-2', 'resource-use', 'E1', jsonb_build_object('site', 'Head office', 'period', '2026-Q3', 'electricityKwh', round(176000 * s.scale), 'dieselLitres', round(5900 * s.scale), 'waterM3', round(2250 * s.scale), 'wasteTonnes', round(13.8 * s.scale, 1), 'recycledShare', 0.42)),
    ('RES-3', 'resource-use', 'E2', jsonb_build_object('site', 'Main office', 'period', '2026-Q3', 'electricityKwh', round(54000 * s.scale), 'dieselLitres', round(1800 * s.scale), 'waterM3', round(700 * s.scale), 'wasteTonnes', round(4.1 * s.scale, 1), 'recycledShare', 0.25)),
    -- ESG-linked products (F34)
    ('PRD-1', 'esg-products', 'E1', jsonb_build_object('product', 'Sustainability-linked loan: solar IPP', 'type', 'Sustainability-linked loan', 'counterparty', 'Renewable energy borrower', 'amountUsd', round(2500000 * s.scale), 'kpi', 'MWh clean power generated', 'kpiTarget', 18000, 'kpiActual', 19250, 'marginRatchetBps', -15, 'status', 'On track')),
    ('PRD-2', 'esg-products', 'E1', jsonb_build_object('product', 'Green home improvement loan', 'type', 'Green retail loan', 'counterparty', 'Retail customers', 'amountUsd', round(900000 * s.scale), 'kpi', 'Homes with solar + efficient geysers', 'kpiTarget', 600, 'kpiActual', 410, 'marginRatchetBps', 0, 'status', 'Off track'))
) AS r(code, register, entity, data)
ON CONFLICT (id) DO NOTHING;

-- Targets 1 uses the 2024 Scope 1+2 actuals as its baseline.
UPDATE mavhu.cbz_register_items ri
SET data = ri.data || jsonb_build_object('baselineValue', round(b.total, 1), 'targetValue', round(b.total * 0.7, 1)) - 'targetIsRatio'
FROM (
    SELECT s.prefix, sum(em.emissions_tco2e) AS total
    FROM seed_banks s
    JOIN mavhu.cbz_entities e ON e.bank_id = s.bank_id
    JOIN mavhu.cbz_esg_emissions em ON em.entity_code = e.code
    WHERE em.scope IN ('scope1', 'scope2') AND em.period LIKE '2024-%'
    GROUP BY s.prefix
) b
WHERE ri.id = b.prefix || '-TGT-1' AND ri.data ? 'targetIsRatio';

-- ── Agri MRV ─────────────────────────────────────────────────────────────────
INSERT INTO mavhu.emission_factors (name, component, factor, gwp, description, unit) VALUES
    ('Diesel', 'CO2', 2.6800, 1.0000, '2.68 kg CO2 per litre of diesel burned (illustrative)', 'litre'),
    ('Petrol', 'CO2', 2.3100, 1.0000, '2.31 kg CO2 per litre of petrol burned (illustrative)', 'litre'),
    ('Urea fertiliser', 'CO2e', 1.8300, 1.0000, '1.83 kg CO2e per kg urea applied, incl. field N2O (illustrative)', 'kg'),
    ('Ammonium nitrate', 'CO2e', 3.4500, 1.0000, '3.45 kg CO2e per kg AN applied, incl. manufacture (illustrative)', 'kg'),
    ('Grid electricity (Zimbabwe)', 'CO2', 0.6500, 1.0000, '0.65 kg CO2 per kWh, location-based (illustrative)', 'kWh')
ON CONFLICT (name, component) DO NOTHING;

-- Agri users: every agribusiness customer gets at least a contributor and an approver;
-- plus two MAvHU platform auditors. Password for all: Mavhu@2026! (demo only).
INSERT INTO mavhu.users (name, customer_id, email, password)
SELECT v.name, v.customer_id, v.email, crypt('Mavhu@2026!', gen_salt('bf', 10))
FROM (VALUES
    ('Tsungai Marange',  6, 'tsungai.marange@chipingetea.co.zw'),
    ('Gift Mabhena',     8, 'gift.mabhena@chiredzisugar.co.zw'),
    ('Lovemore Sithole', 8, 'lovemore.sithole@chiredzisugar.co.zw'),
    ('Tariro Nyamande',  9, 'tariro.nyamande@nyangaorchards.co.zw'),
    ('Kundai Matare',    9, 'kundai.matare@nyangaorchards.co.zw'),
    ('Nokuthula Ndlovu', 2, 'nokuthula.ndlovu@mavhu.africa'),
    ('Tawanda Chikore',  2, 'tawanda.chikore@mavhu.africa')
) AS v(name, customer_id, email)
WHERE EXISTS (SELECT 1 FROM mavhu.customers c WHERE c.id = v.customer_id)
ON CONFLICT (email) DO NOTHING;

INSERT INTO mavhu.user_roles (user_id, role_id, audit_trail)
SELECT u.id, r.id, 'Provisioned by migration 006 (demo data)'
FROM (VALUES
    ('tsungai.marange@chipingetea.co.zw', 'ESG_APPROVER'),
    ('gift.mabhena@chiredzisugar.co.zw', 'ESG_CONTRIBUTOR'),
    ('lovemore.sithole@chiredzisugar.co.zw', 'ESG_APPROVER'),
    ('tariro.nyamande@nyangaorchards.co.zw', 'ESG_CONTRIBUTOR'),
    ('kundai.matare@nyangaorchards.co.zw', 'ESG_APPROVER'),
    ('nokuthula.ndlovu@mavhu.africa', 'AUDITOR'),
    ('tawanda.chikore@mavhu.africa', 'AUDITOR')
) AS v(email, role)
JOIN mavhu.users u ON u.email = v.email
JOIN mavhu.roles r ON r.name = v.role
WHERE NOT EXISTS (SELECT 1 FROM mavhu.user_roles ur WHERE ur.user_id = u.id AND ur.role_id = r.id);

-- Monthly satellite passes Jan 2024 – Sep 2026 for every estate. Carbon columns follow the
-- formulas documented in models/10_satellite_ndvi_co2.sql. Marondera shows a 2026 drought dip.
INSERT INTO mavhu.satellite_ndvi_co2 (
    customer_id, estate_id, date, ndvi_mean, ndvi_min, ndvi_max, ndvi_std, ndwi_mean, ndwi_min, ndwi_max, ndwi_std,
    ndbi_mean, ndbi_min, ndbi_max, ndbi_std, above_ground_biomass, below_ground_biomass, biomass_carbon, biomass_co2,
    biomass_co2_total, soil_organic_carbon, soil_organic_carbon_co2, soil_organic_carbon_co2_total, net_co2_stock
)
SELECT
    e.customer_id, e.id, (m.month + INTERVAL '14 days')::date,
    round(n.ndvi_max - 0.08, 6), round(n.ndvi_max - 0.22, 6), round(n.ndvi_max, 6), 0.060000,
    round(n.ndvi_max * 0.45 - 0.20, 6), round(n.ndvi_max * 0.45 - 0.32, 6), round(n.ndvi_max * 0.45 - 0.10, 6), 0.040000,
    -0.150000, -0.250000, -0.050000, 0.030000,
    round(c.agb, 4), round(c.agb * 0.24, 4), round(c.agb * 1.24 * 0.47, 4), round(c.agb * 1.24 * 0.47 * 3.67, 4),
    round(c.agb * 1.24 * 0.47 * 3.67 * e.hectares, 4),
    round(c.soc, 4), round(c.soc * 3.67, 4), round(c.soc * 3.67 * e.hectares, 4),
    round(c.agb * 1.24 * 0.47 * 3.67 * e.hectares + c.soc * 3.67 * e.hectares, 4)
FROM mavhu.estates e
CROSS JOIN generate_series(DATE '2024-01-01', DATE '2026-09-01', INTERVAL '1 month') AS m(month)
CROSS JOIN LATERAL (
    SELECT LEAST(0.92, GREATEST(0.12,
        CASE e.id
            WHEN 1 THEN 0.70 + 0.06 * sin(2 * pi() * (EXTRACT(MONTH FROM m.month) - 1) / 12)                 -- tea: evergreen
            WHEN 2 THEN 0.48 + 0.28 * cos(2 * pi() * (EXTRACT(MONTH FROM m.month) - 2) / 12)                 -- maize: rain-fed season
                     - CASE WHEN m.month BETWEEN DATE '2026-01-01' AND DATE '2026-04-01' THEN 0.22 ELSE 0 END  -- 2026 drought
            WHEN 3 THEN 0.62 + 0.12 * cos(2 * pi() * (EXTRACT(MONTH FROM m.month) - 3) / 12)                 -- irrigated sugarcane
            ELSE        0.58 + 0.10 * cos(2 * pi() * (EXTRACT(MONTH FROM m.month) - 1) / 12)                 -- orchards
        END
        + 0.004 * ((EXTRACT(YEAR FROM m.month) - 2024) * 12 + EXTRACT(MONTH FROM m.month)) / 12            -- slow greening
    ))::numeric AS ndvi_max
) n
CROSS JOIN LATERAL (
    SELECT (45.8 * power(n.ndvi_max, 2.1))::numeric AS agb, (82.77 * n.ndvi_max - 1.39)::numeric AS soc
) c
ON CONFLICT (customer_id, estate_id, date) DO NOTHING;

-- Crop cycles: two seasons per estate, recorded by that customer's contributor.
INSERT INTO mavhu.crop_cycles (customer_id, estate_id, user_id, name, start_date, end_date, audit_trail)
SELECT e.customer_id, e.id, u.id, v.name || ' ' || v.season, v.start_date, v.end_date, 'Seeded by migration 006'
FROM mavhu.estates e
JOIN LATERAL (
    SELECT uu.id FROM mavhu.users uu
    JOIN mavhu.user_roles ur ON ur.user_id = uu.id JOIN mavhu.roles r ON r.id = ur.role_id
    WHERE uu.customer_id = e.customer_id AND r.name = 'ESG_CONTRIBUTOR' ORDER BY uu.id LIMIT 1
) u ON TRUE
CROSS JOIN LATERAL (VALUES
    (CASE e.id WHEN 1 THEN 'Tea plucking' WHEN 2 THEN 'Maize' WHEN 3 THEN 'Sugarcane ratoon' ELSE 'Apples' END, '2024/25', TIMESTAMPTZ '2024-10-15 00:00+02', TIMESTAMPTZ '2025-06-30 00:00+02'),
    (CASE e.id WHEN 1 THEN 'Tea plucking' WHEN 2 THEN 'Maize' WHEN 3 THEN 'Sugarcane ratoon' ELSE 'Apples' END, '2025/26', TIMESTAMPTZ '2025-10-15 00:00+02', TIMESTAMPTZ '2026-06-30 00:00+02')
) AS v(name, season, start_date, end_date)
WHERE NOT EXISTS (SELECT 1 FROM mavhu.crop_cycles cc WHERE cc.estate_id = e.id AND cc.name = v.name || ' ' || v.season);

-- Emissions accounting: diesel and fertiliser approved, electricity awaiting approval.
INSERT INTO mavhu.emissions_accounting (customer_id, estate_id, created_by, crop_cycle_id, emission_id, quantity, start_date, end_date, ton_co2e, scope, approved, approved_by, audit_trail, note)
SELECT e.customer_id, e.id, contrib.id, cyc.id, ef.id, v.qty * e.hectares / 1000.0,
       cyc.start_date, cyc.end_date, round(v.qty * e.hectares / 1000.0 * ef.factor / 1000, 4), v.scope,
       v.approved, CASE WHEN v.approved THEN appr.id END, 'Seeded by migration 006', 'seed-006:' || v.factor_name
FROM mavhu.estates e
JOIN LATERAL (SELECT cc.* FROM mavhu.crop_cycles cc WHERE cc.estate_id = e.id ORDER BY cc.start_date DESC LIMIT 1) cyc ON TRUE
JOIN LATERAL (
    SELECT uu.id FROM mavhu.users uu JOIN mavhu.user_roles ur ON ur.user_id = uu.id JOIN mavhu.roles r ON r.id = ur.role_id
    WHERE uu.customer_id = e.customer_id AND r.name = 'ESG_CONTRIBUTOR' ORDER BY uu.id LIMIT 1
) contrib ON TRUE
JOIN LATERAL (
    SELECT uu.id FROM mavhu.users uu JOIN mavhu.user_roles ur ON ur.user_id = uu.id JOIN mavhu.roles r ON r.id = ur.role_id
    WHERE uu.customer_id = e.customer_id AND r.name = 'ESG_APPROVER' ORDER BY uu.id LIMIT 1
) appr ON TRUE
CROSS JOIN (VALUES
    ('Diesel', 32000, 1, TRUE),                       -- litres per 1000 ha
    ('Urea fertiliser', 95000, 1, TRUE),              -- kg per 1000 ha
    ('Grid electricity (Zimbabwe)', 140000, 2, FALSE) -- kWh per 1000 ha (pending approval)
) AS v(factor_name, qty, scope, approved)
JOIN mavhu.emission_factors ef ON ef.name = v.factor_name
WHERE NOT EXISTS (SELECT 1 FROM mavhu.emissions_accounting ea WHERE ea.estate_id = e.id AND ea.note = 'seed-006:' || v.factor_name);

-- Field verification (A2): two visits per estate.
INSERT INTO mavhu.agri_field_verifications (customer_id, estate_id, visit_date, officer, method, findings, ndvi_confirmed, status)
SELECT e.customer_id, e.id, v.visit_date, v.officer, v.method,
       v.findings || ' (' || e.name || ')', v.confirmed, v.status
FROM mavhu.estates e
CROSS JOIN (VALUES
    (DATE '2026-02-18', 'MAvHU field team (Dudley)', 'Ground-truth transect + drone', 'Canopy cover consistent with Sentinel-2 NDVI; no land clearing observed', TRUE, 'Verified'),
    (DATE '2026-08-27', 'Bank agronomist', 'Farm visit + photo evidence', 'Irrigation infrastructure confirmed; input records sighted', TRUE, 'Submitted')
) AS v(visit_date, officer, method, findings, confirmed, status)
WHERE NOT EXISTS (SELECT 1 FROM mavhu.agri_field_verifications f WHERE f.estate_id = e.id AND f.visit_date = v.visit_date);

-- Marondera's drought is real in the satellite series: its first-quarter visit disputes the
-- planned yield instead of confirming it.
UPDATE mavhu.agri_field_verifications SET ndvi_confirmed = TRUE, status = 'Disputed',
    findings = 'Drought stress confirmed on the ground: maize wilting on 40% of fields; yield forecast cut (Marondera North Fields)'
WHERE estate_id = 2 AND visit_date = DATE '2026-02-18' AND status = 'Verified';

-- ── Bank-portal accounts for CBZ staff who only had platform logins ──────────
INSERT INTO mavhu.cbz_members (id, full_name, email, password_hash, phone, entity_code, department_id, role)
SELECT v.id, u.name, u.email, u.password, '', 'CBZBANK', NULL, v.role
FROM (VALUES
    ('USR-PLATFORM-CHIPO',     'chipo.mutasa@cbz.co.zw',     'reader'),
    ('USR-PLATFORM-NYASHA',    'nyasha.dube@cbz.co.zw',      'approver'),
    ('USR-PLATFORM-TAFADZWA',  'tafadzwa.sibanda@cbz.co.zw', 'auditor')
) AS v(id, email, role)
JOIN mavhu.users u ON u.email = v.email
WHERE EXISTS (SELECT 1 FROM mavhu.cbz_entities WHERE code = 'CBZBANK')
ON CONFLICT DO NOTHING;

DROP TABLE IF EXISTS pg_temp.seed_banks;
