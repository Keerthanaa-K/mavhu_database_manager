-- ============================================
-- Migration 005: Synthetic demo data for Stanbic and FBC
--
-- Gives the two non-CBZ banks two subsidiaries each, and every subsidiary
-- 5 rows in every ESG dataset, so the MAvHU admin console and each bank's
-- dashboard have something to show. ALL DATA HERE IS SYNTHETIC.
--
-- Demo logins: <first>.<last>@<bank domain>, password 'cbz-demo'
-- (roles per subsidiary: admin, approver, contributor, reader, auditor).
-- Safe to re-run: every insert skips rows that already exist.
-- ============================================

INSERT INTO mavhu.banks (name, country, email, identifier)
SELECT 'Stanbic Bank Zimbabwe', 'Zimbabwe', 'contact@stanbicbank.co.zw', 'STANBIC-ZW-001'
WHERE NOT EXISTS (SELECT 1 FROM mavhu.banks WHERE identifier = 'STANBIC-ZW-001');

INSERT INTO mavhu.banks (name, country, email, identifier)
SELECT 'FBC Bank Limited', 'Zimbabwe', 'contact@fbc.co.zw', 'FBC-ZW-001'
WHERE NOT EXISTS (SELECT 1 FROM mavhu.banks WHERE identifier = 'FBC-ZW-001');

-- Plain temp table (not ON COMMIT DROP) so this also works when run with psql -f outside a transaction.
DROP TABLE IF EXISTS pg_temp.demo_entities;
CREATE TEMP TABLE demo_entities (
    ord             INTEGER,
    code            VARCHAR(20),
    prefix          VARCHAR(5),
    bank_identifier VARCHAR(50),
    name            VARCHAR(255),
    segment         VARCHAR(255),
    regulator       VARCHAR(100),
    pcaf            VARCHAR(255),
    domain          VARCHAR(100),
    site            VARCHAR(255)
);

INSERT INTO demo_entities VALUES
    (1, 'STANBANK', 'STB', 'STANBIC-ZW-001', 'Stanbic Bank Zimbabwe', 'Corporate, business & retail banking', 'RBZ',    'A (lending)',               'stanbicbank.co.zw',  'Stanbic Centre, Harare'),
    (2, 'STANWLTH', 'STW', 'STANBIC-ZW-001', 'Stanbic Wealth',        'Wealth & asset management',            'SECZim', 'A (listed equity & bonds)', 'stanbicwealth.co.zw', 'Stanbic Wealth, Bulawayo'),
    (3, 'FBCBANK',  'FBB', 'FBC-ZW-001',     'FBC Bank',              'Commercial & retail banking',          'RBZ',    'A (lending)',               'fbc.co.zw',          'FBC Centre, Harare'),
    (4, 'FBCINS',   'FBI', 'FBC-ZW-001',     'FBC Insurance',         'Short-term insurance',                 'IPEC',   'C (insurance-associated)',  'fbcinsurance.co.zw', 'FBC Insurance, Mutare');

-- Subsidiaries
INSERT INTO mavhu.cbz_entities (code, name, segment, regulator, pcaf_applicable, notes, bank_id)
SELECT d.code, d.name, d.segment, d.regulator, d.pcaf, 'Synthetic demo subsidiary', b.id
FROM demo_entities d
JOIN mavhu.banks b ON b.identifier = d.bank_identifier
ON CONFLICT (code) DO NOTHING;

-- Departments (5 per subsidiary)
INSERT INTO mavhu.cbz_departments (id, entity_code, name, kind, head_of_dept, email)
SELECT
    d.prefix || '-DEPT-' || g.i,
    d.code,
    (ARRAY['Corporate & Commercial Banking', 'Retail & Personal Banking', 'Treasury & Markets', 'Sustainability Office', 'Risk & Compliance'])[g.i],
    (ARRAY['Commercial Banking', 'Commercial Banking', 'Investment Banking', 'Risk Advisory', 'Risk Advisory'])[g.i],
    'Head of ' || (ARRAY['Corporate', 'Retail', 'Treasury', 'Sustainability', 'Risk'])[g.i],
    lower((ARRAY['corporate', 'retail', 'treasury', 'sustainability', 'risk'])[g.i]) || '@' || d.domain
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- Members (5 per subsidiary, one per role)
INSERT INTO mavhu.cbz_members (id, full_name, email, password_hash, phone, entity_code, department_id, role)
SELECT
    d.prefix || '-USR-' || g.i,
    f.first || ' ' || f.last,
    lower(f.first || '.' || f.last) || '@' || d.domain,
    crypt('cbz-demo', gen_salt('bf', 10)),
    '+263 77 ' || lpad(((d.ord * 100000) + g.i * 1111)::text, 7, '0'),
    d.code,
    d.prefix || '-DEPT-' || g.i,
    (ARRAY['admin', 'approver', 'contributor', 'reader', 'auditor'])[g.i]
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
CROSS JOIN LATERAL (
    SELECT
        (ARRAY['Tatenda', 'Rumbidzai', 'Kudakwashe', 'Nyasha', 'Tinotenda', 'Chiedza', 'Tapiwa', 'Vimbai', 'Farai', 'Ruvimbo',
               'Simbarashe', 'Tsitsi', 'Takudzwa', 'Fadzai', 'Munyaradzi', 'Rutendo', 'Tonderai', 'Shamiso', 'Panashe', 'Chipo'])[(d.ord - 1) * 5 + g.i] AS first,
        (ARRAY['Mhlanga', 'Ndlovu', 'Chigumba', 'Moyo', 'Mapfumo', 'Sibanda', 'Gumbo', 'Nyathi', 'Mukanya', 'Dube',
               'Marufu', 'Chinoda', 'Zvobgo', 'Mutasa', 'Musoni', 'Hove', 'Maposa', 'Chirwa', 'Bhebhe', 'Mangwende'])[(d.ord - 1) * 5 + g.i] AS last
) f
ON CONFLICT (id) DO NOTHING;

-- Counterparties (5 per subsidiary, one per PCAF asset class)
INSERT INTO mavhu.cbz_counterparties (id, name, sector, listed_status, asset_class, subsidiary, financials, total_emissions_tco2e, dq_score, mrv_enhanced)
SELECT
    d.prefix || '-CP-' || g.i,
    (ARRAY['Mazowe Citrus Growers', 'Borrowdale Brooke Homes', 'Eastgate Retail Park', 'Trans-Zambezi Haulage', 'Kariba North Solar',
           'Gwanda Gold Processing', 'Hillside Residential', 'Fourth Street Offices', 'Matabeleland Logistics', 'Hwange Wind Farm',
           'Chegutu Dairy Co-op', 'Avondale Mortgages Pool', 'Sam Levy Commercial', 'Masvingo Bus Lines', 'Save Valley Irrigation',
           'Nyanga Timber Mills', 'Greendale Housing Trust', 'Kwekwe Industrial Park', 'Beitbridge Freight', 'Mutare Biogas Plant'])[(d.ord - 1) * 5 + g.i],
    (ARRAY['Agriculture', 'Residential real estate', 'Commercial property', 'Transport', 'Renewable energy'])[g.i],
    'Unlisted',
    (ARRAY['business_loans_unlisted_equity', 'mortgages', 'commercial_real_estate', 'motor_vehicle_loans', 'project_finance'])[g.i],
    d.code,
    CASE g.i
        WHEN 1 THEN jsonb_build_object('totalRevenue', (d.ord + 3) * 1400000, 'totalEquityDebt', (d.ord + 3) * 1000000)
        WHEN 2 THEN jsonb_build_object('propertyValue', (d.ord + 2) * 450000)
        WHEN 3 THEN jsonb_build_object('propertyValue', (d.ord + 4) * 1800000)
        WHEN 4 THEN jsonb_build_object('vehicleValue', (d.ord + 2) * 320000)
        ELSE        jsonb_build_object('projectTotalCost', (d.ord + 5) * 2500000)
    END,
    (ARRAY[2400, 85, 960, 1750, 140])[g.i] + d.ord * 110,
    (ARRAY[3, 4, 3, 4, 2])[g.i],
    g.i IN (1, 5)
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- Financed positions (one exposure per counterparty, 15–40% of the PCAF denominator)
INSERT INTO mavhu.cbz_financed_positions (id, counterparty_id, outstanding_amount_usd, period)
SELECT
    d.prefix || '-FE-' || g.i,
    d.prefix || '-CP-' || g.i,
    round((SELECT (v.value)::numeric FROM jsonb_each_text(cp.financials) v WHERE v.key <> 'totalRevenue' LIMIT 1) * (0.10 + 0.06 * g.i), 2),
    '2026-Q3'
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
JOIN mavhu.cbz_counterparties cp ON cp.id = d.prefix || '-CP-' || g.i
ON CONFLICT (id) DO NOTHING;

-- Operational emissions (Scope 1–3, mixed workflow statuses)
INSERT INTO mavhu.cbz_esg_emissions (
    id, entity_code, site, period, scope, dataset_type, fuel_type, activity_data, unit,
    emission_factor_kg_per_unit, emissions_kg_co2e, emissions_tco2e, method, data_quality,
    status, source_ref, submitted_by, submitted_at, approved_by, approved_at
)
SELECT
    d.prefix || '-EM-' || g.i,
    d.code,
    d.site,
    e.period,
    e.scope,
    e.dataset_type,
    e.fuel_type,
    e.activity,
    e.unit,
    e.ef,
    round(e.activity * e.ef, 4),
    round(e.activity * e.ef / 1000, 6),
    e.method,
    e.dq,
    e.status,
    d.code || '_' || upper(e.scope) || '_' || replace(upper(e.dataset_type), ' ', '') || '_' || e.period || '_v1.csv',
    d.prefix || '-USR-3',
    TIMESTAMPTZ '2026-09-01 09:00+02' + (g.i || ' days')::interval,
    CASE WHEN e.status IN ('approved', 'locked') THEN d.prefix || '-USR-2' END,
    CASE WHEN e.status IN ('approved', 'locked') THEN TIMESTAMPTZ '2026-09-03 15:00+02' + (g.i || ' days')::interval END
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
CROSS JOIN LATERAL (
    SELECT
        (ARRAY['2026-08', '2026-08', '2026-08', '2026-Q3', '2026-Q3'])[g.i] AS period,
        (ARRAY['scope1', 'scope1', 'scope2', 'scope3', 'scope3'])[g.i] AS scope,
        (ARRAY['Fleet fuel', 'Backup generator', 'Grid electricity', 'Business travel', 'Cat 1'])[g.i] AS dataset_type,
        (ARRAY['Diesel', 'Diesel', NULL, NULL, NULL])[g.i] AS fuel_type,
        ((ARRAY[1800, 900, 52000, 24000, 85000])[g.i] * (1 + d.ord * 0.15))::numeric AS activity,
        (ARRAY['litres', 'litres', 'kWh', 'pax-km', 'US$'])[g.i] AS unit,
        (ARRAY[2.68, 2.68, 0.57, 0.15, 0.32])[g.i]::numeric AS ef,
        (ARRAY['activity-based', 'activity-based', 'measured', 'activity-based', 'spend-based'])[g.i] AS method,
        (ARRAY[2, 3, 1, 3, 4])[g.i] AS dq,
        (ARRAY['approved', 'approved', 'in_review', 'draft', 'locked'])[g.i] AS status
) e
ON CONFLICT (id) DO NOTHING;

-- Insurance-associated emissions (PCAF Part C), clients are the subsidiary's counterparties
INSERT INTO mavhu.cbz_insurance_policies (
    id, segment, subsidiary, client_id, client_name, sector, gross_written_premium_usd, denominator_type,
    denominator_value_usd, client_total_emissions, attribution_factor, insurance_associated_emissions, dq_score
)
SELECT
    d.prefix || '-IE-' || g.i,
    (ARRAY['Commercial lines', 'Personal motor - individual data', 'Personal motor - PCAF fallback factor', 'Project insurance', 'Treaty reinsurance'])[g.i],
    d.code,
    cp.id,
    cp.name,
    cp.sector,
    p.premium,
    'Client''s Total Revenue',
    p.denominator,
    cp.total_emissions_tco2e,
    round(p.premium / p.denominator, 8),
    round(p.premium / p.denominator * cp.total_emissions_tco2e, 4),
    cp.dq_score
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
JOIN mavhu.cbz_counterparties cp ON cp.id = d.prefix || '-CP-' || g.i
CROSS JOIN LATERAL (
    SELECT
        (15000 * g.i + 5000 * d.ord)::numeric AS premium,
        (SELECT (v.value)::numeric FROM jsonb_each_text(cp.financials) v ORDER BY v.key DESC LIMIT 1) * 1.4 AS denominator
) p
ON CONFLICT (id) DO NOTHING;

-- Financial inclusion programmes
INSERT INTO mavhu.cbz_financial_inclusion (id, subsidiary, programme, beneficiary_count, female_share, total_disbursed_usd, geography, sdg_alignment, repayment_rate, period)
SELECT
    d.prefix || '-FI-' || g.i,
    d.code,
    (ARRAY['SME green credit line', 'Women in agriculture loans', 'Youth enterprise fund', 'Rural mobile banking', 'Climate-smart farming inputs'])[g.i],
    400 * g.i + 150 * d.ord,
    0.45 + 0.04 * g.i,
    120000 * g.i + 30000 * d.ord,
    (ARRAY['Harare', 'Bulawayo', 'Manicaland', 'Masvingo', 'Midlands'])[g.i],
    (ARRAY['SDG 8, SDG 13', 'SDG 5, SDG 2', 'SDG 8', 'SDG 1, SDG 9', 'SDG 2, SDG 13'])[g.i],
    0.86 + 0.02 * g.i,
    '2026-Q3'
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- Workforce (5 quarters of history per subsidiary; dashboards use the latest)
INSERT INTO mavhu.cbz_workforce (id, subsidiary, period, headcount, female_share, avg_training_hours, lti_rate, voluntary_turnover, local_hire_share)
SELECT
    d.prefix || '-WF-' || g.i,
    d.code,
    (ARRAY['2025-Q3', '2025-Q4', '2026-Q1', '2026-Q2', '2026-Q3'])[g.i],
    round((ARRAY[1450, 120, 980, 260])[d.ord] * (1 + 0.01 * g.i)),
    0.44 + 0.005 * g.i,
    10 + g.i,
    0.9 - 0.1 * g.i,
    0.11 - 0.005 * g.i,
    0.95
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- ESG incidents
INSERT INTO mavhu.cbz_incidents (id, subsidiary, date_reported, category, description, severity, status, corrective_action, closure_date)
SELECT
    d.prefix || '-INC-' || g.i,
    d.code,
    DATE '2026-07-01' + g.i * 9,
    (ARRAY['Environmental', 'Social', 'Governance', 'Compliance', 'Environmental'])[g.i],
    (ARRAY['Diesel spill at branch generator bay', 'Customer complaint on loan collection practice', 'Late board ESG committee minutes',
           'Missed RBZ climate-risk return deadline', 'Financed borrower flagged for land clearing'])[g.i],
    (ARRAY['Medium', 'Low', 'High', 'Medium', 'Critical'])[g.i],
    (ARRAY['Closed', 'In Progress', 'Open', 'Closed', 'Open'])[g.i],
    (ARRAY['Bund wall installed; soil remediated', 'Collections script retrained', 'Secretariat SLA agreed',
           'Return filed; reminder workflow added', 'Site visit and satellite review scheduled'])[g.i],
    CASE WHEN g.i IN (1, 4) THEN DATE '2026-07-01' + g.i * 9 + 14 END
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- Climate risk register
INSERT INTO mavhu.cbz_risk_entries (id, title, category, likelihood, impact, owner, status, linked_entity, bank_id)
SELECT
    d.prefix || '-RSK-' || g.i,
    (ARRAY['Drought impact on agri loan book', 'Carbon pricing on heavy-emitting borrowers', 'Flood exposure of mortgage collateral',
           'Green bond issuance opportunity', 'Climate disclosure litigation'])[g.i],
    (ARRAY['Physical', 'Transition', 'Physical', 'Opportunity', 'Liability'])[g.i],
    (ARRAY[4, 3, 3, 4, 2])[g.i],
    (ARRAY[4, 4, 3, 3, 3])[g.i],
    m.full_name,
    (ARRAY['Mitigating', 'Monitoring', 'Identified', 'Identified', 'Monitoring'])[g.i],
    d.code,
    e.bank_id
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
JOIN mavhu.cbz_entities e ON e.code = d.code
JOIN mavhu.cbz_members m ON m.id = d.prefix || '-USR-2'
ON CONFLICT (id) DO NOTHING;

-- Geospatial / NDVI passes over financed borrowers
INSERT INTO mavhu.cbz_geospatial (id, linked_borrower_name, subsidiary, district, coordinates, pass_date, data_source, ndvi, land_use, area_ha, deforestation_flag, flood_risk, drought_stress)
SELECT
    d.prefix || '-GEO-' || g.i,
    cp.name,
    d.code,
    (ARRAY['Mazowe', 'Goromonzi', 'Chipinge', 'Gweru', 'Masvingo'])[g.i],
    (ARRAY['-17.51, 30.97', '-17.82, 31.37', '-20.19, 32.62', '-19.45, 29.82', '-20.07, 30.83'])[g.i],
    DATE '2026-08-04' + g.i * 5,
    (ARRAY['Sentinel-2', 'Landsat-9', 'Sentinel-2', 'MODIS', 'Sentinel-2'])[g.i],
    0.35 + 0.08 * g.i,
    (ARRAY['Maize', 'Tobacco', 'Tea estate', 'Cattle ranching', 'Sugarcane'])[g.i],
    120 * g.i + 40 * d.ord,
    (ARRAY['No', 'No', 'Possible - flagged for review', 'No', 'Confirmed'])[g.i],
    (ARRAY['Low', 'Medium', 'High', 'Low', 'Medium'])[g.i],
    (ARRAY['High', 'Medium', 'Low', 'High', 'Medium'])[g.i]
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
JOIN mavhu.cbz_counterparties cp ON cp.id = d.prefix || '-CP-' || g.i
ON CONFLICT (id) DO NOTHING;

-- Ingestion batches
INSERT INTO mavhu.cbz_ingestion_batches (id, file_name, channel, subsidiary, uploaded_at, records_processed, validation_status, error_details, notification_sent)
SELECT
    d.prefix || '-ING-' || g.i,
    d.code || '_' || (ARRAY['SCOPE1_FLEET', 'NDVI_PASS', 'LOANBOOK_API', 'MANUAL_FORM', 'SCOPE2_UTILITY'])[g.i] || '_2026-08.csv',
    (ARRAY['File Ingester (manual upload)', 'Satellite Data Ingester', 'Ingestion API (manual)', 'Manual form entry', 'File Ingester (manual upload)'])[g.i],
    d.code,
    TIMESTAMPTZ '2026-09-10 08:00+02' + (g.i || ' days')::interval,
    (ARRAY[1240, 86, 410, 12, 960])[g.i],
    (ARRAY['Success', 'Success', 'Partial', 'Success', 'Failure'])[g.i],
    (ARRAY['', '', '3 rows missing period', '', 'Invalid unit column'])[g.i],
    TRUE
FROM demo_entities d CROSS JOIN generate_series(1, 5) AS g(i)
ON CONFLICT (id) DO NOTHING;

-- Audit trail
INSERT INTO mavhu.cbz_audit_log (id, timestamp, actor, action, entity_code, target_type, target_id, detail, bank_id)
SELECT
    d.prefix || '-AUD-' || g.i,
    TIMESTAMPTZ '2026-09-20 09:00+02' + (g.i || ' hours')::interval,
    m.full_name,
    (ARRAY['LOGIN', 'CREATE', 'SUBMIT', 'APPROVE', 'LOCK'])[g.i],
    d.code,
    (ARRAY['Auth', 'Counterparty', 'EmissionRecord', 'EmissionRecord', 'Workflow'])[g.i],
    (ARRAY[NULL, d.prefix || '-CP-1', d.prefix || '-EM-3', d.prefix || '-EM-1', d.prefix || '-EM-5'])[g.i],
    (ARRAY['Signed in', 'Added counterparty', 'Submitted grid electricity for review', 'Approved fleet fuel', 'Locked Cat 1 spend record'])[g.i],
    e.bank_id
FROM demo_entities d
CROSS JOIN generate_series(1, 5) AS g(i)
JOIN mavhu.cbz_entities e ON e.code = d.code
JOIN mavhu.cbz_members m ON m.id = d.prefix || '-USR-' || (ARRAY[1, 3, 3, 2, 2])[g.i]
ON CONFLICT (id) DO NOTHING;

DROP TABLE IF EXISTS pg_temp.demo_entities;
