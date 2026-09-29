-- ============================================
-- CBZ ESG Platform Tables
-- Migration 003: All 14 CBZ ESG tables
-- ============================================

-- Entities (CBZ subsidiaries)
CREATE TABLE IF NOT EXISTS mavhu.cbz_entities (
    code                VARCHAR(20)     PRIMARY KEY,
    name                VARCHAR(255)    NOT NULL,
    segment             VARCHAR(255)    NOT NULL,
    regulator           VARCHAR(100)    NOT NULL,
    pcaf_applicable     VARCHAR(255)    NOT NULL DEFAULT '',
    notes               TEXT            NOT NULL DEFAULT '',
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_entities_updated_at ON mavhu.cbz_entities;
CREATE TRIGGER cbz_entities_updated_at BEFORE UPDATE ON mavhu.cbz_entities FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Departments
CREATE TABLE IF NOT EXISTS mavhu.cbz_departments (
    id              VARCHAR(20)     PRIMARY KEY,
    entity_code     VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    name            VARCHAR(255)    NOT NULL,
    kind            VARCHAR(100)    NOT NULL,
    head_of_dept    VARCHAR(255)    NOT NULL,
    email           VARCHAR(255)    NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_departments_updated_at ON mavhu.cbz_departments;
CREATE TRIGGER cbz_departments_updated_at BEFORE UPDATE ON mavhu.cbz_departments FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Members (CBZ portal users)
CREATE TABLE IF NOT EXISTS mavhu.cbz_members (
    id              VARCHAR(30)     PRIMARY KEY,
    full_name       VARCHAR(255)    NOT NULL,
    email           VARCHAR(255)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL,
    phone           VARCHAR(50)     NOT NULL DEFAULT '',
    entity_code     VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    department_id   VARCHAR(20)     REFERENCES mavhu.cbz_departments(id),
    role            VARCHAR(20)     NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_members_updated_at ON mavhu.cbz_members;
CREATE TRIGGER cbz_members_updated_at BEFORE UPDATE ON mavhu.cbz_members FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Counterparties (borrowers / investees)
CREATE TABLE IF NOT EXISTS mavhu.cbz_counterparties (
    id                      VARCHAR(20)     PRIMARY KEY,
    name                    VARCHAR(255)    NOT NULL,
    sector                  VARCHAR(100)    NOT NULL,
    listed_status           VARCHAR(20)     NOT NULL,
    asset_class             VARCHAR(50)     NOT NULL,
    subsidiary              VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    financials              JSONB           NOT NULL DEFAULT '{}',
    total_emissions_tco2e   DECIMAL(15,4)   NOT NULL DEFAULT 0,
    dq_score                SMALLINT        NOT NULL,
    mrv_enhanced            BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_counterparties_updated_at ON mavhu.cbz_counterparties;
CREATE TRIGGER cbz_counterparties_updated_at BEFORE UPDATE ON mavhu.cbz_counterparties FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Financed positions (loan exposures)
CREATE TABLE IF NOT EXISTS mavhu.cbz_financed_positions (
    id                      VARCHAR(20)     PRIMARY KEY,
    counterparty_id         VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_counterparties(id),
    outstanding_amount_usd  DECIMAL(15,2)   NOT NULL,
    period                  VARCHAR(20)     NOT NULL,
    created_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_financed_positions_updated_at ON mavhu.cbz_financed_positions;
CREATE TRIGGER cbz_financed_positions_updated_at BEFORE UPDATE ON mavhu.cbz_financed_positions FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ESG Emissions (Scope 1, 2, 3 operational)
CREATE TABLE IF NOT EXISTS mavhu.cbz_esg_emissions (
    id                          VARCHAR(20)     PRIMARY KEY,
    entity_code                 VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    site                        VARCHAR(255)    NOT NULL,
    period                      VARCHAR(20)     NOT NULL,
    scope                       VARCHAR(10)     NOT NULL,
    dataset_type                VARCHAR(100)    NOT NULL,
    fuel_type                   VARCHAR(50),
    activity_data               DECIMAL(15,4)   NOT NULL,
    unit                        VARCHAR(50)     NOT NULL,
    emission_factor_kg_per_unit DECIMAL(15,6)   NOT NULL,
    emissions_kg_co2e           DECIMAL(15,4)   NOT NULL,
    emissions_tco2e             DECIMAL(15,6)   NOT NULL,
    method                      VARCHAR(30)     NOT NULL,
    data_quality                SMALLINT        NOT NULL,
    status                      VARCHAR(20)     NOT NULL DEFAULT 'draft',
    source_ref                  VARCHAR(255)    NOT NULL DEFAULT '',
    submitted_by                VARCHAR(30)     REFERENCES mavhu.cbz_members(id),
    submitted_at                TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    approved_by                 VARCHAR(30)     REFERENCES mavhu.cbz_members(id),
    approved_at                 TIMESTAMPTZ,
    created_at                  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_esg_emissions_updated_at ON mavhu.cbz_esg_emissions;
CREATE TRIGGER cbz_esg_emissions_updated_at BEFORE UPDATE ON mavhu.cbz_esg_emissions FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Insurance policies (PCAF Part C)
CREATE TABLE IF NOT EXISTS mavhu.cbz_insurance_policies (
    id                              VARCHAR(20)     PRIMARY KEY,
    segment                         VARCHAR(100)    NOT NULL,
    subsidiary                      VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    client_id                       VARCHAR(50)     NOT NULL,
    client_name                     VARCHAR(255)    NOT NULL,
    sector                          VARCHAR(100)    NOT NULL,
    gross_written_premium_usd       DECIMAL(15,2)   NOT NULL,
    denominator_type                VARCHAR(255)    NOT NULL,
    denominator_value_usd           DECIMAL(20,2),
    client_total_emissions          DECIMAL(15,4)   NOT NULL,
    attribution_factor              DECIMAL(15,8)   NOT NULL,
    insurance_associated_emissions  DECIMAL(15,4)   NOT NULL,
    dq_score                        SMALLINT        NOT NULL,
    created_at                      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_insurance_policies_updated_at ON mavhu.cbz_insurance_policies;
CREATE TRIGGER cbz_insurance_policies_updated_at BEFORE UPDATE ON mavhu.cbz_insurance_policies FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Financial inclusion records
CREATE TABLE IF NOT EXISTS mavhu.cbz_financial_inclusion (
    id                  VARCHAR(20)     PRIMARY KEY,
    subsidiary          VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    programme           VARCHAR(255)    NOT NULL,
    beneficiary_count   INTEGER         NOT NULL,
    female_share        DECIMAL(5,4)    NOT NULL,
    total_disbursed_usd DECIMAL(15,2)   NOT NULL,
    geography           VARCHAR(255)    NOT NULL,
    sdg_alignment       VARCHAR(255)    NOT NULL,
    repayment_rate      DECIMAL(5,4)    NOT NULL,
    period              VARCHAR(20)     NOT NULL,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_financial_inclusion_updated_at ON mavhu.cbz_financial_inclusion;
CREATE TRIGGER cbz_financial_inclusion_updated_at BEFORE UPDATE ON mavhu.cbz_financial_inclusion FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Workforce records
CREATE TABLE IF NOT EXISTS mavhu.cbz_workforce (
    id                  VARCHAR(20)     PRIMARY KEY,
    subsidiary          VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    period              VARCHAR(20)     NOT NULL,
    headcount           INTEGER         NOT NULL,
    female_share        DECIMAL(5,4)    NOT NULL,
    avg_training_hours  DECIMAL(8,2)    NOT NULL,
    lti_rate            DECIMAL(8,4)    NOT NULL,
    voluntary_turnover  DECIMAL(5,4)    NOT NULL,
    local_hire_share    DECIMAL(5,4)    NOT NULL,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_workforce_updated_at ON mavhu.cbz_workforce;
CREATE TRIGGER cbz_workforce_updated_at BEFORE UPDATE ON mavhu.cbz_workforce FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ESG Incidents
CREATE TABLE IF NOT EXISTS mavhu.cbz_incidents (
    id                  VARCHAR(20)     PRIMARY KEY,
    subsidiary          VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    date_reported       DATE            NOT NULL,
    category            VARCHAR(30)     NOT NULL,
    description         TEXT            NOT NULL,
    severity            VARCHAR(20)     NOT NULL,
    status              VARCHAR(20)     NOT NULL,
    corrective_action   TEXT            NOT NULL DEFAULT '',
    closure_date        DATE,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_incidents_updated_at ON mavhu.cbz_incidents;
CREATE TRIGGER cbz_incidents_updated_at BEFORE UPDATE ON mavhu.cbz_incidents FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Climate risk entries
CREATE TABLE IF NOT EXISTS mavhu.cbz_risk_entries (
    id              VARCHAR(20)     PRIMARY KEY,
    title           VARCHAR(255)    NOT NULL,
    category        VARCHAR(30)     NOT NULL,
    likelihood      SMALLINT        NOT NULL,
    impact          SMALLINT        NOT NULL,
    owner           VARCHAR(255)    NOT NULL,
    status          VARCHAR(30)     NOT NULL,
    linked_entity   VARCHAR(20)     NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_risk_entries_updated_at ON mavhu.cbz_risk_entries;
CREATE TRIGGER cbz_risk_entries_updated_at BEFORE UPDATE ON mavhu.cbz_risk_entries FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Geospatial / NDVI records
CREATE TABLE IF NOT EXISTS mavhu.cbz_geospatial (
    id                      VARCHAR(20)     PRIMARY KEY,
    linked_borrower_name    VARCHAR(255)    NOT NULL,
    subsidiary              VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    district                VARCHAR(100)    NOT NULL,
    coordinates             VARCHAR(50)     NOT NULL,
    pass_date               DATE            NOT NULL,
    data_source             VARCHAR(20)     NOT NULL,
    ndvi                    DECIMAL(8,4),
    land_use                VARCHAR(255)    NOT NULL,
    area_ha                 DECIMAL(10,2)   NOT NULL,
    deforestation_flag      VARCHAR(50)     NOT NULL,
    flood_risk              VARCHAR(10)     NOT NULL,
    drought_stress          VARCHAR(10)     NOT NULL,
    created_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_geospatial_updated_at ON mavhu.cbz_geospatial;
CREATE TRIGGER cbz_geospatial_updated_at BEFORE UPDATE ON mavhu.cbz_geospatial FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Data ingestion batches
CREATE TABLE IF NOT EXISTS mavhu.cbz_ingestion_batches (
    id                  VARCHAR(20)     PRIMARY KEY,
    file_name           VARCHAR(255)    NOT NULL,
    channel             VARCHAR(100)    NOT NULL,
    subsidiary          VARCHAR(20)     NOT NULL REFERENCES mavhu.cbz_entities(code),
    uploaded_at         TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    records_processed   INTEGER         NOT NULL DEFAULT 0,
    validation_status   VARCHAR(20)     NOT NULL,
    error_details       TEXT            NOT NULL DEFAULT '',
    notification_sent   BOOLEAN         NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS cbz_ingestion_batches_updated_at ON mavhu.cbz_ingestion_batches;
CREATE TRIGGER cbz_ingestion_batches_updated_at BEFORE UPDATE ON mavhu.cbz_ingestion_batches FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Audit log (append-only)
CREATE TABLE IF NOT EXISTS mavhu.cbz_audit_log (
    id          VARCHAR(20)     PRIMARY KEY,
    timestamp   TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actor       VARCHAR(255)    NOT NULL,
    action      VARCHAR(50)     NOT NULL,
    entity_code VARCHAR(20),
    target_type VARCHAR(30)     NOT NULL,
    target_id   VARCHAR(50),
    detail      TEXT            NOT NULL DEFAULT '',
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
