--
-- PostgreSQL database dump
--

\restrict t5dptAEu69cWbAlAmYawXiznOYuMKTTT0Rw3RV4l9ygvYrkDQ11NzJfNYgRmn7C

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_estate_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.user_roles DROP CONSTRAINT IF EXISTS user_roles_user_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.user_roles DROP CONSTRAINT IF EXISTS user_roles_role_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.satellite_ndvi_co2 DROP CONSTRAINT IF EXISTS satellite_ndvi_co2_estate_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.satellite_ndvi_co2 DROP CONSTRAINT IF EXISTS satellite_ndvi_co2_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_role_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_api_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.estates DROP CONSTRAINT IF EXISTS estates_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_estate_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_emission_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_crop_cycle_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_created_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.crop_cycles DROP CONSTRAINT IF EXISTS crop_cycles_user_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.crop_cycles DROP CONSTRAINT IF EXISTS crop_cycles_estate_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.crop_cycles DROP CONSTRAINT IF EXISTS crop_cycles_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_workforce DROP CONSTRAINT IF EXISTS cbz_workforce_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_risk_entries DROP CONSTRAINT IF EXISTS cbz_risk_entries_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_reporting_periods DROP CONSTRAINT IF EXISTS cbz_reporting_periods_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_department_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_insurance_policies DROP CONSTRAINT IF EXISTS cbz_insurance_policies_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_ingestion_batches DROP CONSTRAINT IF EXISTS cbz_ingestion_batches_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_incidents DROP CONSTRAINT IF EXISTS cbz_incidents_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_geospatial DROP CONSTRAINT IF EXISTS cbz_geospatial_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financial_inclusion DROP CONSTRAINT IF EXISTS cbz_financial_inclusion_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financed_positions DROP CONSTRAINT IF EXISTS cbz_financed_positions_counterparty_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_submitted_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_entities DROP CONSTRAINT IF EXISTS cbz_entities_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_departments DROP CONSTRAINT IF EXISTS cbz_departments_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_counterparties DROP CONSTRAINT IF EXISTS cbz_counterparties_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_audit_log DROP CONSTRAINT IF EXISTS cbz_audit_log_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_bank_id_fkey;
DROP TRIGGER IF EXISTS users_updated_at ON mavhu.users;
DROP TRIGGER IF EXISTS user_roles_updated_at ON mavhu.user_roles;
DROP TRIGGER IF EXISTS satellite_ndvi_co2_updated_at ON mavhu.satellite_ndvi_co2;
DROP TRIGGER IF EXISTS estates_updated_at ON mavhu.estates;
DROP TRIGGER IF EXISTS emissions_accounting_updated_at ON mavhu.emissions_accounting;
DROP TRIGGER IF EXISTS customer_updated_at ON mavhu.customers;
DROP TRIGGER IF EXISTS crop_cycles_updated_at ON mavhu.crop_cycles;
DROP TRIGGER IF EXISTS cbz_workforce_updated_at ON mavhu.cbz_workforce;
DROP TRIGGER IF EXISTS cbz_risk_entries_updated_at ON mavhu.cbz_risk_entries;
DROP TRIGGER IF EXISTS cbz_reporting_periods_updated_at ON mavhu.cbz_reporting_periods;
DROP TRIGGER IF EXISTS cbz_members_updated_at ON mavhu.cbz_members;
DROP TRIGGER IF EXISTS cbz_insurance_policies_updated_at ON mavhu.cbz_insurance_policies;
DROP TRIGGER IF EXISTS cbz_ingestion_batches_updated_at ON mavhu.cbz_ingestion_batches;
DROP TRIGGER IF EXISTS cbz_incidents_updated_at ON mavhu.cbz_incidents;
DROP TRIGGER IF EXISTS cbz_geospatial_updated_at ON mavhu.cbz_geospatial;
DROP TRIGGER IF EXISTS cbz_financial_inclusion_updated_at ON mavhu.cbz_financial_inclusion;
DROP TRIGGER IF EXISTS cbz_financed_positions_updated_at ON mavhu.cbz_financed_positions;
DROP TRIGGER IF EXISTS cbz_esg_emissions_updated_at ON mavhu.cbz_esg_emissions;
DROP TRIGGER IF EXISTS cbz_entities_updated_at ON mavhu.cbz_entities;
DROP TRIGGER IF EXISTS cbz_departments_updated_at ON mavhu.cbz_departments;
DROP TRIGGER IF EXISTS cbz_counterparties_updated_at ON mavhu.cbz_counterparties;
DROP TRIGGER IF EXISTS banks_updated_at ON mavhu.banks;
DROP TRIGGER IF EXISTS bank_customers_updated_at ON mavhu.bank_customers;
DROP INDEX IF EXISTS mavhu.idx_cbz_risk_entries_bank_id;
DROP INDEX IF EXISTS mavhu.idx_cbz_entities_bank_id;
DROP INDEX IF EXISTS mavhu.idx_cbz_audit_log_bank_id;
ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.user_roles DROP CONSTRAINT IF EXISTS user_roles_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.satellite_ndvi_co2 DROP CONSTRAINT IF EXISTS uq_satellite_customer_estate_date;
ALTER TABLE IF EXISTS ONLY mavhu.role_permissions DROP CONSTRAINT IF EXISTS uq_role_api;
ALTER TABLE IF EXISTS ONLY mavhu.emission_factors DROP CONSTRAINT IF EXISTS uq_emission_factors_name_component;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_reporting_periods DROP CONSTRAINT IF EXISTS uq_cbz_reporting_period;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS uq_bank_customer_reference_number;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS uq_bank_customer;
ALTER TABLE IF EXISTS ONLY mavhu.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_filename_key;
ALTER TABLE IF EXISTS ONLY mavhu.satellite_ndvi_co2 DROP CONSTRAINT IF EXISTS satellite_ndvi_co2_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.roles DROP CONSTRAINT IF EXISTS roles_name_key;
ALTER TABLE IF EXISTS ONLY mavhu.role_permissions DROP CONSTRAINT IF EXISTS role_permissions_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.estates DROP CONSTRAINT IF EXISTS estates_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.estates DROP CONSTRAINT IF EXISTS estates_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.emissions_accounting DROP CONSTRAINT IF EXISTS emissions_accounting_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.emission_factors DROP CONSTRAINT IF EXISTS emission_factors_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.customers DROP CONSTRAINT IF EXISTS customers_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.customers DROP CONSTRAINT IF EXISTS customers_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.crop_cycles DROP CONSTRAINT IF EXISTS crop_cycles_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_workforce DROP CONSTRAINT IF EXISTS cbz_workforce_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_risk_entries DROP CONSTRAINT IF EXISTS cbz_risk_entries_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_reporting_periods DROP CONSTRAINT IF EXISTS cbz_reporting_periods_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_insurance_policies DROP CONSTRAINT IF EXISTS cbz_insurance_policies_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_ingestion_batches DROP CONSTRAINT IF EXISTS cbz_ingestion_batches_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_incidents DROP CONSTRAINT IF EXISTS cbz_incidents_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_geospatial DROP CONSTRAINT IF EXISTS cbz_geospatial_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financial_inclusion DROP CONSTRAINT IF EXISTS cbz_financial_inclusion_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financed_positions DROP CONSTRAINT IF EXISTS cbz_financed_positions_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_entities DROP CONSTRAINT IF EXISTS cbz_entities_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_departments DROP CONSTRAINT IF EXISTS cbz_departments_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_counterparties DROP CONSTRAINT IF EXISTS cbz_counterparties_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_audit_log DROP CONSTRAINT IF EXISTS cbz_audit_log_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.banks DROP CONSTRAINT IF EXISTS banks_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.banks DROP CONSTRAINT IF EXISTS banks_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.apis DROP CONSTRAINT IF EXISTS apis_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.apis DROP CONSTRAINT IF EXISTS apis_name_key;
ALTER TABLE IF EXISTS mavhu.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.user_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.schema_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.satellite_ndvi_co2 ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.role_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.estates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.emissions_accounting ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.emission_factors ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.crop_cycles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.cbz_reporting_periods ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.banks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.bank_customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.apis ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS mavhu.users_id_seq;
DROP TABLE IF EXISTS mavhu.users;
DROP SEQUENCE IF EXISTS mavhu.user_roles_id_seq;
DROP TABLE IF EXISTS mavhu.user_roles;
DROP SEQUENCE IF EXISTS mavhu.schema_migrations_id_seq;
DROP TABLE IF EXISTS mavhu.schema_migrations;
DROP SEQUENCE IF EXISTS mavhu.satellite_ndvi_co2_id_seq;
DROP TABLE IF EXISTS mavhu.satellite_ndvi_co2;
DROP SEQUENCE IF EXISTS mavhu.roles_id_seq;
DROP TABLE IF EXISTS mavhu.roles;
DROP SEQUENCE IF EXISTS mavhu.role_permissions_id_seq;
DROP TABLE IF EXISTS mavhu.role_permissions;
DROP SEQUENCE IF EXISTS mavhu.estates_id_seq;
DROP TABLE IF EXISTS mavhu.estates;
DROP SEQUENCE IF EXISTS mavhu.emissions_accounting_id_seq;
DROP TABLE IF EXISTS mavhu.emissions_accounting;
DROP SEQUENCE IF EXISTS mavhu.emission_factors_id_seq;
DROP TABLE IF EXISTS mavhu.emission_factors;
DROP SEQUENCE IF EXISTS mavhu.customers_id_seq;
DROP TABLE IF EXISTS mavhu.customers;
DROP SEQUENCE IF EXISTS mavhu.crop_cycles_id_seq;
DROP TABLE IF EXISTS mavhu.crop_cycles;
DROP TABLE IF EXISTS mavhu.cbz_workforce;
DROP TABLE IF EXISTS mavhu.cbz_risk_entries;
DROP SEQUENCE IF EXISTS mavhu.cbz_reporting_periods_id_seq;
DROP TABLE IF EXISTS mavhu.cbz_reporting_periods;
DROP TABLE IF EXISTS mavhu.cbz_members;
DROP TABLE IF EXISTS mavhu.cbz_insurance_policies;
DROP TABLE IF EXISTS mavhu.cbz_ingestion_batches;
DROP TABLE IF EXISTS mavhu.cbz_incidents;
DROP TABLE IF EXISTS mavhu.cbz_geospatial;
DROP TABLE IF EXISTS mavhu.cbz_financial_inclusion;
DROP TABLE IF EXISTS mavhu.cbz_financed_positions;
DROP TABLE IF EXISTS mavhu.cbz_esg_emissions;
DROP TABLE IF EXISTS mavhu.cbz_entities;
DROP TABLE IF EXISTS mavhu.cbz_departments;
DROP TABLE IF EXISTS mavhu.cbz_counterparties;
DROP TABLE IF EXISTS mavhu.cbz_audit_log;
DROP SEQUENCE IF EXISTS mavhu.banks_id_seq;
DROP TABLE IF EXISTS mavhu.banks;
DROP SEQUENCE IF EXISTS mavhu.bank_customers_id_seq;
DROP TABLE IF EXISTS mavhu.bank_customers;
DROP SEQUENCE IF EXISTS mavhu.apis_id_seq;
DROP TABLE IF EXISTS mavhu.apis;
DROP SCHEMA IF EXISTS mavhu;
--
-- Name: mavhu; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA mavhu;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: apis; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.apis (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: apis_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.apis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: apis_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.apis_id_seq OWNED BY mavhu.apis.id;


--
-- Name: bank_customers; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.bank_customers (
    id integer NOT NULL,
    bank_id integer NOT NULL,
    customer_id integer NOT NULL,
    customer_reference_number character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: bank_customers_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.bank_customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bank_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.bank_customers_id_seq OWNED BY mavhu.bank_customers.id;


--
-- Name: banks; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.banks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    country character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(255),
    identifier character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    modules text[] DEFAULT ARRAY['snapshot'::text, 'portfolio'::text, 'insurance'::text, 'risk'::text, 'predictive'::text, 'workflow'::text, 'entity'::text, 'data-entry'::text, 'members'::text] NOT NULL,
    CONSTRAINT banks_status_check CHECK (((status)::text = ANY ((ARRAY['onboarding'::character varying, 'active'::character varying, 'suspended'::character varying])::text[])))
);


--
-- Name: banks_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.banks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.banks_id_seq OWNED BY mavhu.banks.id;


--
-- Name: cbz_audit_log; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_audit_log (
    id character varying(40) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    actor character varying(255) NOT NULL,
    action character varying(50) NOT NULL,
    entity_code character varying(20),
    target_type character varying(30) NOT NULL,
    target_id character varying(50),
    detail text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bank_id integer
);


--
-- Name: cbz_counterparties; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_counterparties (
    id character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    sector character varying(100) NOT NULL,
    listed_status character varying(20) NOT NULL,
    asset_class character varying(50) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    financials jsonb DEFAULT '{}'::jsonb NOT NULL,
    total_emissions_tco2e numeric(15,4) DEFAULT 0 NOT NULL,
    dq_score smallint NOT NULL,
    mrv_enhanced boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_departments; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_departments (
    id character varying(40) NOT NULL,
    entity_code character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    kind character varying(100) NOT NULL,
    head_of_dept character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_entities; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_entities (
    code character varying(20) NOT NULL,
    name character varying(255) NOT NULL,
    segment character varying(255) NOT NULL,
    regulator character varying(100) NOT NULL,
    pcaf_applicable character varying(255) DEFAULT ''::character varying NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bank_id integer NOT NULL
);


--
-- Name: cbz_esg_emissions; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_esg_emissions (
    id character varying(40) NOT NULL,
    entity_code character varying(20) NOT NULL,
    site character varying(255) NOT NULL,
    period character varying(20) NOT NULL,
    scope character varying(10) NOT NULL,
    dataset_type character varying(100) NOT NULL,
    fuel_type character varying(50),
    activity_data numeric(15,4) NOT NULL,
    unit character varying(50) NOT NULL,
    emission_factor_kg_per_unit numeric(15,6) NOT NULL,
    emissions_kg_co2e numeric(15,4) NOT NULL,
    emissions_tco2e numeric(15,6) NOT NULL,
    method character varying(30) NOT NULL,
    data_quality smallint NOT NULL,
    status character varying(20) DEFAULT 'draft'::character varying NOT NULL,
    source_ref character varying(255) DEFAULT ''::character varying NOT NULL,
    submitted_by character varying(40),
    submitted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    approved_by character varying(40),
    approved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_financed_positions; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_financed_positions (
    id character varying(40) NOT NULL,
    counterparty_id character varying(40) NOT NULL,
    outstanding_amount_usd numeric(15,2) NOT NULL,
    period character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_financial_inclusion; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_financial_inclusion (
    id character varying(20) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    programme character varying(255) NOT NULL,
    beneficiary_count integer NOT NULL,
    female_share numeric(5,4) NOT NULL,
    total_disbursed_usd numeric(15,2) NOT NULL,
    geography character varying(255) NOT NULL,
    sdg_alignment character varying(255) NOT NULL,
    repayment_rate numeric(5,4) NOT NULL,
    period character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_geospatial; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_geospatial (
    id character varying(20) NOT NULL,
    linked_borrower_name character varying(255) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    district character varying(100) NOT NULL,
    coordinates character varying(50) NOT NULL,
    pass_date date NOT NULL,
    data_source character varying(20) NOT NULL,
    ndvi numeric(8,4),
    land_use character varying(255) NOT NULL,
    area_ha numeric(10,2) NOT NULL,
    deforestation_flag character varying(50) NOT NULL,
    flood_risk character varying(10) NOT NULL,
    drought_stress character varying(10) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_incidents; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_incidents (
    id character varying(40) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    date_reported date NOT NULL,
    category character varying(30) NOT NULL,
    description text NOT NULL,
    severity character varying(20) NOT NULL,
    status character varying(20) NOT NULL,
    corrective_action text DEFAULT ''::text NOT NULL,
    closure_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_ingestion_batches; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_ingestion_batches (
    id character varying(40) NOT NULL,
    file_name character varying(255) NOT NULL,
    channel character varying(100) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    uploaded_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    records_processed integer DEFAULT 0 NOT NULL,
    validation_status character varying(20) NOT NULL,
    error_details text DEFAULT ''::text NOT NULL,
    notification_sent boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_insurance_policies; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_insurance_policies (
    id character varying(40) NOT NULL,
    segment character varying(100) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    client_id character varying(50) NOT NULL,
    client_name character varying(255) NOT NULL,
    sector character varying(100) NOT NULL,
    gross_written_premium_usd numeric(15,2) NOT NULL,
    denominator_type character varying(255) NOT NULL,
    denominator_value_usd numeric(20,2),
    client_total_emissions numeric(15,4) NOT NULL,
    attribution_factor numeric(15,8) NOT NULL,
    insurance_associated_emissions numeric(15,4) NOT NULL,
    dq_score smallint NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: cbz_members; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_members (
    id character varying(40) NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    phone character varying(50) DEFAULT ''::character varying NOT NULL,
    entity_code character varying(20) NOT NULL,
    department_id character varying(40),
    role character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: cbz_reporting_periods; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_reporting_periods (
    id integer NOT NULL,
    bank_id integer NOT NULL,
    period character varying(20) NOT NULL,
    status character varying(10) DEFAULT 'open'::character varying NOT NULL,
    locked_by character varying(255),
    locked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT cbz_reporting_periods_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'locked'::character varying])::text[])))
);


--
-- Name: cbz_reporting_periods_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.cbz_reporting_periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cbz_reporting_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.cbz_reporting_periods_id_seq OWNED BY mavhu.cbz_reporting_periods.id;


--
-- Name: cbz_risk_entries; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_risk_entries (
    id character varying(40) NOT NULL,
    title character varying(255) NOT NULL,
    category character varying(30) NOT NULL,
    likelihood smallint NOT NULL,
    impact smallint NOT NULL,
    owner character varying(255) NOT NULL,
    status character varying(30) NOT NULL,
    linked_entity character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bank_id integer
);


--
-- Name: cbz_workforce; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_workforce (
    id character varying(20) NOT NULL,
    subsidiary character varying(20) NOT NULL,
    period character varying(20) NOT NULL,
    headcount integer NOT NULL,
    female_share numeric(5,4) NOT NULL,
    avg_training_hours numeric(8,2) NOT NULL,
    lti_rate numeric(8,4) NOT NULL,
    voluntary_turnover numeric(5,4) NOT NULL,
    local_hire_share numeric(5,4) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: crop_cycles; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.crop_cycles (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    estate_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    audit_trail text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: crop_cycles_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.crop_cycles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: crop_cycles_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.crop_cycles_id_seq OWNED BY mavhu.crop_cycles.id;


--
-- Name: customers; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.customers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    hectares integer NOT NULL,
    country character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(255),
    identifier public.customer_identifier NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    CONSTRAINT customers_hectares_check CHECK ((hectares > 0))
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.customers_id_seq OWNED BY mavhu.customers.id;


--
-- Name: emission_factors; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.emission_factors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    component character varying(255) NOT NULL,
    factor numeric(10,4) NOT NULL,
    gwp numeric(10,4) NOT NULL,
    description character varying(1000),
    unit character varying(255) NOT NULL
);


--
-- Name: emission_factors_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.emission_factors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emission_factors_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.emission_factors_id_seq OWNED BY mavhu.emission_factors.id;


--
-- Name: emissions_accounting; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.emissions_accounting (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    estate_id integer NOT NULL,
    created_by integer,
    crop_cycle_id integer NOT NULL,
    emission_id integer NOT NULL,
    quantity numeric(10,4) NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    ton_co2e numeric(10,4),
    scope integer NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    approved_by integer,
    audit_trail text,
    note text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT emissions_accounting_scope_check CHECK (((scope >= 1) AND (scope <= 3)))
);


--
-- Name: emissions_accounting_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.emissions_accounting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emissions_accounting_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.emissions_accounting_id_seq OWNED BY mavhu.emissions_accounting.id;


--
-- Name: estates; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.estates (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    hectares integer NOT NULL,
    customer_id integer NOT NULL,
    country character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT estates_hectares_check CHECK ((hectares > 0))
);


--
-- Name: estates_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.estates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estates_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.estates_id_seq OWNED BY mavhu.estates.id;


--
-- Name: role_permissions; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.role_permissions (
    id integer NOT NULL,
    role_id integer NOT NULL,
    api_id integer NOT NULL
);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.role_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.role_permissions_id_seq OWNED BY mavhu.role_permissions.id;


--
-- Name: roles; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.roles_id_seq OWNED BY mavhu.roles.id;


--
-- Name: satellite_ndvi_co2; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.satellite_ndvi_co2 (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    estate_id integer NOT NULL,
    date date NOT NULL,
    ndvi_mean numeric(16,15),
    ndvi_min numeric(16,15),
    ndvi_max numeric(16,15),
    ndvi_std numeric(16,15),
    ndwi_mean numeric(16,15),
    ndwi_min numeric(16,15),
    ndwi_max numeric(16,15),
    ndwi_std numeric(16,15),
    ndbi_mean numeric(16,15),
    ndbi_min numeric(16,15),
    ndbi_max numeric(16,15),
    ndbi_std numeric(16,15),
    above_ground_biomass numeric(7,4),
    below_ground_biomass numeric(7,4),
    biomass_carbon numeric(7,4),
    biomass_co2 numeric(7,4),
    biomass_co2_total numeric(10,4),
    soil_organic_carbon numeric(7,4),
    soil_organic_carbon_co2 numeric(7,4),
    soil_organic_carbon_co2_total numeric(10,4),
    net_co2_stock numeric(10,4),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT satellite_ndvi_co2_ndbi_max_check CHECK (((ndbi_max >= '-1.0'::numeric) AND (ndbi_max <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndbi_mean_check CHECK (((ndbi_mean >= '-1.0'::numeric) AND (ndbi_mean <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndbi_min_check CHECK (((ndbi_min >= '-1.0'::numeric) AND (ndbi_min <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndbi_std_check CHECK (((ndbi_std >= '-1.0'::numeric) AND (ndbi_std <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndvi_max_check CHECK (((ndvi_max >= '-1.0'::numeric) AND (ndvi_max <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndvi_mean_check CHECK (((ndvi_mean >= '-1.0'::numeric) AND (ndvi_mean <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndvi_min_check CHECK (((ndvi_min >= '-1.0'::numeric) AND (ndvi_min <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndvi_std_check CHECK (((ndvi_std >= '-1.0'::numeric) AND (ndvi_std <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndwi_max_check CHECK (((ndwi_max >= '-1.0'::numeric) AND (ndwi_max <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndwi_mean_check CHECK (((ndwi_mean >= '-1.0'::numeric) AND (ndwi_mean <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndwi_min_check CHECK (((ndwi_min >= '-1.0'::numeric) AND (ndwi_min <= 1.0))),
    CONSTRAINT satellite_ndvi_co2_ndwi_std_check CHECK (((ndwi_std >= '-1.0'::numeric) AND (ndwi_std <= 1.0)))
);


--
-- Name: satellite_ndvi_co2_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.satellite_ndvi_co2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: satellite_ndvi_co2_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.satellite_ndvi_co2_id_seq OWNED BY mavhu.satellite_ndvi_co2.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.schema_migrations (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    applied_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: schema_migrations_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.schema_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schema_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.schema_migrations_id_seq OWNED BY mavhu.schema_migrations.id;


--
-- Name: user_roles; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.user_roles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    audit_trail text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.user_roles_id_seq OWNED BY mavhu.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    customer_id integer NOT NULL,
    estate_id integer,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.users_id_seq OWNED BY mavhu.users.id;


--
-- Name: apis id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.apis ALTER COLUMN id SET DEFAULT nextval('mavhu.apis_id_seq'::regclass);


--
-- Name: bank_customers id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers ALTER COLUMN id SET DEFAULT nextval('mavhu.bank_customers_id_seq'::regclass);


--
-- Name: banks id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.banks ALTER COLUMN id SET DEFAULT nextval('mavhu.banks_id_seq'::regclass);


--
-- Name: cbz_reporting_periods id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_reporting_periods ALTER COLUMN id SET DEFAULT nextval('mavhu.cbz_reporting_periods_id_seq'::regclass);


--
-- Name: crop_cycles id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.crop_cycles ALTER COLUMN id SET DEFAULT nextval('mavhu.crop_cycles_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.customers ALTER COLUMN id SET DEFAULT nextval('mavhu.customers_id_seq'::regclass);


--
-- Name: emission_factors id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emission_factors ALTER COLUMN id SET DEFAULT nextval('mavhu.emission_factors_id_seq'::regclass);


--
-- Name: emissions_accounting id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting ALTER COLUMN id SET DEFAULT nextval('mavhu.emissions_accounting_id_seq'::regclass);


--
-- Name: estates id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.estates ALTER COLUMN id SET DEFAULT nextval('mavhu.estates_id_seq'::regclass);


--
-- Name: role_permissions id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.role_permissions ALTER COLUMN id SET DEFAULT nextval('mavhu.role_permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.roles ALTER COLUMN id SET DEFAULT nextval('mavhu.roles_id_seq'::regclass);


--
-- Name: satellite_ndvi_co2 id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.satellite_ndvi_co2 ALTER COLUMN id SET DEFAULT nextval('mavhu.satellite_ndvi_co2_id_seq'::regclass);


--
-- Name: schema_migrations id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.schema_migrations ALTER COLUMN id SET DEFAULT nextval('mavhu.schema_migrations_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.user_roles ALTER COLUMN id SET DEFAULT nextval('mavhu.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.users ALTER COLUMN id SET DEFAULT nextval('mavhu.users_id_seq'::regclass);


--
-- Data for Name: apis; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.apis (id, name) FROM stdin;
\.


--
-- Data for Name: bank_customers; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.bank_customers (id, bank_id, customer_id, customer_reference_number, created_at, updated_at) FROM stdin;
1	1	6	CBZ-AGR-0001	2026-09-24 08:22:50.187464+02	2026-09-24 08:22:50.187464+02
2	1	7	CBZ-AGR-0002	2026-09-24 08:22:50.19456+02	2026-09-24 08:22:50.19456+02
3	1	8	CBZ-AGR-0003	2026-09-24 08:22:50.197109+02	2026-09-24 08:22:50.197109+02
4	2	9	STB-AGR-0001	2026-09-24 08:22:50.199108+02	2026-09-24 08:22:50.199108+02
5	3	7	FBC-AGR-0001	2026-09-24 08:22:50.201275+02	2026-09-24 08:22:50.201275+02
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.banks (id, name, country, email, phone_number, identifier, created_at, updated_at, is_deleted, status, modules) FROM stdin;
1	CBZ Bank Limited	Zimbabwe	contact@cbz.co.zw	\N	CBZ-ZW-001	2026-09-24 08:22:50.176256+02	2026-09-24 08:22:50.176256+02	f	active	{snapshot,portfolio,insurance,risk,predictive,workflow,entity,data-entry,members}
2	Stanbic Bank Zimbabwe	Zimbabwe	contact@stanbicbank.co.zw	\N	STANBIC-ZW-001	2026-09-24 08:22:50.180001+02	2026-09-24 08:22:50.180001+02	f	active	{snapshot,portfolio,insurance,risk,predictive,workflow,entity,data-entry,members}
3	FBC Bank Limited	Zimbabwe	contact@fbc.co.zw	\N	FBC-ZW-001	2026-09-24 08:22:50.182259+02	2026-10-04 22:28:08.753704+02	f	active	{snapshot,portfolio,insurance,risk,predictive,workflow,entity,data-entry,members}
\.


--
-- Data for Name: cbz_audit_log; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_audit_log (id, "timestamp", actor, action, entity_code, target_type, target_id, detail, created_at, bank_id) FROM stdin;
AUDIT-001	2026-09-02 10:14:00+02	Melissa Chirandu	INGEST	CBZBANK	EmissionRecord	S1-001	Uploaded CBZBANK Scope 1 fleet fuel for 2026-08 (9 records)	2026-09-28 09:11:14.509635+02	1
AUDIT-002	2026-09-03 12:00:00+02	Tafara Chikwanha	APPROVE	CBZBANK	EmissionRecord	S1-001	Approved batch of 4 Scope 1 records for CBZBANK 2026-08	2026-09-28 09:11:14.515057+02	1
AUDIT-003	2026-09-05 16:22:00+02	Anesu Mutasa	INGEST_PARTIAL	CBZBANK	EmissionRecord	BATCH-2604	Batch BATCH-2604: 118 records posted, 6 rejected (denominator missing)	2026-09-28 09:11:14.518784+02	1
AUDIT-004	2026-09-06 12:00:00+02	Anesu Mutasa	APPROVE	GROUP	EmissionRecord	S3-001	Approved Group Scope 3 category 1 & 5 records	2026-09-28 09:11:14.523192+02	1
AUDIT-005	2026-09-06 15:47:00+02	Blessing Mutasa	INGEST	CBZCAP	EmissionRecord	BATCH-2608	Uploaded CBZCAP facilitated emissions batch for 2026	2026-09-28 09:11:14.527576+02	1
STB-AUD-1	2026-09-20 10:00:00+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	2
STW-AUD-1	2026-09-20 10:00:00+02	Chiedza Sibanda	LOGIN	STANWLTH	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	2
FBB-AUD-1	2026-09-20 10:00:00+02	Simbarashe Marufu	LOGIN	FBCBANK	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	3
FBI-AUD-1	2026-09-20 10:00:00+02	Rutendo Hove	LOGIN	FBCINS	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	3
STB-AUD-2	2026-09-20 11:00:00+02	Kudakwashe Chigumba	CREATE	STANBANK	Counterparty	STB-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	2
STW-AUD-2	2026-09-20 11:00:00+02	Vimbai Nyathi	CREATE	STANWLTH	Counterparty	STW-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	2
FBB-AUD-2	2026-09-20 11:00:00+02	Takudzwa Zvobgo	CREATE	FBCBANK	Counterparty	FBB-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	3
FBI-AUD-2	2026-09-20 11:00:00+02	Shamiso Chirwa	CREATE	FBCINS	Counterparty	FBI-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	3
STB-AUD-3	2026-09-20 12:00:00+02	Kudakwashe Chigumba	SUBMIT	STANBANK	EmissionRecord	STB-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	2
STW-AUD-3	2026-09-20 12:00:00+02	Vimbai Nyathi	SUBMIT	STANWLTH	EmissionRecord	STW-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	2
FBB-AUD-3	2026-09-20 12:00:00+02	Takudzwa Zvobgo	SUBMIT	FBCBANK	EmissionRecord	FBB-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	3
FBI-AUD-3	2026-09-20 12:00:00+02	Shamiso Chirwa	SUBMIT	FBCINS	EmissionRecord	FBI-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	3
STB-AUD-4	2026-09-20 13:00:00+02	Rumbidzai Ndlovu	APPROVE	STANBANK	EmissionRecord	STB-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	2
STW-AUD-4	2026-09-20 13:00:00+02	Tapiwa Gumbo	APPROVE	STANWLTH	EmissionRecord	STW-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	2
FBB-AUD-4	2026-09-20 13:00:00+02	Tsitsi Chinoda	APPROVE	FBCBANK	EmissionRecord	FBB-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	3
FBI-AUD-4	2026-09-20 13:00:00+02	Tonderai Maposa	APPROVE	FBCINS	EmissionRecord	FBI-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	3
STB-AUD-5	2026-09-20 14:00:00+02	Rumbidzai Ndlovu	LOCK	STANBANK	Workflow	STB-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	2
STW-AUD-5	2026-09-20 14:00:00+02	Tapiwa Gumbo	LOCK	STANWLTH	Workflow	STW-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	2
FBB-AUD-5	2026-09-20 14:00:00+02	Tsitsi Chinoda	LOCK	FBCBANK	Workflow	FBB-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	3
FBI-AUD-5	2026-09-20 14:00:00+02	Tonderai Maposa	LOCK	FBCINS	Workflow	FBI-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	3
4bcd9d68-7a23-4c64-9488-cc13f9ecefc7	2026-10-04 22:22:16.254+02	tendai.moyo@mavhu.africa (MAvHU)	LOCK	GROUP	Workflow	2026-Q4	Locked reporting period 2026-Q4 for CBZ Bank Limited	2026-10-04 22:22:16.256419+02	1
66f62bdf-4836-4e5e-912f-82c16e5f7c9b	2026-10-04 22:22:20.509+02	tendai.moyo@mavhu.africa (MAvHU)	UNLOCK	GROUP	Workflow	2026-Q4	Reopened reporting period 2026-Q4 for CBZ Bank Limited	2026-10-04 22:22:20.512501+02	1
f6400a11-d24a-4d0b-83e8-d3f14ea702da	2026-10-04 22:27:52.398+02	tendai.moyo@mavhu.africa (MAvHU)	UPDATE	\N	Bank	3	Updated undefined: modules → snapshot, portfolio, risk	2026-10-04 22:27:52.399527+02	3
\.


--
-- Data for Name: cbz_counterparties; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_counterparties (id, name, sector, listed_status, asset_class, subsidiary, financials, total_emissions_tco2e, dq_score, mrv_enhanced, created_at, updated_at) FROM stdin;
CP-001	Mashonaland Grain Millers (Pvt) Ltd	Agri-processing	Unlisted	business_loans_unlisted_equity	CBZBANK	{"totalRevenue": 6800000, "totalEquityDebt": 4800000}	2850.0000	3	t	2026-09-28 09:11:13.929013+02	2026-09-28 09:11:13.929013+02
CP-002	Manyame Textiles Ltd	Manufacturing	Unlisted	business_loans_unlisted_equity	CBZAGRO	{"totalRevenue": 3100000, "totalEquityDebt": 2100000}	1920.0000	4	f	2026-09-28 09:11:13.935051+02	2026-09-28 09:11:13.935051+02
CP-003	Highveld Beverages PLC	Consumer goods	Listed	business_loans_listed	CBZBANK	{"evic": 145000000, "totalRevenue": 210000000}	41200.0000	4	f	2026-09-28 09:11:13.940506+02	2026-09-28 09:11:13.940506+02
CP-004	Nyanga Hydro Partners (Pvt) Ltd	Renewable energy	Unlisted	project_finance	CBZCAP	{"projectTotalCost": 18500000}	1150.0000	2	t	2026-09-28 09:11:13.946345+02	2026-09-28 09:11:13.946345+02
CP-005	Chinhoyi Solar Partners (Pvt) Ltd	Renewable energy	Unlisted	project_finance	CBZCAP	{"projectTotalCost": 9700000}	480.0000	2	t	2026-09-28 09:11:13.95131+02	2026-09-28 09:11:13.95131+02
CP-006	Borrowdale Office Park (Pvt) Ltd	Real estate	Unlisted	commercial_real_estate	CBZPROP	{"propertyValue": 12800000}	980.0000	4	f	2026-09-28 09:11:13.956498+02	2026-09-28 09:11:13.956498+02
CP-007	Msasa Industrial Park (Pvt) Ltd	Real estate	Unlisted	commercial_real_estate	CBZBANK	{"propertyValue": 7900000}	1340.0000	4	f	2026-09-28 09:11:13.961327+02	2026-09-28 09:11:13.961327+02
CP-008	Retail Mortgage Customer #00214	Residential	n/a	mortgages	CBZBANK	{"propertyValue": 260000}	6.4000	4	f	2026-09-28 09:11:13.966006+02	2026-09-28 09:11:13.966006+02
CP-009	Retail Mortgage Customer #00389	Residential	n/a	mortgages	CBZBANK	{"propertyValue": 140000}	4.1000	4	f	2026-09-28 09:11:13.971096+02	2026-09-28 09:11:13.971096+02
CP-010	Retail Vehicle Loan #01023	Personal transport	n/a	motor_vehicle_loans	CBZBANK	{"vehicleValue": 24000}	3.2000	3	f	2026-09-28 09:11:13.975915+02	2026-09-28 09:11:13.975915+02
CP-011	Retail Vehicle Loan #01187	Personal transport	n/a	motor_vehicle_loans	CBZBANK	{"vehicleValue": 31500}	4.6000	3	f	2026-09-28 09:11:13.981473+02	2026-09-28 09:11:13.981473+02
CP-012	Eastlands Mining Corp PLC	Mining	Listed	listed_equity_corporate_bonds	DATVEST	{"evic": 68000000}	96500.0000	5	f	2026-09-28 09:11:13.986922+02	2026-09-28 09:11:13.986922+02
CP-013	Government of Zimbabwe 91-day Treasury Bill	Sovereign	Sovereign	sovereign_debt	DATVEST	{"gdpPpp": 44000000000}	28400000.0000	5	f	2026-09-28 09:11:13.991997+02	2026-09-28 09:11:13.991997+02
CP-014	Government of Zimbabwe ZWG Bond 2029	Sovereign	Sovereign	sovereign_debt	DATVEST	{"gdpPpp": 44000000000}	28400000.0000	5	f	2026-09-28 09:11:13.997057+02	2026-09-28 09:11:13.997057+02
CP-015	City of Harare Municipal Bond 2027	Sub-sovereign	Sub-sovereign	sub_sovereign_debt	DATVEST	{"regionalGdpPpp": 3200000000}	185000.0000	5	f	2026-09-28 09:11:14.001585+02	2026-09-28 09:11:14.001585+02
CP-016	Bulawayo City Council Water Infrastructure Note	Sub-sovereign	Sub-sovereign	sub_sovereign_debt	DATVEST	{"regionalGdpPpp": 1450000000}	92000.0000	5	f	2026-09-28 09:11:14.007039+02	2026-09-28 09:11:14.007039+02
CP-017	CBZ Green Infrastructure Bond 2026	Green bond	Unlisted	use_of_proceeds	CBZBANK	{"uopStructureValue": 3000000}	640.0000	3	t	2026-09-28 09:11:14.0108+02	2026-09-28 09:11:14.0108+02
CP-018	Agro-Yield Solar Mini-Grid Loan	Renewable energy	Unlisted	use_of_proceeds	CBZAGRO	{"uopStructureValue": 480000}	95.0000	2	t	2026-09-28 09:11:14.015656+02	2026-09-28 09:11:14.015656+02
STB-CP-1	Mazowe Citrus Growers	Agriculture	Unlisted	business_loans_unlisted_equity	STANBANK	{"totalRevenue": 5600000, "totalEquityDebt": 4000000}	2510.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-CP-1	Gwanda Gold Processing	Agriculture	Unlisted	business_loans_unlisted_equity	STANWLTH	{"totalRevenue": 7000000, "totalEquityDebt": 5000000}	2620.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-CP-1	Chegutu Dairy Co-op	Agriculture	Unlisted	business_loans_unlisted_equity	FBCBANK	{"totalRevenue": 8400000, "totalEquityDebt": 6000000}	2730.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-CP-1	Nyanga Timber Mills	Agriculture	Unlisted	business_loans_unlisted_equity	FBCINS	{"totalRevenue": 9800000, "totalEquityDebt": 7000000}	2840.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-CP-2	Borrowdale Brooke Homes	Residential real estate	Unlisted	mortgages	STANBANK	{"propertyValue": 1350000}	195.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-CP-2	Hillside Residential	Residential real estate	Unlisted	mortgages	STANWLTH	{"propertyValue": 1800000}	305.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-CP-2	Avondale Mortgages Pool	Residential real estate	Unlisted	mortgages	FBCBANK	{"propertyValue": 2250000}	415.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-CP-2	Greendale Housing Trust	Residential real estate	Unlisted	mortgages	FBCINS	{"propertyValue": 2700000}	525.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-CP-3	Eastgate Retail Park	Commercial property	Unlisted	commercial_real_estate	STANBANK	{"propertyValue": 9000000}	1070.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-CP-3	Fourth Street Offices	Commercial property	Unlisted	commercial_real_estate	STANWLTH	{"propertyValue": 10800000}	1180.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-CP-3	Sam Levy Commercial	Commercial property	Unlisted	commercial_real_estate	FBCBANK	{"propertyValue": 12600000}	1290.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-CP-3	Kwekwe Industrial Park	Commercial property	Unlisted	commercial_real_estate	FBCINS	{"propertyValue": 14400000}	1400.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-CP-4	Trans-Zambezi Haulage	Transport	Unlisted	motor_vehicle_loans	STANBANK	{"vehicleValue": 960000}	1860.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-CP-4	Matabeleland Logistics	Transport	Unlisted	motor_vehicle_loans	STANWLTH	{"vehicleValue": 1280000}	1970.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-CP-4	Masvingo Bus Lines	Transport	Unlisted	motor_vehicle_loans	FBCBANK	{"vehicleValue": 1600000}	2080.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-CP-4	Beitbridge Freight	Transport	Unlisted	motor_vehicle_loans	FBCINS	{"vehicleValue": 1920000}	2190.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-CP-5	Kariba North Solar	Renewable energy	Unlisted	project_finance	STANBANK	{"projectTotalCost": 15000000}	250.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-CP-5	Hwange Wind Farm	Renewable energy	Unlisted	project_finance	STANWLTH	{"projectTotalCost": 17500000}	360.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-CP-5	Save Valley Irrigation	Renewable energy	Unlisted	project_finance	FBCBANK	{"projectTotalCost": 20000000}	470.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-CP-5	Mutare Biogas Plant	Renewable energy	Unlisted	project_finance	FBCINS	{"projectTotalCost": 22500000}	580.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_departments; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_departments (id, entity_code, name, kind, head_of_dept, email, created_at, updated_at) FROM stdin;
DEPT-001	CBZBANK	Corporate & Commercial Banking	Commercial Banking	Tafara Chikwanha	corporate@cbz.co.zw	2026-09-28 09:11:13.847438+02	2026-09-28 09:11:13.847438+02
DEPT-002	CBZBANK	Retail & Mortgages	Commercial Banking	Nyasha Moyo	mortgages@cbz.co.zw	2026-09-28 09:11:13.855102+02	2026-09-28 09:11:13.855102+02
DEPT-003	CBZINS	Commercial Lines Underwriting	Short-term Insurance	Rutendo Mukamuri	commercial-underwriting@cbzinsurance.co.zw	2026-09-28 09:11:13.859969+02	2026-09-28 09:11:13.859969+02
DEPT-004	CBZINS	Personal & Motor Insurance	Short-term Insurance	Farai Ndlovu	motor@cbzinsurance.co.zw	2026-09-28 09:11:13.865071+02	2026-09-28 09:11:13.865071+02
DEPT-005	CBZAGRO	Contract Farming Operations	Agribusiness	Simba Chirwa	contracts@agroyield.co.zw	2026-09-28 09:11:13.869754+02	2026-09-28 09:11:13.869754+02
DEPT-006	CBZAGRO	Smallholder & Financial Inclusion	Microfinance	Chiedza Mangwiro	inclusion@agroyield.co.zw	2026-09-28 09:11:13.873763+02	2026-09-28 09:11:13.873763+02
DEPT-007	DATVEST	Fixed Income Portfolio	Asset Management	Kudakwashe Sithole	fixed-income@datvest.co.zw	2026-09-28 09:11:13.878056+02	2026-09-28 09:11:13.878056+02
DEPT-008	CBZCAP	Project & Structured Finance	Investment Banking	Blessing Mutasa	projects@cbzcapital.co.zw	2026-09-28 09:11:13.882037+02	2026-09-28 09:11:13.882037+02
DEPT-009	CBZPROP	Portfolio Operations	Property	Tendai Chikomo	ops@cbzproperties.co.zw	2026-09-28 09:11:13.886332+02	2026-09-28 09:11:13.886332+02
DEPT-010	CBZRED	Rural Micro-lending	Microfinance	Panashe Zvavamwe	rural@redsphere.co.zw	2026-09-28 09:11:13.890167+02	2026-09-28 09:11:13.890167+02
STB-DEPT-1	STANBANK	Corporate & Commercial Banking	Commercial Banking	Head of Corporate	corporate@stanbicbank.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-DEPT-1	STANWLTH	Corporate & Commercial Banking	Commercial Banking	Head of Corporate	corporate@stanbicwealth.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-DEPT-1	FBCBANK	Corporate & Commercial Banking	Commercial Banking	Head of Corporate	corporate@fbc.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-DEPT-1	FBCINS	Corporate & Commercial Banking	Commercial Banking	Head of Corporate	corporate@fbcinsurance.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-DEPT-2	STANBANK	Retail & Personal Banking	Commercial Banking	Head of Retail	retail@stanbicbank.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-DEPT-2	STANWLTH	Retail & Personal Banking	Commercial Banking	Head of Retail	retail@stanbicwealth.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-DEPT-2	FBCBANK	Retail & Personal Banking	Commercial Banking	Head of Retail	retail@fbc.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-DEPT-2	FBCINS	Retail & Personal Banking	Commercial Banking	Head of Retail	retail@fbcinsurance.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-DEPT-3	STANBANK	Treasury & Markets	Investment Banking	Head of Treasury	treasury@stanbicbank.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-DEPT-3	STANWLTH	Treasury & Markets	Investment Banking	Head of Treasury	treasury@stanbicwealth.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-DEPT-3	FBCBANK	Treasury & Markets	Investment Banking	Head of Treasury	treasury@fbc.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-DEPT-3	FBCINS	Treasury & Markets	Investment Banking	Head of Treasury	treasury@fbcinsurance.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-DEPT-4	STANBANK	Sustainability Office	Risk Advisory	Head of Sustainability	sustainability@stanbicbank.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-DEPT-4	STANWLTH	Sustainability Office	Risk Advisory	Head of Sustainability	sustainability@stanbicwealth.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-DEPT-4	FBCBANK	Sustainability Office	Risk Advisory	Head of Sustainability	sustainability@fbc.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-DEPT-4	FBCINS	Sustainability Office	Risk Advisory	Head of Sustainability	sustainability@fbcinsurance.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-DEPT-5	STANBANK	Risk & Compliance	Risk Advisory	Head of Risk	risk@stanbicbank.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-DEPT-5	STANWLTH	Risk & Compliance	Risk Advisory	Head of Risk	risk@stanbicwealth.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-DEPT-5	FBCBANK	Risk & Compliance	Risk Advisory	Head of Risk	risk@fbc.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-DEPT-5	FBCINS	Risk & Compliance	Risk Advisory	Head of Risk	risk@fbcinsurance.co.zw	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_entities; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_entities (code, name, segment, regulator, pcaf_applicable, notes, created_at, updated_at, bank_id) FROM stdin;
CBZBANK	CBZ Bank	Commercial & corporate banking	RBZ	A (lending), B (if underwriting)	Largest loan book; business loans, mortgages, motor vehicle, CRE	2026-09-28 09:11:13.772845+02	2026-10-04 22:10:18.087517+02	1
CBZCAP	CBZ Capital	Investment banking / capital markets	RBZ/SECZim	A (project finance), B (facilitated)	Facilitated-emissions scope pending mandate confirmation	2026-09-28 09:11:13.792326+02	2026-10-04 22:10:18.087517+02	1
DATVEST	Datvest (CBZ Asset Management)	Asset management	SECZim	A (listed equity, corp bonds, sovereign, sub-sovereign)	Holds fixed income incl. Treasury Bills	2026-09-28 09:11:13.798096+02	2026-10-04 22:10:18.087517+02	1
CBZAGRO	CBZ Agro-Yield	Agribusiness financing	RBZ	A (business loans), operational	Primary target for MAvHU satellite/geospatial MRV uplift	2026-09-28 09:11:13.806937+02	2026-10-04 22:10:18.087517+02	1
CBZPROP	CBZ Properties	Property investment	n/a	A (CRE)		2026-09-28 09:11:13.813038+02	2026-10-04 22:10:18.087517+02	1
CBZINS	CBZ Insurance	Short-term/general insurance	IPEC	C (insurance-associated)	Commercial lines, personal motor, project insurance, treaty reinsurance	2026-09-28 09:11:13.819648+02	2026-10-04 22:10:18.087517+02	1
CBZLIFE	CBZ Life	Life assurance	IPEC	None — operational only	Excluded from Part C; life/health/pensions not yet covered by any PCAF standard	2026-09-28 09:11:13.826235+02	2026-10-04 22:10:18.087517+02	1
CBZRISK	CBZ Risk Advisory	Insurance broking / risk advisory	IPEC	None — operational only	No PCAF asset class applies to pure advisory activity	2026-09-28 09:11:13.831932+02	2026-10-04 22:10:18.087517+02	1
CBZRED	CBZ Red Sphere Finance	Microfinance	RBZ	A (business loans, small scale)	Financial-inclusion reporting priority	2026-09-28 09:11:13.838919+02	2026-10-04 22:10:18.087517+02	1
STANWLTH	Stanbic Wealth	Wealth & asset management	SECZim	A (listed equity & bonds)	Synthetic demo subsidiary	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STANBANK	Stanbic Bank Zimbabwe	Corporate, business & retail banking	RBZ	A (lending)	Synthetic demo subsidiary	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBCINS	FBC Insurance	Short-term insurance	IPEC	C (insurance-associated)	Synthetic demo subsidiary	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBCBANK	FBC Bank	Commercial & retail banking	RBZ	A (lending)	Synthetic demo subsidiary	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
\.


--
-- Data for Name: cbz_esg_emissions; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_esg_emissions (id, entity_code, site, period, scope, dataset_type, fuel_type, activity_data, unit, emission_factor_kg_per_unit, emissions_kg_co2e, emissions_tco2e, method, data_quality, status, source_ref, submitted_by, submitted_at, approved_by, approved_at, created_at, updated_at) FROM stdin;
S1-001	CBZBANK	Harare Head Office	2026-08	scope1	Fleet fuel	Diesel	2450.0000	litres	2.680000	6566.0000	6.566000	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.113064+02	2026-09-28 09:11:14.113064+02
S1-002	CBZBANK	Bulawayo Branch	2026-08	scope1	Fleet fuel	Petrol	980.0000	litres	2.310000	2263.8000	2.263800	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.119908+02	2026-09-28 09:11:14.119908+02
S1-003	CBZAGRO	Mvurwi Regional Office	2026-08	scope1	Fleet fuel	Diesel	3120.0000	litres	2.680000	8361.6000	8.361600	activity-based	2	approved	CBZAGRO_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-AGRO	2026-09-02 10:14:00+02	USR-ADMIN	2026-09-04 12:00:00+02	2026-09-28 09:11:14.125415+02	2026-09-28 09:11:14.125415+02
S1-004	CBZBANK	Harare Head Office	2026-08	scope1	Backup generator	Diesel	1840.0000	litres	2.680000	4931.2000	4.931200	activity-based	2	approved	CBZBANK_SCOPE1_GENSET_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 11:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.130748+02	2026-09-28 09:11:14.130748+02
S1-005	CBZINS	Harare Underwriting Centre	2026-08	scope1	Backup generator	Diesel	610.0000	litres	2.680000	1634.8000	1.634800	activity-based	2	approved	CBZINS_SCOPE1_GENSET_2026-08_v1.csv	USR-CONTRIB-INS	2026-09-02 11:41:00+02	USR-ADMIN	2026-09-04 12:00:00+02	2026-09-28 09:11:14.136769+02	2026-09-28 09:11:14.136769+02
S1-006	CBZPROP	Borrowdale Office Park	2026-08	scope1	Backup generator	Diesel	940.0000	litres	2.680000	2519.2000	2.519200	activity-based	2	approved	CBZPROP_SCOPE1_GENSET_2026-08_v1.csv	USR-ADMIN	2026-09-02 11:15:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.14301+02	2026-09-28 09:11:14.14301+02
S1-007	CBZBANK	Harare Head Office	2026-08	scope1	Refrigerant top-up	R410A	4.5000	kg	2088.000000	9396.0000	9.396000	activity-based	2	approved	CBZBANK_SCOPE1_REFRIG_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 11:30:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.148474+02	2026-09-28 09:11:14.148474+02
S1-008	DATVEST	Harare Office	2026-08	scope1	Refrigerant top-up	R134a	1.8000	kg	1430.000000	2574.0000	2.574000	activity-based	2	approved	DATVEST_SCOPE1_REFRIG_2026-08_v1.csv	USR-READER-DATVEST	2026-09-02 12:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.15353+02	2026-09-28 09:11:14.15353+02
S1-009	CBZBANK	Mutare Branch	2026-08	scope1	Fleet fuel	Diesel	1120.0000	litres	2.680000	3001.6000	3.001600	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.158201+02	2026-09-28 09:11:14.158201+02
S1-010	CBZRED	Masvingo Agent Hub	2026-08	scope1	Fleet fuel	Petrol	560.0000	litres	2.310000	1293.6000	1.293600	activity-based	2	approved	CBZRED_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-ADMIN	2026-09-02 10:14:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.163661+02	2026-09-28 09:11:14.163661+02
S2-001	CBZBANK	Harare Head Office	2026-08	scope2	Grid electricity (location-based)	\N	84500.0000	kWh	0.650000	54925.0000	54.925000	activity-based	2	approved	CBZBANK_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 13:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.168625+02	2026-09-28 09:11:14.168625+02
S2-002	CBZBANK	Bulawayo Branch	2026-08	scope2	Grid electricity (location-based)	\N	31200.0000	kWh	0.650000	20280.0000	20.280000	activity-based	2	approved	CBZBANK_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 13:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.172758+02	2026-09-28 09:11:14.172758+02
S2-003	CBZAGRO	Mvurwi Regional Office	2026-08	scope2	Grid electricity (location-based)	\N	12800.0000	kWh	0.650000	8320.0000	8.320000	activity-based	2	approved	CBZAGRO_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-AGRO	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.178479+02	2026-09-28 09:11:14.178479+02
S2-004	CBZINS	Harare Underwriting Centre	2026-08	scope2	Grid electricity (location-based)	\N	19600.0000	kWh	0.650000	12740.0000	12.740000	activity-based	2	approved	CBZINS_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-INS	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.18343+02	2026-09-28 09:11:14.18343+02
S2-005	CBZPROP	Borrowdale Office Park	2026-08	scope2	Grid electricity (location-based)	\N	28400.0000	kWh	0.650000	18460.0000	18.460000	activity-based	2	approved	CBZPROP_SCOPE2_ELEC_2026-08_v1.csv	USR-ADMIN	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.189219+02	2026-09-28 09:11:14.189219+02
S2-006	DATVEST	Harare Office	2026-08	scope2	Grid electricity (location-based)	\N	9100.0000	kWh	0.650000	5915.0000	5.915000	activity-based	2	approved	DATVEST_SCOPE2_ELEC_2026-08_v1.csv	USR-READER-DATVEST	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.195515+02	2026-09-28 09:11:14.195515+02
S2-007	CBZRED	Masvingo Agent Hub	2026-08	scope2	Grid electricity (location-based)	\N	4200.0000	kWh	0.650000	2730.0000	2.730000	activity-based	2	approved	CBZRED_SCOPE2_ELEC_2026-08_v1.csv	USR-ADMIN	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.202575+02	2026-09-28 09:11:14.202575+02
S3-001	CBZBANK	Group	2026-Q3	scope3	Cat 1 - Procurement	\N	185000.0000	US$	0.350000	64750.0000	64.750000	spend-based	4	approved	CBZBANK_SCOPE3CAT1_PROCURE_2026-Q3_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.209481+02	2026-09-28 09:11:14.209481+02
S3-002	CBZAGRO	Group	2026-Q3	scope3	Cat 1 - Agri-inputs	\N	96000.0000	US$	0.550000	52800.0000	52.800000	spend-based	4	approved	CBZAGRO_SCOPE3CAT1_PROCURE_2026-Q3_v1.csv	USR-CONTRIB-AGRO	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.214929+02	2026-09-28 09:11:14.214929+02
S3-003	CBZPROP	Borrowdale annex	2026-Q3	scope3	Cat 2 - Capex	\N	420000.0000	US$	0.400000	168000.0000	168.000000	spend-based	4	approved	CBZPROP_SCOPE3CAT2_CAPEX_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.22027+02	2026-09-28 09:11:14.22027+02
S3-004	CBZBANK	Group	2026-08	scope3	Cat 3 - T&D losses	\N	84500.0000	kWh	0.045000	3802.5000	3.802500	activity-based	3	approved	CBZBANK_SCOPE3CAT3_TDLOSS_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.225822+02	2026-09-28 09:11:14.225822+02
S3-005	CBZBANK	Group	2026-Q3	scope3	Cat 5 - Waste	\N	3.2000	tonnes	21.000000	67.2000	0.067200	activity-based	3	approved	CBZBANK_SCOPE3CAT5_WASTE_2026-Q3_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.232268+02	2026-09-28 09:11:14.232268+02
S3-006	CBZCAP	Group	2026-Q3	scope3	Cat 6 - Business travel	\N	42000.0000	pax-km	0.150000	6300.0000	6.300000	activity-based	3	in_review	CBZCAP_SCOPE3CAT6_TRAVEL_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	\N	\N	2026-09-28 09:11:14.238031+02	2026-09-28 09:11:14.238031+02
S3-007	CBZINS	Group	2026-Q3	scope3	Cat 7 - Commuting	\N	210.0000	employees	0.850000	178.5000	0.178500	activity-based	4	draft	CBZINS_SCOPE3CAT7_COMMUTE_2026-Q3_v1.csv	USR-CONTRIB-INS	2026-09-05 11:00:00+02	\N	\N	2026-09-28 09:11:14.243933+02	2026-09-28 09:11:14.243933+02
S3-008	DATVEST	Harare Office	2026-Q3	scope3	Cat 8 - Leased assets	\N	1850.0000	m2	0.060000	111.0000	0.111000	activity-based	3	approved	DATVEST_SCOPE3CAT8_LEASE_2026-Q3_v1.csv	USR-READER-DATVEST	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.248591+02	2026-09-28 09:11:14.248591+02
S3-009	CBZPROP	Borrowdale Office Park	2026-Q3	scope3	Cat 13 - Tenant energy	\N	9200.0000	m2	0.060000	552.0000	0.552000	activity-based	3	approved	CBZPROP_SCOPE3CAT13_TENANT_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.25454+02	2026-09-28 09:11:14.25454+02
STB-EM-1	STANBANK	Stanbic Centre, Harare	2026-08	scope1	Fleet fuel	Diesel	2070.0000	litres	2.680000	5547.6000	5.547600	activity-based	2	approved	STANBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	STB-USR-3	2026-09-02 09:00:00+02	STB-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-EM-1	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope1	Fleet fuel	Diesel	2340.0000	litres	2.680000	6271.2000	6.271200	activity-based	2	approved	STANWLTH_SCOPE1_FLEETFUEL_2026-08_v1.csv	STW-USR-3	2026-09-02 09:00:00+02	STW-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-EM-1	FBCBANK	FBC Centre, Harare	2026-08	scope1	Fleet fuel	Diesel	2610.0000	litres	2.680000	6994.8000	6.994800	activity-based	2	approved	FBCBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	FBB-USR-3	2026-09-02 09:00:00+02	FBB-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-EM-1	FBCINS	FBC Insurance, Mutare	2026-08	scope1	Fleet fuel	Diesel	2880.0000	litres	2.680000	7718.4000	7.718400	activity-based	2	approved	FBCINS_SCOPE1_FLEETFUEL_2026-08_v1.csv	FBI-USR-3	2026-09-02 09:00:00+02	FBI-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-EM-2	STANBANK	Stanbic Centre, Harare	2026-08	scope1	Backup generator	Diesel	1035.0000	litres	2.680000	2773.8000	2.773800	activity-based	3	approved	STANBANK_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	STB-USR-3	2026-09-03 09:00:00+02	STB-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-EM-2	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope1	Backup generator	Diesel	1170.0000	litres	2.680000	3135.6000	3.135600	activity-based	3	approved	STANWLTH_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	STW-USR-3	2026-09-03 09:00:00+02	STW-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-EM-2	FBCBANK	FBC Centre, Harare	2026-08	scope1	Backup generator	Diesel	1305.0000	litres	2.680000	3497.4000	3.497400	activity-based	3	approved	FBCBANK_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	FBB-USR-3	2026-09-03 09:00:00+02	FBB-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-EM-2	FBCINS	FBC Insurance, Mutare	2026-08	scope1	Backup generator	Diesel	1440.0000	litres	2.680000	3859.2000	3.859200	activity-based	3	approved	FBCINS_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	FBI-USR-3	2026-09-03 09:00:00+02	FBI-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-EM-3	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope2	Grid electricity	\N	67600.0000	kWh	0.570000	38532.0000	38.532000	measured	1	in_review	STANWLTH_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	STW-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-EM-3	FBCBANK	FBC Centre, Harare	2026-08	scope2	Grid electricity	\N	75400.0000	kWh	0.570000	42978.0000	42.978000	measured	1	in_review	FBCBANK_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	FBB-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-EM-3	FBCINS	FBC Insurance, Mutare	2026-08	scope2	Grid electricity	\N	83200.0000	kWh	0.570000	47424.0000	47.424000	measured	1	in_review	FBCINS_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	FBI-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-EM-4	STANBANK	Stanbic Centre, Harare	2026-Q3	scope3	Business travel	\N	27600.0000	pax-km	0.150000	4140.0000	4.140000	activity-based	3	draft	STANBANK_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	STB-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-EM-4	STANWLTH	Stanbic Wealth, Bulawayo	2026-Q3	scope3	Business travel	\N	31200.0000	pax-km	0.150000	4680.0000	4.680000	activity-based	3	draft	STANWLTH_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	STW-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-EM-4	FBCBANK	FBC Centre, Harare	2026-Q3	scope3	Business travel	\N	34800.0000	pax-km	0.150000	5220.0000	5.220000	activity-based	3	draft	FBCBANK_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	FBB-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-EM-4	FBCINS	FBC Insurance, Mutare	2026-Q3	scope3	Business travel	\N	38400.0000	pax-km	0.150000	5760.0000	5.760000	activity-based	3	draft	FBCINS_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	FBI-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-EM-5	STANBANK	Stanbic Centre, Harare	2026-Q3	scope3	Cat 1	\N	97750.0000	US$	0.320000	31280.0000	31.280000	spend-based	4	locked	STANBANK_SCOPE3_CAT1_2026-Q3_v1.csv	STB-USR-3	2026-09-06 09:00:00+02	STB-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-EM-5	STANWLTH	Stanbic Wealth, Bulawayo	2026-Q3	scope3	Cat 1	\N	110500.0000	US$	0.320000	35360.0000	35.360000	spend-based	4	locked	STANWLTH_SCOPE3_CAT1_2026-Q3_v1.csv	STW-USR-3	2026-09-06 09:00:00+02	STW-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-EM-5	FBCBANK	FBC Centre, Harare	2026-Q3	scope3	Cat 1	\N	123250.0000	US$	0.320000	39440.0000	39.440000	spend-based	4	locked	FBCBANK_SCOPE3_CAT1_2026-Q3_v1.csv	FBB-USR-3	2026-09-06 09:00:00+02	FBB-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-EM-5	FBCINS	FBC Insurance, Mutare	2026-Q3	scope3	Cat 1	\N	136000.0000	US$	0.320000	43520.0000	43.520000	spend-based	4	locked	FBCINS_SCOPE3_CAT1_2026-Q3_v1.csv	FBI-USR-3	2026-09-06 09:00:00+02	FBI-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-EM-3	STANBANK	Stanbic Centre, Harare	2026-08	scope2	Grid electricity	\N	59800.0000	kWh	0.570000	34086.0000	34.086000	measured	1	in_review	STANBANK_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	STB-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:15:17.140949+02
\.


--
-- Data for Name: cbz_financed_positions; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_financed_positions (id, counterparty_id, outstanding_amount_usd, period, created_at, updated_at) FROM stdin;
FE-001	CP-001	1250000.00	2026-Q3	2026-09-28 09:11:14.021524+02	2026-09-28 09:11:14.021524+02
FE-002	CP-002	640000.00	2026-Q3	2026-09-28 09:11:14.027069+02	2026-09-28 09:11:14.027069+02
FE-003	CP-003	3800000.00	2026-Q3	2026-09-28 09:11:14.031487+02	2026-09-28 09:11:14.031487+02
FE-004	CP-004	5200000.00	2026-Q3	2026-09-28 09:11:14.035818+02	2026-09-28 09:11:14.035818+02
FE-005	CP-005	2900000.00	2026-Q3	2026-09-28 09:11:14.040935+02	2026-09-28 09:11:14.040935+02
FE-006	CP-006	4100000.00	2026-Q3	2026-09-28 09:11:14.04528+02	2026-09-28 09:11:14.04528+02
FE-007	CP-007	2650000.00	2026-Q3	2026-09-28 09:11:14.04941+02	2026-09-28 09:11:14.04941+02
FE-008	CP-008	185000.00	2026-Q3	2026-09-28 09:11:14.054086+02	2026-09-28 09:11:14.054086+02
FE-009	CP-009	92000.00	2026-Q3	2026-09-28 09:11:14.058883+02	2026-09-28 09:11:14.058883+02
FE-010	CP-010	18500.00	2026-Q3	2026-09-28 09:11:14.063376+02	2026-09-28 09:11:14.063376+02
FE-011	CP-011	26200.00	2026-Q3	2026-09-28 09:11:14.06774+02	2026-09-28 09:11:14.06774+02
FE-012	CP-003	950000.00	2026-Q3	2026-09-28 09:11:14.072241+02	2026-09-28 09:11:14.072241+02
FE-013	CP-012	1400000.00	2026-Q3	2026-09-28 09:11:14.076421+02	2026-09-28 09:11:14.076421+02
FE-014	CP-013	2200000.00	2026-Q3	2026-09-28 09:11:14.081147+02	2026-09-28 09:11:14.081147+02
FE-015	CP-014	1600000.00	2026-Q3	2026-09-28 09:11:14.085107+02	2026-09-28 09:11:14.085107+02
FE-016	CP-017	3000000.00	2026-Q3	2026-09-28 09:11:14.08957+02	2026-09-28 09:11:14.08957+02
FE-017	CP-018	480000.00	2026-Q3	2026-09-28 09:11:14.094297+02	2026-09-28 09:11:14.094297+02
FE-018	CP-015	410000.00	2026-Q3	2026-09-28 09:11:14.09867+02	2026-09-28 09:11:14.09867+02
FE-019	CP-016	260000.00	2026-Q3	2026-09-28 09:11:14.106977+02	2026-09-28 09:11:14.106977+02
STB-FE-1	STB-CP-1	640000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FE-1	STW-CP-1	800000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FE-1	FBB-CP-1	960000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FE-1	FBI-CP-1	1120000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FE-2	STB-CP-2	297000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FE-2	STW-CP-2	396000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FE-2	FBB-CP-2	495000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FE-2	FBI-CP-2	594000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FE-3	STB-CP-3	2520000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FE-3	STW-CP-3	3024000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FE-3	FBB-CP-3	3528000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FE-3	FBI-CP-3	4032000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FE-4	STB-CP-4	326400.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FE-4	STW-CP-4	435200.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FE-4	FBB-CP-4	544000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FE-4	FBI-CP-4	652800.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FE-5	STB-CP-5	6000000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FE-5	STW-CP-5	7000000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FE-5	FBB-CP-5	8000000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FE-5	FBI-CP-5	9000000.00	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_financial_inclusion; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_financial_inclusion (id, subsidiary, programme, beneficiary_count, female_share, total_disbursed_usd, geography, sdg_alignment, repayment_rate, period, created_at, updated_at) FROM stdin;
FI-001	CBZRED	Rural micro-loans	1840	0.6100	620000.00	Mashonaland West	SDG 1, SDG 5	0.9200	2026-Q3	2026-09-28 09:11:14.302662+02	2026-09-28 09:11:14.302662+02
FI-002	CBZRED	Rural micro-loans	1120	0.5800	410000.00	Manicaland	SDG 1, SDG 5	0.9000	2026-Q3	2026-09-28 09:11:14.307954+02	2026-09-28 09:11:14.307954+02
FI-003	CBZRED	Rural micro-loans	960	0.5500	350000.00	Masvingo	SDG 1, SDG 5	0.8900	2026-Q3	2026-09-28 09:11:14.312565+02	2026-09-28 09:11:14.312565+02
FI-004	CBZAGRO	Mechanisation scheme	410	0.2200	2100000.00	Mashonaland Central	SDG 2, SDG 8	0.9500	2026-Q3	2026-09-28 09:11:14.31671+02	2026-09-28 09:11:14.31671+02
FI-005	CBZAGRO	Contract farming support	2650	0.3400	4800000.00	Multiple provinces	SDG 1, SDG 2	0.9100	2026-Q3	2026-09-28 09:11:14.321507+02	2026-09-28 09:11:14.321507+02
STB-FI-1	STANBANK	SME green credit line	550	0.4900	150000.00	Harare	SDG 8, SDG 13	0.8800	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FI-1	STANWLTH	SME green credit line	700	0.4900	180000.00	Harare	SDG 8, SDG 13	0.8800	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FI-1	FBCBANK	SME green credit line	850	0.4900	210000.00	Harare	SDG 8, SDG 13	0.8800	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FI-1	FBCINS	SME green credit line	1000	0.4900	240000.00	Harare	SDG 8, SDG 13	0.8800	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FI-2	STANBANK	Women in agriculture loans	950	0.5300	270000.00	Bulawayo	SDG 5, SDG 2	0.9000	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FI-2	STANWLTH	Women in agriculture loans	1100	0.5300	300000.00	Bulawayo	SDG 5, SDG 2	0.9000	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FI-2	FBCBANK	Women in agriculture loans	1250	0.5300	330000.00	Bulawayo	SDG 5, SDG 2	0.9000	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FI-2	FBCINS	Women in agriculture loans	1400	0.5300	360000.00	Bulawayo	SDG 5, SDG 2	0.9000	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FI-3	STANBANK	Youth enterprise fund	1350	0.5700	390000.00	Manicaland	SDG 8	0.9200	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FI-3	STANWLTH	Youth enterprise fund	1500	0.5700	420000.00	Manicaland	SDG 8	0.9200	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FI-3	FBCBANK	Youth enterprise fund	1650	0.5700	450000.00	Manicaland	SDG 8	0.9200	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FI-3	FBCINS	Youth enterprise fund	1800	0.5700	480000.00	Manicaland	SDG 8	0.9200	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FI-4	STANBANK	Rural mobile banking	1750	0.6100	510000.00	Masvingo	SDG 1, SDG 9	0.9400	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FI-4	STANWLTH	Rural mobile banking	1900	0.6100	540000.00	Masvingo	SDG 1, SDG 9	0.9400	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FI-4	FBCBANK	Rural mobile banking	2050	0.6100	570000.00	Masvingo	SDG 1, SDG 9	0.9400	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FI-4	FBCINS	Rural mobile banking	2200	0.6100	600000.00	Masvingo	SDG 1, SDG 9	0.9400	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-FI-5	STANBANK	Climate-smart farming inputs	2150	0.6500	630000.00	Midlands	SDG 2, SDG 13	0.9600	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-FI-5	STANWLTH	Climate-smart farming inputs	2300	0.6500	660000.00	Midlands	SDG 2, SDG 13	0.9600	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-FI-5	FBCBANK	Climate-smart farming inputs	2450	0.6500	690000.00	Midlands	SDG 2, SDG 13	0.9600	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-FI-5	FBCINS	Climate-smart farming inputs	2600	0.6500	720000.00	Midlands	SDG 2, SDG 13	0.9600	2026-Q3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_geospatial; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_geospatial (id, linked_borrower_name, subsidiary, district, coordinates, pass_date, data_source, ndvi, land_use, area_ha, deforestation_flag, flood_risk, drought_stress, created_at, updated_at) FROM stdin;
GEO-001	Mashonaland Grain Millers (Pvt) Ltd	CBZAGRO	Mazowe	-17.28, 30.97	2026-07-15	Sentinel-2	0.7100	Cropland - maize	640.00	No	Low	Medium	2026-09-28 09:11:14.42659+02	2026-09-28 09:11:14.42659+02
GEO-002	Mashonaland Grain Millers (Pvt) Ltd	CBZAGRO	Mazowe	-17.28, 30.97	2026-08-14	Sentinel-2	0.6800	Cropland - maize	640.00	No	Low	Medium	2026-09-28 09:11:14.432433+02	2026-09-28 09:11:14.432433+02
GEO-003	Agro-Yield Smallholder Cluster A	CBZAGRO	Mvurwi	-16.97, 30.99	2026-08-10	Sentinel-2	0.5400	Mixed smallholder cropland	185.00	No	Low	High	2026-09-28 09:11:14.437234+02	2026-09-28 09:11:14.437234+02
GEO-004	Agro-Yield Smallholder Cluster B	CBZAGRO	Mvurwi	-17.01, 31.05	2026-08-10	Sentinel-2	0.4900	Mixed smallholder cropland	210.00	Possible - flagged for review	Low	High	2026-09-28 09:11:14.441138+02	2026-09-28 09:11:14.441138+02
GEO-005	Nyanga Hydro Partners (Pvt) Ltd	CBZCAP	Nyanga	-18.22, 32.75	2026-08-02	Landsat-9	\N	Forested catchment / run-of-river site	45.00	No	Low	Low	2026-09-28 09:11:14.444636+02	2026-09-28 09:11:14.444636+02
GEO-006	Chinhoyi Solar Partners (Pvt) Ltd	CBZCAP	Chinhoyi	-17.35, 30.20	2026-08-02	Sentinel-2	0.1200	Cleared land / solar array	38.00	No	Low	Medium	2026-09-28 09:11:14.448072+02	2026-09-28 09:11:14.448072+02
GEO-007	Borrowdale Office Park (Pvt) Ltd	CBZPROP	Harare	-17.75, 31.09	2026-08-05	Sentinel-2	0.2200	Commercial/built-up	3.10	No	Low	Low	2026-09-28 09:11:14.451856+02	2026-09-28 09:11:14.451856+02
GEO-008	Msasa Industrial Park (Pvt) Ltd	CBZBANK	Harare	-17.83, 31.13	2026-08-05	Sentinel-2	0.1500	Industrial/built-up	5.40	No	Medium	Low	2026-09-28 09:11:14.456485+02	2026-09-28 09:11:14.456485+02
STB-GEO-1	Mazowe Citrus Growers	STANBANK	Mazowe	-17.51, 30.97	2026-08-09	Sentinel-2	0.4300	Maize	160.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-GEO-1	Gwanda Gold Processing	STANWLTH	Mazowe	-17.51, 30.97	2026-08-09	Sentinel-2	0.4300	Maize	200.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-GEO-1	Chegutu Dairy Co-op	FBCBANK	Mazowe	-17.51, 30.97	2026-08-09	Sentinel-2	0.4300	Maize	240.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-GEO-1	Nyanga Timber Mills	FBCINS	Mazowe	-17.51, 30.97	2026-08-09	Sentinel-2	0.4300	Maize	280.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-GEO-2	Borrowdale Brooke Homes	STANBANK	Goromonzi	-17.82, 31.37	2026-08-14	Landsat-9	0.5100	Tobacco	280.00	No	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-GEO-2	Hillside Residential	STANWLTH	Goromonzi	-17.82, 31.37	2026-08-14	Landsat-9	0.5100	Tobacco	320.00	No	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-GEO-2	Avondale Mortgages Pool	FBCBANK	Goromonzi	-17.82, 31.37	2026-08-14	Landsat-9	0.5100	Tobacco	360.00	No	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-GEO-2	Greendale Housing Trust	FBCINS	Goromonzi	-17.82, 31.37	2026-08-14	Landsat-9	0.5100	Tobacco	400.00	No	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-GEO-3	Eastgate Retail Park	STANBANK	Chipinge	-20.19, 32.62	2026-08-19	Sentinel-2	0.5900	Tea estate	400.00	Possible - flagged for review	High	Low	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-GEO-3	Fourth Street Offices	STANWLTH	Chipinge	-20.19, 32.62	2026-08-19	Sentinel-2	0.5900	Tea estate	440.00	Possible - flagged for review	High	Low	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-GEO-3	Sam Levy Commercial	FBCBANK	Chipinge	-20.19, 32.62	2026-08-19	Sentinel-2	0.5900	Tea estate	480.00	Possible - flagged for review	High	Low	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-GEO-3	Kwekwe Industrial Park	FBCINS	Chipinge	-20.19, 32.62	2026-08-19	Sentinel-2	0.5900	Tea estate	520.00	Possible - flagged for review	High	Low	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-GEO-4	Trans-Zambezi Haulage	STANBANK	Gweru	-19.45, 29.82	2026-08-24	MODIS	0.6700	Cattle ranching	520.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-GEO-4	Matabeleland Logistics	STANWLTH	Gweru	-19.45, 29.82	2026-08-24	MODIS	0.6700	Cattle ranching	560.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-GEO-4	Masvingo Bus Lines	FBCBANK	Gweru	-19.45, 29.82	2026-08-24	MODIS	0.6700	Cattle ranching	600.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-GEO-4	Beitbridge Freight	FBCINS	Gweru	-19.45, 29.82	2026-08-24	MODIS	0.6700	Cattle ranching	640.00	No	Low	High	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-GEO-5	Kariba North Solar	STANBANK	Masvingo	-20.07, 30.83	2026-08-29	Sentinel-2	0.7500	Sugarcane	640.00	Confirmed	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-GEO-5	Hwange Wind Farm	STANWLTH	Masvingo	-20.07, 30.83	2026-08-29	Sentinel-2	0.7500	Sugarcane	680.00	Confirmed	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-GEO-5	Save Valley Irrigation	FBCBANK	Masvingo	-20.07, 30.83	2026-08-29	Sentinel-2	0.7500	Sugarcane	720.00	Confirmed	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-GEO-5	Mutare Biogas Plant	FBCINS	Masvingo	-20.07, 30.83	2026-08-29	Sentinel-2	0.7500	Sugarcane	760.00	Confirmed	Medium	Medium	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_incidents; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_incidents (id, subsidiary, date_reported, category, description, severity, status, corrective_action, closure_date, created_at, updated_at) FROM stdin;
INC-001	CBZPROP	2026-06-12	Environmental	Minor diesel spill during generator refuelling, Borrowdale Office Park	Low	Closed	Spill kit deployed, contaminated soil removed, staff retrained	2026-06-20	2026-09-28 09:11:14.367249+02	2026-09-28 09:11:14.367249+02
INC-002	CBZRED	2026-07-03	Social	Client grievance re: loan officer conduct, Masvingo hub	Medium	Closed	Investigated, loan officer retrained, client compensated	2026-07-25	2026-09-28 09:11:14.372648+02	2026-09-28 09:11:14.372648+02
INC-003	CBZBANK	2026-07-18	Governance	Data access control gap identified in internal audit	Medium	Open	RBAC remediation in progress	\N	2026-09-28 09:11:14.376221+02	2026-09-28 09:11:14.376221+02
INC-004	CBZAGRO	2026-08-01	Environmental	Smallholder cluster flagged for possible unauthorised land clearing (GEO-004)	Medium	Open	Field verification scheduled with ESG champion	\N	2026-09-28 09:11:14.380156+02	2026-09-28 09:11:14.380156+02
INC-005	CBZINS	2026-08-09	Compliance	Late regulatory return to IPEC	Low	Closed	Process corrected, submission calendar automated	2026-08-15	2026-09-28 09:11:14.38469+02	2026-09-28 09:11:14.38469+02
STB-INC-1	STANBANK	2026-07-10	Environmental	Diesel spill at branch generator bay	Medium	Closed	Bund wall installed; soil remediated	2026-07-24	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-INC-1	STANWLTH	2026-07-10	Environmental	Diesel spill at branch generator bay	Medium	Closed	Bund wall installed; soil remediated	2026-07-24	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-INC-1	FBCBANK	2026-07-10	Environmental	Diesel spill at branch generator bay	Medium	Closed	Bund wall installed; soil remediated	2026-07-24	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-INC-1	FBCINS	2026-07-10	Environmental	Diesel spill at branch generator bay	Medium	Closed	Bund wall installed; soil remediated	2026-07-24	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-INC-2	STANBANK	2026-07-19	Social	Customer complaint on loan collection practice	Low	In Progress	Collections script retrained	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-INC-2	STANWLTH	2026-07-19	Social	Customer complaint on loan collection practice	Low	In Progress	Collections script retrained	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-INC-2	FBCBANK	2026-07-19	Social	Customer complaint on loan collection practice	Low	In Progress	Collections script retrained	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-INC-2	FBCINS	2026-07-19	Social	Customer complaint on loan collection practice	Low	In Progress	Collections script retrained	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-INC-3	STANBANK	2026-07-28	Governance	Late board ESG committee minutes	High	Open	Secretariat SLA agreed	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-INC-3	STANWLTH	2026-07-28	Governance	Late board ESG committee minutes	High	Open	Secretariat SLA agreed	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-INC-3	FBCBANK	2026-07-28	Governance	Late board ESG committee minutes	High	Open	Secretariat SLA agreed	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-INC-3	FBCINS	2026-07-28	Governance	Late board ESG committee minutes	High	Open	Secretariat SLA agreed	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-INC-4	STANBANK	2026-08-06	Compliance	Missed RBZ climate-risk return deadline	Medium	Closed	Return filed; reminder workflow added	2026-08-20	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-INC-4	STANWLTH	2026-08-06	Compliance	Missed RBZ climate-risk return deadline	Medium	Closed	Return filed; reminder workflow added	2026-08-20	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-INC-4	FBCBANK	2026-08-06	Compliance	Missed RBZ climate-risk return deadline	Medium	Closed	Return filed; reminder workflow added	2026-08-20	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-INC-4	FBCINS	2026-08-06	Compliance	Missed RBZ climate-risk return deadline	Medium	Closed	Return filed; reminder workflow added	2026-08-20	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-INC-5	STANBANK	2026-08-15	Environmental	Financed borrower flagged for land clearing	Critical	Open	Site visit and satellite review scheduled	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-INC-5	STANWLTH	2026-08-15	Environmental	Financed borrower flagged for land clearing	Critical	Open	Site visit and satellite review scheduled	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-INC-5	FBCBANK	2026-08-15	Environmental	Financed borrower flagged for land clearing	Critical	Open	Site visit and satellite review scheduled	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-INC-5	FBCINS	2026-08-15	Environmental	Financed borrower flagged for land clearing	Critical	Open	Site visit and satellite review scheduled	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_ingestion_batches; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_ingestion_batches (id, file_name, channel, subsidiary, uploaded_at, records_processed, validation_status, error_details, notification_sent, created_at, updated_at) FROM stdin;
BATCH-2601	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	File Ingester (manual upload)	CBZBANK	2026-09-02 10:14:00+02	9	Success	n/a	f	2026-09-28 09:11:14.461825+02	2026-09-28 09:11:14.461825+02
BATCH-2602	CBZAGRO_GEOSPATIAL_2026-08-10_v1.geojson	Satellite Data Ingester	CBZAGRO	2026-08-11 01:02:00+02	2	Success	n/a	f	2026-09-28 09:11:14.46669+02	2026-09-28 09:11:14.46669+02
BATCH-2603	CBZINS_SCOPE1_GENSET_2026-08_v1.csv	File Ingester (manual upload)	CBZINS	2026-09-02 11:41:00+02	1	Success	n/a	f	2026-09-28 09:11:14.470715+02	2026-09-28 09:11:14.470715+02
BATCH-2604	CBZBANK_FINEMISSIONS_2026-Q3_v1.csv	Ingestion API (manual)	CBZBANK	2026-09-05 16:22:00+02	118	Partial	6 records rejected: missing Denominator Value for listed-borrower rows	t	2026-09-28 09:11:14.475299+02	2026-09-28 09:11:14.475299+02
BATCH-2605	DATVEST_FINEMISSIONS_2026-Q3_v2.csv	Ingestion API (manual)	DATVEST	2026-09-05 18:05:00+02	6	Success	Resubmission of v1 (rejected batch) after correction	t	2026-09-28 09:11:14.479623+02	2026-09-28 09:11:14.479623+02
BATCH-2606	CBZPROP_SCOPE3CAT13_TENANT_2026-Q3_v1.csv	File Ingester (manual upload)	CBZPROP	2026-09-03 13:18:00+02	4	Failure	Invalid date format in Period column (expected YYYY-Q#)	t	2026-09-28 09:11:14.484209+02	2026-09-28 09:11:14.484209+02
BATCH-2607	CBZRED_SOCIALFININCL_2026-Q3_v1.csv	File Ingester (manual upload)	CBZRED	2026-09-04 12:03:00+02	3	Success	n/a	f	2026-09-28 09:11:14.488641+02	2026-09-28 09:11:14.488641+02
BATCH-2608	CBZCAP_FACEMISSIONS_2026_v1.csv	Ingestion API (manual)	CBZCAP	2026-09-06 15:47:00+02	2	Success	n/a	f	2026-09-28 09:11:14.492674+02	2026-09-28 09:11:14.492674+02
BATCH-2609	CBZBANK_GOVINCIDENT_2026-07-18_v1.csv	File Ingester (manual upload)	CBZBANK	2026-07-19 11:00:00+02	1	Success	n/a	f	2026-09-28 09:11:14.497434+02	2026-09-28 09:11:14.497434+02
BATCH-2610	CBZCAP_SCOPE3CAT6_TRAVEL_2026-Q3_v1.csv	File Ingester (manual upload)	CBZCAP	2026-09-03 17:30:00+02	11	Failure	Mandatory field 'pax-km' blank on 3 rows	t	2026-09-28 09:11:14.50323+02	2026-09-28 09:11:14.50323+02
STB-ING-1	STANBANK_SCOPE1_FLEET_2026-08.csv	File Ingester (manual upload)	STANBANK	2026-09-11 08:00:00+02	1240	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-ING-1	STANWLTH_SCOPE1_FLEET_2026-08.csv	File Ingester (manual upload)	STANWLTH	2026-09-11 08:00:00+02	1240	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-ING-1	FBCBANK_SCOPE1_FLEET_2026-08.csv	File Ingester (manual upload)	FBCBANK	2026-09-11 08:00:00+02	1240	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-ING-1	FBCINS_SCOPE1_FLEET_2026-08.csv	File Ingester (manual upload)	FBCINS	2026-09-11 08:00:00+02	1240	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-ING-2	STANBANK_NDVI_PASS_2026-08.csv	Satellite Data Ingester	STANBANK	2026-09-12 08:00:00+02	86	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-ING-2	STANWLTH_NDVI_PASS_2026-08.csv	Satellite Data Ingester	STANWLTH	2026-09-12 08:00:00+02	86	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-ING-2	FBCBANK_NDVI_PASS_2026-08.csv	Satellite Data Ingester	FBCBANK	2026-09-12 08:00:00+02	86	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-ING-2	FBCINS_NDVI_PASS_2026-08.csv	Satellite Data Ingester	FBCINS	2026-09-12 08:00:00+02	86	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-ING-3	STANBANK_LOANBOOK_API_2026-08.csv	Ingestion API (manual)	STANBANK	2026-09-13 08:00:00+02	410	Partial	3 rows missing period	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-ING-3	STANWLTH_LOANBOOK_API_2026-08.csv	Ingestion API (manual)	STANWLTH	2026-09-13 08:00:00+02	410	Partial	3 rows missing period	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-ING-3	FBCBANK_LOANBOOK_API_2026-08.csv	Ingestion API (manual)	FBCBANK	2026-09-13 08:00:00+02	410	Partial	3 rows missing period	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-ING-3	FBCINS_LOANBOOK_API_2026-08.csv	Ingestion API (manual)	FBCINS	2026-09-13 08:00:00+02	410	Partial	3 rows missing period	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-ING-4	STANBANK_MANUAL_FORM_2026-08.csv	Manual form entry	STANBANK	2026-09-14 08:00:00+02	12	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-ING-4	STANWLTH_MANUAL_FORM_2026-08.csv	Manual form entry	STANWLTH	2026-09-14 08:00:00+02	12	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-ING-4	FBCBANK_MANUAL_FORM_2026-08.csv	Manual form entry	FBCBANK	2026-09-14 08:00:00+02	12	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-ING-4	FBCINS_MANUAL_FORM_2026-08.csv	Manual form entry	FBCINS	2026-09-14 08:00:00+02	12	Success		t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-ING-5	STANBANK_SCOPE2_UTILITY_2026-08.csv	File Ingester (manual upload)	STANBANK	2026-09-15 08:00:00+02	960	Failure	Invalid unit column	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-ING-5	STANWLTH_SCOPE2_UTILITY_2026-08.csv	File Ingester (manual upload)	STANWLTH	2026-09-15 08:00:00+02	960	Failure	Invalid unit column	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-ING-5	FBCBANK_SCOPE2_UTILITY_2026-08.csv	File Ingester (manual upload)	FBCBANK	2026-09-15 08:00:00+02	960	Failure	Invalid unit column	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-ING-5	FBCINS_SCOPE2_UTILITY_2026-08.csv	File Ingester (manual upload)	FBCINS	2026-09-15 08:00:00+02	960	Failure	Invalid unit column	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_insurance_policies; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_insurance_policies (id, segment, subsidiary, client_id, client_name, sector, gross_written_premium_usd, denominator_type, denominator_value_usd, client_total_emissions, attribution_factor, insurance_associated_emissions, dq_score, created_at, updated_at) FROM stdin;
IE-001	Commercial lines	CBZINS	CP-001	Mashonaland Grain Millers (Pvt) Ltd	Agri-processing	42000.00	Client's Total Revenue	6800000.00	2850.0000	0.00617647	17.6029	3	2026-09-28 09:11:14.261295+02	2026-09-28 09:11:14.261295+02
IE-002	Commercial lines	CBZINS	CP-002	Manyame Textiles Ltd	Manufacturing	18500.00	Client's Total Revenue	3100000.00	1920.0000	0.00596774	11.4581	4	2026-09-28 09:11:14.26797+02	2026-09-28 09:11:14.26797+02
IE-003	Commercial lines	CBZINS	CP-003	Highveld Beverages PLC	Consumer goods	96000.00	Client's Total Revenue	210000000.00	41200.0000	0.00045714	18.8343	4	2026-09-28 09:11:14.273244+02	2026-09-28 09:11:14.273244+02
IE-004	Personal motor - individual data	CBZINS	RETAIL-3311	Retail Motor Policyholder #3311	Personal transport	620.00	Client's Annual Vehicle Ownership Cost	8900.00	2.1000	0.06966292	0.1463	3	2026-09-28 09:11:14.278525+02	2026-09-28 09:11:14.278525+02
IE-005	Personal motor - PCAF fallback factor	CBZINS	RETAIL-BOOK	Retail Motor Book (aggregated)	Personal transport	480000.00	PCAF Global Weighted Avg (6.99%, published constant)	\N	3650.0000	0.06990000	255.1350	5	2026-09-28 09:11:14.283035+02	2026-09-28 09:11:14.283035+02
IE-006	Project insurance	CBZINS	PROJ-KARIBA	Kariba Hydro Extension Project	Renewable energy	165000.00	Insured Value / Project TE&D	22000000.00	620.0000	0.00750000	4.6500	3	2026-09-28 09:11:14.290661+02	2026-09-28 09:11:14.290661+02
IE-007	Treaty reinsurance	CBZINS	RE-SABLE	Sable Re Treaty Panel 2026	Reinsurance	310000.00	Ceded Premium Share of Cedant Portfolio	4200000.00	18500.0000	0.07380952	1365.4762	5	2026-09-28 09:11:14.296979+02	2026-09-28 09:11:14.296979+02
STB-IE-1	Commercial lines	STANBANK	STB-CP-1	Mazowe Citrus Growers	Agriculture	20000.00	Client's Total Revenue	7840000.00	2510.0000	0.00255102	6.4031	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-IE-1	Commercial lines	STANWLTH	STW-CP-1	Gwanda Gold Processing	Agriculture	25000.00	Client's Total Revenue	9800000.00	2620.0000	0.00255102	6.6837	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-IE-1	Commercial lines	FBCBANK	FBB-CP-1	Chegutu Dairy Co-op	Agriculture	30000.00	Client's Total Revenue	11760000.00	2730.0000	0.00255102	6.9643	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-IE-1	Commercial lines	FBCINS	FBI-CP-1	Nyanga Timber Mills	Agriculture	35000.00	Client's Total Revenue	13720000.00	2840.0000	0.00255102	7.2449	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-IE-2	Personal motor - individual data	STANBANK	STB-CP-2	Borrowdale Brooke Homes	Residential real estate	35000.00	Client's Total Revenue	1890000.00	195.0000	0.01851852	3.6111	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-IE-2	Personal motor - individual data	STANWLTH	STW-CP-2	Hillside Residential	Residential real estate	40000.00	Client's Total Revenue	2520000.00	305.0000	0.01587302	4.8413	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-IE-2	Personal motor - individual data	FBCBANK	FBB-CP-2	Avondale Mortgages Pool	Residential real estate	45000.00	Client's Total Revenue	3150000.00	415.0000	0.01428571	5.9286	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-IE-2	Personal motor - individual data	FBCINS	FBI-CP-2	Greendale Housing Trust	Residential real estate	50000.00	Client's Total Revenue	3780000.00	525.0000	0.01322751	6.9444	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-IE-3	Personal motor - PCAF fallback factor	STANBANK	STB-CP-3	Eastgate Retail Park	Commercial property	50000.00	Client's Total Revenue	12600000.00	1070.0000	0.00396825	4.2460	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-IE-3	Personal motor - PCAF fallback factor	STANWLTH	STW-CP-3	Fourth Street Offices	Commercial property	55000.00	Client's Total Revenue	15120000.00	1180.0000	0.00363757	4.2923	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-IE-3	Personal motor - PCAF fallback factor	FBCBANK	FBB-CP-3	Sam Levy Commercial	Commercial property	60000.00	Client's Total Revenue	17640000.00	1290.0000	0.00340136	4.3878	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-IE-3	Personal motor - PCAF fallback factor	FBCINS	FBI-CP-3	Kwekwe Industrial Park	Commercial property	65000.00	Client's Total Revenue	20160000.00	1400.0000	0.00322421	4.5139	3	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-IE-4	Project insurance	STANBANK	STB-CP-4	Trans-Zambezi Haulage	Transport	65000.00	Client's Total Revenue	1344000.00	1860.0000	0.04836310	89.9554	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-IE-4	Project insurance	STANWLTH	STW-CP-4	Matabeleland Logistics	Transport	70000.00	Client's Total Revenue	1792000.00	1970.0000	0.03906250	76.9531	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-IE-4	Project insurance	FBCBANK	FBB-CP-4	Masvingo Bus Lines	Transport	75000.00	Client's Total Revenue	2240000.00	2080.0000	0.03348214	69.6429	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-IE-4	Project insurance	FBCINS	FBI-CP-4	Beitbridge Freight	Transport	80000.00	Client's Total Revenue	2688000.00	2190.0000	0.02976190	65.1786	4	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-IE-5	Treaty reinsurance	STANBANK	STB-CP-5	Kariba North Solar	Renewable energy	80000.00	Client's Total Revenue	21000000.00	250.0000	0.00380952	0.9524	2	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-IE-5	Treaty reinsurance	STANWLTH	STW-CP-5	Hwange Wind Farm	Renewable energy	85000.00	Client's Total Revenue	24500000.00	360.0000	0.00346939	1.2490	2	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-IE-5	Treaty reinsurance	FBCBANK	FBB-CP-5	Save Valley Irrigation	Renewable energy	90000.00	Client's Total Revenue	28000000.00	470.0000	0.00321429	1.5107	2	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-IE-5	Treaty reinsurance	FBCINS	FBI-CP-5	Mutare Biogas Plant	Renewable energy	95000.00	Client's Total Revenue	31500000.00	580.0000	0.00301587	1.7492	2	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: cbz_members; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_members (id, full_name, email, password_hash, phone, entity_code, department_id, role, created_at, updated_at, is_active) FROM stdin;
USR-ADMIN	Anesu Mutasa	anesu.mutasa@cbzholdings.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0100	CBZBANK	\N	admin	2026-09-28 09:11:13.894639+02	2026-09-28 09:11:13.894639+02	t
USR-APPROVER-BANK	Tafara Chikwanha	tafara.chikwanha@cbz.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0101	CBZBANK	DEPT-001	approver	2026-09-28 09:11:13.900248+02	2026-09-28 09:11:13.900248+02	t
USR-CONTRIB-BANK	Melissa Chirandu	melissa.chirandu@cbz.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0102	CBZBANK	DEPT-002	contributor	2026-09-28 09:11:13.905295+02	2026-09-28 09:11:13.905295+02	t
USR-CONTRIB-INS	Rutendo Mukamuri	rutendo.mukamuri@cbzinsurance.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0103	CBZINS	DEPT-003	contributor	2026-09-28 09:11:13.908817+02	2026-09-28 09:11:13.908817+02	t
USR-CONTRIB-AGRO	Simba Chirwa	simba.chirwa@agroyield.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0104	CBZAGRO	DEPT-005	contributor	2026-09-28 09:11:13.91229+02	2026-09-28 09:11:13.91229+02	t
USR-READER-DATVEST	Kudakwashe Sithole	kudakwashe.sithole@datvest.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0105	DATVEST	DEPT-007	reader	2026-09-28 09:11:13.916045+02	2026-09-28 09:11:13.916045+02	t
USR-CUST-MILLERS	Mashonaland Grain Millers Ops	sustainability@grainmillers.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0201	CBZBANK	DEPT-001	customer	2026-09-28 09:11:13.920159+02	2026-09-28 09:11:13.920159+02	t
USR-CUST-HIGHVELD	Highveld Beverages ESG Lead	esg@highveldbev.co.zw	$2b$10$UMrZku9/2r.bhAF82Q.hK.j6iq2PSE4LlF.0tZP4gc3i08hoibrZC	+263 77 900 0202	CBZBANK	DEPT-001	customer	2026-09-28 09:11:13.923983+02	2026-09-28 09:11:13.923983+02	t
STB-USR-1	Tatenda Mhlanga	tatenda.mhlanga@stanbicbank.co.zw	$2a$10$.gzlfwgE30x55T.4xC14geUhJaJU1aRVCqiM28T1mJBsa1Jc0JgPK	+263 77 0101111	STANBANK	STB-DEPT-1	admin	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STW-USR-1	Chiedza Sibanda	chiedza.sibanda@stanbicwealth.co.zw	$2a$10$m6tLnVplfYWkPVoLnumNG.UISkuxbvjWD2wwA1fj1R5OquMQio/fi	+263 77 0201111	STANWLTH	STW-DEPT-1	admin	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBB-USR-1	Simbarashe Marufu	simbarashe.marufu@fbc.co.zw	$2a$10$DTqPPv76mZr4ZD6RCCvVrOPIS3oct6VCyWWtbKfCJlCCt6GjXTliO	+263 77 0301111	FBCBANK	FBB-DEPT-1	admin	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBI-USR-1	Rutendo Hove	rutendo.hove@fbcinsurance.co.zw	$2a$10$KQz2ZtkAxRsIs6FVhZMpGOfHJT5BiAcyzFFwdNrSp3v.VLcSgnP7q	+263 77 0401111	FBCINS	FBI-DEPT-1	admin	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STB-USR-2	Rumbidzai Ndlovu	rumbidzai.ndlovu@stanbicbank.co.zw	$2a$10$NMUusxlOexzgMlAOxZ9xpe27gNfZKPv0pEv9hWRfVq8DchA6dyGKe	+263 77 0102222	STANBANK	STB-DEPT-2	approver	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STW-USR-2	Tapiwa Gumbo	tapiwa.gumbo@stanbicwealth.co.zw	$2a$10$Cl7olO3AgMkR75BlihIBr.4NuA8HQ/ZhXvCzGdGAHepMeVu3hN3ZK	+263 77 0202222	STANWLTH	STW-DEPT-2	approver	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBB-USR-2	Tsitsi Chinoda	tsitsi.chinoda@fbc.co.zw	$2a$10$ykjjkDY0KGnU.fq8YYYssei7CCvo1aruVvHFlJccM75MsqzQ3kLnm	+263 77 0302222	FBCBANK	FBB-DEPT-2	approver	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBI-USR-2	Tonderai Maposa	tonderai.maposa@fbcinsurance.co.zw	$2a$10$5kq7I7BV6IxdgHAP4Cll3O0LjRGinSBL47F/jz2h.1uui74cJl15u	+263 77 0402222	FBCINS	FBI-DEPT-2	approver	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STB-USR-3	Kudakwashe Chigumba	kudakwashe.chigumba@stanbicbank.co.zw	$2a$10$kFRJgzm1ZcXYdAxT6TaN.OYs6eWY25tNr7IbnluDAriGdklRZYT6W	+263 77 0103333	STANBANK	STB-DEPT-3	contributor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STW-USR-3	Vimbai Nyathi	vimbai.nyathi@stanbicwealth.co.zw	$2a$10$jsJDbsC2INQuwqvJslA8feX/eCirY3x1.cDVy3NYVO3y4Ua0Ey2h.	+263 77 0203333	STANWLTH	STW-DEPT-3	contributor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBB-USR-3	Takudzwa Zvobgo	takudzwa.zvobgo@fbc.co.zw	$2a$10$5f1YCVL20ZjnrhDQinW4I.LQqqGlpGtMVoSzI2SZ0PK3pOk/O2Jey	+263 77 0303333	FBCBANK	FBB-DEPT-3	contributor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBI-USR-3	Shamiso Chirwa	shamiso.chirwa@fbcinsurance.co.zw	$2a$10$zgBV2U4GoLuTGgAL.6JHs.2BZe8SFfKJxcVlQkRiAAg/.GYbd9lLe	+263 77 0403333	FBCINS	FBI-DEPT-3	contributor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STB-USR-4	Nyasha Moyo	nyasha.moyo@stanbicbank.co.zw	$2a$10$u9W4LGchkg78vIncufJ2qeFUsT4N4c5H3YPkJY/tTCt5F7FgMrnvi	+263 77 0104444	STANBANK	STB-DEPT-4	reader	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STW-USR-4	Farai Mukanya	farai.mukanya@stanbicwealth.co.zw	$2a$10$rJjMlT1Ks.DZGXnEI6667.LVWa1OUppdL71bnHjWO18Yjwu6qrIRC	+263 77 0204444	STANWLTH	STW-DEPT-4	reader	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBB-USR-4	Fadzai Mutasa	fadzai.mutasa@fbc.co.zw	$2a$10$jOOBfSag3qr4.sRfgsaEBOsysUJzD5MCAoq5dAjTrBSVJKsFvijaC	+263 77 0304444	FBCBANK	FBB-DEPT-4	reader	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBI-USR-4	Panashe Bhebhe	panashe.bhebhe@fbcinsurance.co.zw	$2a$10$tG5SeUjBP2XYbc3IcymaEur7YxDit53rhYJdCuds.AyZtq3ddpM2m	+263 77 0404444	FBCINS	FBI-DEPT-4	reader	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STB-USR-5	Tinotenda Mapfumo	tinotenda.mapfumo@stanbicbank.co.zw	$2a$10$3QqRdkd1gJywjVF20YbNm.YedVcMp.IcTucyfcXtNbMBaIvuXRRHu	+263 77 0105555	STANBANK	STB-DEPT-5	auditor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
STW-USR-5	Ruvimbo Dube	ruvimbo.dube@stanbicwealth.co.zw	$2a$10$voruZVhBhs31xsxm0VK9bODhv.CrJaOgWmpln3dtCahe6BgFPnGNy	+263 77 0205555	STANWLTH	STW-DEPT-5	auditor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBB-USR-5	Munyaradzi Musoni	munyaradzi.musoni@fbc.co.zw	$2a$10$npINniNpUUoGT8Znr3Jz4emER6BTxrwj8b74vupWJ7LhTysbP0uLy	+263 77 0305555	FBCBANK	FBB-DEPT-5	auditor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
FBI-USR-5	Chipo Mangwende	chipo.mangwende@fbcinsurance.co.zw	$2a$10$ylJhbMMQMmPEyefTDfn7Jutbkgg4BtjKD65TgM0R8NT1iTwHkcVI6	+263 77 0405555	FBCINS	FBI-DEPT-5	auditor	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	t
\.


--
-- Data for Name: cbz_reporting_periods; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_reporting_periods (id, bank_id, period, status, locked_by, locked_at, created_at, updated_at) FROM stdin;
2	1	2026-Q4	open	\N	\N	2026-10-04 22:22:16.249842+02	2026-10-04 22:22:20.495499+02
\.


--
-- Data for Name: cbz_risk_entries; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_risk_entries (id, title, category, likelihood, impact, owner, status, linked_entity, created_at, updated_at, bank_id) FROM stdin;
RSK-001	Drought exposure — smallholder cropland (Mvurwi)	Physical	4	4	Chiedza Mangwiro	Mitigating	CBZAGRO	2026-09-28 09:11:14.38961+02	2026-10-04 22:10:18.087517+02	1
RSK-002	Stranded assets — mining sector (Eastlands)	Transition	3	5	Kudakwashe Sithole	Monitoring	DATVEST	2026-09-28 09:11:14.395096+02	2026-10-04 22:10:18.087517+02	1
RSK-003	Flood risk — Msasa Industrial Park collateral	Physical	2	4	Nyasha Moyo	Identified	CBZBANK	2026-09-28 09:11:14.400003+02	2026-10-04 22:10:18.087517+02	1
RSK-004	Carbon-price pass-through to project finance IRR	Transition	3	3	Blessing Mutasa	Monitoring	CBZCAP	2026-09-28 09:11:14.404467+02	2026-10-04 22:10:18.087517+02	1
RSK-005	Regulatory — IFRS S2 mandatory disclosure gap	Liability	4	3	Anesu Mutasa	Mitigating	GROUP	2026-09-28 09:11:14.408927+02	2026-10-04 22:10:18.087517+02	1
RSK-006	Underwriting concentration — climate perils on Kariba	Physical	3	4	Rutendo Mukamuri	Monitoring	CBZINS	2026-09-28 09:11:14.413272+02	2026-10-04 22:10:18.087517+02	1
RSK-007	Green bond origination opportunity (F22, F33)	Opportunity	4	3	Blessing Mutasa	Mitigating	CBZCAP	2026-09-28 09:11:14.417157+02	2026-10-04 22:10:18.087517+02	1
RSK-008	Data-quality risk — DQ score drift on retail motor book	Liability	3	2	Farai Ndlovu	Identified	CBZINS	2026-09-28 09:11:14.421025+02	2026-10-04 22:10:18.087517+02	1
STB-RSK-1	Drought impact on agri loan book	Physical	4	4	Rumbidzai Ndlovu	Mitigating	STANBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STW-RSK-1	Drought impact on agri loan book	Physical	4	4	Tapiwa Gumbo	Mitigating	STANWLTH	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBB-RSK-1	Drought impact on agri loan book	Physical	4	4	Tsitsi Chinoda	Mitigating	FBCBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBI-RSK-1	Drought impact on agri loan book	Physical	4	4	Tonderai Maposa	Mitigating	FBCINS	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
STB-RSK-2	Carbon pricing on heavy-emitting borrowers	Transition	3	4	Rumbidzai Ndlovu	Monitoring	STANBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STW-RSK-2	Carbon pricing on heavy-emitting borrowers	Transition	3	4	Tapiwa Gumbo	Monitoring	STANWLTH	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBB-RSK-2	Carbon pricing on heavy-emitting borrowers	Transition	3	4	Tsitsi Chinoda	Monitoring	FBCBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBI-RSK-2	Carbon pricing on heavy-emitting borrowers	Transition	3	4	Tonderai Maposa	Monitoring	FBCINS	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
STB-RSK-3	Flood exposure of mortgage collateral	Physical	3	3	Rumbidzai Ndlovu	Identified	STANBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STW-RSK-3	Flood exposure of mortgage collateral	Physical	3	3	Tapiwa Gumbo	Identified	STANWLTH	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBB-RSK-3	Flood exposure of mortgage collateral	Physical	3	3	Tsitsi Chinoda	Identified	FBCBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBI-RSK-3	Flood exposure of mortgage collateral	Physical	3	3	Tonderai Maposa	Identified	FBCINS	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
STB-RSK-4	Green bond issuance opportunity	Opportunity	4	3	Rumbidzai Ndlovu	Identified	STANBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STW-RSK-4	Green bond issuance opportunity	Opportunity	4	3	Tapiwa Gumbo	Identified	STANWLTH	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBB-RSK-4	Green bond issuance opportunity	Opportunity	4	3	Tsitsi Chinoda	Identified	FBCBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBI-RSK-4	Green bond issuance opportunity	Opportunity	4	3	Tonderai Maposa	Identified	FBCINS	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
STB-RSK-5	Climate disclosure litigation	Liability	2	3	Rumbidzai Ndlovu	Monitoring	STANBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
STW-RSK-5	Climate disclosure litigation	Liability	2	3	Tapiwa Gumbo	Monitoring	STANWLTH	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	2
FBB-RSK-5	Climate disclosure litigation	Liability	2	3	Tsitsi Chinoda	Monitoring	FBCBANK	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
FBI-RSK-5	Climate disclosure litigation	Liability	2	3	Tonderai Maposa	Monitoring	FBCINS	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	3
\.


--
-- Data for Name: cbz_workforce; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_workforce (id, subsidiary, period, headcount, female_share, avg_training_hours, lti_rate, voluntary_turnover, local_hire_share, created_at, updated_at) FROM stdin;
WF-CBZBANK	CBZBANK	2026-Q3	1240	0.4800	14.50	0.8000	0.0900	0.9700	2026-09-28 09:11:14.326579+02	2026-09-28 09:11:14.326579+02
WF-CBZCAP	CBZCAP	2026-Q3	85	0.4400	22.00	0.0000	0.0600	1.0000	2026-09-28 09:11:14.331355+02	2026-09-28 09:11:14.331355+02
WF-DATVEST	DATVEST	2026-Q3	62	0.3900	18.00	0.0000	0.0500	0.9800	2026-09-28 09:11:14.335217+02	2026-09-28 09:11:14.335217+02
WF-CBZAGRO	CBZAGRO	2026-Q3	310	0.2800	11.00	1.4000	0.1100	1.0000	2026-09-28 09:11:14.339077+02	2026-09-28 09:11:14.339077+02
WF-CBZPROP	CBZPROP	2026-Q3	45	0.3600	9.50	0.0000	0.0400	1.0000	2026-09-28 09:11:14.34293+02	2026-09-28 09:11:14.34293+02
WF-CBZINS	CBZINS	2026-Q3	190	0.5200	16.00	0.2000	0.0700	0.9900	2026-09-28 09:11:14.346962+02	2026-09-28 09:11:14.346962+02
WF-CBZLIFE	CBZLIFE	2026-Q3	130	0.5500	15.50	0.0000	0.0600	0.9900	2026-09-28 09:11:14.351162+02	2026-09-28 09:11:14.351162+02
WF-CBZRISK	CBZRISK	2026-Q3	38	0.4200	12.00	0.0000	0.0800	1.0000	2026-09-28 09:11:14.355985+02	2026-09-28 09:11:14.355985+02
WF-CBZRED	CBZRED	2026-Q3	420	0.4600	8.00	0.5000	0.1400	1.0000	2026-09-28 09:11:14.360402+02	2026-09-28 09:11:14.360402+02
STB-WF-1	STANBANK	2025-Q3	1465	0.4450	11.00	0.8000	0.1050	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-WF-1	STANWLTH	2025-Q3	121	0.4450	11.00	0.8000	0.1050	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-WF-1	FBCBANK	2025-Q3	990	0.4450	11.00	0.8000	0.1050	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-WF-1	FBCINS	2025-Q3	263	0.4450	11.00	0.8000	0.1050	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-WF-2	STANBANK	2025-Q4	1479	0.4500	12.00	0.7000	0.1000	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-WF-2	STANWLTH	2025-Q4	122	0.4500	12.00	0.7000	0.1000	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-WF-2	FBCBANK	2025-Q4	1000	0.4500	12.00	0.7000	0.1000	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-WF-2	FBCINS	2025-Q4	265	0.4500	12.00	0.7000	0.1000	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-WF-3	STANBANK	2026-Q1	1494	0.4550	13.00	0.6000	0.0950	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-WF-3	STANWLTH	2026-Q1	124	0.4550	13.00	0.6000	0.0950	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-WF-3	FBCBANK	2026-Q1	1009	0.4550	13.00	0.6000	0.0950	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-WF-3	FBCINS	2026-Q1	268	0.4550	13.00	0.6000	0.0950	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-WF-4	STANBANK	2026-Q2	1508	0.4600	14.00	0.5000	0.0900	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-WF-4	STANWLTH	2026-Q2	125	0.4600	14.00	0.5000	0.0900	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-WF-4	FBCBANK	2026-Q2	1019	0.4600	14.00	0.5000	0.0900	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-WF-4	FBCINS	2026-Q2	270	0.4600	14.00	0.5000	0.0900	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STB-WF-5	STANBANK	2026-Q3	1523	0.4650	15.00	0.4000	0.0850	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
STW-WF-5	STANWLTH	2026-Q3	126	0.4650	15.00	0.4000	0.0850	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBB-WF-5	FBCBANK	2026-Q3	1029	0.4650	15.00	0.4000	0.0850	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
FBI-WF-5	FBCINS	2026-Q3	273	0.4650	15.00	0.4000	0.0850	0.9500	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: crop_cycles; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.crop_cycles (id, customer_id, estate_id, user_id, name, start_date, end_date, audit_trail, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.customers (id, name, hectares, country, email, phone_number, identifier, created_at, updated_at, is_deleted) FROM stdin;
2	Mavhu Africa	1	Zimbabwe	info@mavhu.africa	\N	PLATFORM	2026-09-24 08:22:50.140059+02	2026-09-24 08:22:50.140059+02	f
3	CBZ Bank Limited	1	Zimbabwe	esg@cbz.co.zw	\N	BANK	2026-09-24 08:22:50.148704+02	2026-09-24 08:22:50.148704+02	f
4	Stanbic Bank Zimbabwe	1	Zimbabwe	esg@stanbicbank.co.zw	\N	BANK	2026-09-24 08:22:50.15184+02	2026-09-24 08:22:50.15184+02	f
5	FBC Bank Limited	1	Zimbabwe	esg@fbc.co.zw	\N	BANK	2026-09-24 08:22:50.158357+02	2026-09-24 08:22:50.158357+02	f
6	Chipinge Tea Estates (Pvt) Ltd	850	Zimbabwe	info@chipingetea.co.zw	\N	AGROBUSINESS	2026-09-24 08:22:50.161323+02	2026-09-24 08:22:50.161323+02	f
7	Marondera Maize Holdings	1200	Zimbabwe	office@maronderamaize.co.zw	\N	AGROBUSINESS	2026-09-24 08:22:50.164583+02	2026-09-24 08:22:50.164583+02	f
8	Chiredzi Sugar Growers	2100	Zimbabwe	admin@chiredzisugar.co.zw	\N	AGROBUSINESS	2026-09-24 08:22:50.167057+02	2026-09-24 08:22:50.167057+02	f
9	Nyanga Highlands Orchards	640	Zimbabwe	hello@nyangaorchards.co.zw	\N	AGROBUSINESS	2026-09-24 08:22:50.170329+02	2026-09-24 08:22:50.170329+02	f
\.


--
-- Data for Name: emission_factors; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.emission_factors (id, name, component, factor, gwp, description, unit) FROM stdin;
\.


--
-- Data for Name: emissions_accounting; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.emissions_accounting (id, customer_id, estate_id, created_by, crop_cycle_id, emission_id, quantity, start_date, end_date, ton_co2e, scope, approved, approved_by, audit_trail, note, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: estates; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.estates (id, name, hectares, customer_id, country, email, phone_number, created_at, updated_at) FROM stdin;
1	Chipinge Highveld Block	850	6	Zimbabwe	estate@chipingetea.co.zw	\N	2026-09-24 08:22:50.205164+02	2026-09-24 08:22:50.205164+02
2	Marondera North Fields	1200	7	Zimbabwe	estate@maronderamaize.co.zw	\N	2026-09-24 08:22:50.207673+02	2026-09-24 08:22:50.207673+02
3	Hippo Valley Cane Fields	2100	8	Zimbabwe	estate@chiredzisugar.co.zw	\N	2026-09-24 08:22:50.209717+02	2026-09-24 08:22:50.209717+02
4	Nyanga Orchard Terraces	640	9	Zimbabwe	estate@nyangaorchards.co.zw	\N	2026-09-24 08:22:50.215402+02	2026-09-24 08:22:50.215402+02
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.role_permissions (id, role_id, api_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.roles (id, name) FROM stdin;
1	AUDITOR
2	ESG_READER
3	ESG_CONTRIBUTOR
4	ESG_APPROVER
5	MAVHU_ADMIN
\.


--
-- Data for Name: satellite_ndvi_co2; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.satellite_ndvi_co2 (id, customer_id, estate_id, date, ndvi_mean, ndvi_min, ndvi_max, ndvi_std, ndwi_mean, ndwi_min, ndwi_max, ndwi_std, ndbi_mean, ndbi_min, ndbi_max, ndbi_std, above_ground_biomass, below_ground_biomass, biomass_carbon, biomass_co2, biomass_co2_total, soil_organic_carbon, soil_organic_carbon_co2, soil_organic_carbon_co2_total, net_co2_stock, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.schema_migrations (id, filename, applied_at) FROM stdin;
1	001_add_platform_customer_identifier.sql	2026-09-24 08:21:43.609352+02
2	002_add_mavhu_admin_role.sql	2026-09-24 08:21:43.641469+02
3	004_multi_bank_platform_admin.sql	2026-10-04 22:10:18.087517+02
4	005_demo_data_other_banks.sql	2026-10-04 22:10:18.087517+02
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.user_roles (id, user_id, role_id, audit_trail, created_at, updated_at) FROM stdin;
1	1	5	Provisioned by seed script	2026-09-24 08:22:50.281076+02	2026-09-24 08:22:50.281076+02
2	2	5	Provisioned by seed script	2026-09-24 08:22:50.341553+02	2026-09-24 08:22:50.341553+02
3	3	5	Provisioned by seed script	2026-09-24 08:22:50.406446+02	2026-09-24 08:22:50.406446+02
4	4	1	Provisioned by seed script	2026-09-24 08:22:50.46577+02	2026-09-24 08:22:50.46577+02
5	5	4	Provisioned by seed script	2026-09-24 08:22:50.525719+02	2026-09-24 08:22:50.525719+02
6	6	2	Provisioned by seed script	2026-09-24 08:22:50.585768+02	2026-09-24 08:22:50.585768+02
7	7	3	Provisioned by seed script	2026-09-24 08:22:50.646749+02	2026-09-24 08:22:50.646749+02
8	8	3	Provisioned by seed script	2026-09-24 08:22:50.707466+02	2026-09-24 08:22:50.707466+02
9	9	4	Provisioned by seed script	2026-09-24 08:22:50.766776+02	2026-09-24 08:22:50.766776+02
10	10	2	Provisioned by seed script	2026-09-24 08:22:50.82651+02	2026-09-24 08:22:50.82651+02
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.users (id, name, customer_id, estate_id, email, password, created_at, updated_at, is_deleted) FROM stdin;
1	Tendai Moyo	2	\N	tendai.moyo@mavhu.africa	$2b$10$i3pSeQLxte92N1kh9GO2xuoRSwJs5Hx9C3MVTSL9fGObN3rOE4ary	2026-09-24 08:22:50.277661+02	2026-09-24 08:22:50.277661+02	f
2	Rudo Chikwanha	2	\N	rudo.chikwanha@mavhu.africa	$2b$10$h.W9nihpmB8FbC7WG8Q2xuiGWhBIVnwxm/GXrgjbn7slMaF3j2Fzi	2026-09-24 08:22:50.339626+02	2026-09-24 08:22:50.339626+02	f
3	Farai Ncube	2	\N	farai.ncube@mavhu.africa	$2b$10$ViFtwisTLQSfJXsjwnRf9uzv4cM2t0Ylp1LIpIOHubMaJVOWbe4iC	2026-09-24 08:22:50.404199+02	2026-09-24 08:22:50.404199+02	f
4	Tafadzwa Sibanda	3	\N	tafadzwa.sibanda@cbz.co.zw	$2b$10$iug44mZTWsX.U094/0DBaezrQFaZ6DVYJGPshLSwBRFIT2B5cbHHe	2026-09-24 08:22:50.463564+02	2026-09-24 08:22:50.463564+02	f
5	Nyasha Dube	3	\N	nyasha.dube@cbz.co.zw	$2b$10$sticoo.aRi5NwD7EPVMP2ex4cDhs3adJpD1Uk.TnZDij/Qby2RCee	2026-09-24 08:22:50.523738+02	2026-09-24 08:22:50.523738+02	f
6	Chipo Mutasa	3	\N	chipo.mutasa@cbz.co.zw	$2b$10$y/3Q9uUmhrtZmMSotTEpJuMU.fppMbgDXf/mOk3LZUQ.sKyRTsXFy	2026-09-24 08:22:50.582502+02	2026-09-24 08:22:50.582502+02	f
7	Blessing Mhlanga	6	\N	blessing.mhlanga@chipingetea.co.zw	$2b$10$O7/aapBEuRtgo7Keu0uDFOzoJNE72OK6fiN5V8ykszDIyS1eUKFAS	2026-09-24 08:22:50.644812+02	2026-09-24 08:22:50.644812+02	f
8	Tinashe Gumbo	7	\N	tinashe.gumbo@maronderamaize.co.zw	$2b$10$Nz0MOXuWKhr84.kGVCpFAuR7iZSJbEJk7g.LuNaqpwDlPc4udR/9y	2026-09-24 08:22:50.703775+02	2026-09-24 08:22:50.703775+02	f
9	Kudzai Zhou	7	\N	kudzai.zhou@maronderamaize.co.zw	$2b$10$e34RBSWYp9kNQsqMvE8Uk.R1ZVMMaboq4XjWwwvWfaXoLe3/CmzA2	2026-09-24 08:22:50.764473+02	2026-09-24 08:22:50.764473+02	f
10	Rutendo Makoni	8	\N	rutendo.makoni@chiredzisugar.co.zw	$2b$10$VvccSo3ZHt631w4ZgW8MZe7d4BaNobKiVcHBdR5zrhjAIbSNwhJga	2026-09-24 08:22:50.824368+02	2026-09-24 08:22:50.824368+02	f
\.


--
-- Name: apis_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.apis_id_seq', 1, false);


--
-- Name: bank_customers_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.bank_customers_id_seq', 5, true);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.banks_id_seq', 3, true);


--
-- Name: cbz_reporting_periods_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.cbz_reporting_periods_id_seq', 3, true);


--
-- Name: crop_cycles_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.crop_cycles_id_seq', 1, false);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.customers_id_seq', 9, true);


--
-- Name: emission_factors_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.emission_factors_id_seq', 1, false);


--
-- Name: emissions_accounting_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.emissions_accounting_id_seq', 1, false);


--
-- Name: estates_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.estates_id_seq', 4, true);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.role_permissions_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.roles_id_seq', 5, true);


--
-- Name: satellite_ndvi_co2_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.satellite_ndvi_co2_id_seq', 1, false);


--
-- Name: schema_migrations_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.schema_migrations_id_seq', 4, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.user_roles_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.users_id_seq', 11, true);


--
-- Name: apis apis_name_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.apis
    ADD CONSTRAINT apis_name_key UNIQUE (name);


--
-- Name: apis apis_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.apis
    ADD CONSTRAINT apis_pkey PRIMARY KEY (id);


--
-- Name: bank_customers bank_customers_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers
    ADD CONSTRAINT bank_customers_pkey PRIMARY KEY (id);


--
-- Name: banks banks_email_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.banks
    ADD CONSTRAINT banks_email_key UNIQUE (email);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);


--
-- Name: cbz_audit_log cbz_audit_log_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_audit_log
    ADD CONSTRAINT cbz_audit_log_pkey PRIMARY KEY (id);


--
-- Name: cbz_counterparties cbz_counterparties_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_counterparties
    ADD CONSTRAINT cbz_counterparties_pkey PRIMARY KEY (id);


--
-- Name: cbz_departments cbz_departments_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_departments
    ADD CONSTRAINT cbz_departments_pkey PRIMARY KEY (id);


--
-- Name: cbz_entities cbz_entities_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_entities
    ADD CONSTRAINT cbz_entities_pkey PRIMARY KEY (code);


--
-- Name: cbz_esg_emissions cbz_esg_emissions_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_esg_emissions
    ADD CONSTRAINT cbz_esg_emissions_pkey PRIMARY KEY (id);


--
-- Name: cbz_financed_positions cbz_financed_positions_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_financed_positions
    ADD CONSTRAINT cbz_financed_positions_pkey PRIMARY KEY (id);


--
-- Name: cbz_financial_inclusion cbz_financial_inclusion_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_financial_inclusion
    ADD CONSTRAINT cbz_financial_inclusion_pkey PRIMARY KEY (id);


--
-- Name: cbz_geospatial cbz_geospatial_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_geospatial
    ADD CONSTRAINT cbz_geospatial_pkey PRIMARY KEY (id);


--
-- Name: cbz_incidents cbz_incidents_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_incidents
    ADD CONSTRAINT cbz_incidents_pkey PRIMARY KEY (id);


--
-- Name: cbz_ingestion_batches cbz_ingestion_batches_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_ingestion_batches
    ADD CONSTRAINT cbz_ingestion_batches_pkey PRIMARY KEY (id);


--
-- Name: cbz_insurance_policies cbz_insurance_policies_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_insurance_policies
    ADD CONSTRAINT cbz_insurance_policies_pkey PRIMARY KEY (id);


--
-- Name: cbz_members cbz_members_email_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_members
    ADD CONSTRAINT cbz_members_email_key UNIQUE (email);


--
-- Name: cbz_members cbz_members_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_members
    ADD CONSTRAINT cbz_members_pkey PRIMARY KEY (id);


--
-- Name: cbz_reporting_periods cbz_reporting_periods_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_reporting_periods
    ADD CONSTRAINT cbz_reporting_periods_pkey PRIMARY KEY (id);


--
-- Name: cbz_risk_entries cbz_risk_entries_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_risk_entries
    ADD CONSTRAINT cbz_risk_entries_pkey PRIMARY KEY (id);


--
-- Name: cbz_workforce cbz_workforce_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_workforce
    ADD CONSTRAINT cbz_workforce_pkey PRIMARY KEY (id);


--
-- Name: crop_cycles crop_cycles_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.crop_cycles
    ADD CONSTRAINT crop_cycles_pkey PRIMARY KEY (id);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: emission_factors emission_factors_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emission_factors
    ADD CONSTRAINT emission_factors_pkey PRIMARY KEY (id);


--
-- Name: emissions_accounting emissions_accounting_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_pkey PRIMARY KEY (id);


--
-- Name: estates estates_email_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.estates
    ADD CONSTRAINT estates_email_key UNIQUE (email);


--
-- Name: estates estates_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.estates
    ADD CONSTRAINT estates_pkey PRIMARY KEY (id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: satellite_ndvi_co2 satellite_ndvi_co2_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.satellite_ndvi_co2
    ADD CONSTRAINT satellite_ndvi_co2_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_filename_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.schema_migrations
    ADD CONSTRAINT schema_migrations_filename_key UNIQUE (filename);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (id);


--
-- Name: bank_customers uq_bank_customer; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers
    ADD CONSTRAINT uq_bank_customer UNIQUE (bank_id, customer_id);


--
-- Name: bank_customers uq_bank_customer_reference_number; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers
    ADD CONSTRAINT uq_bank_customer_reference_number UNIQUE (bank_id, customer_reference_number);


--
-- Name: cbz_reporting_periods uq_cbz_reporting_period; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_reporting_periods
    ADD CONSTRAINT uq_cbz_reporting_period UNIQUE (bank_id, period);


--
-- Name: emission_factors uq_emission_factors_name_component; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emission_factors
    ADD CONSTRAINT uq_emission_factors_name_component UNIQUE (name, component);


--
-- Name: role_permissions uq_role_api; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.role_permissions
    ADD CONSTRAINT uq_role_api UNIQUE (role_id, api_id);


--
-- Name: satellite_ndvi_co2 uq_satellite_customer_estate_date; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.satellite_ndvi_co2
    ADD CONSTRAINT uq_satellite_customer_estate_date UNIQUE (customer_id, estate_id, date);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_cbz_audit_log_bank_id; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_audit_log_bank_id ON mavhu.cbz_audit_log USING btree (bank_id);


--
-- Name: idx_cbz_entities_bank_id; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_entities_bank_id ON mavhu.cbz_entities USING btree (bank_id);


--
-- Name: idx_cbz_risk_entries_bank_id; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_risk_entries_bank_id ON mavhu.cbz_risk_entries USING btree (bank_id);


--
-- Name: bank_customers bank_customers_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER bank_customers_updated_at BEFORE UPDATE ON mavhu.bank_customers FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: banks banks_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER banks_updated_at BEFORE UPDATE ON mavhu.banks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_counterparties cbz_counterparties_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_counterparties_updated_at BEFORE UPDATE ON mavhu.cbz_counterparties FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_departments cbz_departments_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_departments_updated_at BEFORE UPDATE ON mavhu.cbz_departments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_entities cbz_entities_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_entities_updated_at BEFORE UPDATE ON mavhu.cbz_entities FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_esg_emissions cbz_esg_emissions_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_esg_emissions_updated_at BEFORE UPDATE ON mavhu.cbz_esg_emissions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_financed_positions cbz_financed_positions_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_financed_positions_updated_at BEFORE UPDATE ON mavhu.cbz_financed_positions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_financial_inclusion cbz_financial_inclusion_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_financial_inclusion_updated_at BEFORE UPDATE ON mavhu.cbz_financial_inclusion FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_geospatial cbz_geospatial_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_geospatial_updated_at BEFORE UPDATE ON mavhu.cbz_geospatial FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_incidents cbz_incidents_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_incidents_updated_at BEFORE UPDATE ON mavhu.cbz_incidents FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_ingestion_batches cbz_ingestion_batches_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_ingestion_batches_updated_at BEFORE UPDATE ON mavhu.cbz_ingestion_batches FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_insurance_policies cbz_insurance_policies_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_insurance_policies_updated_at BEFORE UPDATE ON mavhu.cbz_insurance_policies FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_members cbz_members_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_members_updated_at BEFORE UPDATE ON mavhu.cbz_members FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_reporting_periods cbz_reporting_periods_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_reporting_periods_updated_at BEFORE UPDATE ON mavhu.cbz_reporting_periods FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_risk_entries cbz_risk_entries_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_risk_entries_updated_at BEFORE UPDATE ON mavhu.cbz_risk_entries FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_workforce cbz_workforce_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_workforce_updated_at BEFORE UPDATE ON mavhu.cbz_workforce FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: crop_cycles crop_cycles_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER crop_cycles_updated_at BEFORE UPDATE ON mavhu.crop_cycles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: customers customer_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER customer_updated_at BEFORE UPDATE ON mavhu.customers FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: emissions_accounting emissions_accounting_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER emissions_accounting_updated_at BEFORE UPDATE ON mavhu.emissions_accounting FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: estates estates_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER estates_updated_at BEFORE UPDATE ON mavhu.estates FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: satellite_ndvi_co2 satellite_ndvi_co2_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER satellite_ndvi_co2_updated_at BEFORE UPDATE ON mavhu.satellite_ndvi_co2 FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: user_roles user_roles_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER user_roles_updated_at BEFORE UPDATE ON mavhu.user_roles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: users users_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER users_updated_at BEFORE UPDATE ON mavhu.users FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: bank_customers bank_customers_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers
    ADD CONSTRAINT bank_customers_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: bank_customers bank_customers_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.bank_customers
    ADD CONSTRAINT bank_customers_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_audit_log cbz_audit_log_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_audit_log
    ADD CONSTRAINT cbz_audit_log_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_counterparties cbz_counterparties_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_counterparties
    ADD CONSTRAINT cbz_counterparties_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_departments cbz_departments_entity_code_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_departments
    ADD CONSTRAINT cbz_departments_entity_code_fkey FOREIGN KEY (entity_code) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_entities cbz_entities_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_entities
    ADD CONSTRAINT cbz_entities_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_esg_emissions cbz_esg_emissions_approved_by_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_esg_emissions
    ADD CONSTRAINT cbz_esg_emissions_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES mavhu.cbz_members(id);


--
-- Name: cbz_esg_emissions cbz_esg_emissions_entity_code_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_esg_emissions
    ADD CONSTRAINT cbz_esg_emissions_entity_code_fkey FOREIGN KEY (entity_code) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_esg_emissions cbz_esg_emissions_submitted_by_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_esg_emissions
    ADD CONSTRAINT cbz_esg_emissions_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES mavhu.cbz_members(id);


--
-- Name: cbz_financed_positions cbz_financed_positions_counterparty_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_financed_positions
    ADD CONSTRAINT cbz_financed_positions_counterparty_id_fkey FOREIGN KEY (counterparty_id) REFERENCES mavhu.cbz_counterparties(id);


--
-- Name: cbz_financial_inclusion cbz_financial_inclusion_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_financial_inclusion
    ADD CONSTRAINT cbz_financial_inclusion_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_geospatial cbz_geospatial_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_geospatial
    ADD CONSTRAINT cbz_geospatial_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_incidents cbz_incidents_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_incidents
    ADD CONSTRAINT cbz_incidents_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_ingestion_batches cbz_ingestion_batches_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_ingestion_batches
    ADD CONSTRAINT cbz_ingestion_batches_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_insurance_policies cbz_insurance_policies_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_insurance_policies
    ADD CONSTRAINT cbz_insurance_policies_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_members cbz_members_department_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_members
    ADD CONSTRAINT cbz_members_department_id_fkey FOREIGN KEY (department_id) REFERENCES mavhu.cbz_departments(id);


--
-- Name: cbz_members cbz_members_entity_code_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_members
    ADD CONSTRAINT cbz_members_entity_code_fkey FOREIGN KEY (entity_code) REFERENCES mavhu.cbz_entities(code);


--
-- Name: cbz_reporting_periods cbz_reporting_periods_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_reporting_periods
    ADD CONSTRAINT cbz_reporting_periods_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_risk_entries cbz_risk_entries_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_risk_entries
    ADD CONSTRAINT cbz_risk_entries_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_workforce cbz_workforce_subsidiary_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_workforce
    ADD CONSTRAINT cbz_workforce_subsidiary_fkey FOREIGN KEY (subsidiary) REFERENCES mavhu.cbz_entities(code);


--
-- Name: crop_cycles crop_cycles_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.crop_cycles
    ADD CONSTRAINT crop_cycles_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: crop_cycles crop_cycles_estate_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.crop_cycles
    ADD CONSTRAINT crop_cycles_estate_id_fkey FOREIGN KEY (estate_id) REFERENCES mavhu.estates(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: crop_cycles crop_cycles_user_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.crop_cycles
    ADD CONSTRAINT crop_cycles_user_id_fkey FOREIGN KEY (user_id) REFERENCES mavhu.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_approved_by_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES mavhu.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_created_by_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_created_by_fkey FOREIGN KEY (created_by) REFERENCES mavhu.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_crop_cycle_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_crop_cycle_id_fkey FOREIGN KEY (crop_cycle_id) REFERENCES mavhu.crop_cycles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_emission_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_emission_id_fkey FOREIGN KEY (emission_id) REFERENCES mavhu.emission_factors(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: emissions_accounting emissions_accounting_estate_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.emissions_accounting
    ADD CONSTRAINT emissions_accounting_estate_id_fkey FOREIGN KEY (estate_id) REFERENCES mavhu.estates(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: estates estates_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.estates
    ADD CONSTRAINT estates_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: role_permissions role_permissions_api_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.role_permissions
    ADD CONSTRAINT role_permissions_api_id_fkey FOREIGN KEY (api_id) REFERENCES mavhu.apis(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES mavhu.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: satellite_ndvi_co2 satellite_ndvi_co2_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.satellite_ndvi_co2
    ADD CONSTRAINT satellite_ndvi_co2_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: satellite_ndvi_co2 satellite_ndvi_co2_estate_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.satellite_ndvi_co2
    ADD CONSTRAINT satellite_ndvi_co2_estate_id_fkey FOREIGN KEY (estate_id) REFERENCES mavhu.estates(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES mavhu.roles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES mavhu.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.users
    ADD CONSTRAINT users_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: users users_estate_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.users
    ADD CONSTRAINT users_estate_id_fkey FOREIGN KEY (estate_id) REFERENCES mavhu.estates(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict t5dptAEu69cWbAlAmYawXiznOYuMKTTT0Rw3RV4l9ygvYrkDQ11NzJfNYgRmn7C

