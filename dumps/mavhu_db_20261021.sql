--
-- PostgreSQL database dump
--

\restrict laSKlvqT0aGAhTzpPSgd7OuQbj4ar5hbYjRnNERILQZpmjkfBeTOJqtdHhMSftX

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

--
-- Prerequisites outside the mavhu schema. pg_dump -n mavhu does not include them, so a restore
-- into a fresh database (e.g. the EC2 server) would fail on the customers table and the
-- updated_at triggers. Both are created only when missing, so re-running this file is safe.
--

DO $do$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type t JOIN pg_namespace n ON n.oid = t.typnamespace
                   WHERE n.nspname = 'public' AND t.typname = 'customer_identifier') THEN
        CREATE TYPE public.customer_identifier AS ENUM ('BANK', 'AGROBUSINESS', 'PLATFORM');
    END IF;
END
$do$;

ALTER TYPE public.customer_identifier ADD VALUE IF NOT EXISTS 'PLATFORM';

DO $do$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
                   WHERE n.nspname = 'public' AND p.proname = 'update_updated_at') THEN
        CREATE FUNCTION public.update_updated_at() RETURNS trigger LANGUAGE plpgsql AS $fn$
        BEGIN
            NEW.updated_at = CURRENT_TIMESTAMP;
            RETURN NEW;
        END;
        $fn$;
    END IF;
END
$do$;


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
ALTER TABLE IF EXISTS ONLY mavhu.cbz_register_items DROP CONSTRAINT IF EXISTS cbz_register_items_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_department_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_insurance_policies DROP CONSTRAINT IF EXISTS cbz_insurance_policies_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_ingestion_batches DROP CONSTRAINT IF EXISTS cbz_ingestion_batches_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_incidents DROP CONSTRAINT IF EXISTS cbz_incidents_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_geospatial DROP CONSTRAINT IF EXISTS cbz_geospatial_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financial_inclusion DROP CONSTRAINT IF EXISTS cbz_financial_inclusion_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financed_positions DROP CONSTRAINT IF EXISTS cbz_financed_positions_counterparty_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_evidence DROP CONSTRAINT IF EXISTS cbz_evidence_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_evidence DROP CONSTRAINT IF EXISTS cbz_evidence_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_submitted_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_entities DROP CONSTRAINT IF EXISTS cbz_entities_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_disclosures DROP CONSTRAINT IF EXISTS cbz_disclosures_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_departments DROP CONSTRAINT IF EXISTS cbz_departments_entity_code_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_counterparties DROP CONSTRAINT IF EXISTS cbz_counterparties_subsidiary_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_counterparties DROP CONSTRAINT IF EXISTS cbz_counterparties_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_audit_log DROP CONSTRAINT IF EXISTS cbz_audit_log_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_bank_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.agri_field_verifications DROP CONSTRAINT IF EXISTS agri_field_verifications_estate_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.agri_field_verifications DROP CONSTRAINT IF EXISTS agri_field_verifications_customer_id_fkey;
ALTER TABLE IF EXISTS ONLY mavhu.agri_field_verifications DROP CONSTRAINT IF EXISTS agri_field_verifications_created_by_fkey;
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
DROP TRIGGER IF EXISTS cbz_register_items_updated_at ON mavhu.cbz_register_items;
DROP TRIGGER IF EXISTS cbz_members_updated_at ON mavhu.cbz_members;
DROP TRIGGER IF EXISTS cbz_insurance_policies_updated_at ON mavhu.cbz_insurance_policies;
DROP TRIGGER IF EXISTS cbz_ingestion_batches_updated_at ON mavhu.cbz_ingestion_batches;
DROP TRIGGER IF EXISTS cbz_incidents_updated_at ON mavhu.cbz_incidents;
DROP TRIGGER IF EXISTS cbz_geospatial_updated_at ON mavhu.cbz_geospatial;
DROP TRIGGER IF EXISTS cbz_financial_inclusion_updated_at ON mavhu.cbz_financial_inclusion;
DROP TRIGGER IF EXISTS cbz_financed_positions_updated_at ON mavhu.cbz_financed_positions;
DROP TRIGGER IF EXISTS cbz_esg_emissions_updated_at ON mavhu.cbz_esg_emissions;
DROP TRIGGER IF EXISTS cbz_entities_updated_at ON mavhu.cbz_entities;
DROP TRIGGER IF EXISTS cbz_disclosures_immutable ON mavhu.cbz_disclosures;
DROP TRIGGER IF EXISTS cbz_departments_updated_at ON mavhu.cbz_departments;
DROP TRIGGER IF EXISTS cbz_counterparties_updated_at ON mavhu.cbz_counterparties;
DROP TRIGGER IF EXISTS cbz_audit_log_append_only ON mavhu.cbz_audit_log;
DROP TRIGGER IF EXISTS banks_updated_at ON mavhu.banks;
DROP TRIGGER IF EXISTS bank_customers_updated_at ON mavhu.bank_customers;
DROP TRIGGER IF EXISTS agri_field_verifications_updated_at ON mavhu.agri_field_verifications;
DROP INDEX IF EXISTS mavhu.uq_cbz_audit_log_seq;
DROP INDEX IF EXISTS mavhu.idx_cbz_risk_entries_bank_id;
DROP INDEX IF EXISTS mavhu.idx_cbz_register_items_bank;
DROP INDEX IF EXISTS mavhu.idx_cbz_evidence_target;
DROP INDEX IF EXISTS mavhu.idx_cbz_entities_bank_id;
DROP INDEX IF EXISTS mavhu.idx_cbz_audit_log_bank_id;
ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.user_roles DROP CONSTRAINT IF EXISTS user_roles_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.satellite_ndvi_co2 DROP CONSTRAINT IF EXISTS uq_satellite_customer_estate_date;
ALTER TABLE IF EXISTS ONLY mavhu.role_permissions DROP CONSTRAINT IF EXISTS uq_role_api;
ALTER TABLE IF EXISTS ONLY mavhu.emission_factors DROP CONSTRAINT IF EXISTS uq_emission_factors_name_component;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_reporting_periods DROP CONSTRAINT IF EXISTS uq_cbz_reporting_period;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_disclosures DROP CONSTRAINT IF EXISTS uq_cbz_disclosure_version;
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
ALTER TABLE IF EXISTS ONLY mavhu.cbz_register_items DROP CONSTRAINT IF EXISTS cbz_register_items_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_members DROP CONSTRAINT IF EXISTS cbz_members_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_insurance_policies DROP CONSTRAINT IF EXISTS cbz_insurance_policies_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_ingestion_batches DROP CONSTRAINT IF EXISTS cbz_ingestion_batches_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_incidents DROP CONSTRAINT IF EXISTS cbz_incidents_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_geospatial DROP CONSTRAINT IF EXISTS cbz_geospatial_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financial_inclusion DROP CONSTRAINT IF EXISTS cbz_financial_inclusion_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_financed_positions DROP CONSTRAINT IF EXISTS cbz_financed_positions_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_evidence DROP CONSTRAINT IF EXISTS cbz_evidence_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_esg_emissions DROP CONSTRAINT IF EXISTS cbz_esg_emissions_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_entities DROP CONSTRAINT IF EXISTS cbz_entities_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_disclosures DROP CONSTRAINT IF EXISTS cbz_disclosures_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_departments DROP CONSTRAINT IF EXISTS cbz_departments_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_counterparties DROP CONSTRAINT IF EXISTS cbz_counterparties_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.cbz_audit_log DROP CONSTRAINT IF EXISTS cbz_audit_log_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.banks DROP CONSTRAINT IF EXISTS banks_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.banks DROP CONSTRAINT IF EXISTS banks_email_key;
ALTER TABLE IF EXISTS ONLY mavhu.bank_customers DROP CONSTRAINT IF EXISTS bank_customers_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.apis DROP CONSTRAINT IF EXISTS apis_pkey;
ALTER TABLE IF EXISTS ONLY mavhu.apis DROP CONSTRAINT IF EXISTS apis_name_key;
ALTER TABLE IF EXISTS ONLY mavhu.agri_field_verifications DROP CONSTRAINT IF EXISTS agri_field_verifications_pkey;
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
ALTER TABLE IF EXISTS mavhu.cbz_audit_log ALTER COLUMN seq DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.banks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.bank_customers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.apis ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS mavhu.agri_field_verifications ALTER COLUMN id DROP DEFAULT;
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
DROP TABLE IF EXISTS mavhu.cbz_register_items;
DROP TABLE IF EXISTS mavhu.cbz_members;
DROP TABLE IF EXISTS mavhu.cbz_insurance_policies;
DROP TABLE IF EXISTS mavhu.cbz_ingestion_batches;
DROP TABLE IF EXISTS mavhu.cbz_incidents;
DROP TABLE IF EXISTS mavhu.cbz_geospatial;
DROP TABLE IF EXISTS mavhu.cbz_financial_inclusion;
DROP TABLE IF EXISTS mavhu.cbz_financed_positions;
DROP TABLE IF EXISTS mavhu.cbz_evidence;
DROP TABLE IF EXISTS mavhu.cbz_esg_emissions;
DROP TABLE IF EXISTS mavhu.cbz_entities;
DROP TABLE IF EXISTS mavhu.cbz_disclosures;
DROP TABLE IF EXISTS mavhu.cbz_departments;
DROP TABLE IF EXISTS mavhu.cbz_counterparties;
DROP SEQUENCE IF EXISTS mavhu.cbz_audit_log_seq_seq;
DROP TABLE IF EXISTS mavhu.cbz_audit_log;
DROP SEQUENCE IF EXISTS mavhu.banks_id_seq;
DROP TABLE IF EXISTS mavhu.banks;
DROP SEQUENCE IF EXISTS mavhu.bank_customers_id_seq;
DROP TABLE IF EXISTS mavhu.bank_customers;
DROP SEQUENCE IF EXISTS mavhu.apis_id_seq;
DROP TABLE IF EXISTS mavhu.apis;
DROP SEQUENCE IF EXISTS mavhu.agri_field_verifications_id_seq;
DROP TABLE IF EXISTS mavhu.agri_field_verifications;
DROP FUNCTION IF EXISTS mavhu.cbz_disclosures_immutable();
DROP FUNCTION IF EXISTS mavhu.cbz_audit_log_append_only();
DROP SCHEMA IF EXISTS mavhu;
--
-- Name: mavhu; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA mavhu;


--
-- Name: cbz_audit_log_append_only(); Type: FUNCTION; Schema: mavhu; Owner: -
--

CREATE FUNCTION mavhu.cbz_audit_log_append_only() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


--
-- Name: cbz_disclosures_immutable(); Type: FUNCTION; Schema: mavhu; Owner: -
--

CREATE FUNCTION mavhu.cbz_disclosures_immutable() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    RAISE EXCEPTION 'Published disclosures are immutable; publish a new version instead';
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: agri_field_verifications; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.agri_field_verifications (
    id integer NOT NULL,
    customer_id integer NOT NULL,
    estate_id integer NOT NULL,
    visit_date date NOT NULL,
    officer character varying(255) NOT NULL,
    method character varying(100) NOT NULL,
    findings text NOT NULL,
    ndvi_confirmed boolean DEFAULT true NOT NULL,
    status character varying(20) DEFAULT 'Submitted'::character varying NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT agri_field_verifications_status_check CHECK (((status)::text = ANY ((ARRAY['Submitted'::character varying, 'Verified'::character varying, 'Disputed'::character varying])::text[])))
);


--
-- Name: agri_field_verifications_id_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.agri_field_verifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agri_field_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.agri_field_verifications_id_seq OWNED BY mavhu.agri_field_verifications.id;


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
    modules text[] DEFAULT ARRAY['snapshot'::text, 'portfolio'::text, 'insurance'::text, 'risk'::text, 'predictive'::text, 'workflow'::text, 'entity'::text, 'data-entry'::text, 'members'::text, 'sustainable-finance'::text, 'scenarios'::text, 'appetite'::text, 'targets'::text, 'decarbonisation'::text, 'environment'::text, 'social'::text, 'materiality'::text, 'stakeholders'::text, 'suppliers'::text, 'data-ownership'::text, 'disclosures'::text, 'evidence'::text] NOT NULL,
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
    bank_id integer,
    seq bigint NOT NULL,
    before jsonb,
    after jsonb,
    prev_hash character varying(64),
    hash character varying(64)
);


--
-- Name: cbz_audit_log_seq_seq; Type: SEQUENCE; Schema: mavhu; Owner: -
--

CREATE SEQUENCE mavhu.cbz_audit_log_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cbz_audit_log_seq_seq; Type: SEQUENCE OWNED BY; Schema: mavhu; Owner: -
--

ALTER SEQUENCE mavhu.cbz_audit_log_seq_seq OWNED BY mavhu.cbz_audit_log.seq;


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
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    taxonomy character varying(40),
    taxonomy_category character varying(120),
    taxonomy_status character varying(20),
    customer_id integer
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
-- Name: cbz_disclosures; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_disclosures (
    id character varying(40) NOT NULL,
    bank_id integer NOT NULL,
    framework character varying(40) NOT NULL,
    period character varying(20) NOT NULL,
    version integer NOT NULL,
    title character varying(255) NOT NULL,
    snapshot jsonb NOT NULL,
    hash character varying(64) NOT NULL,
    published_by character varying(255) NOT NULL,
    published_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    review_note text
);


--
-- Name: cbz_evidence; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_evidence (
    id character varying(40) NOT NULL,
    bank_id integer NOT NULL,
    entity_code character varying(20),
    target_type character varying(40) NOT NULL,
    target_id character varying(60),
    file_name character varying(255) NOT NULL,
    mime_type character varying(120) NOT NULL,
    size_bytes integer NOT NULL,
    sha256 character varying(64) NOT NULL,
    content bytea NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    uploaded_by character varying(255) NOT NULL,
    uploaded_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
-- Name: cbz_register_items; Type: TABLE; Schema: mavhu; Owner: -
--

CREATE TABLE mavhu.cbz_register_items (
    id character varying(40) NOT NULL,
    bank_id integer NOT NULL,
    register character varying(40) NOT NULL,
    entity_code character varying(20),
    data jsonb NOT NULL,
    created_by character varying(255) NOT NULL,
    updated_by character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
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
-- Name: agri_field_verifications id; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.agri_field_verifications ALTER COLUMN id SET DEFAULT nextval('mavhu.agri_field_verifications_id_seq'::regclass);


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
-- Name: cbz_audit_log seq; Type: DEFAULT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_audit_log ALTER COLUMN seq SET DEFAULT nextval('mavhu.cbz_audit_log_seq_seq'::regclass);


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
-- Data for Name: agri_field_verifications; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.agri_field_verifications (id, customer_id, estate_id, visit_date, officer, method, findings, ndvi_confirmed, status, created_by, created_at, updated_at) FROM stdin;
1	7	2	2026-08-27	Bank agronomist	Farm visit + photo evidence	Irrigation infrastructure confirmed; input records sighted (Marondera North Fields)	t	Submitted	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
3	8	3	2026-08-27	Bank agronomist	Farm visit + photo evidence	Irrigation infrastructure confirmed; input records sighted (Hippo Valley Cane Fields)	t	Submitted	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
4	9	4	2026-02-18	MAvHU field team (Dudley)	Ground-truth transect + drone	Canopy cover consistent with Sentinel-2 NDVI; no land clearing observed (Nyanga Orchard Terraces)	t	Verified	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
5	6	1	2026-02-18	MAvHU field team (Dudley)	Ground-truth transect + drone	Canopy cover consistent with Sentinel-2 NDVI; no land clearing observed (Chipinge Highveld Block)	t	Verified	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
6	8	3	2026-02-18	MAvHU field team (Dudley)	Ground-truth transect + drone	Canopy cover consistent with Sentinel-2 NDVI; no land clearing observed (Hippo Valley Cane Fields)	t	Verified	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
7	9	4	2026-08-27	Bank agronomist	Farm visit + photo evidence	Irrigation infrastructure confirmed; input records sighted (Nyanga Orchard Terraces)	t	Submitted	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
8	6	1	2026-08-27	Bank agronomist	Farm visit + photo evidence	Irrigation infrastructure confirmed; input records sighted (Chipinge Highveld Block)	t	Submitted	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
2	7	2	2026-02-18	MAvHU field team (Dudley)	Ground-truth transect + drone	Drought stress confirmed on the ground: maize wilting on 40% of fields; yield forecast cut (Marondera North Fields)	t	Disputed	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
\.


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
1	CBZ Bank Limited	Zimbabwe	contact@cbz.co.zw	\N	CBZ-ZW-001	2026-09-24 08:22:50.176256+02	2026-10-21 07:10:51.523049+02	f	active	{appetite,data-entry,data-ownership,decarbonisation,disclosures,entity,environment,evidence,insurance,materiality,members,portfolio,predictive,risk,scenarios,snapshot,social,stakeholders,suppliers,sustainable-finance,targets,workflow}
2	Stanbic Bank Zimbabwe	Zimbabwe	contact@stanbicbank.co.zw	\N	STANBIC-ZW-001	2026-09-24 08:22:50.180001+02	2026-10-21 07:10:51.523049+02	f	active	{appetite,data-entry,data-ownership,decarbonisation,disclosures,entity,environment,evidence,insurance,materiality,members,portfolio,predictive,risk,scenarios,snapshot,social,stakeholders,suppliers,sustainable-finance,targets,workflow}
3	FBC Bank Limited	Zimbabwe	contact@fbc.co.zw	\N	FBC-ZW-001	2026-09-24 08:22:50.182259+02	2026-10-21 07:10:51.523049+02	f	active	{appetite,data-entry,data-ownership,decarbonisation,disclosures,entity,environment,evidence,insurance,materiality,members,portfolio,predictive,risk,scenarios,snapshot,social,stakeholders,suppliers,sustainable-finance,targets,workflow}
\.


--
-- Data for Name: cbz_audit_log; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_audit_log (id, "timestamp", actor, action, entity_code, target_type, target_id, detail, created_at, bank_id, seq, before, after, prev_hash, hash) FROM stdin;
AUDIT-001	2026-09-02 10:14:00+02	Melissa Chirandu	INGEST	CBZBANK	EmissionRecord	S1-001	Uploaded CBZBANK Scope 1 fleet fuel for 2026-08 (9 records)	2026-09-28 09:11:14.509635+02	1	1	\N	\N	0000000000000000000000000000000000000000000000000000000000000000	df3fe3faef36104b58f33db84b34702b6fd41f66cdbe2e3066ad89b34eb8ff74
AUDIT-002	2026-09-03 12:00:00+02	Tafara Chikwanha	APPROVE	CBZBANK	EmissionRecord	S1-001	Approved batch of 4 Scope 1 records for CBZBANK 2026-08	2026-09-28 09:11:14.515057+02	1	2	\N	\N	df3fe3faef36104b58f33db84b34702b6fd41f66cdbe2e3066ad89b34eb8ff74	a83cf1a20f5f746b7c19e4217bd5e9e54106afe9542c900fb99b9fbe3ef856e5
AUDIT-003	2026-09-05 16:22:00+02	Anesu Mutasa	INGEST_PARTIAL	CBZBANK	EmissionRecord	BATCH-2604	Batch BATCH-2604: 118 records posted, 6 rejected (denominator missing)	2026-09-28 09:11:14.518784+02	1	3	\N	\N	a83cf1a20f5f746b7c19e4217bd5e9e54106afe9542c900fb99b9fbe3ef856e5	c091ab6446753f3d54d45236120c330c102affd5948d9fbeb87ad17c207a1c76
AUDIT-004	2026-09-06 12:00:00+02	Anesu Mutasa	APPROVE	GROUP	EmissionRecord	S3-001	Approved Group Scope 3 category 1 & 5 records	2026-09-28 09:11:14.523192+02	1	4	\N	\N	c091ab6446753f3d54d45236120c330c102affd5948d9fbeb87ad17c207a1c76	6c2dee2d2de8e2161507091062264f24fba62d77d41b8b6f3ce7bd10b24332d1
AUDIT-005	2026-09-06 15:47:00+02	Blessing Mutasa	INGEST	CBZCAP	EmissionRecord	BATCH-2608	Uploaded CBZCAP facilitated emissions batch for 2026	2026-09-28 09:11:14.527576+02	1	5	\N	\N	6c2dee2d2de8e2161507091062264f24fba62d77d41b8b6f3ce7bd10b24332d1	a9a8bc342bc7806800d0fbe98c79be623ad2eacd28fc1880d9b547ec7e050fb9
STB-AUD-1	2026-09-20 10:00:00+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	2	6	\N	\N	a9a8bc342bc7806800d0fbe98c79be623ad2eacd28fc1880d9b547ec7e050fb9	2750ef5c21a28de016c3242f3cb9ef1ffd0ca43c01531ce9677680e290c69452
STW-AUD-1	2026-09-20 10:00:00+02	Chiedza Sibanda	LOGIN	STANWLTH	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	2	7	\N	\N	2750ef5c21a28de016c3242f3cb9ef1ffd0ca43c01531ce9677680e290c69452	c24213dcf6fa106032da53df58206ca24355db3b6353134d898fc63e60a1fca9
FBB-AUD-1	2026-09-20 10:00:00+02	Simbarashe Marufu	LOGIN	FBCBANK	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	3	8	\N	\N	c24213dcf6fa106032da53df58206ca24355db3b6353134d898fc63e60a1fca9	4383cda1e12047253306c11648deefd2ae61c4d4f7591782da055d252ce72641
FBI-AUD-1	2026-09-20 10:00:00+02	Rutendo Hove	LOGIN	FBCINS	Auth	\N	Signed in	2026-10-04 22:10:18.087517+02	3	9	\N	\N	4383cda1e12047253306c11648deefd2ae61c4d4f7591782da055d252ce72641	d30ea5a4c4e5223163f1330dbef9b2f8c7c71cbd87b0589d85cec9f04a218a92
STB-AUD-2	2026-09-20 11:00:00+02	Kudakwashe Chigumba	CREATE	STANBANK	Counterparty	STB-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	2	10	\N	\N	d30ea5a4c4e5223163f1330dbef9b2f8c7c71cbd87b0589d85cec9f04a218a92	cdce8a8b974d2a8d24626f556a51755b9d6265a01f35a7a80015ef1e579496cf
STW-AUD-2	2026-09-20 11:00:00+02	Vimbai Nyathi	CREATE	STANWLTH	Counterparty	STW-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	2	11	\N	\N	cdce8a8b974d2a8d24626f556a51755b9d6265a01f35a7a80015ef1e579496cf	0f3dd01d0b8786adaf7c8dec2322dfeeb53bc1a80910bd1c30b6346ca39633d0
FBB-AUD-2	2026-09-20 11:00:00+02	Takudzwa Zvobgo	CREATE	FBCBANK	Counterparty	FBB-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	3	12	\N	\N	0f3dd01d0b8786adaf7c8dec2322dfeeb53bc1a80910bd1c30b6346ca39633d0	1d0f8f0d10ce7660f0ec30d115ce6e63238c620d5441c4bf47109d5129f53652
FBI-AUD-2	2026-09-20 11:00:00+02	Shamiso Chirwa	CREATE	FBCINS	Counterparty	FBI-CP-1	Added counterparty	2026-10-04 22:10:18.087517+02	3	13	\N	\N	1d0f8f0d10ce7660f0ec30d115ce6e63238c620d5441c4bf47109d5129f53652	592be916219a4424eb4015fc441751225920052422b2f7de55e1674650c4fc60
STB-AUD-3	2026-09-20 12:00:00+02	Kudakwashe Chigumba	SUBMIT	STANBANK	EmissionRecord	STB-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	2	14	\N	\N	592be916219a4424eb4015fc441751225920052422b2f7de55e1674650c4fc60	95cf04205a39b5e4ce905d9ac26febd3630280c2c2d48a52feef6d8e0f8e4b9b
STW-AUD-3	2026-09-20 12:00:00+02	Vimbai Nyathi	SUBMIT	STANWLTH	EmissionRecord	STW-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	2	15	\N	\N	95cf04205a39b5e4ce905d9ac26febd3630280c2c2d48a52feef6d8e0f8e4b9b	ad69cb9bcca5ba6e4282725248175ea80c54b82775bb18ee28052de7253638a3
FBB-AUD-3	2026-09-20 12:00:00+02	Takudzwa Zvobgo	SUBMIT	FBCBANK	EmissionRecord	FBB-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	3	16	\N	\N	ad69cb9bcca5ba6e4282725248175ea80c54b82775bb18ee28052de7253638a3	3a9e15500f49d353f7553d45474d9b3bbe0e514fc460f296666aa3afe3fcd206
FBI-AUD-3	2026-09-20 12:00:00+02	Shamiso Chirwa	SUBMIT	FBCINS	EmissionRecord	FBI-EM-3	Submitted grid electricity for review	2026-10-04 22:10:18.087517+02	3	17	\N	\N	3a9e15500f49d353f7553d45474d9b3bbe0e514fc460f296666aa3afe3fcd206	cc704ff972b4c41c4df867ac6feab99126d379b7ed16d194d76c885b1c2dde7e
STW-AUD-4	2026-09-20 13:00:00+02	Tapiwa Gumbo	APPROVE	STANWLTH	EmissionRecord	STW-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	2	19	\N	\N	8c650aaf3407d832d6cc782372e9412c5194e2be92253b18632de1e726bb1c59	3a5eeb41942da91351c9e98819735500d478fbc79e623e0186a2d98eb94eec0a
FBB-AUD-4	2026-09-20 13:00:00+02	Tsitsi Chinoda	APPROVE	FBCBANK	EmissionRecord	FBB-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	3	20	\N	\N	3a5eeb41942da91351c9e98819735500d478fbc79e623e0186a2d98eb94eec0a	f239eb07aaec9157a3bc620de5e29087342104bd2458377f8b32e18688735230
FBI-AUD-4	2026-09-20 13:00:00+02	Tonderai Maposa	APPROVE	FBCINS	EmissionRecord	FBI-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	3	21	\N	\N	f239eb07aaec9157a3bc620de5e29087342104bd2458377f8b32e18688735230	4b09ed178f6f9d01d765600bd2c599f150946858b5f2b1a9e6eeb349f85c1b39
STB-AUD-5	2026-09-20 14:00:00+02	Rumbidzai Ndlovu	LOCK	STANBANK	Workflow	STB-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	2	22	\N	\N	4b09ed178f6f9d01d765600bd2c599f150946858b5f2b1a9e6eeb349f85c1b39	6677435904b8476379f69e8dbc9b21c0763998d84d872b1a899b041079fca002
STW-AUD-5	2026-09-20 14:00:00+02	Tapiwa Gumbo	LOCK	STANWLTH	Workflow	STW-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	2	23	\N	\N	6677435904b8476379f69e8dbc9b21c0763998d84d872b1a899b041079fca002	2ed9ff47d89c745a774cb78e0e335d9e86d6b55f8b3448e42f505855a62997b2
FBB-AUD-5	2026-09-20 14:00:00+02	Tsitsi Chinoda	LOCK	FBCBANK	Workflow	FBB-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	3	24	\N	\N	2ed9ff47d89c745a774cb78e0e335d9e86d6b55f8b3448e42f505855a62997b2	d5ac9b50f8a6a6f0c44bf78377df956a42d1b064bb7214c1957bae955139191e
FBI-AUD-5	2026-09-20 14:00:00+02	Tonderai Maposa	LOCK	FBCINS	Workflow	FBI-EM-5	Locked Cat 1 spend record	2026-10-04 22:10:18.087517+02	3	25	\N	\N	d5ac9b50f8a6a6f0c44bf78377df956a42d1b064bb7214c1957bae955139191e	b27eab1012d2ec6c29b6b9767b03fd6b27e8d2a98d6b6cc4b0eb74df82ccc419
4bcd9d68-7a23-4c64-9488-cc13f9ecefc7	2026-10-04 22:22:16.254+02	tendai.moyo@mavhu.africa (MAvHU)	LOCK	GROUP	Workflow	2026-Q4	Locked reporting period 2026-Q4 for CBZ Bank Limited	2026-10-04 22:22:16.256419+02	1	26	\N	\N	b27eab1012d2ec6c29b6b9767b03fd6b27e8d2a98d6b6cc4b0eb74df82ccc419	b3637ba102417ab1395338b0c471acc065580fbceeddbe59a2a38c66b6d4bff3
66f62bdf-4836-4e5e-912f-82c16e5f7c9b	2026-10-04 22:22:20.509+02	tendai.moyo@mavhu.africa (MAvHU)	UNLOCK	GROUP	Workflow	2026-Q4	Reopened reporting period 2026-Q4 for CBZ Bank Limited	2026-10-04 22:22:20.512501+02	1	27	\N	\N	b3637ba102417ab1395338b0c471acc065580fbceeddbe59a2a38c66b6d4bff3	bb77e0c750e3bebf5b0ccc28690225516ecef9831b546c9e80118f82382ed57a
f6400a11-d24a-4d0b-83e8-d3f14ea702da	2026-10-04 22:27:52.398+02	tendai.moyo@mavhu.africa (MAvHU)	UPDATE	\N	Bank	3	Updated undefined: modules → snapshot, portfolio, risk	2026-10-04 22:27:52.399527+02	3	28	\N	\N	bb77e0c750e3bebf5b0ccc28690225516ecef9831b546c9e80118f82382ed57a	a807b57dc7e5e2a36c37cab1a5b2ad319b2184c67def8f66f739ca7e67ffdee6
639c3ea4-adf3-48ec-980d-0ddd49ae7abc	2026-10-21 07:54:41.111+02	Anesu Mutasa	LOGIN	CBZBANK	Auth	USR-ADMIN	Signed in as admin	2026-10-21 07:54:41.11049+02	1	81	\N	\N	7ebfb7072d11e85d214f7a7391278ff94aa692a0a7751cdf4a397c90da4b62ec	b48c611c8249c64a8a45e7e8b0dfab56b342ae0036a9f767e003029c62c3bbdd
STB-AUD-4	2026-09-20 13:00:00+02	Rumbidzai Ndlovu	APPROVE	STANBANK	EmissionRecord	STB-EM-1	Approved fleet fuel	2026-10-04 22:10:18.087517+02	2	18	\N	\N	cc704ff972b4c41c4df867ac6feab99126d379b7ed16d194d76c885b1c2dde7e	8c650aaf3407d832d6cc782372e9412c5194e2be92253b18632de1e726bb1c59
79d5cf9e-d2e8-4353-ade2-22316b6e7457	2026-10-21 07:43:28.856+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	STB-USR-1	Signed in as admin	2026-10-21 07:43:28.854715+02	2	59	\N	\N	a807b57dc7e5e2a36c37cab1a5b2ad319b2184c67def8f66f739ca7e67ffdee6	3b0665f7a00fe2a7a92234242bfecca9799b026cf4d2cf1fda4ffc83a23d57de
444b8916-b5e7-4137-a4ff-6aa6c2c3efa7	2026-10-21 07:43:51.856+02	Nyasha Moyo	LOGIN	STANBANK	Auth	STB-USR-4	Signed in as reader	2026-10-21 07:43:51.856281+02	2	60	\N	\N	3b0665f7a00fe2a7a92234242bfecca9799b026cf4d2cf1fda4ffc83a23d57de	8e8d9c1576de4ed54bac1a14c450d0f73f1998f1ec011f62422609ce4acda3b9
22f013a7-9732-4d23-8acc-7ed3efa79d32	2026-10-21 07:43:56.545+02	Anesu Mutasa	LOGIN	CBZBANK	Auth	USR-ADMIN	Signed in as admin	2026-10-21 07:43:56.544983+02	1	61	\N	\N	8e8d9c1576de4ed54bac1a14c450d0f73f1998f1ec011f62422609ce4acda3b9	7f021999345ababc0836b91837d28d387299c8b3e66a9972f41e80edf748b2f2
a7920a2c-5ce2-4e84-a6db-41ef20418feb	2026-10-21 07:48:21.757+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	STB-USR-1	Signed in as admin	2026-10-21 07:48:21.756832+02	2	62	\N	\N	7f021999345ababc0836b91837d28d387299c8b3e66a9972f41e80edf748b2f2	bb251fd542662bb9ffcc26715354b369ba82daaea3eaaf22d97aeda20badcb5d
d7735509-0574-4738-8349-f4797e425d3c	2026-10-21 07:48:21.832+02	Simbarashe Marufu	LOGIN	FBCBANK	Auth	FBB-USR-1	Signed in as admin	2026-10-21 07:48:21.831946+02	3	63	\N	\N	bb251fd542662bb9ffcc26715354b369ba82daaea3eaaf22d97aeda20badcb5d	26b679829fc78fc54612b02df3d877ec4fb0a61ca972456e4fcfe69c84e6251f
c6096d84-2dd4-4e91-b0ad-c208cbd5ecbf	2026-10-21 07:48:39.965+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	STB-USR-1	Signed in as admin	2026-10-21 07:48:39.964168+02	2	64	\N	\N	26b679829fc78fc54612b02df3d877ec4fb0a61ca972456e4fcfe69c84e6251f	7246843888955355bc3ddd80a428e3c72771ba0023e49747597f55dc810eb429
ef8354d8-c0a3-48a6-a6b0-26645adc7cdc	2026-10-21 07:49:08.355+02	Tatenda Mhlanga	LOGIN	STANBANK	Auth	STB-USR-1	Signed in as admin	2026-10-21 07:49:08.354653+02	2	65	\N	\N	7246843888955355bc3ddd80a428e3c72771ba0023e49747597f55dc810eb429	ec54311dc38e36367b06cf39192341992786849476ac06d6bdc286ee9b35c09d
2745c9ad-88b7-479d-829b-f77ef7cd7ec6	2026-10-21 07:49:11.06+02	Tatenda Mhlanga	UPLOAD	GROUP	Evidence	2b2c3980-8479-40f6-bd25-189386a2259b	Attached Fuel_card_statement_STANBANK_2026-08.pdf (2 KB, sha256 1211456b9db5…) to EmissionRecord	2026-10-21 07:49:11.057668+02	2	66	\N	\N	ec54311dc38e36367b06cf39192341992786849476ac06d6bdc286ee9b35c09d	7c7d85a4c67c7978f9fe48614d13ad875ea6dace567eb47b881305e9f9fdf9a5
ab788cf3-4dd6-46d9-90e1-e1c04897baae	2026-10-21 07:49:13.884+02	Tatenda Mhlanga	UPLOAD	GROUP	Evidence	f598cc56-13fc-4de3-9eb9-4efa2b9f775f	Attached Board_ESG_committee_minutes_2026-Q3.pdf (2 KB, sha256 04d0a8da3de4…) to Disclosure	2026-10-21 07:49:13.882516+02	2	67	\N	\N	7c7d85a4c67c7978f9fe48614d13ad875ea6dace567eb47b881305e9f9fdf9a5	9e16931340cbb472e8f20f3edd106f884aaf785b6b8bef605212a1aadada8af8
07eea10c-f410-4135-83bd-6b706e076a30	2026-10-21 07:49:17.458+02	Tatenda Mhlanga	PUBLISH	GROUP	Disclosure	a149ac78-f18b-43fb-b32a-0ab89c566edc	Published IFRS S2 2025 v1 (13/15 items reported, sha256 d9bfe5f62fe2…)	2026-10-21 07:49:17.452822+02	2	68	\N	\N	9e16931340cbb472e8f20f3edd106f884aaf785b6b8bef605212a1aadada8af8	091f9714ac527f72fdf12d52d70386a68370e3232990c4d477e57649b3085d28
04cee664-c5fa-48c2-ad9d-0d6b2a3d30ea	2026-10-21 07:49:21.225+02	Tatenda Mhlanga	PUBLISH	GROUP	Disclosure	5c0ab666-fe9f-4aa5-af1c-6b4821296c1e	Published GRI 2025 v1 (11/17 items reported, sha256 e77cdc026ff4…)	2026-10-21 07:49:21.222341+02	2	69	\N	\N	091f9714ac527f72fdf12d52d70386a68370e3232990c4d477e57649b3085d28	94ec8aa634cd811d2eb71f12dc90487aa00b2ad7d5326b478479bc4450ef203c
d239354c-5687-49f0-8439-a706e66cdfbb	2026-10-21 07:49:27.666+02	Simbarashe Marufu	LOGIN	FBCBANK	Auth	FBB-USR-1	Signed in as admin	2026-10-21 07:49:27.665995+02	3	70	\N	\N	94ec8aa634cd811d2eb71f12dc90487aa00b2ad7d5326b478479bc4450ef203c	aea12ca75069ee37ba201374d4d25c9ff1028df962b32bca6dc8c99951a726f5
dd909a1c-a913-4dce-8e2e-387be490680a	2026-10-21 07:49:30.344+02	Simbarashe Marufu	UPLOAD	GROUP	Evidence	2eaf30f8-573e-4147-9baa-38736a374a74	Attached ZESA_electricity_bill_FBCBANK_2026-08.pdf (2 KB, sha256 beb6ca957c75…) to EmissionRecord	2026-10-21 07:49:30.342092+02	3	71	\N	\N	aea12ca75069ee37ba201374d4d25c9ff1028df962b32bca6dc8c99951a726f5	d9dea2945268e4b94f8e074a34c0dfe8ac8cd69c827e5feab936fee64a87e7e3
fc724e15-2bc1-405e-b68b-bf0ec2a66513	2026-10-21 07:49:33.181+02	Simbarashe Marufu	UPLOAD	GROUP	Evidence	d622c0db-970c-46c9-acdd-a9a0a3a5829f	Attached Green_bond_framework_ICMA_alignment.pdf (2 KB, sha256 dbd7060380d9…) to Counterparty	2026-10-21 07:49:33.180606+02	3	72	\N	\N	d9dea2945268e4b94f8e074a34c0dfe8ac8cd69c827e5feab936fee64a87e7e3	bf6ab2d987110ee603dec363d476b98f892402eef75dbe5e49cdc79d4bfac812
76ca691f-72a7-49db-b4d9-624d64b4338d	2026-10-21 07:49:36.746+02	Simbarashe Marufu	PUBLISH	GROUP	Disclosure	38189431-8f9f-4549-9a42-cb147876bee6	Published IFRS S2 2025 v1 (13/15 items reported, sha256 b8a1d8eaccea…)	2026-10-21 07:49:36.743228+02	3	73	\N	\N	bf6ab2d987110ee603dec363d476b98f892402eef75dbe5e49cdc79d4bfac812	348466b7c5b7fed2e9fe9b7c4b33a0346decb97dcc6460fdf9e076ac32299b58
925217e5-fb32-4f79-bb52-be491856b150	2026-10-21 07:49:40.51+02	Simbarashe Marufu	PUBLISH	GROUP	Disclosure	69b1e907-230f-4e5c-9dd5-c405ffbd5bdd	Published GRI 2025 v1 (11/17 items reported, sha256 92bd9e9bcf20…)	2026-10-21 07:49:40.508152+02	3	74	\N	\N	348466b7c5b7fed2e9fe9b7c4b33a0346decb97dcc6460fdf9e076ac32299b58	fb21f507b5130532f2ecdb3655c2da46d6dace234aa373b890bf0aff8efdd317
8de5e449-49c9-450c-b98b-35a73f542165	2026-10-21 07:49:43.306+02	Anesu Mutasa	LOGIN	CBZBANK	Auth	USR-ADMIN	Signed in as admin	2026-10-21 07:49:43.305922+02	1	75	\N	\N	fb21f507b5130532f2ecdb3655c2da46d6dace234aa373b890bf0aff8efdd317	3b599139ca3c2007e3b96ddbe98d69aeb9bc8b3863cdab70206568a26b1b3e7d
f45b98e0-8b54-4662-8cc5-aaaa6c712e88	2026-10-21 07:49:45.948+02	Anesu Mutasa	UPLOAD	GROUP	Evidence	2405a470-64f9-4a5c-b0be-54e872deb9fd	Attached Green_bond_framework_ICMA_alignment.pdf (2 KB, sha256 dbd7060380d9…) to Counterparty	2026-10-21 07:49:45.946863+02	1	76	\N	\N	3b599139ca3c2007e3b96ddbe98d69aeb9bc8b3863cdab70206568a26b1b3e7d	8ca7bce6520bec6a2ddbed85015729e1c58678e3be9a8baedc56f844e1a34e3c
ca0a34ce-8e83-4564-bad3-4d0624fa62d5	2026-10-21 07:49:48.782+02	Anesu Mutasa	UPLOAD	GROUP	Evidence	baf0cdd3-e2a2-452a-a398-35ddca9883a8	Attached Board_ESG_committee_minutes_2026-Q3.pdf (2 KB, sha256 04d0a8da3de4…) to Disclosure	2026-10-21 07:49:48.780748+02	1	77	\N	\N	8ca7bce6520bec6a2ddbed85015729e1c58678e3be9a8baedc56f844e1a34e3c	19a49cc094a8cc2955b5cd5eb8a384d77815b5f7b75e9e2f07917021c5976248
f7a4f0a7-d8b6-4c77-bcd2-845a659def1d	2026-10-21 07:49:52.323+02	Anesu Mutasa	PUBLISH	GROUP	Disclosure	e2a88b5f-83ea-4ad1-8f6c-913b6c2783c0	Published IFRS S2 2025 v1 (12/15 items reported, sha256 d0193ec4197f…)	2026-10-21 07:49:52.320375+02	1	78	\N	\N	19a49cc094a8cc2955b5cd5eb8a384d77815b5f7b75e9e2f07917021c5976248	7ee89ef0fcd6c2f2f6da08c507e9153e63588527c3a40e9972ba1ecb177a5eb4
27970d9f-6834-4263-9cec-9426d8dfbd6e	2026-10-21 07:49:56.071+02	Anesu Mutasa	PUBLISH	GROUP	Disclosure	7fa5f80d-6cdc-43e4-8169-69d20d1b1980	Published GRI 2025 v1 (11/17 items reported, sha256 3c9ff56d928d…)	2026-10-21 07:49:56.070071+02	1	79	\N	\N	7ee89ef0fcd6c2f2f6da08c507e9153e63588527c3a40e9972ba1ecb177a5eb4	7d2d476a17db1a68963f90f4e0cd71e42551a36016497614910105cba5744178
62ffb750-eac1-43a3-9748-d7a8787d3584	2026-10-21 07:53:59.83+02	Anesu Mutasa	LOGIN	CBZBANK	Auth	USR-ADMIN	Signed in as admin	2026-10-21 07:53:59.829047+02	1	80	\N	\N	7d2d476a17db1a68963f90f4e0cd71e42551a36016497614910105cba5744178	7ebfb7072d11e85d214f7a7391278ff94aa692a0a7751cdf4a397c90da4b62ec
\.


--
-- Data for Name: cbz_counterparties; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_counterparties (id, name, sector, listed_status, asset_class, subsidiary, financials, total_emissions_tco2e, dq_score, mrv_enhanced, created_at, updated_at, taxonomy, taxonomy_category, taxonomy_status, customer_id) FROM stdin;
CP-002	Manyame Textiles Ltd	Manufacturing	Unlisted	business_loans_unlisted_equity	CBZAGRO	{"totalRevenue": 3100000, "totalEquityDebt": 2100000}	1920.0000	4	f	2026-09-28 09:11:13.935051+02	2026-09-28 09:11:13.935051+02	\N	\N	\N	\N
CP-003	Highveld Beverages PLC	Consumer goods	Listed	business_loans_listed	CBZBANK	{"evic": 145000000, "totalRevenue": 210000000}	41200.0000	4	f	2026-09-28 09:11:13.940506+02	2026-09-28 09:11:13.940506+02	\N	\N	\N	\N
CP-006	Borrowdale Office Park (Pvt) Ltd	Real estate	Unlisted	commercial_real_estate	CBZPROP	{"propertyValue": 12800000}	980.0000	4	f	2026-09-28 09:11:13.956498+02	2026-09-28 09:11:13.956498+02	\N	\N	\N	\N
CP-007	Msasa Industrial Park (Pvt) Ltd	Real estate	Unlisted	commercial_real_estate	CBZBANK	{"propertyValue": 7900000}	1340.0000	4	f	2026-09-28 09:11:13.961327+02	2026-09-28 09:11:13.961327+02	\N	\N	\N	\N
CP-008	Retail Mortgage Customer #00214	Residential	n/a	mortgages	CBZBANK	{"propertyValue": 260000}	6.4000	4	f	2026-09-28 09:11:13.966006+02	2026-09-28 09:11:13.966006+02	\N	\N	\N	\N
CP-009	Retail Mortgage Customer #00389	Residential	n/a	mortgages	CBZBANK	{"propertyValue": 140000}	4.1000	4	f	2026-09-28 09:11:13.971096+02	2026-09-28 09:11:13.971096+02	\N	\N	\N	\N
CP-010	Retail Vehicle Loan #01023	Personal transport	n/a	motor_vehicle_loans	CBZBANK	{"vehicleValue": 24000}	3.2000	3	f	2026-09-28 09:11:13.975915+02	2026-09-28 09:11:13.975915+02	\N	\N	\N	\N
CP-011	Retail Vehicle Loan #01187	Personal transport	n/a	motor_vehicle_loans	CBZBANK	{"vehicleValue": 31500}	4.6000	3	f	2026-09-28 09:11:13.981473+02	2026-09-28 09:11:13.981473+02	\N	\N	\N	\N
CP-012	Eastlands Mining Corp PLC	Mining	Listed	listed_equity_corporate_bonds	DATVEST	{"evic": 68000000}	96500.0000	5	f	2026-09-28 09:11:13.986922+02	2026-09-28 09:11:13.986922+02	\N	\N	\N	\N
CP-013	Government of Zimbabwe 91-day Treasury Bill	Sovereign	Sovereign	sovereign_debt	DATVEST	{"gdpPpp": 44000000000}	28400000.0000	5	f	2026-09-28 09:11:13.991997+02	2026-09-28 09:11:13.991997+02	\N	\N	\N	\N
CP-014	Government of Zimbabwe ZWG Bond 2029	Sovereign	Sovereign	sovereign_debt	DATVEST	{"gdpPpp": 44000000000}	28400000.0000	5	f	2026-09-28 09:11:13.997057+02	2026-09-28 09:11:13.997057+02	\N	\N	\N	\N
CP-015	City of Harare Municipal Bond 2027	Sub-sovereign	Sub-sovereign	sub_sovereign_debt	DATVEST	{"regionalGdpPpp": 3200000000}	185000.0000	5	f	2026-09-28 09:11:14.001585+02	2026-09-28 09:11:14.001585+02	\N	\N	\N	\N
CP-016	Bulawayo City Council Water Infrastructure Note	Sub-sovereign	Sub-sovereign	sub_sovereign_debt	DATVEST	{"regionalGdpPpp": 1450000000}	92000.0000	5	f	2026-09-28 09:11:14.007039+02	2026-09-28 09:11:14.007039+02	\N	\N	\N	\N
STW-CP-1	Gwanda Gold Processing	Agriculture	Unlisted	business_loans_unlisted_equity	STANWLTH	{"totalRevenue": 7000000, "totalEquityDebt": 5000000}	2620.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBI-CP-1	Nyanga Timber Mills	Agriculture	Unlisted	business_loans_unlisted_equity	FBCINS	{"totalRevenue": 9800000, "totalEquityDebt": 7000000}	2840.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
STW-CP-2	Hillside Residential	Residential real estate	Unlisted	mortgages	STANWLTH	{"propertyValue": 1800000}	305.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBI-CP-2	Greendale Housing Trust	Residential real estate	Unlisted	mortgages	FBCINS	{"propertyValue": 2700000}	525.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
STB-CP-3	Eastgate Retail Park	Commercial property	Unlisted	commercial_real_estate	STANBANK	{"propertyValue": 9000000}	1070.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
STW-CP-3	Fourth Street Offices	Commercial property	Unlisted	commercial_real_estate	STANWLTH	{"propertyValue": 10800000}	1180.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBB-CP-3	Sam Levy Commercial	Commercial property	Unlisted	commercial_real_estate	FBCBANK	{"propertyValue": 12600000}	1290.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBI-CP-3	Kwekwe Industrial Park	Commercial property	Unlisted	commercial_real_estate	FBCINS	{"propertyValue": 14400000}	1400.0000	3	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
STB-CP-4	Trans-Zambezi Haulage	Transport	Unlisted	motor_vehicle_loans	STANBANK	{"vehicleValue": 960000}	1860.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
STW-CP-4	Matabeleland Logistics	Transport	Unlisted	motor_vehicle_loans	STANWLTH	{"vehicleValue": 1280000}	1970.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBB-CP-4	Masvingo Bus Lines	Transport	Unlisted	motor_vehicle_loans	FBCBANK	{"vehicleValue": 1600000}	2080.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
FBI-CP-4	Beitbridge Freight	Transport	Unlisted	motor_vehicle_loans	FBCINS	{"vehicleValue": 1920000}	2190.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N	\N	\N	\N
CP-004	Nyanga Hydro Partners (Pvt) Ltd	Renewable energy	Unlisted	project_finance	CBZCAP	{"projectTotalCost": 18500000}	1150.0000	2	t	2026-09-28 09:11:13.946345+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
CP-005	Chinhoyi Solar Partners (Pvt) Ltd	Renewable energy	Unlisted	project_finance	CBZCAP	{"projectTotalCost": 9700000}	480.0000	2	t	2026-09-28 09:11:13.95131+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
STB-CP-5	Kariba North Solar	Renewable energy	Unlisted	project_finance	STANBANK	{"projectTotalCost": 15000000}	250.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
STW-CP-5	Hwange Wind Farm	Renewable energy	Unlisted	project_finance	STANWLTH	{"projectTotalCost": 17500000}	360.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
CP-017	CBZ Green Infrastructure Bond 2026	Green bond	Unlisted	use_of_proceeds	CBZBANK	{"uopStructureValue": 3000000}	640.0000	3	t	2026-09-28 09:11:14.0108+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Green buildings	Aligned	\N
FBB-CP-5	Save Valley Irrigation	Renewable energy	Unlisted	project_finance	FBCBANK	{"projectTotalCost": 20000000}	470.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
FBI-CP-5	Mutare Biogas Plant	Renewable energy	Unlisted	project_finance	FBCINS	{"projectTotalCost": 22500000}	580.0000	2	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA GBP	Renewable energy	Aligned	\N
CP-018	Agro-Yield Solar Mini-Grid Loan	Renewable energy	Unlisted	use_of_proceeds	CBZAGRO	{"uopStructureValue": 480000}	95.0000	2	t	2026-09-28 09:11:14.015656+02	2026-10-21 07:10:51.523049+02	AfDB	Access to clean energy	Aligned	\N
CP-001	Mashonaland Grain Millers (Pvt) Ltd	Agri-processing	Unlisted	business_loans_unlisted_equity	CBZBANK	{"totalRevenue": 6800000, "totalEquityDebt": 4800000}	2850.0000	3	t	2026-09-28 09:11:13.929013+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Under review	\N
STB-CP-1	Mazowe Citrus Growers	Agriculture	Unlisted	business_loans_unlisted_equity	STANBANK	{"totalRevenue": 5600000, "totalEquityDebt": 4000000}	2510.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Under review	\N
FBB-CP-1	Chegutu Dairy Co-op	Agriculture	Unlisted	business_loans_unlisted_equity	FBCBANK	{"totalRevenue": 8400000, "totalEquityDebt": 6000000}	2730.0000	3	t	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Under review	\N
STB-CP-2	Borrowdale Brooke Homes	Residential real estate	Unlisted	mortgages	STANBANK	{"propertyValue": 1350000}	195.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA SBP	Affordable housing	Eligible	\N
FBB-CP-2	Avondale Mortgages Pool	Residential real estate	Unlisted	mortgages	FBCBANK	{"propertyValue": 2250000}	415.0000	4	f	2026-10-04 22:10:18.087517+02	2026-10-21 07:10:51.523049+02	ICMA SBP	Affordable housing	Eligible	\N
AGR-CBZ-CHIPINGE	Chipinge Tea Estates (Pvt) Ltd	Agriculture	Unlisted	business_loans_unlisted_equity	CBZAGRO	{"totalRevenue": 4940000.0, "totalEquityDebt": 3800000}	1640.0000	2	t	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Eligible	6
AGR-FBB-MARONDERA	Marondera Maize Holdings	Agriculture	Unlisted	business_loans_unlisted_equity	FBCBANK	{"totalRevenue": 4030000.0, "totalEquityDebt": 3100000}	2310.0000	2	t	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Eligible	7
AGR-CBZ-MARONDERA	Marondera Maize Holdings	Agriculture	Unlisted	business_loans_unlisted_equity	CBZAGRO	{"totalRevenue": 6760000.0, "totalEquityDebt": 5200000}	2310.0000	2	t	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Eligible	7
AGR-CBZ-CHIREDZI	Chiredzi Sugar Growers	Agriculture	Unlisted	business_loans_unlisted_equity	CBZAGRO	{"totalRevenue": 11830000.0, "totalEquityDebt": 9100000}	4870.0000	2	t	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Eligible	8
AGR-STB-NYANGA	Nyanga Highlands Orchards	Agriculture	Unlisted	business_loans_unlisted_equity	STANBANK	{"totalRevenue": 3120000.0, "totalEquityDebt": 2400000}	720.0000	2	t	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	AfDB	Climate-smart agriculture	Eligible	9
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
-- Data for Name: cbz_disclosures; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_disclosures (id, bank_id, framework, period, version, title, snapshot, hash, published_by, published_at) FROM stdin;
a149ac78-f18b-43fb-b32a-0ab89c566edc	2	IFRS S2	2025	1	Stanbic Bank Zimbabwe IFRS S2 disclosure 2025	{"bank": "Stanbic Bank Zimbabwe", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 55.8971, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(1)"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 347.6181, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(2), (a)(v)"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "29(a)(i)(3), (a)(vi)"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 1728.5, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "29(a)(vi)(2)"}, {"code": "PCAF_DQ", "unit": "score 1-5", "basis": "Emissions-weighted average of position DQ scores", "label": "Financed emissions: weighted PCAF data-quality score", "value": 3.187, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "29(a)(vi)(2) measurement approach"}, {"code": "FINANCED_INTENSITY", "unit": "tCO2e / US$m", "basis": "Financed emissions ÷ outstanding (US$ millions)", "label": "Financed emissions intensity", "value": 162.7069, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(a)(vi)(2)"}, {"code": "GHG_INSURANCE", "unit": "tCO2e", "basis": "PCAF Part C: Σ premium attribution × client emissions", "label": "Insurance-associated emissions", "value": 105.168, "pillar": "Environmental", "status": "Reported", "sources": 5, "reference": "29(a)(vi)(2) insurance"}, {"code": "EXPOSURE_TOTAL", "unit": "US$", "basis": "Outstanding amounts of financed positions", "label": "Lending and investment exposure in scope", "value": 10623400, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(b)-(c) denominator"}, {"code": "HIGH_TRANSITION_SHARE", "unit": "% of exposure", "basis": "Share of outstanding in: Mining, Energy, Oil & gas, Transport, Manufacturing, Sovereign, Consumer goods, Agri-processing", "label": "Exposure to carbon-related / high transition-risk sectors", "value": 0.0307, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(b) transition risk"}, {"code": "PHYSICAL_RISK_SHARE", "unit": "% of exposure", "basis": "Borrowers flagged High in satellite/geospatial monitoring", "label": "Exposure to borrowers with high flood or drought risk", "value": 0.3282, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(c) physical risk"}, {"code": "SUSTAINABLE_SHARE", "unit": "% of exposure", "basis": "Outstanding tagged Aligned under AfDB / ICMA / local taxonomy", "label": "Taxonomy-aligned sustainable finance (green asset ratio)", "value": 0.5648, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(d)-(e) opportunities & capital deployment"}, {"code": "CLIMATE_RISKS_HIGH", "unit": "risks", "basis": "Risk register", "label": "Climate and ESG risks rated high (likelihood × impact ≥ 12)", "value": 3, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "10-12, 25"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "33-36"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "(S1) materiality judgement"}, {"code": "GOV_OVERSIGHT", "unit": "narrative", "basis": "Narrative: not yet captured in the platform", "label": "Board oversight of climate-related risks", "value": null, "pillar": "Governance", "status": "Not available", "sources": 0, "reference": "6"}], "basis": "Approved and locked records only", "notes": "", "title": "Stanbic Bank Zimbabwe IFRS S2 disclosure 2025", "period": "2025", "version": 1, "framework": "IFRS S2", "publishedBy": "Tatenda Mhlanga", "completeness": 0.8666666666666667}	d9bfe5f62fe21cd2e41edd67e537ce5faacfa7de55c80e531006ce9a1780b53a	Tatenda Mhlanga	2026-10-21 07:49:17.454+02
5c0ab666-fe9f-4aa5-af1c-6b4821296c1e	2	GRI	2025	1	Stanbic Bank Zimbabwe GRI disclosure 2025	{"bank": "Stanbic Bank Zimbabwe", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 55.8971, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-1"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 347.6181, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-2"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "305-3"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 1728.5, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "305-3"}, {"code": "ENERGY_KWH", "unit": "kWh", "basis": "Environmental resources register", "label": "Electricity consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 2, "reference": "302-1"}, {"code": "WATER_M3", "unit": "m³", "basis": "Environmental resources register", "label": "Water consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "303-5"}, {"code": "WASTE_T", "unit": "tonnes", "basis": "Environmental resources register", "label": "Waste generated (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "306-3"}, {"code": "HEADCOUNT", "unit": "employees", "basis": "Latest workforce record per subsidiary", "label": "Total workforce", "value": 1523, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "2-7"}, {"code": "FEMALE_SHARE", "unit": "%", "basis": "Headcount-weighted female share, latest period", "label": "Women in the workforce", "value": 0.465, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "405-1"}, {"code": "TRAINING_HOURS", "unit": "hours", "basis": "Headcount-weighted, latest period", "label": "Average training hours per employee", "value": 15, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "404-1"}, {"code": "LTI_RATE", "unit": "rate", "basis": "Headcount-weighted, latest period", "label": "Lost-time injury rate", "value": 0.4, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "403-9"}, {"code": "FI_BENEFICIARIES", "unit": "people", "basis": "Financial inclusion programmes", "label": "Financial inclusion beneficiaries", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "203-2"}, {"code": "COMMUNITY_SPEND", "unit": "US$", "basis": "Community investment register", "label": "Community investment", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "201-1, 203-1"}, {"code": "SUPPLIERS_SCREENED", "unit": "% of suppliers", "basis": "Supplier ESG register", "label": "Suppliers screened on ESG criteria", "value": 0.6667, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "308-1, 414-1"}, {"code": "INCIDENTS_OPEN", "unit": "incidents", "basis": "Incident register, not closed", "label": "Open ESG and compliance incidents", "value": 3, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "2-27"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-3"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-1, 3-2"}], "basis": "Approved and locked records only", "notes": "", "title": "Stanbic Bank Zimbabwe GRI disclosure 2025", "period": "2025", "version": 1, "framework": "GRI", "publishedBy": "Tatenda Mhlanga", "completeness": 0.6470588235294118}	e77cdc026ff4b03bfd29725432d11bf92c85b8e4dc5d6698fbf11fcfb238b0ad	Tatenda Mhlanga	2026-10-21 07:49:21.222+02
38189431-8f9f-4549-9a42-cb147876bee6	3	IFRS S2	2025	1	FBC Bank Limited IFRS S2 disclosure 2025	{"bank": "FBC Bank Limited", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 45.4164, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(1)"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 282.4397, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(2), (a)(v)"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "29(a)(i)(3), (a)(vi)"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 2593, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "29(a)(vi)(2)"}, {"code": "PCAF_DQ", "unit": "score 1-5", "basis": "Emissions-weighted average of position DQ scores", "label": "Financed emissions: weighted PCAF data-quality score", "value": 2.9236, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "29(a)(vi)(2) measurement approach"}, {"code": "FINANCED_INTENSITY", "unit": "tCO2e / US$m", "basis": "Financed emissions ÷ outstanding (US$ millions)", "label": "Financed emissions intensity", "value": 177.4569, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(a)(vi)(2)"}, {"code": "GHG_INSURANCE", "unit": "tCO2e", "basis": "PCAF Part C: Σ premium attribution × client emissions", "label": "Insurance-associated emissions", "value": 88.4343, "pillar": "Environmental", "status": "Reported", "sources": 5, "reference": "29(a)(vi)(2) insurance"}, {"code": "EXPOSURE_TOTAL", "unit": "US$", "basis": "Outstanding amounts of financed positions", "label": "Lending and investment exposure in scope", "value": 14612000, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(b)-(c) denominator"}, {"code": "HIGH_TRANSITION_SHARE", "unit": "% of exposure", "basis": "Share of outstanding in: Mining, Energy, Oil & gas, Transport, Manufacturing, Sovereign, Consumer goods, Agri-processing", "label": "Exposure to carbon-related / high transition-risk sectors", "value": 0.0372, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(b) transition risk"}, {"code": "PHYSICAL_RISK_SHARE", "unit": "% of exposure", "basis": "Borrowers flagged High in satellite/geospatial monitoring", "label": "Exposure to borrowers with high flood or drought risk", "value": 0.3444, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(c) physical risk"}, {"code": "SUSTAINABLE_SHARE", "unit": "% of exposure", "basis": "Outstanding tagged Aligned under AfDB / ICMA / local taxonomy", "label": "Taxonomy-aligned sustainable finance (green asset ratio)", "value": 0.5475, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(d)-(e) opportunities & capital deployment"}, {"code": "CLIMATE_RISKS_HIGH", "unit": "risks", "basis": "Risk register", "label": "Climate and ESG risks rated high (likelihood × impact ≥ 12)", "value": 3, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "10-12, 25"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "33-36"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "(S1) materiality judgement"}, {"code": "GOV_OVERSIGHT", "unit": "narrative", "basis": "Narrative: not yet captured in the platform", "label": "Board oversight of climate-related risks", "value": null, "pillar": "Governance", "status": "Not available", "sources": 0, "reference": "6"}], "basis": "Approved and locked records only", "notes": "", "title": "FBC Bank Limited IFRS S2 disclosure 2025", "period": "2025", "version": 1, "framework": "IFRS S2", "publishedBy": "Simbarashe Marufu", "completeness": 0.8666666666666667}	b8a1d8eacceabc3392ffcf5dbdef88e64d1c29a50c987a784c79fd4f4ad55f8a	Simbarashe Marufu	2026-10-21 07:49:36.743+02
69b1e907-230f-4e5c-9dd5-c405ffbd5bdd	3	GRI	2025	1	FBC Bank Limited GRI disclosure 2025	{"bank": "FBC Bank Limited", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 45.4164, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-1"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 282.4397, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-2"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "305-3"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 2593, "pillar": "Environmental", "status": "Reported", "sources": 6, "reference": "305-3"}, {"code": "ENERGY_KWH", "unit": "kWh", "basis": "Environmental resources register", "label": "Electricity consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 2, "reference": "302-1"}, {"code": "WATER_M3", "unit": "m³", "basis": "Environmental resources register", "label": "Water consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "303-5"}, {"code": "WASTE_T", "unit": "tonnes", "basis": "Environmental resources register", "label": "Waste generated (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "306-3"}, {"code": "HEADCOUNT", "unit": "employees", "basis": "Latest workforce record per subsidiary", "label": "Total workforce", "value": 1029, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "2-7"}, {"code": "FEMALE_SHARE", "unit": "%", "basis": "Headcount-weighted female share, latest period", "label": "Women in the workforce", "value": 0.465, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "405-1"}, {"code": "TRAINING_HOURS", "unit": "hours", "basis": "Headcount-weighted, latest period", "label": "Average training hours per employee", "value": 15, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "404-1"}, {"code": "LTI_RATE", "unit": "rate", "basis": "Headcount-weighted, latest period", "label": "Lost-time injury rate", "value": 0.4, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "403-9"}, {"code": "FI_BENEFICIARIES", "unit": "people", "basis": "Financial inclusion programmes", "label": "Financial inclusion beneficiaries", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "203-2"}, {"code": "COMMUNITY_SPEND", "unit": "US$", "basis": "Community investment register", "label": "Community investment", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "201-1, 203-1"}, {"code": "SUPPLIERS_SCREENED", "unit": "% of suppliers", "basis": "Supplier ESG register", "label": "Suppliers screened on ESG criteria", "value": 0.6667, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "308-1, 414-1"}, {"code": "INCIDENTS_OPEN", "unit": "incidents", "basis": "Incident register, not closed", "label": "Open ESG and compliance incidents", "value": 3, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "2-27"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-3"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-1, 3-2"}], "basis": "Approved and locked records only", "notes": "", "title": "FBC Bank Limited GRI disclosure 2025", "period": "2025", "version": 1, "framework": "GRI", "publishedBy": "Simbarashe Marufu", "completeness": 0.6470588235294118}	92bd9e9bcf205f3f3293b98841c11159faf9b0046e3d40a5ee8d02487a872d76	Simbarashe Marufu	2026-10-21 07:49:40.508+02
e2a88b5f-83ea-4ad1-8f6c-913b6c2783c0	1	IFRS S2	2025	1	CBZ Bank Limited IFRS S2 disclosure 2025	{"bank": "CBZ Bank Limited", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 69.8714, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(1)"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 434.5226, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "29(a)(i)(2), (a)(v)"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "29(a)(i)(3), (a)(vi)"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 3194.8772, "pillar": "Environmental", "status": "Reported", "sources": 9, "reference": "29(a)(vi)(2)"}, {"code": "PCAF_DQ", "unit": "score 1-5", "basis": "Emissions-weighted average of position DQ scores", "label": "Financed emissions: weighted PCAF data-quality score", "value": 3.5654, "pillar": "Environmental", "status": "Reported", "sources": 9, "reference": "29(a)(vi)(2) measurement approach"}, {"code": "FINANCED_INTENSITY", "unit": "tCO2e / US$m", "basis": "Financed emissions ÷ outstanding (US$ millions)", "label": "Financed emissions intensity", "value": 266.8691, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(a)(vi)(2)"}, {"code": "GHG_INSURANCE", "unit": "tCO2e", "basis": "PCAF Part C: Σ premium attribution × client emissions", "label": "Insurance-associated emissions", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "29(a)(vi)(2) insurance"}, {"code": "EXPOSURE_TOTAL", "unit": "US$", "basis": "Outstanding amounts of financed positions", "label": "Lending and investment exposure in scope", "value": 11971700, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(b)-(c) denominator"}, {"code": "HIGH_TRANSITION_SHARE", "unit": "% of exposure", "basis": "Share of outstanding in: Mining, Energy, Oil & gas, Transport, Manufacturing, Sovereign, Consumer goods, Agri-processing", "label": "Exposure to carbon-related / high transition-risk sectors", "value": 0.5049, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(b) transition risk"}, {"code": "PHYSICAL_RISK_SHARE", "unit": "% of exposure", "basis": "Borrowers flagged High in satellite/geospatial monitoring", "label": "Exposure to borrowers with high flood or drought risk", "value": 0, "pillar": "Environmental", "status": "Reported", "sources": 0, "reference": "29(c) physical risk"}, {"code": "SUSTAINABLE_SHARE", "unit": "% of exposure", "basis": "Outstanding tagged Aligned under AfDB / ICMA / local taxonomy", "label": "Taxonomy-aligned sustainable finance (green asset ratio)", "value": 0.2506, "pillar": "Economic", "status": "Reported", "sources": 0, "reference": "29(d)-(e) opportunities & capital deployment"}, {"code": "CLIMATE_RISKS_HIGH", "unit": "risks", "basis": "Risk register", "label": "Climate and ESG risks rated high (likelihood × impact ≥ 12)", "value": 0, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "10-12, 25"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "33-36"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "(S1) materiality judgement"}, {"code": "GOV_OVERSIGHT", "unit": "narrative", "basis": "Narrative: not yet captured in the platform", "label": "Board oversight of climate-related risks", "value": null, "pillar": "Governance", "status": "Not available", "sources": 0, "reference": "6"}], "basis": "Approved and locked records only", "notes": "", "title": "CBZ Bank Limited IFRS S2 disclosure 2025", "period": "2025", "version": 1, "framework": "IFRS S2", "publishedBy": "Anesu Mutasa", "completeness": 0.8}	d0193ec4197f470e73b09266da25eedd4929ebb9a8f4ab4ec5c2431e7c404ee9	Anesu Mutasa	2026-10-21 07:49:52.321+02
7fa5f80d-6cdc-43e4-8169-69d20d1b1980	1	GRI	2025	1	CBZ Bank Limited GRI disclosure 2025	{"bank": "CBZ Bank Limited", "rows": [{"code": "GHG_SCOPE1", "unit": "tCO2e", "basis": "Sum of approved Scope 1 records (GHG Protocol)", "label": "Gross Scope 1 GHG emissions", "value": 69.8714, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-1"}, {"code": "GHG_SCOPE2", "unit": "tCO2e", "basis": "Sum of approved Scope 2 records, location-based", "label": "Gross Scope 2 GHG emissions (location-based)", "value": 434.5226, "pillar": "Environmental", "status": "Reported", "sources": 12, "reference": "305-2"}, {"code": "GHG_SCOPE3_OPS", "unit": "tCO2e", "basis": "Approved Scope 3 records excluding category 15", "label": "Scope 3 operational (categories 1-14)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "305-3"}, {"code": "GHG_FINANCED", "unit": "tCO2e", "basis": "PCAF Part A: Σ attribution factor × borrower emissions", "label": "Financed emissions (Scope 3 category 15)", "value": 3194.8772, "pillar": "Environmental", "status": "Reported", "sources": 9, "reference": "305-3"}, {"code": "ENERGY_KWH", "unit": "kWh", "basis": "Environmental resources register", "label": "Electricity consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 2, "reference": "302-1"}, {"code": "WATER_M3", "unit": "m³", "basis": "Environmental resources register", "label": "Water consumed (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "303-5"}, {"code": "WASTE_T", "unit": "tonnes", "basis": "Environmental resources register", "label": "Waste generated (own operations)", "value": null, "pillar": "Environmental", "status": "Not available", "sources": 0, "reference": "306-3"}, {"code": "HEADCOUNT", "unit": "employees", "basis": "Latest workforce record per subsidiary", "label": "Total workforce", "value": 1240, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "2-7"}, {"code": "FEMALE_SHARE", "unit": "%", "basis": "Headcount-weighted female share, latest period", "label": "Women in the workforce", "value": 0.48, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "405-1"}, {"code": "TRAINING_HOURS", "unit": "hours", "basis": "Headcount-weighted, latest period", "label": "Average training hours per employee", "value": 14.5, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "404-1"}, {"code": "LTI_RATE", "unit": "rate", "basis": "Headcount-weighted, latest period", "label": "Lost-time injury rate", "value": 0.8, "pillar": "Social", "status": "Reported", "sources": 0, "reference": "403-9"}, {"code": "FI_BENEFICIARIES", "unit": "people", "basis": "Financial inclusion programmes", "label": "Financial inclusion beneficiaries", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "203-2"}, {"code": "COMMUNITY_SPEND", "unit": "US$", "basis": "Community investment register", "label": "Community investment", "value": null, "pillar": "Social", "status": "Not available", "sources": 0, "reference": "201-1, 203-1"}, {"code": "SUPPLIERS_SCREENED", "unit": "% of suppliers", "basis": "Supplier ESG register", "label": "Suppliers screened on ESG criteria", "value": 0.6667, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "308-1, 414-1"}, {"code": "INCIDENTS_OPEN", "unit": "incidents", "basis": "Incident register, not closed", "label": "Open ESG and compliance incidents", "value": 1, "pillar": "Governance", "status": "Reported", "sources": 0, "reference": "2-27"}, {"code": "TARGETS", "unit": "narrative", "basis": "Targets register", "label": "Climate and ESG targets set", "value": "Portfolio PCAF data quality ≤ 3.0 by 2027 (2025→2027); Women at least 45% of workforce by 2027 (2025→2027); Cut Scope 1+2 emissions 30% by 2030 (2024→2030)", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-3"}, {"code": "MATERIAL_TOPICS", "unit": "narrative", "basis": "Materiality assessment; topics scoring ≥ 4 on either axis", "label": "Material topics (double materiality)", "value": "Climate risk in the loan book; Biodiversity and land use in agri lending; Financial inclusion; Data privacy and cyber security", "pillar": "Governance", "status": "Narrative", "sources": 0, "reference": "3-1, 3-2"}], "basis": "Approved and locked records only", "notes": "", "title": "CBZ Bank Limited GRI disclosure 2025", "period": "2025", "version": 1, "framework": "GRI", "publishedBy": "Anesu Mutasa", "completeness": 0.6470588235294118}	3c9ff56d928d74a1c1594b7cff500d2013c102222b94552f8d22adb5370b5d08	Anesu Mutasa	2026-10-21 07:49:56.07+02
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

COPY mavhu.cbz_esg_emissions (id, entity_code, site, period, scope, dataset_type, fuel_type, activity_data, unit, emission_factor_kg_per_unit, emissions_kg_co2e, emissions_tco2e, method, data_quality, status, source_ref, submitted_by, submitted_at, approved_by, approved_at, created_at, updated_at, review_note) FROM stdin;
S1-001	CBZBANK	Harare Head Office	2026-08	scope1	Fleet fuel	Diesel	2450.0000	litres	2.680000	6566.0000	6.566000	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.113064+02	2026-09-28 09:11:14.113064+02	\N
S1-002	CBZBANK	Bulawayo Branch	2026-08	scope1	Fleet fuel	Petrol	980.0000	litres	2.310000	2263.8000	2.263800	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.119908+02	2026-09-28 09:11:14.119908+02	\N
S1-003	CBZAGRO	Mvurwi Regional Office	2026-08	scope1	Fleet fuel	Diesel	3120.0000	litres	2.680000	8361.6000	8.361600	activity-based	2	approved	CBZAGRO_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-AGRO	2026-09-02 10:14:00+02	USR-ADMIN	2026-09-04 12:00:00+02	2026-09-28 09:11:14.125415+02	2026-09-28 09:11:14.125415+02	\N
S1-004	CBZBANK	Harare Head Office	2026-08	scope1	Backup generator	Diesel	1840.0000	litres	2.680000	4931.2000	4.931200	activity-based	2	approved	CBZBANK_SCOPE1_GENSET_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 11:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.130748+02	2026-09-28 09:11:14.130748+02	\N
S1-005	CBZINS	Harare Underwriting Centre	2026-08	scope1	Backup generator	Diesel	610.0000	litres	2.680000	1634.8000	1.634800	activity-based	2	approved	CBZINS_SCOPE1_GENSET_2026-08_v1.csv	USR-CONTRIB-INS	2026-09-02 11:41:00+02	USR-ADMIN	2026-09-04 12:00:00+02	2026-09-28 09:11:14.136769+02	2026-09-28 09:11:14.136769+02	\N
S1-006	CBZPROP	Borrowdale Office Park	2026-08	scope1	Backup generator	Diesel	940.0000	litres	2.680000	2519.2000	2.519200	activity-based	2	approved	CBZPROP_SCOPE1_GENSET_2026-08_v1.csv	USR-ADMIN	2026-09-02 11:15:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.14301+02	2026-09-28 09:11:14.14301+02	\N
S1-007	CBZBANK	Harare Head Office	2026-08	scope1	Refrigerant top-up	R410A	4.5000	kg	2088.000000	9396.0000	9.396000	activity-based	2	approved	CBZBANK_SCOPE1_REFRIG_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 11:30:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.148474+02	2026-09-28 09:11:14.148474+02	\N
S1-008	DATVEST	Harare Office	2026-08	scope1	Refrigerant top-up	R134a	1.8000	kg	1430.000000	2574.0000	2.574000	activity-based	2	approved	DATVEST_SCOPE1_REFRIG_2026-08_v1.csv	USR-READER-DATVEST	2026-09-02 12:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.15353+02	2026-09-28 09:11:14.15353+02	\N
S1-009	CBZBANK	Mutare Branch	2026-08	scope1	Fleet fuel	Diesel	1120.0000	litres	2.680000	3001.6000	3.001600	activity-based	2	approved	CBZBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 10:14:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.158201+02	2026-09-28 09:11:14.158201+02	\N
S1-010	CBZRED	Masvingo Agent Hub	2026-08	scope1	Fleet fuel	Petrol	560.0000	litres	2.310000	1293.6000	1.293600	activity-based	2	approved	CBZRED_SCOPE1_FLEETFUEL_2026-08_v1.csv	USR-ADMIN	2026-09-02 10:14:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.163661+02	2026-09-28 09:11:14.163661+02	\N
S2-001	CBZBANK	Harare Head Office	2026-08	scope2	Grid electricity (location-based)	\N	84500.0000	kWh	0.650000	54925.0000	54.925000	activity-based	2	approved	CBZBANK_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 13:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.168625+02	2026-09-28 09:11:14.168625+02	\N
S2-002	CBZBANK	Bulawayo Branch	2026-08	scope2	Grid electricity (location-based)	\N	31200.0000	kWh	0.650000	20280.0000	20.280000	activity-based	2	approved	CBZBANK_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-02 13:00:00+02	USR-APPROVER-BANK	2026-09-03 12:00:00+02	2026-09-28 09:11:14.172758+02	2026-09-28 09:11:14.172758+02	\N
S2-003	CBZAGRO	Mvurwi Regional Office	2026-08	scope2	Grid electricity (location-based)	\N	12800.0000	kWh	0.650000	8320.0000	8.320000	activity-based	2	approved	CBZAGRO_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-AGRO	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.178479+02	2026-09-28 09:11:14.178479+02	\N
S2-004	CBZINS	Harare Underwriting Centre	2026-08	scope2	Grid electricity (location-based)	\N	19600.0000	kWh	0.650000	12740.0000	12.740000	activity-based	2	approved	CBZINS_SCOPE2_ELEC_2026-08_v1.csv	USR-CONTRIB-INS	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.18343+02	2026-09-28 09:11:14.18343+02	\N
S2-005	CBZPROP	Borrowdale Office Park	2026-08	scope2	Grid electricity (location-based)	\N	28400.0000	kWh	0.650000	18460.0000	18.460000	activity-based	2	approved	CBZPROP_SCOPE2_ELEC_2026-08_v1.csv	USR-ADMIN	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.189219+02	2026-09-28 09:11:14.189219+02	\N
S2-006	DATVEST	Harare Office	2026-08	scope2	Grid electricity (location-based)	\N	9100.0000	kWh	0.650000	5915.0000	5.915000	activity-based	2	approved	DATVEST_SCOPE2_ELEC_2026-08_v1.csv	USR-READER-DATVEST	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.195515+02	2026-09-28 09:11:14.195515+02	\N
S2-007	CBZRED	Masvingo Agent Hub	2026-08	scope2	Grid electricity (location-based)	\N	4200.0000	kWh	0.650000	2730.0000	2.730000	activity-based	2	approved	CBZRED_SCOPE2_ELEC_2026-08_v1.csv	USR-ADMIN	2026-09-02 13:00:00+02	USR-ADMIN	2026-09-03 12:00:00+02	2026-09-28 09:11:14.202575+02	2026-09-28 09:11:14.202575+02	\N
S3-001	CBZBANK	Group	2026-Q3	scope3	Cat 1 - Procurement	\N	185000.0000	US$	0.350000	64750.0000	64.750000	spend-based	4	approved	CBZBANK_SCOPE3CAT1_PROCURE_2026-Q3_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.209481+02	2026-09-28 09:11:14.209481+02	\N
S3-002	CBZAGRO	Group	2026-Q3	scope3	Cat 1 - Agri-inputs	\N	96000.0000	US$	0.550000	52800.0000	52.800000	spend-based	4	approved	CBZAGRO_SCOPE3CAT1_PROCURE_2026-Q3_v1.csv	USR-CONTRIB-AGRO	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.214929+02	2026-09-28 09:11:14.214929+02	\N
S3-003	CBZPROP	Borrowdale annex	2026-Q3	scope3	Cat 2 - Capex	\N	420000.0000	US$	0.400000	168000.0000	168.000000	spend-based	4	approved	CBZPROP_SCOPE3CAT2_CAPEX_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.22027+02	2026-09-28 09:11:14.22027+02	\N
S3-004	CBZBANK	Group	2026-08	scope3	Cat 3 - T&D losses	\N	84500.0000	kWh	0.045000	3802.5000	3.802500	activity-based	3	approved	CBZBANK_SCOPE3CAT3_TDLOSS_2026-08_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.225822+02	2026-09-28 09:11:14.225822+02	\N
S3-005	CBZBANK	Group	2026-Q3	scope3	Cat 5 - Waste	\N	3.2000	tonnes	21.000000	67.2000	0.067200	activity-based	3	approved	CBZBANK_SCOPE3CAT5_WASTE_2026-Q3_v1.csv	USR-CONTRIB-BANK	2026-09-05 11:00:00+02	USR-APPROVER-BANK	2026-09-06 12:00:00+02	2026-09-28 09:11:14.232268+02	2026-09-28 09:11:14.232268+02	\N
S3-006	CBZCAP	Group	2026-Q3	scope3	Cat 6 - Business travel	\N	42000.0000	pax-km	0.150000	6300.0000	6.300000	activity-based	3	in_review	CBZCAP_SCOPE3CAT6_TRAVEL_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	\N	\N	2026-09-28 09:11:14.238031+02	2026-09-28 09:11:14.238031+02	\N
S3-007	CBZINS	Group	2026-Q3	scope3	Cat 7 - Commuting	\N	210.0000	employees	0.850000	178.5000	0.178500	activity-based	4	draft	CBZINS_SCOPE3CAT7_COMMUTE_2026-Q3_v1.csv	USR-CONTRIB-INS	2026-09-05 11:00:00+02	\N	\N	2026-09-28 09:11:14.243933+02	2026-09-28 09:11:14.243933+02	\N
S3-008	DATVEST	Harare Office	2026-Q3	scope3	Cat 8 - Leased assets	\N	1850.0000	m2	0.060000	111.0000	0.111000	activity-based	3	approved	DATVEST_SCOPE3CAT8_LEASE_2026-Q3_v1.csv	USR-READER-DATVEST	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.248591+02	2026-09-28 09:11:14.248591+02	\N
S3-009	CBZPROP	Borrowdale Office Park	2026-Q3	scope3	Cat 13 - Tenant energy	\N	9200.0000	m2	0.060000	552.0000	0.552000	activity-based	3	approved	CBZPROP_SCOPE3CAT13_TENANT_2026-Q3_v1.csv	USR-ADMIN	2026-09-05 11:00:00+02	USR-ADMIN	2026-09-06 12:00:00+02	2026-09-28 09:11:14.25454+02	2026-09-28 09:11:14.25454+02	\N
STB-EM-1	STANBANK	Stanbic Centre, Harare	2026-08	scope1	Fleet fuel	Diesel	2070.0000	litres	2.680000	5547.6000	5.547600	activity-based	2	approved	STANBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	STB-USR-3	2026-09-02 09:00:00+02	STB-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STW-EM-1	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope1	Fleet fuel	Diesel	2340.0000	litres	2.680000	6271.2000	6.271200	activity-based	2	approved	STANWLTH_SCOPE1_FLEETFUEL_2026-08_v1.csv	STW-USR-3	2026-09-02 09:00:00+02	STW-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBB-EM-1	FBCBANK	FBC Centre, Harare	2026-08	scope1	Fleet fuel	Diesel	2610.0000	litres	2.680000	6994.8000	6.994800	activity-based	2	approved	FBCBANK_SCOPE1_FLEETFUEL_2026-08_v1.csv	FBB-USR-3	2026-09-02 09:00:00+02	FBB-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBI-EM-1	FBCINS	FBC Insurance, Mutare	2026-08	scope1	Fleet fuel	Diesel	2880.0000	litres	2.680000	7718.4000	7.718400	activity-based	2	approved	FBCINS_SCOPE1_FLEETFUEL_2026-08_v1.csv	FBI-USR-3	2026-09-02 09:00:00+02	FBI-USR-2	2026-09-04 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STB-EM-2	STANBANK	Stanbic Centre, Harare	2026-08	scope1	Backup generator	Diesel	1035.0000	litres	2.680000	2773.8000	2.773800	activity-based	3	approved	STANBANK_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	STB-USR-3	2026-09-03 09:00:00+02	STB-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STW-EM-2	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope1	Backup generator	Diesel	1170.0000	litres	2.680000	3135.6000	3.135600	activity-based	3	approved	STANWLTH_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	STW-USR-3	2026-09-03 09:00:00+02	STW-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBB-EM-2	FBCBANK	FBC Centre, Harare	2026-08	scope1	Backup generator	Diesel	1305.0000	litres	2.680000	3497.4000	3.497400	activity-based	3	approved	FBCBANK_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	FBB-USR-3	2026-09-03 09:00:00+02	FBB-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBI-EM-2	FBCINS	FBC Insurance, Mutare	2026-08	scope1	Backup generator	Diesel	1440.0000	litres	2.680000	3859.2000	3.859200	activity-based	3	approved	FBCINS_SCOPE1_BACKUPGENERATOR_2026-08_v1.csv	FBI-USR-3	2026-09-03 09:00:00+02	FBI-USR-2	2026-09-05 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STW-EM-3	STANWLTH	Stanbic Wealth, Bulawayo	2026-08	scope2	Grid electricity	\N	67600.0000	kWh	0.570000	38532.0000	38.532000	measured	1	in_review	STANWLTH_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	STW-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBB-EM-3	FBCBANK	FBC Centre, Harare	2026-08	scope2	Grid electricity	\N	75400.0000	kWh	0.570000	42978.0000	42.978000	measured	1	in_review	FBCBANK_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	FBB-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBI-EM-3	FBCINS	FBC Insurance, Mutare	2026-08	scope2	Grid electricity	\N	83200.0000	kWh	0.570000	47424.0000	47.424000	measured	1	in_review	FBCINS_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	FBI-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STB-EM-4	STANBANK	Stanbic Centre, Harare	2026-Q3	scope3	Business travel	\N	27600.0000	pax-km	0.150000	4140.0000	4.140000	activity-based	3	draft	STANBANK_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	STB-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STW-EM-4	STANWLTH	Stanbic Wealth, Bulawayo	2026-Q3	scope3	Business travel	\N	31200.0000	pax-km	0.150000	4680.0000	4.680000	activity-based	3	draft	STANWLTH_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	STW-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBB-EM-4	FBCBANK	FBC Centre, Harare	2026-Q3	scope3	Business travel	\N	34800.0000	pax-km	0.150000	5220.0000	5.220000	activity-based	3	draft	FBCBANK_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	FBB-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBI-EM-4	FBCINS	FBC Insurance, Mutare	2026-Q3	scope3	Business travel	\N	38400.0000	pax-km	0.150000	5760.0000	5.760000	activity-based	3	draft	FBCINS_SCOPE3_BUSINESSTRAVEL_2026-Q3_v1.csv	FBI-USR-3	2026-09-05 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STB-EM-5	STANBANK	Stanbic Centre, Harare	2026-Q3	scope3	Cat 1	\N	97750.0000	US$	0.320000	31280.0000	31.280000	spend-based	4	locked	STANBANK_SCOPE3_CAT1_2026-Q3_v1.csv	STB-USR-3	2026-09-06 09:00:00+02	STB-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STW-EM-5	STANWLTH	Stanbic Wealth, Bulawayo	2026-Q3	scope3	Cat 1	\N	110500.0000	US$	0.320000	35360.0000	35.360000	spend-based	4	locked	STANWLTH_SCOPE3_CAT1_2026-Q3_v1.csv	STW-USR-3	2026-09-06 09:00:00+02	STW-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBB-EM-5	FBCBANK	FBC Centre, Harare	2026-Q3	scope3	Cat 1	\N	123250.0000	US$	0.320000	39440.0000	39.440000	spend-based	4	locked	FBCBANK_SCOPE3_CAT1_2026-Q3_v1.csv	FBB-USR-3	2026-09-06 09:00:00+02	FBB-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
FBI-EM-5	FBCINS	FBC Insurance, Mutare	2026-Q3	scope3	Cat 1	\N	136000.0000	US$	0.320000	43520.0000	43.520000	spend-based	4	locked	FBCINS_SCOPE3_CAT1_2026-Q3_v1.csv	FBI-USR-3	2026-09-06 09:00:00+02	FBI-USR-2	2026-09-08 15:00:00+02	2026-10-04 22:10:18.087517+02	2026-10-04 22:10:18.087517+02	\N
STB-EM-3	STANBANK	Stanbic Centre, Harare	2026-08	scope2	Grid electricity	\N	59800.0000	kWh	0.570000	34086.0000	34.086000	measured	1	in_review	STANBANK_SCOPE2_GRIDELECTRICITY_2026-08_v1.csv	STB-USR-3	2026-09-04 09:00:00+02	\N	\N	2026-10-04 22:10:18.087517+02	2026-10-04 22:15:17.140949+02	\N
CBZ-H-E1-F-202401	CBZBANK	Head office	2024-01	scope1	Fleet fuel	Diesel	2100.0000	litres	2.680000	5628.0000	5.628000	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-01_v1.csv	USR-CONTRIB-BANK	2024-02-05 00:00:00+02	USR-APPROVER-BANK	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202401	CBZBANK	Head office	2024-01	scope2	Grid electricity (location-based)	\N	61000.0000	kWh	0.650000	39650.0000	39.650000	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-01_v1.csv	USR-CONTRIB-BANK	2024-02-05 00:00:00+02	USR-APPROVER-BANK	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202401	CBZAGRO	Main office	2024-01	scope1	Fleet fuel	Diesel	640.0000	litres	2.680000	1715.2000	1.715200	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-01_v1.csv	USR-CONTRIB-BANK	2024-02-05 00:00:00+02	USR-APPROVER-BANK	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202401	CBZAGRO	Main office	2024-01	scope2	Grid electricity (location-based)	\N	18500.0000	kWh	0.650000	12025.0000	12.025000	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-01_v1.csv	USR-CONTRIB-BANK	2024-02-05 00:00:00+02	USR-APPROVER-BANK	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202401	STANBANK	Head office	2024-01	scope1	Fleet fuel	Diesel	1680.0000	litres	2.680000	4502.4000	4.502400	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-01_v1.csv	STB-USR-3	2024-02-05 00:00:00+02	STB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202401	STANBANK	Head office	2024-01	scope2	Grid electricity (location-based)	\N	48800.0000	kWh	0.650000	31720.0000	31.720000	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-01_v1.csv	STB-USR-3	2024-02-05 00:00:00+02	STB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202401	STANWLTH	Main office	2024-01	scope1	Fleet fuel	Diesel	512.0000	litres	2.680000	1372.1600	1.372160	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-01_v1.csv	STB-USR-3	2024-02-05 00:00:00+02	STB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202401	STANWLTH	Main office	2024-01	scope2	Grid electricity (location-based)	\N	14800.0000	kWh	0.650000	9620.0000	9.620000	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-01_v1.csv	STB-USR-3	2024-02-05 00:00:00+02	STB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202401	FBCBANK	Head office	2024-01	scope1	Fleet fuel	Diesel	1365.0000	litres	2.680000	3658.2000	3.658200	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-01_v1.csv	FBB-USR-3	2024-02-05 00:00:00+02	FBB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202401	FBCBANK	Head office	2024-01	scope2	Grid electricity (location-based)	\N	39650.0000	kWh	0.650000	25772.5000	25.772500	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-01_v1.csv	FBB-USR-3	2024-02-05 00:00:00+02	FBB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202401	FBCINS	Main office	2024-01	scope1	Fleet fuel	Diesel	416.0000	litres	2.680000	1114.8800	1.114880	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-01_v1.csv	FBB-USR-3	2024-02-05 00:00:00+02	FBB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202401	FBCINS	Main office	2024-01	scope2	Grid electricity (location-based)	\N	12025.0000	kWh	0.650000	7816.2500	7.816250	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-01_v1.csv	FBB-USR-3	2024-02-05 00:00:00+02	FBB-USR-2	2024-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202402	CBZBANK	Head office	2024-02	scope1	Fleet fuel	Diesel	2173.0800	litres	2.680000	5823.8544	5.823854	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-02_v1.csv	USR-CONTRIB-BANK	2024-03-07 00:00:00+02	USR-APPROVER-BANK	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202402	CBZBANK	Head office	2024-02	scope2	Grid electricity (location-based)	\N	63122.8000	kWh	0.650000	41029.8200	41.029820	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-02_v1.csv	USR-CONTRIB-BANK	2024-03-07 00:00:00+02	USR-APPROVER-BANK	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202402	CBZAGRO	Main office	2024-02	scope1	Fleet fuel	Diesel	662.2700	litres	2.680000	1774.8890	1.774889	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-02_v1.csv	USR-CONTRIB-BANK	2024-03-07 00:00:00+02	USR-APPROVER-BANK	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202402	CBZAGRO	Main office	2024-02	scope2	Grid electricity (location-based)	\N	19143.8000	kWh	0.650000	12443.4700	12.443470	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-02_v1.csv	USR-CONTRIB-BANK	2024-03-07 00:00:00+02	USR-APPROVER-BANK	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202402	STANBANK	Head office	2024-02	scope1	Fleet fuel	Diesel	1738.4600	litres	2.680000	4659.0835	4.659084	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-02_v1.csv	STB-USR-3	2024-03-07 00:00:00+02	STB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202402	STANBANK	Head office	2024-02	scope2	Grid electricity (location-based)	\N	50498.2400	kWh	0.650000	32823.8560	32.823856	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-02_v1.csv	STB-USR-3	2024-03-07 00:00:00+02	STB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202402	STANWLTH	Main office	2024-02	scope1	Fleet fuel	Diesel	529.8200	litres	2.680000	1419.9112	1.419911	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-02_v1.csv	STB-USR-3	2024-03-07 00:00:00+02	STB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202402	STANWLTH	Main office	2024-02	scope2	Grid electricity (location-based)	\N	15315.0400	kWh	0.650000	9954.7760	9.954776	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-02_v1.csv	STB-USR-3	2024-03-07 00:00:00+02	STB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202402	FBCBANK	Head office	2024-02	scope1	Fleet fuel	Diesel	1412.5000	litres	2.680000	3785.5054	3.785505	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-02_v1.csv	FBB-USR-3	2024-03-07 00:00:00+02	FBB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202402	FBCBANK	Head office	2024-02	scope2	Grid electricity (location-based)	\N	41029.8200	kWh	0.650000	26669.3830	26.669383	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-02_v1.csv	FBB-USR-3	2024-03-07 00:00:00+02	FBB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202402	FBCINS	Main office	2024-02	scope1	Fleet fuel	Diesel	430.4800	litres	2.680000	1153.6778	1.153678	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-02_v1.csv	FBB-USR-3	2024-03-07 00:00:00+02	FBB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202402	FBCINS	Main office	2024-02	scope2	Grid electricity (location-based)	\N	12443.4700	kWh	0.650000	8088.2555	8.088256	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-02_v1.csv	FBB-USR-3	2024-03-07 00:00:00+02	FBB-USR-2	2024-03-12 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202403	CBZBANK	Head office	2024-03	scope1	Fleet fuel	Diesel	2223.0400	litres	2.680000	5957.7401	5.957740	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-03_v1.csv	USR-CONTRIB-BANK	2024-04-05 00:00:00+02	USR-APPROVER-BANK	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202403	CBZBANK	Head office	2024-03	scope2	Grid electricity (location-based)	\N	64573.9400	kWh	0.650000	41973.0623	41.973062	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-03_v1.csv	USR-CONTRIB-BANK	2024-04-05 00:00:00+02	USR-APPROVER-BANK	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202403	CBZAGRO	Main office	2024-03	scope1	Fleet fuel	Diesel	677.5000	litres	2.680000	1815.6922	1.815692	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-03_v1.csv	USR-CONTRIB-BANK	2024-04-05 00:00:00+02	USR-APPROVER-BANK	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202403	CBZAGRO	Main office	2024-03	scope2	Grid electricity (location-based)	\N	19583.9000	kWh	0.650000	12729.5353	12.729535	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-03_v1.csv	USR-CONTRIB-BANK	2024-04-05 00:00:00+02	USR-APPROVER-BANK	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202403	STANBANK	Head office	2024-03	scope1	Fleet fuel	Diesel	1778.4300	litres	2.680000	4766.1921	4.766192	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-03_v1.csv	STB-USR-3	2024-04-05 00:00:00+02	STB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202403	STANBANK	Head office	2024-03	scope2	Grid electricity (location-based)	\N	51659.1500	kWh	0.650000	33578.4498	33.578450	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-03_v1.csv	STB-USR-3	2024-04-05 00:00:00+02	STB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202403	STANWLTH	Main office	2024-03	scope1	Fleet fuel	Diesel	542.0000	litres	2.680000	1452.5538	1.452554	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-03_v1.csv	STB-USR-3	2024-04-05 00:00:00+02	STB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202403	STANWLTH	Main office	2024-03	scope2	Grid electricity (location-based)	\N	15667.1200	kWh	0.650000	10183.6282	10.183628	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-03_v1.csv	STB-USR-3	2024-04-05 00:00:00+02	STB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202403	FBCBANK	Head office	2024-03	scope1	Fleet fuel	Diesel	1444.9700	litres	2.680000	3872.5311	3.872531	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-03_v1.csv	FBB-USR-3	2024-04-05 00:00:00+02	FBB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202403	FBCBANK	Head office	2024-03	scope2	Grid electricity (location-based)	\N	41973.0600	kWh	0.650000	27282.4905	27.282490	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-03_v1.csv	FBB-USR-3	2024-04-05 00:00:00+02	FBB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202403	FBCINS	Main office	2024-03	scope1	Fleet fuel	Diesel	440.3700	litres	2.680000	1180.1999	1.180200	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-03_v1.csv	FBB-USR-3	2024-04-05 00:00:00+02	FBB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202403	FBCINS	Main office	2024-03	scope2	Grid electricity (location-based)	\N	12729.5400	kWh	0.650000	8274.1979	8.274198	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-03_v1.csv	FBB-USR-3	2024-04-05 00:00:00+02	FBB-USR-2	2024-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202404	CBZBANK	Head office	2024-04	scope1	Fleet fuel	Diesel	2233.9800	litres	2.680000	5987.0664	5.987066	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-04_v1.csv	USR-CONTRIB-BANK	2024-05-06 00:00:00+02	USR-APPROVER-BANK	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202404	CBZBANK	Head office	2024-04	scope2	Grid electricity (location-based)	\N	64891.8000	kWh	0.650000	42179.6700	42.179670	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-04_v1.csv	USR-CONTRIB-BANK	2024-05-06 00:00:00+02	USR-APPROVER-BANK	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202404	CBZAGRO	Main office	2024-04	scope1	Fleet fuel	Diesel	680.8300	litres	2.680000	1824.6298	1.824630	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-04_v1.csv	USR-CONTRIB-BANK	2024-05-06 00:00:00+02	USR-APPROVER-BANK	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202404	CBZAGRO	Main office	2024-04	scope2	Grid electricity (location-based)	\N	19680.3000	kWh	0.650000	12792.1950	12.792195	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-04_v1.csv	USR-CONTRIB-BANK	2024-05-06 00:00:00+02	USR-APPROVER-BANK	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202404	STANBANK	Head office	2024-04	scope1	Fleet fuel	Diesel	1787.1800	litres	2.680000	4789.6531	4.789653	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-04_v1.csv	STB-USR-3	2024-05-06 00:00:00+02	STB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202404	STANBANK	Head office	2024-04	scope2	Grid electricity (location-based)	\N	51913.4400	kWh	0.650000	33743.7360	33.743736	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-04_v1.csv	STB-USR-3	2024-05-06 00:00:00+02	STB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202404	STANWLTH	Main office	2024-04	scope1	Fleet fuel	Diesel	544.6700	litres	2.680000	1459.7038	1.459704	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-04_v1.csv	STB-USR-3	2024-05-06 00:00:00+02	STB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202404	STANWLTH	Main office	2024-04	scope2	Grid electricity (location-based)	\N	15744.2400	kWh	0.650000	10233.7560	10.233756	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-04_v1.csv	STB-USR-3	2024-05-06 00:00:00+02	STB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202404	FBCBANK	Head office	2024-04	scope1	Fleet fuel	Diesel	1452.0900	litres	2.680000	3891.5932	3.891593	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-04_v1.csv	FBB-USR-3	2024-05-06 00:00:00+02	FBB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202404	FBCBANK	Head office	2024-04	scope2	Grid electricity (location-based)	\N	42179.6700	kWh	0.650000	27416.7855	27.416786	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-04_v1.csv	FBB-USR-3	2024-05-06 00:00:00+02	FBB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202404	FBCINS	Main office	2024-04	scope1	Fleet fuel	Diesel	442.5400	litres	2.680000	1186.0093	1.186009	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-04_v1.csv	FBB-USR-3	2024-05-06 00:00:00+02	FBB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202404	FBCINS	Main office	2024-04	scope2	Grid electricity (location-based)	\N	12792.2000	kWh	0.650000	8314.9268	8.314927	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-04_v1.csv	FBB-USR-3	2024-05-06 00:00:00+02	FBB-USR-2	2024-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202405	CBZBANK	Head office	2024-05	scope1	Fleet fuel	Diesel	2200.5800	litres	2.680000	5897.5609	5.897561	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-05_v1.csv	USR-CONTRIB-BANK	2024-06-05 00:00:00+02	USR-APPROVER-BANK	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202405	CBZBANK	Head office	2024-05	scope2	Grid electricity (location-based)	\N	63921.6800	kWh	0.650000	41549.0919	41.549092	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-05_v1.csv	USR-CONTRIB-BANK	2024-06-05 00:00:00+02	USR-APPROVER-BANK	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202405	CBZAGRO	Main office	2024-05	scope1	Fleet fuel	Diesel	670.6500	litres	2.680000	1797.3519	1.797352	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-05_v1.csv	USR-CONTRIB-BANK	2024-06-05 00:00:00+02	USR-APPROVER-BANK	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202405	CBZAGRO	Main office	2024-05	scope2	Grid electricity (location-based)	\N	19386.0800	kWh	0.650000	12600.9541	12.600954	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-05_v1.csv	USR-CONTRIB-BANK	2024-06-05 00:00:00+02	USR-APPROVER-BANK	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202405	STANBANK	Head office	2024-05	scope1	Fleet fuel	Diesel	1760.4700	litres	2.680000	4718.0487	4.718049	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-05_v1.csv	STB-USR-3	2024-06-05 00:00:00+02	STB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202405	STANBANK	Head office	2024-05	scope2	Grid electricity (location-based)	\N	51137.3400	kWh	0.650000	33239.2735	33.239274	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-05_v1.csv	STB-USR-3	2024-06-05 00:00:00+02	STB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202405	STANWLTH	Main office	2024-05	scope1	Fleet fuel	Diesel	536.5200	litres	2.680000	1437.8815	1.437882	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-05_v1.csv	STB-USR-3	2024-06-05 00:00:00+02	STB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202405	STANWLTH	Main office	2024-05	scope2	Grid electricity (location-based)	\N	15508.8700	kWh	0.650000	10080.7633	10.080763	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-05_v1.csv	STB-USR-3	2024-06-05 00:00:00+02	STB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202405	FBCBANK	Head office	2024-05	scope1	Fleet fuel	Diesel	1430.3800	litres	2.680000	3833.4146	3.833415	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-05_v1.csv	FBB-USR-3	2024-06-05 00:00:00+02	FBB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202405	FBCBANK	Head office	2024-05	scope2	Grid electricity (location-based)	\N	41549.0900	kWh	0.650000	27006.9098	27.006910	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-05_v1.csv	FBB-USR-3	2024-06-05 00:00:00+02	FBB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202405	FBCINS	Main office	2024-05	scope1	Fleet fuel	Diesel	435.9200	litres	2.680000	1168.2787	1.168279	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-05_v1.csv	FBB-USR-3	2024-06-05 00:00:00+02	FBB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202405	FBCINS	Main office	2024-05	scope2	Grid electricity (location-based)	\N	12600.9500	kWh	0.650000	8190.6202	8.190620	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-05_v1.csv	FBB-USR-3	2024-06-05 00:00:00+02	FBB-USR-2	2024-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202406	CBZBANK	Head office	2024-06	scope1	Fleet fuel	Diesel	2129.4000	litres	2.680000	5706.7920	5.706792	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-06_v1.csv	USR-CONTRIB-BANK	2024-07-06 00:00:00+02	USR-APPROVER-BANK	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202406	CBZBANK	Head office	2024-06	scope2	Grid electricity (location-based)	\N	61854.0000	kWh	0.650000	40205.1000	40.205100	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-06_v1.csv	USR-CONTRIB-BANK	2024-07-06 00:00:00+02	USR-APPROVER-BANK	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202406	CBZAGRO	Main office	2024-06	scope1	Fleet fuel	Diesel	648.9600	litres	2.680000	1739.2128	1.739213	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-06_v1.csv	USR-CONTRIB-BANK	2024-07-06 00:00:00+02	USR-APPROVER-BANK	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202406	CBZAGRO	Main office	2024-06	scope2	Grid electricity (location-based)	\N	18759.0000	kWh	0.650000	12193.3500	12.193350	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-06_v1.csv	USR-CONTRIB-BANK	2024-07-06 00:00:00+02	USR-APPROVER-BANK	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202406	STANBANK	Head office	2024-06	scope1	Fleet fuel	Diesel	1703.5200	litres	2.680000	4565.4336	4.565434	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-06_v1.csv	STB-USR-3	2024-07-06 00:00:00+02	STB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202406	STANBANK	Head office	2024-06	scope2	Grid electricity (location-based)	\N	49483.2000	kWh	0.650000	32164.0800	32.164080	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-06_v1.csv	STB-USR-3	2024-07-06 00:00:00+02	STB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202406	STANWLTH	Main office	2024-06	scope1	Fleet fuel	Diesel	519.1700	litres	2.680000	1391.3702	1.391370	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-06_v1.csv	STB-USR-3	2024-07-06 00:00:00+02	STB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202406	STANWLTH	Main office	2024-06	scope2	Grid electricity (location-based)	\N	15007.2000	kWh	0.650000	9754.6800	9.754680	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-06_v1.csv	STB-USR-3	2024-07-06 00:00:00+02	STB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202406	FBCBANK	Head office	2024-06	scope1	Fleet fuel	Diesel	1384.1100	litres	2.680000	3709.4148	3.709415	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-06_v1.csv	FBB-USR-3	2024-07-06 00:00:00+02	FBB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202406	FBCBANK	Head office	2024-06	scope2	Grid electricity (location-based)	\N	40205.1000	kWh	0.650000	26133.3150	26.133315	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-06_v1.csv	FBB-USR-3	2024-07-06 00:00:00+02	FBB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202406	FBCINS	Main office	2024-06	scope1	Fleet fuel	Diesel	421.8200	litres	2.680000	1130.4883	1.130488	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-06_v1.csv	FBB-USR-3	2024-07-06 00:00:00+02	FBB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202406	FBCINS	Main office	2024-06	scope2	Grid electricity (location-based)	\N	12193.3500	kWh	0.650000	7925.6775	7.925678	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-06_v1.csv	FBB-USR-3	2024-07-06 00:00:00+02	FBB-USR-2	2024-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202407	CBZBANK	Head office	2024-07	scope1	Fleet fuel	Diesel	2037.0000	litres	2.680000	5459.1600	5.459160	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-07_v1.csv	USR-CONTRIB-BANK	2024-08-05 00:00:00+02	USR-APPROVER-BANK	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202407	CBZBANK	Head office	2024-07	scope2	Grid electricity (location-based)	\N	59170.0000	kWh	0.650000	38460.5000	38.460500	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-07_v1.csv	USR-CONTRIB-BANK	2024-08-05 00:00:00+02	USR-APPROVER-BANK	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202407	CBZAGRO	Main office	2024-07	scope1	Fleet fuel	Diesel	620.8000	litres	2.680000	1663.7440	1.663744	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-07_v1.csv	USR-CONTRIB-BANK	2024-08-05 00:00:00+02	USR-APPROVER-BANK	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202407	CBZAGRO	Main office	2024-07	scope2	Grid electricity (location-based)	\N	17945.0000	kWh	0.650000	11664.2500	11.664250	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-07_v1.csv	USR-CONTRIB-BANK	2024-08-05 00:00:00+02	USR-APPROVER-BANK	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202407	STANBANK	Head office	2024-07	scope1	Fleet fuel	Diesel	1629.6000	litres	2.680000	4367.3280	4.367328	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-07_v1.csv	STB-USR-3	2024-08-05 00:00:00+02	STB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202407	STANBANK	Head office	2024-07	scope2	Grid electricity (location-based)	\N	47336.0000	kWh	0.650000	30768.4000	30.768400	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-07_v1.csv	STB-USR-3	2024-08-05 00:00:00+02	STB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202407	STANWLTH	Main office	2024-07	scope1	Fleet fuel	Diesel	496.6400	litres	2.680000	1330.9952	1.330995	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-07_v1.csv	STB-USR-3	2024-08-05 00:00:00+02	STB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202407	STANWLTH	Main office	2024-07	scope2	Grid electricity (location-based)	\N	14356.0000	kWh	0.650000	9331.4000	9.331400	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-07_v1.csv	STB-USR-3	2024-08-05 00:00:00+02	STB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202407	FBCBANK	Head office	2024-07	scope1	Fleet fuel	Diesel	1324.0500	litres	2.680000	3548.4540	3.548454	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-07_v1.csv	FBB-USR-3	2024-08-05 00:00:00+02	FBB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202407	FBCBANK	Head office	2024-07	scope2	Grid electricity (location-based)	\N	38460.5000	kWh	0.650000	24999.3250	24.999325	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-07_v1.csv	FBB-USR-3	2024-08-05 00:00:00+02	FBB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202407	FBCINS	Main office	2024-07	scope1	Fleet fuel	Diesel	403.5200	litres	2.680000	1081.4336	1.081434	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-07_v1.csv	FBB-USR-3	2024-08-05 00:00:00+02	FBB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202407	FBCINS	Main office	2024-07	scope2	Grid electricity (location-based)	\N	11664.2500	kWh	0.650000	7581.7625	7.581763	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-07_v1.csv	FBB-USR-3	2024-08-05 00:00:00+02	FBB-USR-2	2024-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202408	CBZBANK	Head office	2024-08	scope1	Fleet fuel	Diesel	1945.4400	litres	2.680000	5213.7792	5.213779	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-08_v1.csv	USR-CONTRIB-BANK	2024-09-05 00:00:00+02	USR-APPROVER-BANK	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202408	CBZBANK	Head office	2024-08	scope2	Grid electricity (location-based)	\N	56510.4000	kWh	0.650000	36731.7600	36.731760	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-08_v1.csv	USR-CONTRIB-BANK	2024-09-05 00:00:00+02	USR-APPROVER-BANK	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202408	CBZAGRO	Main office	2024-08	scope1	Fleet fuel	Diesel	592.9000	litres	2.680000	1588.9613	1.588961	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-08_v1.csv	USR-CONTRIB-BANK	2024-09-05 00:00:00+02	USR-APPROVER-BANK	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202408	CBZAGRO	Main office	2024-08	scope2	Grid electricity (location-based)	\N	17138.4000	kWh	0.650000	11139.9600	11.139960	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-08_v1.csv	USR-CONTRIB-BANK	2024-09-05 00:00:00+02	USR-APPROVER-BANK	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202408	STANBANK	Head office	2024-08	scope1	Fleet fuel	Diesel	1556.3500	litres	2.680000	4171.0234	4.171023	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-08_v1.csv	STB-USR-3	2024-09-05 00:00:00+02	STB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202408	STANBANK	Head office	2024-08	scope2	Grid electricity (location-based)	\N	45208.3200	kWh	0.650000	29385.4080	29.385408	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-08_v1.csv	STB-USR-3	2024-09-05 00:00:00+02	STB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202408	STANWLTH	Main office	2024-08	scope1	Fleet fuel	Diesel	474.3200	litres	2.680000	1271.1690	1.271169	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-08_v1.csv	STB-USR-3	2024-09-05 00:00:00+02	STB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202408	STANWLTH	Main office	2024-08	scope2	Grid electricity (location-based)	\N	13710.7200	kWh	0.650000	8911.9680	8.911968	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-08_v1.csv	STB-USR-3	2024-09-05 00:00:00+02	STB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202408	FBCBANK	Head office	2024-08	scope1	Fleet fuel	Diesel	1264.5400	litres	2.680000	3388.9565	3.388956	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-08_v1.csv	FBB-USR-3	2024-09-05 00:00:00+02	FBB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202408	FBCBANK	Head office	2024-08	scope2	Grid electricity (location-based)	\N	36731.7600	kWh	0.650000	23875.6440	23.875644	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-08_v1.csv	FBB-USR-3	2024-09-05 00:00:00+02	FBB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202408	FBCINS	Main office	2024-08	scope1	Fleet fuel	Diesel	385.3800	litres	2.680000	1032.8248	1.032825	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-08_v1.csv	FBB-USR-3	2024-09-05 00:00:00+02	FBB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202408	FBCINS	Main office	2024-08	scope2	Grid electricity (location-based)	\N	11139.9600	kWh	0.650000	7240.9740	7.240974	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-08_v1.csv	FBB-USR-3	2024-09-05 00:00:00+02	FBB-USR-2	2024-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202409	CBZBANK	Head office	2024-09	scope1	Fleet fuel	Diesel	1876.3300	litres	2.680000	5028.5575	5.028557	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-09_v1.csv	USR-CONTRIB-BANK	2024-10-06 00:00:00+02	USR-APPROVER-BANK	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202409	CBZBANK	Head office	2024-09	scope2	Grid electricity (location-based)	\N	54502.8400	kWh	0.650000	35426.8487	35.426849	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-09_v1.csv	USR-CONTRIB-BANK	2024-10-06 00:00:00+02	USR-APPROVER-BANK	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202409	CBZAGRO	Main office	2024-09	scope1	Fleet fuel	Diesel	571.8300	litres	2.680000	1532.5128	1.532513	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-09_v1.csv	USR-CONTRIB-BANK	2024-10-06 00:00:00+02	USR-APPROVER-BANK	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202409	CBZAGRO	Main office	2024-09	scope2	Grid electricity (location-based)	\N	16529.5500	kWh	0.650000	10744.2082	10.744208	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-09_v1.csv	USR-CONTRIB-BANK	2024-10-06 00:00:00+02	USR-APPROVER-BANK	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202409	STANBANK	Head office	2024-09	scope1	Fleet fuel	Diesel	1501.0600	litres	2.680000	4022.8460	4.022846	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-09_v1.csv	STB-USR-3	2024-10-06 00:00:00+02	STB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202409	STANBANK	Head office	2024-09	scope2	Grid electricity (location-based)	\N	43602.2800	kWh	0.650000	28341.4790	28.341479	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-09_v1.csv	STB-USR-3	2024-10-06 00:00:00+02	STB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202409	STANWLTH	Main office	2024-09	scope1	Fleet fuel	Diesel	457.4700	litres	2.680000	1226.0102	1.226010	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-09_v1.csv	STB-USR-3	2024-10-06 00:00:00+02	STB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202409	STANWLTH	Main office	2024-09	scope2	Grid electricity (location-based)	\N	13223.6400	kWh	0.650000	8595.3666	8.595367	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-09_v1.csv	STB-USR-3	2024-10-06 00:00:00+02	STB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202409	FBCBANK	Head office	2024-09	scope1	Fleet fuel	Diesel	1219.6100	litres	2.680000	3268.5624	3.268562	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-09_v1.csv	FBB-USR-3	2024-10-06 00:00:00+02	FBB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202409	FBCBANK	Head office	2024-09	scope2	Grid electricity (location-based)	\N	35426.8500	kWh	0.650000	23027.4517	23.027452	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-09_v1.csv	FBB-USR-3	2024-10-06 00:00:00+02	FBB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202409	FBCINS	Main office	2024-09	scope1	Fleet fuel	Diesel	371.6900	litres	2.680000	996.1333	0.996133	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-09_v1.csv	FBB-USR-3	2024-10-06 00:00:00+02	FBB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202409	FBCINS	Main office	2024-09	scope2	Grid electricity (location-based)	\N	10744.2100	kWh	0.650000	6983.7353	6.983735	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-09_v1.csv	FBB-USR-3	2024-10-06 00:00:00+02	FBB-USR-2	2024-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202410	CBZBANK	Head office	2024-10	scope1	Fleet fuel	Diesel	1845.0600	litres	2.680000	4944.7608	4.944761	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-10_v1.csv	USR-CONTRIB-BANK	2024-11-05 00:00:00+02	USR-APPROVER-BANK	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202410	CBZBANK	Head office	2024-10	scope2	Grid electricity (location-based)	\N	53594.6000	kWh	0.650000	34836.4900	34.836490	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-10_v1.csv	USR-CONTRIB-BANK	2024-11-05 00:00:00+02	USR-APPROVER-BANK	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202410	CBZAGRO	Main office	2024-10	scope1	Fleet fuel	Diesel	562.3000	litres	2.680000	1506.9747	1.506975	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-10_v1.csv	USR-CONTRIB-BANK	2024-11-05 00:00:00+02	USR-APPROVER-BANK	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202410	CBZAGRO	Main office	2024-10	scope2	Grid electricity (location-based)	\N	16254.1000	kWh	0.650000	10565.1650	10.565165	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-10_v1.csv	USR-CONTRIB-BANK	2024-11-05 00:00:00+02	USR-APPROVER-BANK	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202410	STANBANK	Head office	2024-10	scope1	Fleet fuel	Diesel	1476.0500	litres	2.680000	3955.8086	3.955809	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-10_v1.csv	STB-USR-3	2024-11-05 00:00:00+02	STB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202410	STANBANK	Head office	2024-10	scope2	Grid electricity (location-based)	\N	42875.6800	kWh	0.650000	27869.1920	27.869192	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-10_v1.csv	STB-USR-3	2024-11-05 00:00:00+02	STB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202410	STANWLTH	Main office	2024-10	scope1	Fleet fuel	Diesel	449.8400	litres	2.680000	1205.5798	1.205580	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-10_v1.csv	STB-USR-3	2024-11-05 00:00:00+02	STB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202410	STANWLTH	Main office	2024-10	scope2	Grid electricity (location-based)	\N	13003.2800	kWh	0.650000	8452.1320	8.452132	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-10_v1.csv	STB-USR-3	2024-11-05 00:00:00+02	STB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202410	FBCBANK	Head office	2024-10	scope1	Fleet fuel	Diesel	1199.2900	litres	2.680000	3214.0945	3.214095	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-10_v1.csv	FBB-USR-3	2024-11-05 00:00:00+02	FBB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202410	FBCBANK	Head office	2024-10	scope2	Grid electricity (location-based)	\N	34836.4900	kWh	0.650000	22643.7185	22.643719	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-10_v1.csv	FBB-USR-3	2024-11-05 00:00:00+02	FBB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202410	FBCINS	Main office	2024-10	scope1	Fleet fuel	Diesel	365.5000	litres	2.680000	979.5336	0.979534	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-10_v1.csv	FBB-USR-3	2024-11-05 00:00:00+02	FBB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202410	FBCINS	Main office	2024-10	scope2	Grid electricity (location-based)	\N	10565.1700	kWh	0.650000	6867.3573	6.867357	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-10_v1.csv	FBB-USR-3	2024-11-05 00:00:00+02	FBB-USR-2	2024-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202411	CBZBANK	Head office	2024-11	scope1	Fleet fuel	Diesel	1856.7800	litres	2.680000	4976.1767	4.976177	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-11_v1.csv	USR-CONTRIB-BANK	2024-12-06 00:00:00+02	USR-APPROVER-BANK	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202411	CBZBANK	Head office	2024-11	scope2	Grid electricity (location-based)	\N	53935.1100	kWh	0.650000	35057.8190	35.057819	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-11_v1.csv	USR-CONTRIB-BANK	2024-12-06 00:00:00+02	USR-APPROVER-BANK	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202411	CBZAGRO	Main office	2024-11	scope1	Fleet fuel	Diesel	565.8800	litres	2.680000	1516.5491	1.516549	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-11_v1.csv	USR-CONTRIB-BANK	2024-12-06 00:00:00+02	USR-APPROVER-BANK	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202411	CBZAGRO	Main office	2024-11	scope2	Grid electricity (location-based)	\N	16357.3700	kWh	0.650000	10632.2894	10.632289	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-11_v1.csv	USR-CONTRIB-BANK	2024-12-06 00:00:00+02	USR-APPROVER-BANK	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202411	STANBANK	Head office	2024-11	scope1	Fleet fuel	Diesel	1485.4300	litres	2.680000	3980.9413	3.980941	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-11_v1.csv	STB-USR-3	2024-12-06 00:00:00+02	STB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202411	STANBANK	Head office	2024-11	scope2	Grid electricity (location-based)	\N	43148.0800	kWh	0.650000	28046.2552	28.046255	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-11_v1.csv	STB-USR-3	2024-12-06 00:00:00+02	STB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202411	STANWLTH	Main office	2024-11	scope1	Fleet fuel	Diesel	452.7000	litres	2.680000	1213.2393	1.213239	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-11_v1.csv	STB-USR-3	2024-12-06 00:00:00+02	STB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202411	STANWLTH	Main office	2024-11	scope2	Grid electricity (location-based)	\N	13085.8900	kWh	0.650000	8505.8315	8.505832	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-11_v1.csv	STB-USR-3	2024-12-06 00:00:00+02	STB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202411	FBCBANK	Head office	2024-11	scope1	Fleet fuel	Diesel	1206.9100	litres	2.680000	3234.5148	3.234515	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-11_v1.csv	FBB-USR-3	2024-12-06 00:00:00+02	FBB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202411	FBCBANK	Head office	2024-11	scope2	Grid electricity (location-based)	\N	35057.8200	kWh	0.650000	22787.5824	22.787582	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-11_v1.csv	FBB-USR-3	2024-12-06 00:00:00+02	FBB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202411	FBCINS	Main office	2024-11	scope1	Fleet fuel	Diesel	367.8200	litres	2.680000	985.7569	0.985757	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-11_v1.csv	FBB-USR-3	2024-12-06 00:00:00+02	FBB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202411	FBCINS	Main office	2024-11	scope2	Grid electricity (location-based)	\N	10632.2900	kWh	0.650000	6910.9881	6.910988	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-11_v1.csv	FBB-USR-3	2024-12-06 00:00:00+02	FBB-USR-2	2024-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202412	CBZBANK	Head office	2024-12	scope1	Fleet fuel	Diesel	1905.1200	litres	2.680000	5105.7216	5.105722	activity-based	2	locked	CBZBANK_SCOPE1_HISTORY_2024-12_v1.csv	USR-CONTRIB-BANK	2025-01-05 00:00:00+02	USR-APPROVER-BANK	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202412	CBZBANK	Head office	2024-12	scope2	Grid electricity (location-based)	\N	55339.2000	kWh	0.650000	35970.4800	35.970480	activity-based	2	locked	CBZBANK_SCOPE2_HISTORY_2024-12_v1.csv	USR-CONTRIB-BANK	2025-01-05 00:00:00+02	USR-APPROVER-BANK	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202412	CBZAGRO	Main office	2024-12	scope1	Fleet fuel	Diesel	580.6100	litres	2.680000	1556.0294	1.556029	activity-based	2	locked	CBZAGRO_SCOPE1_HISTORY_2024-12_v1.csv	USR-CONTRIB-BANK	2025-01-05 00:00:00+02	USR-APPROVER-BANK	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202412	CBZAGRO	Main office	2024-12	scope2	Grid electricity (location-based)	\N	16783.2000	kWh	0.650000	10909.0800	10.909080	activity-based	2	locked	CBZAGRO_SCOPE2_HISTORY_2024-12_v1.csv	USR-CONTRIB-BANK	2025-01-05 00:00:00+02	USR-APPROVER-BANK	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202412	STANBANK	Head office	2024-12	scope1	Fleet fuel	Diesel	1524.1000	litres	2.680000	4084.5773	4.084577	activity-based	2	locked	STANBANK_SCOPE1_HISTORY_2024-12_v1.csv	STB-USR-3	2025-01-05 00:00:00+02	STB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202412	STANBANK	Head office	2024-12	scope2	Grid electricity (location-based)	\N	44271.3600	kWh	0.650000	28776.3840	28.776384	activity-based	2	locked	STANBANK_SCOPE2_HISTORY_2024-12_v1.csv	STB-USR-3	2025-01-05 00:00:00+02	STB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202412	STANWLTH	Main office	2024-12	scope1	Fleet fuel	Diesel	464.4900	litres	2.680000	1244.8236	1.244824	activity-based	2	locked	STANWLTH_SCOPE1_HISTORY_2024-12_v1.csv	STB-USR-3	2025-01-05 00:00:00+02	STB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202412	STANWLTH	Main office	2024-12	scope2	Grid electricity (location-based)	\N	13426.5600	kWh	0.650000	8727.2640	8.727264	activity-based	2	locked	STANWLTH_SCOPE2_HISTORY_2024-12_v1.csv	STB-USR-3	2025-01-05 00:00:00+02	STB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202412	FBCBANK	Head office	2024-12	scope1	Fleet fuel	Diesel	1238.3300	litres	2.680000	3318.7190	3.318719	activity-based	2	locked	FBCBANK_SCOPE1_HISTORY_2024-12_v1.csv	FBB-USR-3	2025-01-05 00:00:00+02	FBB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202412	FBCBANK	Head office	2024-12	scope2	Grid electricity (location-based)	\N	35970.4800	kWh	0.650000	23380.8120	23.380812	activity-based	2	locked	FBCBANK_SCOPE2_HISTORY_2024-12_v1.csv	FBB-USR-3	2025-01-05 00:00:00+02	FBB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202412	FBCINS	Main office	2024-12	scope1	Fleet fuel	Diesel	377.4000	litres	2.680000	1011.4191	1.011419	activity-based	2	locked	FBCINS_SCOPE1_HISTORY_2024-12_v1.csv	FBB-USR-3	2025-01-05 00:00:00+02	FBB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202412	FBCINS	Main office	2024-12	scope2	Grid electricity (location-based)	\N	10909.0800	kWh	0.650000	7090.9020	7.090902	activity-based	2	locked	FBCINS_SCOPE2_HISTORY_2024-12_v1.csv	FBB-USR-3	2025-01-05 00:00:00+02	FBB-USR-2	2025-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202501	CBZBANK	Head office	2025-01	scope1	Fleet fuel	Diesel	1974.0000	litres	2.680000	5290.3200	5.290320	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-01_v1.csv	USR-CONTRIB-BANK	2025-02-05 00:00:00+02	USR-APPROVER-BANK	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202501	CBZBANK	Head office	2025-01	scope2	Grid electricity (location-based)	\N	57340.0000	kWh	0.650000	37271.0000	37.271000	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-01_v1.csv	USR-CONTRIB-BANK	2025-02-05 00:00:00+02	USR-APPROVER-BANK	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202501	CBZAGRO	Main office	2025-01	scope1	Fleet fuel	Diesel	601.6000	litres	2.680000	1612.2880	1.612288	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-01_v1.csv	USR-CONTRIB-BANK	2025-02-05 00:00:00+02	USR-APPROVER-BANK	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202501	CBZAGRO	Main office	2025-01	scope2	Grid electricity (location-based)	\N	17390.0000	kWh	0.650000	11303.5000	11.303500	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-01_v1.csv	USR-CONTRIB-BANK	2025-02-05 00:00:00+02	USR-APPROVER-BANK	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202501	STANBANK	Head office	2025-01	scope1	Fleet fuel	Diesel	1579.2000	litres	2.680000	4232.2560	4.232256	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-01_v1.csv	STB-USR-3	2025-02-05 00:00:00+02	STB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202501	STANBANK	Head office	2025-01	scope2	Grid electricity (location-based)	\N	45872.0000	kWh	0.650000	29816.8000	29.816800	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-01_v1.csv	STB-USR-3	2025-02-05 00:00:00+02	STB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202501	STANWLTH	Main office	2025-01	scope1	Fleet fuel	Diesel	481.2800	litres	2.680000	1289.8304	1.289830	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-01_v1.csv	STB-USR-3	2025-02-05 00:00:00+02	STB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202501	STANWLTH	Main office	2025-01	scope2	Grid electricity (location-based)	\N	13912.0000	kWh	0.650000	9042.8000	9.042800	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-01_v1.csv	STB-USR-3	2025-02-05 00:00:00+02	STB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202501	FBCBANK	Head office	2025-01	scope1	Fleet fuel	Diesel	1283.1000	litres	2.680000	3438.7080	3.438708	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-01_v1.csv	FBB-USR-3	2025-02-05 00:00:00+02	FBB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202501	FBCBANK	Head office	2025-01	scope2	Grid electricity (location-based)	\N	37271.0000	kWh	0.650000	24226.1500	24.226150	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-01_v1.csv	FBB-USR-3	2025-02-05 00:00:00+02	FBB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202501	FBCINS	Main office	2025-01	scope1	Fleet fuel	Diesel	391.0400	litres	2.680000	1047.9872	1.047987	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-01_v1.csv	FBB-USR-3	2025-02-05 00:00:00+02	FBB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202501	FBCINS	Main office	2025-01	scope2	Grid electricity (location-based)	\N	11303.5000	kWh	0.650000	7347.2750	7.347275	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-01_v1.csv	FBB-USR-3	2025-02-05 00:00:00+02	FBB-USR-2	2025-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202502	CBZBANK	Head office	2025-02	scope1	Fleet fuel	Diesel	2042.0400	litres	2.680000	5472.6672	5.472667	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-02_v1.csv	USR-CONTRIB-BANK	2025-03-08 00:00:00+02	USR-APPROVER-BANK	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202502	CBZBANK	Head office	2025-02	scope2	Grid electricity (location-based)	\N	59316.4000	kWh	0.650000	38555.6600	38.555660	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-02_v1.csv	USR-CONTRIB-BANK	2025-03-08 00:00:00+02	USR-APPROVER-BANK	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202502	CBZAGRO	Main office	2025-02	scope1	Fleet fuel	Diesel	622.3400	litres	2.680000	1667.8605	1.667860	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-02_v1.csv	USR-CONTRIB-BANK	2025-03-08 00:00:00+02	USR-APPROVER-BANK	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202502	CBZAGRO	Main office	2025-02	scope2	Grid electricity (location-based)	\N	17989.4000	kWh	0.650000	11693.1100	11.693110	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-02_v1.csv	USR-CONTRIB-BANK	2025-03-08 00:00:00+02	USR-APPROVER-BANK	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202502	STANBANK	Head office	2025-02	scope1	Fleet fuel	Diesel	1633.6300	litres	2.680000	4378.1338	4.378134	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-02_v1.csv	STB-USR-3	2025-03-08 00:00:00+02	STB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202502	STANBANK	Head office	2025-02	scope2	Grid electricity (location-based)	\N	47453.1200	kWh	0.650000	30844.5280	30.844528	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-02_v1.csv	STB-USR-3	2025-03-08 00:00:00+02	STB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202502	STANWLTH	Main office	2025-02	scope1	Fleet fuel	Diesel	497.8700	litres	2.680000	1334.2884	1.334288	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-02_v1.csv	STB-USR-3	2025-03-08 00:00:00+02	STB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202502	STANWLTH	Main office	2025-02	scope2	Grid electricity (location-based)	\N	14391.5200	kWh	0.650000	9354.4880	9.354488	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-02_v1.csv	STB-USR-3	2025-03-08 00:00:00+02	STB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202502	FBCBANK	Head office	2025-02	scope1	Fleet fuel	Diesel	1327.3300	litres	2.680000	3557.2337	3.557234	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-02_v1.csv	FBB-USR-3	2025-03-08 00:00:00+02	FBB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202502	FBCBANK	Head office	2025-02	scope2	Grid electricity (location-based)	\N	38555.6600	kWh	0.650000	25061.1790	25.061179	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-02_v1.csv	FBB-USR-3	2025-03-08 00:00:00+02	FBB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202502	FBCINS	Main office	2025-02	scope1	Fleet fuel	Diesel	404.5200	litres	2.680000	1084.1093	1.084109	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-02_v1.csv	FBB-USR-3	2025-03-08 00:00:00+02	FBB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202502	FBCINS	Main office	2025-02	scope2	Grid electricity (location-based)	\N	11693.1100	kWh	0.650000	7600.5215	7.600522	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-02_v1.csv	FBB-USR-3	2025-03-08 00:00:00+02	FBB-USR-2	2025-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202503	CBZBANK	Head office	2025-03	scope1	Fleet fuel	Diesel	2088.3100	litres	2.680000	5596.6649	5.596665	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-03_v1.csv	USR-CONTRIB-BANK	2025-04-05 00:00:00+02	USR-APPROVER-BANK	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202503	CBZBANK	Head office	2025-03	scope2	Grid electricity (location-based)	\N	60660.3700	kWh	0.650000	39429.2403	39.429240	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-03_v1.csv	USR-CONTRIB-BANK	2025-04-05 00:00:00+02	USR-APPROVER-BANK	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202503	CBZAGRO	Main office	2025-03	scope1	Fleet fuel	Diesel	636.4400	litres	2.680000	1705.6503	1.705650	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-03_v1.csv	USR-CONTRIB-BANK	2025-04-05 00:00:00+02	USR-APPROVER-BANK	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202503	CBZAGRO	Main office	2025-03	scope2	Grid electricity (location-based)	\N	18397.0000	kWh	0.650000	11958.0483	11.958048	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-03_v1.csv	USR-CONTRIB-BANK	2025-04-05 00:00:00+02	USR-APPROVER-BANK	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202503	STANBANK	Head office	2025-03	scope1	Fleet fuel	Diesel	1670.6500	litres	2.680000	4477.3319	4.477332	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-03_v1.csv	STB-USR-3	2025-04-05 00:00:00+02	STB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202503	STANBANK	Head office	2025-03	scope2	Grid electricity (location-based)	\N	48528.3000	kWh	0.650000	31543.3922	31.543392	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-03_v1.csv	STB-USR-3	2025-04-05 00:00:00+02	STB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202503	STANWLTH	Main office	2025-03	scope1	Fleet fuel	Diesel	509.1500	litres	2.680000	1364.5202	1.364520	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-03_v1.csv	STB-USR-3	2025-04-05 00:00:00+02	STB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202503	STANWLTH	Main office	2025-03	scope2	Grid electricity (location-based)	\N	14717.6000	kWh	0.650000	9566.4386	9.566439	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-03_v1.csv	STB-USR-3	2025-04-05 00:00:00+02	STB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202503	FBCBANK	Head office	2025-03	scope1	Fleet fuel	Diesel	1357.4000	litres	2.680000	3637.8322	3.637832	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-03_v1.csv	FBB-USR-3	2025-04-05 00:00:00+02	FBB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202503	FBCBANK	Head office	2025-03	scope2	Grid electricity (location-based)	\N	39429.2400	kWh	0.650000	25629.0062	25.629006	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-03_v1.csv	FBB-USR-3	2025-04-05 00:00:00+02	FBB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202503	FBCINS	Main office	2025-03	scope1	Fleet fuel	Diesel	413.6800	litres	2.680000	1108.6727	1.108673	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-03_v1.csv	FBB-USR-3	2025-04-05 00:00:00+02	FBB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202503	FBCINS	Main office	2025-03	scope2	Grid electricity (location-based)	\N	11958.0500	kWh	0.650000	7772.7314	7.772731	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-03_v1.csv	FBB-USR-3	2025-04-05 00:00:00+02	FBB-USR-2	2025-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202504	CBZBANK	Head office	2025-04	scope1	Fleet fuel	Diesel	2097.9000	litres	2.680000	5622.3720	5.622372	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-04_v1.csv	USR-CONTRIB-BANK	2025-05-06 00:00:00+02	USR-APPROVER-BANK	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202504	CBZBANK	Head office	2025-04	scope2	Grid electricity (location-based)	\N	60939.0000	kWh	0.650000	39610.3500	39.610350	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-04_v1.csv	USR-CONTRIB-BANK	2025-05-06 00:00:00+02	USR-APPROVER-BANK	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202504	CBZAGRO	Main office	2025-04	scope1	Fleet fuel	Diesel	639.3600	litres	2.680000	1713.4848	1.713485	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-04_v1.csv	USR-CONTRIB-BANK	2025-05-06 00:00:00+02	USR-APPROVER-BANK	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202504	CBZAGRO	Main office	2025-04	scope2	Grid electricity (location-based)	\N	18481.5000	kWh	0.650000	12012.9750	12.012975	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-04_v1.csv	USR-CONTRIB-BANK	2025-05-06 00:00:00+02	USR-APPROVER-BANK	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202504	STANBANK	Head office	2025-04	scope1	Fleet fuel	Diesel	1678.3200	litres	2.680000	4497.8976	4.497898	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-04_v1.csv	STB-USR-3	2025-05-06 00:00:00+02	STB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202504	STANBANK	Head office	2025-04	scope2	Grid electricity (location-based)	\N	48751.2000	kWh	0.650000	31688.2800	31.688280	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-04_v1.csv	STB-USR-3	2025-05-06 00:00:00+02	STB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202504	STANWLTH	Main office	2025-04	scope1	Fleet fuel	Diesel	511.4900	litres	2.680000	1370.7878	1.370788	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-04_v1.csv	STB-USR-3	2025-05-06 00:00:00+02	STB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202504	STANWLTH	Main office	2025-04	scope2	Grid electricity (location-based)	\N	14785.2000	kWh	0.650000	9610.3800	9.610380	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-04_v1.csv	STB-USR-3	2025-05-06 00:00:00+02	STB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202504	FBCBANK	Head office	2025-04	scope1	Fleet fuel	Diesel	1363.6400	litres	2.680000	3654.5418	3.654542	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-04_v1.csv	FBB-USR-3	2025-05-06 00:00:00+02	FBB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202504	FBCBANK	Head office	2025-04	scope2	Grid electricity (location-based)	\N	39610.3500	kWh	0.650000	25746.7275	25.746728	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-04_v1.csv	FBB-USR-3	2025-05-06 00:00:00+02	FBB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202504	FBCINS	Main office	2025-04	scope1	Fleet fuel	Diesel	415.5800	litres	2.680000	1113.7651	1.113765	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-04_v1.csv	FBB-USR-3	2025-05-06 00:00:00+02	FBB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202504	FBCINS	Main office	2025-04	scope2	Grid electricity (location-based)	\N	12012.9800	kWh	0.650000	7808.4338	7.808434	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-04_v1.csv	FBB-USR-3	2025-05-06 00:00:00+02	FBB-USR-2	2025-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202505	CBZBANK	Head office	2025-05	scope1	Fleet fuel	Diesel	2065.8500	litres	2.680000	5536.4857	5.536486	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-05_v1.csv	USR-CONTRIB-BANK	2025-06-05 00:00:00+02	USR-APPROVER-BANK	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202505	CBZBANK	Head office	2025-05	scope2	Grid electricity (location-based)	\N	60008.1100	kWh	0.650000	39005.2700	39.005270	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-05_v1.csv	USR-CONTRIB-BANK	2025-06-05 00:00:00+02	USR-APPROVER-BANK	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202505	CBZAGRO	Main office	2025-05	scope1	Fleet fuel	Diesel	629.5900	litres	2.680000	1687.3099	1.687310	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-05_v1.csv	USR-CONTRIB-BANK	2025-06-05 00:00:00+02	USR-APPROVER-BANK	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202505	CBZAGRO	Main office	2025-05	scope2	Grid electricity (location-based)	\N	18199.1800	kWh	0.650000	11829.4671	11.829467	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-05_v1.csv	USR-CONTRIB-BANK	2025-06-05 00:00:00+02	USR-APPROVER-BANK	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202505	STANBANK	Head office	2025-05	scope1	Fleet fuel	Diesel	1652.6800	litres	2.680000	4429.1886	4.429189	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-05_v1.csv	STB-USR-3	2025-06-05 00:00:00+02	STB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202505	STANBANK	Head office	2025-05	scope2	Grid electricity (location-based)	\N	48006.4900	kWh	0.650000	31204.2160	31.204216	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-05_v1.csv	STB-USR-3	2025-06-05 00:00:00+02	STB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202505	STANWLTH	Main office	2025-05	scope1	Fleet fuel	Diesel	503.6700	litres	2.680000	1349.8480	1.349848	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-05_v1.csv	STB-USR-3	2025-06-05 00:00:00+02	STB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202505	STANWLTH	Main office	2025-05	scope2	Grid electricity (location-based)	\N	14559.3400	kWh	0.650000	9463.5737	9.463574	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-05_v1.csv	STB-USR-3	2025-06-05 00:00:00+02	STB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202505	FBCBANK	Head office	2025-05	scope1	Fleet fuel	Diesel	1342.8000	litres	2.680000	3598.7157	3.598716	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-05_v1.csv	FBB-USR-3	2025-06-05 00:00:00+02	FBB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202505	FBCBANK	Head office	2025-05	scope2	Grid electricity (location-based)	\N	39005.2700	kWh	0.650000	25353.4255	25.353425	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-05_v1.csv	FBB-USR-3	2025-06-05 00:00:00+02	FBB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202505	FBCINS	Main office	2025-05	scope1	Fleet fuel	Diesel	409.2400	litres	2.680000	1096.7515	1.096751	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-05_v1.csv	FBB-USR-3	2025-06-05 00:00:00+02	FBB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202505	FBCINS	Main office	2025-05	scope2	Grid electricity (location-based)	\N	11829.4700	kWh	0.650000	7689.1536	7.689154	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-05_v1.csv	FBB-USR-3	2025-06-05 00:00:00+02	FBB-USR-2	2025-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202506	CBZBANK	Head office	2025-06	scope1	Fleet fuel	Diesel	1998.3600	litres	2.680000	5355.6048	5.355605	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-06_v1.csv	USR-CONTRIB-BANK	2025-07-06 00:00:00+02	USR-APPROVER-BANK	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202506	CBZBANK	Head office	2025-06	scope2	Grid electricity (location-based)	\N	58047.6000	kWh	0.650000	37730.9400	37.730940	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-06_v1.csv	USR-CONTRIB-BANK	2025-07-06 00:00:00+02	USR-APPROVER-BANK	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202506	CBZAGRO	Main office	2025-06	scope1	Fleet fuel	Diesel	609.0200	litres	2.680000	1632.1843	1.632184	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-06_v1.csv	USR-CONTRIB-BANK	2025-07-06 00:00:00+02	USR-APPROVER-BANK	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202506	CBZAGRO	Main office	2025-06	scope2	Grid electricity (location-based)	\N	17604.6000	kWh	0.650000	11442.9900	11.442990	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-06_v1.csv	USR-CONTRIB-BANK	2025-07-06 00:00:00+02	USR-APPROVER-BANK	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202506	STANBANK	Head office	2025-06	scope1	Fleet fuel	Diesel	1598.6900	litres	2.680000	4284.4838	4.284484	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-06_v1.csv	STB-USR-3	2025-07-06 00:00:00+02	STB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202506	STANBANK	Head office	2025-06	scope2	Grid electricity (location-based)	\N	46438.0800	kWh	0.650000	30184.7520	30.184752	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-06_v1.csv	STB-USR-3	2025-07-06 00:00:00+02	STB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202506	STANWLTH	Main office	2025-06	scope1	Fleet fuel	Diesel	487.2200	litres	2.680000	1305.7475	1.305747	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-06_v1.csv	STB-USR-3	2025-07-06 00:00:00+02	STB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202506	STANWLTH	Main office	2025-06	scope2	Grid electricity (location-based)	\N	14083.6800	kWh	0.650000	9154.3920	9.154392	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-06_v1.csv	STB-USR-3	2025-07-06 00:00:00+02	STB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202506	FBCBANK	Head office	2025-06	scope1	Fleet fuel	Diesel	1298.9300	litres	2.680000	3481.1431	3.481143	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-06_v1.csv	FBB-USR-3	2025-07-06 00:00:00+02	FBB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202506	FBCBANK	Head office	2025-06	scope2	Grid electricity (location-based)	\N	37730.9400	kWh	0.650000	24525.1110	24.525111	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-06_v1.csv	FBB-USR-3	2025-07-06 00:00:00+02	FBB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202506	FBCINS	Main office	2025-06	scope1	Fleet fuel	Diesel	395.8700	litres	2.680000	1060.9198	1.060920	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-06_v1.csv	FBB-USR-3	2025-07-06 00:00:00+02	FBB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202506	FBCINS	Main office	2025-06	scope2	Grid electricity (location-based)	\N	11442.9900	kWh	0.650000	7437.9435	7.437944	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-06_v1.csv	FBB-USR-3	2025-07-06 00:00:00+02	FBB-USR-2	2025-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202507	CBZBANK	Head office	2025-07	scope1	Fleet fuel	Diesel	4968.6000	litres	2.680000	13315.8480	13.315848	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-07_v1.csv	USR-CONTRIB-BANK	2025-08-05 00:00:00+02	USR-APPROVER-BANK	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202507	CBZBANK	Head office	2025-07	scope2	Grid electricity (location-based)	\N	55510.0000	kWh	0.650000	36081.5000	36.081500	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-07_v1.csv	USR-CONTRIB-BANK	2025-08-05 00:00:00+02	USR-APPROVER-BANK	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202507	CBZAGRO	Main office	2025-07	scope1	Fleet fuel	Diesel	582.4000	litres	2.680000	1560.8320	1.560832	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-07_v1.csv	USR-CONTRIB-BANK	2025-08-05 00:00:00+02	USR-APPROVER-BANK	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202507	CBZAGRO	Main office	2025-07	scope2	Grid electricity (location-based)	\N	16835.0000	kWh	0.650000	10942.7500	10.942750	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-07_v1.csv	USR-CONTRIB-BANK	2025-08-05 00:00:00+02	USR-APPROVER-BANK	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202507	STANBANK	Head office	2025-07	scope1	Fleet fuel	Diesel	3974.8800	litres	2.680000	10652.6784	10.652678	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-07_v1.csv	STB-USR-3	2025-08-05 00:00:00+02	STB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202507	STANBANK	Head office	2025-07	scope2	Grid electricity (location-based)	\N	44408.0000	kWh	0.650000	28865.2000	28.865200	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-07_v1.csv	STB-USR-3	2025-08-05 00:00:00+02	STB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202507	STANWLTH	Main office	2025-07	scope1	Fleet fuel	Diesel	465.9200	litres	2.680000	1248.6656	1.248666	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-07_v1.csv	STB-USR-3	2025-08-05 00:00:00+02	STB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202507	STANWLTH	Main office	2025-07	scope2	Grid electricity (location-based)	\N	13468.0000	kWh	0.650000	8754.2000	8.754200	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-07_v1.csv	STB-USR-3	2025-08-05 00:00:00+02	STB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202507	FBCBANK	Head office	2025-07	scope1	Fleet fuel	Diesel	3229.5900	litres	2.680000	8655.3012	8.655301	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-07_v1.csv	FBB-USR-3	2025-08-05 00:00:00+02	FBB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202507	FBCBANK	Head office	2025-07	scope2	Grid electricity (location-based)	\N	36081.5000	kWh	0.650000	23452.9750	23.452975	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-07_v1.csv	FBB-USR-3	2025-08-05 00:00:00+02	FBB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202507	FBCINS	Main office	2025-07	scope1	Fleet fuel	Diesel	378.5600	litres	2.680000	1014.5408	1.014541	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-07_v1.csv	FBB-USR-3	2025-08-05 00:00:00+02	FBB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202507	FBCINS	Main office	2025-07	scope2	Grid electricity (location-based)	\N	10942.7500	kWh	0.650000	7112.7875	7.112788	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-07_v1.csv	FBB-USR-3	2025-08-05 00:00:00+02	FBB-USR-2	2025-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202508	CBZBANK	Head office	2025-08	scope1	Fleet fuel	Diesel	1824.4800	litres	2.680000	4889.6064	4.889606	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-08_v1.csv	USR-CONTRIB-BANK	2025-09-05 00:00:00+02	USR-APPROVER-BANK	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202508	CBZBANK	Head office	2025-08	scope2	Grid electricity (location-based)	\N	52996.8000	kWh	0.650000	34447.9200	34.447920	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-08_v1.csv	USR-CONTRIB-BANK	2025-09-05 00:00:00+02	USR-APPROVER-BANK	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202508	CBZAGRO	Main office	2025-08	scope1	Fleet fuel	Diesel	556.0300	litres	2.680000	1490.1658	1.490166	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-08_v1.csv	USR-CONTRIB-BANK	2025-09-05 00:00:00+02	USR-APPROVER-BANK	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202508	CBZAGRO	Main office	2025-08	scope2	Grid electricity (location-based)	\N	16072.8000	kWh	0.650000	10447.3200	10.447320	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-08_v1.csv	USR-CONTRIB-BANK	2025-09-05 00:00:00+02	USR-APPROVER-BANK	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202508	STANBANK	Head office	2025-08	scope1	Fleet fuel	Diesel	1459.5800	litres	2.680000	3911.6851	3.911685	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-08_v1.csv	STB-USR-3	2025-09-05 00:00:00+02	STB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202508	STANBANK	Head office	2025-08	scope2	Grid electricity (location-based)	\N	42397.4400	kWh	0.650000	27558.3360	27.558336	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-08_v1.csv	STB-USR-3	2025-09-05 00:00:00+02	STB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202508	STANWLTH	Main office	2025-08	scope1	Fleet fuel	Diesel	444.8300	litres	2.680000	1192.1326	1.192133	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-08_v1.csv	STB-USR-3	2025-09-05 00:00:00+02	STB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202508	STANWLTH	Main office	2025-08	scope2	Grid electricity (location-based)	\N	12858.2400	kWh	0.650000	8357.8560	8.357856	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-08_v1.csv	STB-USR-3	2025-09-05 00:00:00+02	STB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202508	FBCBANK	Head office	2025-08	scope1	Fleet fuel	Diesel	1185.9100	litres	2.680000	3178.2442	3.178244	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-08_v1.csv	FBB-USR-3	2025-09-05 00:00:00+02	FBB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202508	FBCBANK	Head office	2025-08	scope2	Grid electricity (location-based)	\N	34447.9200	kWh	0.650000	22391.1480	22.391148	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-08_v1.csv	FBB-USR-3	2025-09-05 00:00:00+02	FBB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202508	FBCINS	Main office	2025-08	scope1	Fleet fuel	Diesel	361.4200	litres	2.680000	968.6077	0.968608	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-08_v1.csv	FBB-USR-3	2025-09-05 00:00:00+02	FBB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202508	FBCINS	Main office	2025-08	scope2	Grid electricity (location-based)	\N	10447.3200	kWh	0.650000	6790.7580	6.790758	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-08_v1.csv	FBB-USR-3	2025-09-05 00:00:00+02	FBB-USR-2	2025-09-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202509	CBZBANK	Head office	2025-09	scope1	Fleet fuel	Diesel	1759.0600	litres	2.680000	4714.2726	4.714273	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-09_v1.csv	USR-CONTRIB-BANK	2025-10-06 00:00:00+02	USR-APPROVER-BANK	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202509	CBZBANK	Head office	2025-09	scope2	Grid electricity (location-based)	\N	51096.4200	kWh	0.650000	33212.6707	33.212671	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-09_v1.csv	USR-CONTRIB-BANK	2025-10-06 00:00:00+02	USR-APPROVER-BANK	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202509	CBZAGRO	Main office	2025-09	scope1	Fleet fuel	Diesel	536.0900	litres	2.680000	1436.7307	1.436731	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-09_v1.csv	USR-CONTRIB-BANK	2025-10-06 00:00:00+02	USR-APPROVER-BANK	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202509	CBZAGRO	Main office	2025-09	scope2	Grid electricity (location-based)	\N	15496.4500	kWh	0.650000	10072.6952	10.072695	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-09_v1.csv	USR-CONTRIB-BANK	2025-10-06 00:00:00+02	USR-APPROVER-BANK	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202509	STANBANK	Head office	2025-09	scope1	Fleet fuel	Diesel	1407.2500	litres	2.680000	3771.4181	3.771418	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-09_v1.csv	STB-USR-3	2025-10-06 00:00:00+02	STB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202509	STANBANK	Head office	2025-09	scope2	Grid electricity (location-based)	\N	40877.1300	kWh	0.650000	26570.1365	26.570137	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-09_v1.csv	STB-USR-3	2025-10-06 00:00:00+02	STB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202509	STANWLTH	Main office	2025-09	scope1	Fleet fuel	Diesel	428.8700	litres	2.680000	1149.3846	1.149385	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-09_v1.csv	STB-USR-3	2025-10-06 00:00:00+02	STB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202509	STANWLTH	Main office	2025-09	scope2	Grid electricity (location-based)	\N	12397.1600	kWh	0.650000	8058.1562	8.058156	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-09_v1.csv	STB-USR-3	2025-10-06 00:00:00+02	STB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202509	FBCBANK	Head office	2025-09	scope1	Fleet fuel	Diesel	1143.3900	litres	2.680000	3064.2772	3.064277	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-09_v1.csv	FBB-USR-3	2025-10-06 00:00:00+02	FBB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202509	FBCBANK	Head office	2025-09	scope2	Grid electricity (location-based)	\N	33212.6700	kWh	0.650000	21588.2359	21.588236	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-09_v1.csv	FBB-USR-3	2025-10-06 00:00:00+02	FBB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202509	FBCINS	Main office	2025-09	scope1	Fleet fuel	Diesel	348.4600	litres	2.680000	933.8750	0.933875	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-09_v1.csv	FBB-USR-3	2025-10-06 00:00:00+02	FBB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202509	FBCINS	Main office	2025-09	scope2	Grid electricity (location-based)	\N	10072.7000	kWh	0.650000	6547.2519	6.547252	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-09_v1.csv	FBB-USR-3	2025-10-06 00:00:00+02	FBB-USR-2	2025-10-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202510	CBZBANK	Head office	2025-10	scope1	Fleet fuel	Diesel	1729.1400	litres	2.680000	4634.0952	4.634095	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-10_v1.csv	USR-CONTRIB-BANK	2025-11-05 00:00:00+02	USR-APPROVER-BANK	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202510	CBZBANK	Head office	2025-10	scope2	Grid electricity (location-based)	\N	50227.4000	kWh	0.650000	32647.8100	32.647810	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-10_v1.csv	USR-CONTRIB-BANK	2025-11-05 00:00:00+02	USR-APPROVER-BANK	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202510	CBZAGRO	Main office	2025-10	scope1	Fleet fuel	Diesel	526.9800	litres	2.680000	1412.2957	1.412296	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-10_v1.csv	USR-CONTRIB-BANK	2025-11-05 00:00:00+02	USR-APPROVER-BANK	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202510	CBZAGRO	Main office	2025-10	scope2	Grid electricity (location-based)	\N	15232.9000	kWh	0.650000	9901.3850	9.901385	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-10_v1.csv	USR-CONTRIB-BANK	2025-11-05 00:00:00+02	USR-APPROVER-BANK	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202510	STANBANK	Head office	2025-10	scope1	Fleet fuel	Diesel	1383.3100	litres	2.680000	3707.2762	3.707276	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-10_v1.csv	STB-USR-3	2025-11-05 00:00:00+02	STB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202510	STANBANK	Head office	2025-10	scope2	Grid electricity (location-based)	\N	40181.9200	kWh	0.650000	26118.2480	26.118248	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-10_v1.csv	STB-USR-3	2025-11-05 00:00:00+02	STB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202510	STANWLTH	Main office	2025-10	scope1	Fleet fuel	Diesel	421.5800	litres	2.680000	1129.8365	1.129837	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-10_v1.csv	STB-USR-3	2025-11-05 00:00:00+02	STB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202510	STANWLTH	Main office	2025-10	scope2	Grid electricity (location-based)	\N	12186.3200	kWh	0.650000	7921.1080	7.921108	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-10_v1.csv	STB-USR-3	2025-11-05 00:00:00+02	STB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202510	FBCBANK	Head office	2025-10	scope1	Fleet fuel	Diesel	1123.9400	litres	2.680000	3012.1619	3.012162	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-10_v1.csv	FBB-USR-3	2025-11-05 00:00:00+02	FBB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202510	FBCBANK	Head office	2025-10	scope2	Grid electricity (location-based)	\N	32647.8100	kWh	0.650000	21221.0765	21.221077	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-10_v1.csv	FBB-USR-3	2025-11-05 00:00:00+02	FBB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202510	FBCINS	Main office	2025-10	scope1	Fleet fuel	Diesel	342.5300	litres	2.680000	917.9922	0.917992	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-10_v1.csv	FBB-USR-3	2025-11-05 00:00:00+02	FBB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202510	FBCINS	Main office	2025-10	scope2	Grid electricity (location-based)	\N	9901.3900	kWh	0.650000	6435.9003	6.435900	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-10_v1.csv	FBB-USR-3	2025-11-05 00:00:00+02	FBB-USR-2	2025-11-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202511	CBZBANK	Head office	2025-11	scope1	Fleet fuel	Diesel	1739.5100	litres	2.680000	4661.8918	4.661892	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-11_v1.csv	USR-CONTRIB-BANK	2025-12-06 00:00:00+02	USR-APPROVER-BANK	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202511	CBZBANK	Head office	2025-11	scope2	Grid electricity (location-based)	\N	50528.6800	kWh	0.650000	32843.6410	32.843641	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-11_v1.csv	USR-CONTRIB-BANK	2025-12-06 00:00:00+02	USR-APPROVER-BANK	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202511	CBZAGRO	Main office	2025-11	scope1	Fleet fuel	Diesel	530.1400	litres	2.680000	1420.7670	1.420767	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-11_v1.csv	USR-CONTRIB-BANK	2025-12-06 00:00:00+02	USR-APPROVER-BANK	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202511	CBZAGRO	Main office	2025-11	scope2	Grid electricity (location-based)	\N	15324.2700	kWh	0.650000	9960.7764	9.960776	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-11_v1.csv	USR-CONTRIB-BANK	2025-12-06 00:00:00+02	USR-APPROVER-BANK	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202511	STANBANK	Head office	2025-11	scope1	Fleet fuel	Diesel	1391.6100	litres	2.680000	3729.5135	3.729513	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-11_v1.csv	STB-USR-3	2025-12-06 00:00:00+02	STB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202511	STANBANK	Head office	2025-11	scope2	Grid electricity (location-based)	\N	40422.9400	kWh	0.650000	26274.9128	26.274913	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-11_v1.csv	STB-USR-3	2025-12-06 00:00:00+02	STB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202511	STANWLTH	Main office	2025-11	scope1	Fleet fuel	Diesel	424.1100	litres	2.680000	1136.6136	1.136614	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-11_v1.csv	STB-USR-3	2025-12-06 00:00:00+02	STB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202511	STANWLTH	Main office	2025-11	scope2	Grid electricity (location-based)	\N	12259.4200	kWh	0.650000	7968.6211	7.968621	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-11_v1.csv	STB-USR-3	2025-12-06 00:00:00+02	STB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202511	FBCBANK	Head office	2025-11	scope1	Fleet fuel	Diesel	1130.6800	litres	2.680000	3030.2297	3.030230	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-11_v1.csv	FBB-USR-3	2025-12-06 00:00:00+02	FBB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202511	FBCBANK	Head office	2025-11	scope2	Grid electricity (location-based)	\N	32843.6400	kWh	0.650000	21348.3667	21.348367	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-11_v1.csv	FBB-USR-3	2025-12-06 00:00:00+02	FBB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202511	FBCINS	Main office	2025-11	scope1	Fleet fuel	Diesel	344.5900	litres	2.680000	923.4986	0.923499	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-11_v1.csv	FBB-USR-3	2025-12-06 00:00:00+02	FBB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202511	FBCINS	Main office	2025-11	scope2	Grid electricity (location-based)	\N	9960.7800	kWh	0.650000	6474.5046	6.474505	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-11_v1.csv	FBB-USR-3	2025-12-06 00:00:00+02	FBB-USR-2	2025-12-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202512	CBZBANK	Head office	2025-12	scope1	Fleet fuel	Diesel	1784.1600	litres	2.680000	4781.5488	4.781549	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2025-12_v1.csv	USR-CONTRIB-BANK	2026-01-05 00:00:00+02	USR-APPROVER-BANK	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202512	CBZBANK	Head office	2025-12	scope2	Grid electricity (location-based)	\N	51825.6000	kWh	0.650000	33686.6400	33.686640	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2025-12_v1.csv	USR-CONTRIB-BANK	2026-01-05 00:00:00+02	USR-APPROVER-BANK	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202512	CBZAGRO	Main office	2025-12	scope1	Fleet fuel	Diesel	543.7400	litres	2.680000	1457.2339	1.457234	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2025-12_v1.csv	USR-CONTRIB-BANK	2026-01-05 00:00:00+02	USR-APPROVER-BANK	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202512	CBZAGRO	Main office	2025-12	scope2	Grid electricity (location-based)	\N	15717.6000	kWh	0.650000	10216.4400	10.216440	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2025-12_v1.csv	USR-CONTRIB-BANK	2026-01-05 00:00:00+02	USR-APPROVER-BANK	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202512	STANBANK	Head office	2025-12	scope1	Fleet fuel	Diesel	1427.3300	litres	2.680000	3825.2390	3.825239	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2025-12_v1.csv	STB-USR-3	2026-01-05 00:00:00+02	STB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202512	STANBANK	Head office	2025-12	scope2	Grid electricity (location-based)	\N	41460.4800	kWh	0.650000	26949.3120	26.949312	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2025-12_v1.csv	STB-USR-3	2026-01-05 00:00:00+02	STB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202512	STANWLTH	Main office	2025-12	scope1	Fleet fuel	Diesel	435.0000	litres	2.680000	1165.7871	1.165787	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2025-12_v1.csv	STB-USR-3	2026-01-05 00:00:00+02	STB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202512	STANWLTH	Main office	2025-12	scope2	Grid electricity (location-based)	\N	12574.0800	kWh	0.650000	8173.1520	8.173152	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2025-12_v1.csv	STB-USR-3	2026-01-05 00:00:00+02	STB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202512	FBCBANK	Head office	2025-12	scope1	Fleet fuel	Diesel	1159.7000	litres	2.680000	3108.0067	3.108007	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2025-12_v1.csv	FBB-USR-3	2026-01-05 00:00:00+02	FBB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202512	FBCBANK	Head office	2025-12	scope2	Grid electricity (location-based)	\N	33686.6400	kWh	0.650000	21896.3160	21.896316	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2025-12_v1.csv	FBB-USR-3	2026-01-05 00:00:00+02	FBB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202512	FBCINS	Main office	2025-12	scope1	Fleet fuel	Diesel	353.4300	litres	2.680000	947.2020	0.947202	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2025-12_v1.csv	FBB-USR-3	2026-01-05 00:00:00+02	FBB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202512	FBCINS	Main office	2025-12	scope2	Grid electricity (location-based)	\N	10216.4400	kWh	0.650000	6640.6860	6.640686	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2025-12_v1.csv	FBB-USR-3	2026-01-05 00:00:00+02	FBB-USR-2	2026-01-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202601	CBZBANK	Head office	2026-01	scope1	Fleet fuel	Diesel	1848.0000	litres	2.680000	4952.6400	4.952640	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-01_v1.csv	USR-CONTRIB-BANK	2026-02-05 00:00:00+02	USR-APPROVER-BANK	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202601	CBZBANK	Head office	2026-01	scope2	Grid electricity (location-based)	\N	53680.0000	kWh	0.650000	34892.0000	34.892000	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-01_v1.csv	USR-CONTRIB-BANK	2026-02-05 00:00:00+02	USR-APPROVER-BANK	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202601	CBZAGRO	Main office	2026-01	scope1	Fleet fuel	Diesel	563.2000	litres	2.680000	1509.3760	1.509376	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-01_v1.csv	USR-CONTRIB-BANK	2026-02-05 00:00:00+02	USR-APPROVER-BANK	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202601	CBZAGRO	Main office	2026-01	scope2	Grid electricity (location-based)	\N	16280.0000	kWh	0.650000	10582.0000	10.582000	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-01_v1.csv	USR-CONTRIB-BANK	2026-02-05 00:00:00+02	USR-APPROVER-BANK	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202601	STANBANK	Head office	2026-01	scope1	Fleet fuel	Diesel	1478.4000	litres	2.680000	3962.1120	3.962112	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-01_v1.csv	STB-USR-3	2026-02-05 00:00:00+02	STB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202601	STANBANK	Head office	2026-01	scope2	Grid electricity (location-based)	\N	42944.0000	kWh	0.650000	27913.6000	27.913600	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-01_v1.csv	STB-USR-3	2026-02-05 00:00:00+02	STB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202601	STANWLTH	Main office	2026-01	scope1	Fleet fuel	Diesel	450.5600	litres	2.680000	1207.5008	1.207501	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-01_v1.csv	STB-USR-3	2026-02-05 00:00:00+02	STB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202601	STANWLTH	Main office	2026-01	scope2	Grid electricity (location-based)	\N	13024.0000	kWh	0.650000	8465.6000	8.465600	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-01_v1.csv	STB-USR-3	2026-02-05 00:00:00+02	STB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202601	FBCBANK	Head office	2026-01	scope1	Fleet fuel	Diesel	1201.2000	litres	2.680000	3219.2160	3.219216	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-01_v1.csv	FBB-USR-3	2026-02-05 00:00:00+02	FBB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202601	FBCBANK	Head office	2026-01	scope2	Grid electricity (location-based)	\N	34892.0000	kWh	0.650000	22679.8000	22.679800	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-01_v1.csv	FBB-USR-3	2026-02-05 00:00:00+02	FBB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202601	FBCINS	Main office	2026-01	scope1	Fleet fuel	Diesel	366.0800	litres	2.680000	981.0944	0.981094	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-01_v1.csv	FBB-USR-3	2026-02-05 00:00:00+02	FBB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202601	FBCINS	Main office	2026-01	scope2	Grid electricity (location-based)	\N	10582.0000	kWh	0.650000	6878.3000	6.878300	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-01_v1.csv	FBB-USR-3	2026-02-05 00:00:00+02	FBB-USR-2	2026-02-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202602	CBZBANK	Head office	2026-02	scope1	Fleet fuel	Diesel	1911.0000	litres	2.680000	5121.4800	5.121480	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-02_v1.csv	USR-CONTRIB-BANK	2026-03-08 00:00:00+02	USR-APPROVER-BANK	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202602	CBZBANK	Head office	2026-02	scope2	Grid electricity (location-based)	\N	55510.0000	kWh	0.650000	36081.5000	36.081500	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-02_v1.csv	USR-CONTRIB-BANK	2026-03-08 00:00:00+02	USR-APPROVER-BANK	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202602	CBZAGRO	Main office	2026-02	scope1	Fleet fuel	Diesel	582.4000	litres	2.680000	1560.8320	1.560832	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-02_v1.csv	USR-CONTRIB-BANK	2026-03-08 00:00:00+02	USR-APPROVER-BANK	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202602	CBZAGRO	Main office	2026-02	scope2	Grid electricity (location-based)	\N	16835.0000	kWh	0.650000	10942.7500	10.942750	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-02_v1.csv	USR-CONTRIB-BANK	2026-03-08 00:00:00+02	USR-APPROVER-BANK	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202602	STANBANK	Head office	2026-02	scope1	Fleet fuel	Diesel	1528.8000	litres	2.680000	4097.1840	4.097184	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-02_v1.csv	STB-USR-3	2026-03-08 00:00:00+02	STB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202602	STANBANK	Head office	2026-02	scope2	Grid electricity (location-based)	\N	44408.0000	kWh	0.650000	28865.2000	28.865200	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-02_v1.csv	STB-USR-3	2026-03-08 00:00:00+02	STB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202602	STANWLTH	Main office	2026-02	scope1	Fleet fuel	Diesel	465.9200	litres	2.680000	1248.6656	1.248666	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-02_v1.csv	STB-USR-3	2026-03-08 00:00:00+02	STB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202602	STANWLTH	Main office	2026-02	scope2	Grid electricity (location-based)	\N	13468.0000	kWh	0.650000	8754.2000	8.754200	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-02_v1.csv	STB-USR-3	2026-03-08 00:00:00+02	STB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202602	FBCBANK	Head office	2026-02	scope1	Fleet fuel	Diesel	1242.1500	litres	2.680000	3328.9620	3.328962	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-02_v1.csv	FBB-USR-3	2026-03-08 00:00:00+02	FBB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202602	FBCBANK	Head office	2026-02	scope2	Grid electricity (location-based)	\N	36081.5000	kWh	0.650000	23452.9750	23.452975	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-02_v1.csv	FBB-USR-3	2026-03-08 00:00:00+02	FBB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202602	FBCINS	Main office	2026-02	scope1	Fleet fuel	Diesel	378.5600	litres	2.680000	1014.5408	1.014541	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-02_v1.csv	FBB-USR-3	2026-03-08 00:00:00+02	FBB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202602	FBCINS	Main office	2026-02	scope2	Grid electricity (location-based)	\N	10942.7500	kWh	0.650000	7112.7875	7.112788	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-02_v1.csv	FBB-USR-3	2026-03-08 00:00:00+02	FBB-USR-2	2026-03-13 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202603	CBZBANK	Head office	2026-03	scope1	Fleet fuel	Diesel	1953.5800	litres	2.680000	5235.5898	5.235590	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-03_v1.csv	USR-CONTRIB-BANK	2026-04-05 00:00:00+02	USR-APPROVER-BANK	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202603	CBZBANK	Head office	2026-03	scope2	Grid electricity (location-based)	\N	56746.8000	kWh	0.650000	36885.4183	36.885418	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-03_v1.csv	USR-CONTRIB-BANK	2026-04-05 00:00:00+02	USR-APPROVER-BANK	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202603	CBZAGRO	Main office	2026-03	scope1	Fleet fuel	Diesel	595.3800	litres	2.680000	1595.6083	1.595608	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-03_v1.csv	USR-CONTRIB-BANK	2026-04-05 00:00:00+02	USR-APPROVER-BANK	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202603	CBZAGRO	Main office	2026-03	scope2	Grid electricity (location-based)	\N	17210.0900	kWh	0.650000	11186.5613	11.186561	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-03_v1.csv	USR-CONTRIB-BANK	2026-04-05 00:00:00+02	USR-APPROVER-BANK	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202603	STANBANK	Head office	2026-03	scope1	Fleet fuel	Diesel	1562.8600	litres	2.680000	4188.4718	4.188472	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-03_v1.csv	STB-USR-3	2026-04-05 00:00:00+02	STB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202603	STANBANK	Head office	2026-03	scope2	Grid electricity (location-based)	\N	45397.4400	kWh	0.650000	29508.3347	29.508335	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-03_v1.csv	STB-USR-3	2026-04-05 00:00:00+02	STB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202603	STANWLTH	Main office	2026-03	scope1	Fleet fuel	Diesel	476.3000	litres	2.680000	1276.4866	1.276487	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-03_v1.csv	STB-USR-3	2026-04-05 00:00:00+02	STB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202603	STANWLTH	Main office	2026-03	scope2	Grid electricity (location-based)	\N	13768.0800	kWh	0.650000	8949.2490	8.949249	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-03_v1.csv	STB-USR-3	2026-04-05 00:00:00+02	STB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202603	FBCBANK	Head office	2026-03	scope1	Fleet fuel	Diesel	1269.8300	litres	2.680000	3403.1334	3.403133	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-03_v1.csv	FBB-USR-3	2026-04-05 00:00:00+02	FBB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202603	FBCBANK	Head office	2026-03	scope2	Grid electricity (location-based)	\N	36885.4200	kWh	0.650000	23975.5219	23.975522	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-03_v1.csv	FBB-USR-3	2026-04-05 00:00:00+02	FBB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202603	FBCINS	Main office	2026-03	scope1	Fleet fuel	Diesel	386.9900	litres	2.680000	1037.1454	1.037145	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-03_v1.csv	FBB-USR-3	2026-04-05 00:00:00+02	FBB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202603	FBCINS	Main office	2026-03	scope2	Grid electricity (location-based)	\N	11186.5600	kWh	0.650000	7271.2648	7.271265	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-03_v1.csv	FBB-USR-3	2026-04-05 00:00:00+02	FBB-USR-2	2026-04-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202604	CBZBANK	Head office	2026-04	scope1	Fleet fuel	Diesel	1961.8200	litres	2.680000	5257.6776	5.257678	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-04_v1.csv	USR-CONTRIB-BANK	2026-05-06 00:00:00+02	USR-APPROVER-BANK	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202604	CBZBANK	Head office	2026-04	scope2	Grid electricity (location-based)	\N	56986.2000	kWh	0.650000	37041.0300	37.041030	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-04_v1.csv	USR-CONTRIB-BANK	2026-05-06 00:00:00+02	USR-APPROVER-BANK	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202604	CBZAGRO	Main office	2026-04	scope1	Fleet fuel	Diesel	597.8900	litres	2.680000	1602.3398	1.602340	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-04_v1.csv	USR-CONTRIB-BANK	2026-05-06 00:00:00+02	USR-APPROVER-BANK	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202604	CBZAGRO	Main office	2026-04	scope2	Grid electricity (location-based)	\N	17282.7000	kWh	0.650000	11233.7550	11.233755	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-04_v1.csv	USR-CONTRIB-BANK	2026-05-06 00:00:00+02	USR-APPROVER-BANK	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202604	STANBANK	Head office	2026-04	scope1	Fleet fuel	Diesel	1569.4600	litres	2.680000	4206.1421	4.206142	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-04_v1.csv	STB-USR-3	2026-05-06 00:00:00+02	STB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202604	STANBANK	Head office	2026-04	scope2	Grid electricity (location-based)	\N	45588.9600	kWh	0.650000	29632.8240	29.632824	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-04_v1.csv	STB-USR-3	2026-05-06 00:00:00+02	STB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202604	STANWLTH	Main office	2026-04	scope1	Fleet fuel	Diesel	478.3100	litres	2.680000	1281.8719	1.281872	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-04_v1.csv	STB-USR-3	2026-05-06 00:00:00+02	STB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202604	STANWLTH	Main office	2026-04	scope2	Grid electricity (location-based)	\N	13826.1600	kWh	0.650000	8987.0040	8.987004	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-04_v1.csv	STB-USR-3	2026-05-06 00:00:00+02	STB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202604	FBCBANK	Head office	2026-04	scope1	Fleet fuel	Diesel	1275.1800	litres	2.680000	3417.4904	3.417490	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-04_v1.csv	FBB-USR-3	2026-05-06 00:00:00+02	FBB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202604	FBCBANK	Head office	2026-04	scope2	Grid electricity (location-based)	\N	37041.0300	kWh	0.650000	24076.6695	24.076670	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-04_v1.csv	FBB-USR-3	2026-05-06 00:00:00+02	FBB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202604	FBCINS	Main office	2026-04	scope1	Fleet fuel	Diesel	388.6300	litres	2.680000	1041.5209	1.041521	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-04_v1.csv	FBB-USR-3	2026-05-06 00:00:00+02	FBB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202604	FBCINS	Main office	2026-04	scope2	Grid electricity (location-based)	\N	11233.7600	kWh	0.650000	7301.9408	7.301941	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-04_v1.csv	FBB-USR-3	2026-05-06 00:00:00+02	FBB-USR-2	2026-05-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202605	CBZBANK	Head office	2026-05	scope1	Fleet fuel	Diesel	1931.1200	litres	2.680000	5175.4106	5.175411	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-05_v1.csv	USR-CONTRIB-BANK	2026-06-05 00:00:00+02	USR-APPROVER-BANK	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202605	CBZBANK	Head office	2026-05	scope2	Grid electricity (location-based)	\N	56094.5400	kWh	0.650000	36461.4480	36.461448	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-05_v1.csv	USR-CONTRIB-BANK	2026-06-05 00:00:00+02	USR-APPROVER-BANK	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202605	CBZAGRO	Main office	2026-05	scope1	Fleet fuel	Diesel	588.5300	litres	2.680000	1577.2680	1.577268	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-05_v1.csv	USR-CONTRIB-BANK	2026-06-05 00:00:00+02	USR-APPROVER-BANK	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202605	CBZAGRO	Main office	2026-05	scope2	Grid electricity (location-based)	\N	17012.2800	kWh	0.650000	11057.9801	11.057980	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-05_v1.csv	USR-CONTRIB-BANK	2026-06-05 00:00:00+02	USR-APPROVER-BANK	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202605	STANBANK	Head office	2026-05	scope1	Fleet fuel	Diesel	1544.9000	litres	2.680000	4140.3285	4.140328	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-05_v1.csv	STB-USR-3	2026-06-05 00:00:00+02	STB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202605	STANBANK	Head office	2026-05	scope2	Grid electricity (location-based)	\N	44875.6300	kWh	0.650000	29169.1584	29.169158	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-05_v1.csv	STB-USR-3	2026-06-05 00:00:00+02	STB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202605	STANWLTH	Main office	2026-05	scope1	Fleet fuel	Diesel	470.8300	litres	2.680000	1261.8144	1.261814	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-05_v1.csv	STB-USR-3	2026-06-05 00:00:00+02	STB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202605	STANWLTH	Main office	2026-05	scope2	Grid electricity (location-based)	\N	13609.8200	kWh	0.650000	8846.3841	8.846384	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-05_v1.csv	STB-USR-3	2026-06-05 00:00:00+02	STB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202605	FBCBANK	Head office	2026-05	scope1	Fleet fuel	Diesel	1255.2300	litres	2.680000	3364.0169	3.364017	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-05_v1.csv	FBB-USR-3	2026-06-05 00:00:00+02	FBB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202605	FBCBANK	Head office	2026-05	scope2	Grid electricity (location-based)	\N	36461.4500	kWh	0.650000	23699.9412	23.699941	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-05_v1.csv	FBB-USR-3	2026-06-05 00:00:00+02	FBB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202605	FBCINS	Main office	2026-05	scope1	Fleet fuel	Diesel	382.5500	litres	2.680000	1025.2242	1.025224	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-05_v1.csv	FBB-USR-3	2026-06-05 00:00:00+02	FBB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202605	FBCINS	Main office	2026-05	scope2	Grid electricity (location-based)	\N	11057.9800	kWh	0.650000	7187.6871	7.187687	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-05_v1.csv	FBB-USR-3	2026-06-05 00:00:00+02	FBB-USR-2	2026-06-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202606	CBZBANK	Head office	2026-06	scope1	Fleet fuel	Diesel	1867.3200	litres	2.680000	5004.4176	5.004418	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-06_v1.csv	USR-CONTRIB-BANK	2026-07-06 00:00:00+02	USR-APPROVER-BANK	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202606	CBZBANK	Head office	2026-06	scope2	Grid electricity (location-based)	\N	54241.2000	kWh	0.650000	35256.7800	35.256780	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-06_v1.csv	USR-CONTRIB-BANK	2026-07-06 00:00:00+02	USR-APPROVER-BANK	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202606	CBZAGRO	Main office	2026-06	scope1	Fleet fuel	Diesel	569.0900	litres	2.680000	1525.1558	1.525156	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-06_v1.csv	USR-CONTRIB-BANK	2026-07-06 00:00:00+02	USR-APPROVER-BANK	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202606	CBZAGRO	Main office	2026-06	scope2	Grid electricity (location-based)	\N	16450.2000	kWh	0.650000	10692.6300	10.692630	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-06_v1.csv	USR-CONTRIB-BANK	2026-07-06 00:00:00+02	USR-APPROVER-BANK	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202606	STANBANK	Head office	2026-06	scope1	Fleet fuel	Diesel	1493.8600	litres	2.680000	4003.5341	4.003534	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-06_v1.csv	STB-USR-3	2026-07-06 00:00:00+02	STB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202606	STANBANK	Head office	2026-06	scope2	Grid electricity (location-based)	\N	43392.9600	kWh	0.650000	28205.4240	28.205424	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-06_v1.csv	STB-USR-3	2026-07-06 00:00:00+02	STB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202606	STANWLTH	Main office	2026-06	scope1	Fleet fuel	Diesel	455.2700	litres	2.680000	1220.1247	1.220125	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-06_v1.csv	STB-USR-3	2026-07-06 00:00:00+02	STB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202606	STANWLTH	Main office	2026-06	scope2	Grid electricity (location-based)	\N	13160.1600	kWh	0.650000	8554.1040	8.554104	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-06_v1.csv	STB-USR-3	2026-07-06 00:00:00+02	STB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202606	FBCBANK	Head office	2026-06	scope1	Fleet fuel	Diesel	1213.7600	litres	2.680000	3252.8714	3.252871	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-06_v1.csv	FBB-USR-3	2026-07-06 00:00:00+02	FBB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202606	FBCBANK	Head office	2026-06	scope2	Grid electricity (location-based)	\N	35256.7800	kWh	0.650000	22916.9070	22.916907	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-06_v1.csv	FBB-USR-3	2026-07-06 00:00:00+02	FBB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202606	FBCINS	Main office	2026-06	scope1	Fleet fuel	Diesel	369.9100	litres	2.680000	991.3513	0.991351	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-06_v1.csv	FBB-USR-3	2026-07-06 00:00:00+02	FBB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202606	FBCINS	Main office	2026-06	scope2	Grid electricity (location-based)	\N	10692.6300	kWh	0.650000	6950.2095	6.950210	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-06_v1.csv	FBB-USR-3	2026-07-06 00:00:00+02	FBB-USR-2	2026-07-11 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-F-202607	CBZBANK	Head office	2026-07	scope1	Fleet fuel	Diesel	1785.0000	litres	2.680000	4783.8000	4.783800	activity-based	2	approved	CBZBANK_SCOPE1_HISTORY_2026-07_v1.csv	USR-CONTRIB-BANK	2026-08-05 00:00:00+02	USR-APPROVER-BANK	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E1-G-202607	CBZBANK	Head office	2026-07	scope2	Grid electricity (location-based)	\N	51850.0000	kWh	0.650000	33702.5000	33.702500	activity-based	2	approved	CBZBANK_SCOPE2_HISTORY_2026-07_v1.csv	USR-CONTRIB-BANK	2026-08-05 00:00:00+02	USR-APPROVER-BANK	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-F-202607	CBZAGRO	Main office	2026-07	scope1	Fleet fuel	Diesel	544.0000	litres	2.680000	1457.9200	1.457920	activity-based	2	approved	CBZAGRO_SCOPE1_HISTORY_2026-07_v1.csv	USR-CONTRIB-BANK	2026-08-05 00:00:00+02	USR-APPROVER-BANK	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
CBZ-H-E2-G-202607	CBZAGRO	Main office	2026-07	scope2	Grid electricity (location-based)	\N	15725.0000	kWh	0.650000	10221.2500	10.221250	activity-based	2	approved	CBZAGRO_SCOPE2_HISTORY_2026-07_v1.csv	USR-CONTRIB-BANK	2026-08-05 00:00:00+02	USR-APPROVER-BANK	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-F-202607	STANBANK	Head office	2026-07	scope1	Fleet fuel	Diesel	1428.0000	litres	2.680000	3827.0400	3.827040	activity-based	2	approved	STANBANK_SCOPE1_HISTORY_2026-07_v1.csv	STB-USR-3	2026-08-05 00:00:00+02	STB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E1-G-202607	STANBANK	Head office	2026-07	scope2	Grid electricity (location-based)	\N	41480.0000	kWh	0.650000	26962.0000	26.962000	activity-based	2	approved	STANBANK_SCOPE2_HISTORY_2026-07_v1.csv	STB-USR-3	2026-08-05 00:00:00+02	STB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-F-202607	STANWLTH	Main office	2026-07	scope1	Fleet fuel	Diesel	435.2000	litres	2.680000	1166.3360	1.166336	activity-based	2	approved	STANWLTH_SCOPE1_HISTORY_2026-07_v1.csv	STB-USR-3	2026-08-05 00:00:00+02	STB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
STB-H-E2-G-202607	STANWLTH	Main office	2026-07	scope2	Grid electricity (location-based)	\N	12580.0000	kWh	0.650000	8177.0000	8.177000	activity-based	2	approved	STANWLTH_SCOPE2_HISTORY_2026-07_v1.csv	STB-USR-3	2026-08-05 00:00:00+02	STB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-F-202607	FBCBANK	Head office	2026-07	scope1	Fleet fuel	Diesel	1160.2500	litres	2.680000	3109.4700	3.109470	activity-based	2	approved	FBCBANK_SCOPE1_HISTORY_2026-07_v1.csv	FBB-USR-3	2026-08-05 00:00:00+02	FBB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E1-G-202607	FBCBANK	Head office	2026-07	scope2	Grid electricity (location-based)	\N	33702.5000	kWh	0.650000	21906.6250	21.906625	activity-based	2	approved	FBCBANK_SCOPE2_HISTORY_2026-07_v1.csv	FBB-USR-3	2026-08-05 00:00:00+02	FBB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-F-202607	FBCINS	Main office	2026-07	scope1	Fleet fuel	Diesel	353.6000	litres	2.680000	947.6480	0.947648	activity-based	2	approved	FBCINS_SCOPE1_HISTORY_2026-07_v1.csv	FBB-USR-3	2026-08-05 00:00:00+02	FBB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
FBB-H-E2-G-202607	FBCINS	Main office	2026-07	scope2	Grid electricity (location-based)	\N	10221.2500	kWh	0.650000	6643.8125	6.643813	activity-based	2	approved	FBCINS_SCOPE2_HISTORY_2026-07_v1.csv	FBB-USR-3	2026-08-05 00:00:00+02	FBB-USR-2	2026-08-10 00:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	\N
\.


--
-- Data for Name: cbz_evidence; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_evidence (id, bank_id, entity_code, target_type, target_id, file_name, mime_type, size_bytes, sha256, content, description, uploaded_by, uploaded_at) FROM stdin;
2b2c3980-8479-40f6-bd25-189386a2259b	2	\N	EmissionRecord	\N	Fuel_card_statement_STANBANK_2026-08.pdf	application/pdf	1542	1211456b9db59fcad21a6b2b9f1bae26c84bf1f5257ad4ada5ffd59bef63e153	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820383931203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a284675656c20636172642073746174656d656e74202d205374616e6269632042616e6b205a696d62616277652c2041756775737420323032362920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a284163636f756e743a205374616e6269632043656e7472652c20486172617265202d20706f6f6c2076656869636c65732920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a28537570706c6965723a20486172617265204675656c204469737472696275746f7273205c2873796e7468657469635c292920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a282920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a2856656869636c652020202020446174652020202020202020204c6974726573202020204675656c2920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a2841425a203435313220202020323032362d30382d30342020203331322e30202020202044696573656c2920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a28414346203039323120202020323032362d30382d31312020203238382e35202020202044696573656c2920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a2841444b203737333020202020323032362d30382d31392020203330312e32202020202044696573656c2920546a0a45540a42540a2f46312031302e352054660a3530203635302054640a28414542203131383420202020323032362d30382d32372020203239362e38202020202044696573656c2920546a0a45540a42540a2f46312031302e352054660a3530203633342054640a282920546a0a45540a42540a2f46312031302e352054660a3530203631382054640a28546f74616c2064696573656c3a20312c3139382e35206c6974726573205c28737570706f7274732053636f7065203120666c656574206675656c207265636f72645c292920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313333380a2525454f460a	Fuel card statement, Aug 2026	Tatenda Mhlanga	2026-10-21 07:49:11.057+02
f598cc56-13fc-4de3-9eb9-4efa2b9f775f	2	\N	Disclosure	\N	Board_ESG_committee_minutes_2026-Q3.pdf	application/pdf	1450	04d0a8da3de481e7bb19cb93ea1d830139f5fc42b55029dd0c910cde49974dc4	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820373939203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a28426f6172642045534720636f6d6d6974746565202d206d696e757465732c20513320323032362920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a2850726573656e743a20426f6172642063686169722c2043524f2c2048656164206f66205375737461696e6162696c6974792c2043464f205c2873796e7468657469635c292920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a282920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a28312e20436c696d617465207269736b2061707065746974653a2066696e616e63656420656d697373696f6e7320696e74656e736974792077697468696e2061707065746974652920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a28322e20417070726f7665642032303330207461726765743a203330252063757420696e2053636f706520312b322076657273757320323032342920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a28332e204e6f7465642032206f70656e2045534720696e636964656e74733b20636f727265637469766520616374696f6e73206f6e20747261636b2920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a28342e20417070726f766564207075626c69636174696f6e206f6620746865204946525320533220646973636c6f7375726520666f7220323032352920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a282920546a0a45540a42540a2f46312031302e352054660a3530203635302054640a28537570706f727473204946525320533220706172612036205c28676f7665726e616e63655c29206e61727261746976652920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313234360a2525454f460a	Board ESG committee minutes Q3 2026	Tatenda Mhlanga	2026-10-21 07:49:13.882+02
2eaf30f8-573e-4147-9baa-38736a374a74	3	\N	EmissionRecord	\N	ZESA_electricity_bill_FBCBANK_2026-08.pdf	application/pdf	1347	beb6ca957c75b416d285b870afa0bd7772168158c5f5e5cefed5024e3c420c5f	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820363936203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a28456c65637472696369747920696e766f696365202d204642432043656e7472652c204861726172652c2041756775737420323032362920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a285574696c6974793a205a45544443205c2873796e74686574696320696e766f6963655c292920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a284d657465723a2030342d37373831322d4852452020205461726966663a20436f6d6d65726369616c2920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a282920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a284f70656e696e672072656164696e673a20312c3230342c353130206b57682920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a28436c6f73696e672072656164696e673a20312c3236352c363130206b57682920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a28436f6e73756d7074696f6e3a2036312c313030206b57682920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a282920546a0a45540a42540a2f46312031302e352054660a3530203635302054640a28537570706f7274732053636f70652032206772696420656c656374726963697479207265636f7264205c286c6f636174696f6e2d626173656420666163746f7220302e3635206b67434f32652f6b57685c292920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313134330a2525454f460a	Electricity invoice, Aug 2026	Simbarashe Marufu	2026-10-21 07:49:30.342+02
d622c0db-970c-46c9-acdd-a9a0a3a5829f	3	\N	Counterparty	\N	Green_bond_framework_ICMA_alignment.pdf	application/pdf	1451	dbd7060380d9842a4ac83f08a1ac75018e32f13c7c535e93a87dba8b178fe0a6	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820383030203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a28477265656e20626f6e64206672616d65776f726b202d2049434d4120477265656e20426f6e64205072696e6369706c657320616c69676e6d656e742920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a28557365206f662070726f63656564733a2072656e657761626c6520656e65726779205c28736f6c61722c20736d616c6c20687964726f5c292c20677265656e206275696c64696e67732920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a2850726f6365737320666f722070726f6a656374206576616c756174696f6e3a204553472063726564697420636f6d6d69747465652073637265656e696e672920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a284d616e6167656d656e74206f662070726f63656564733a2072696e672d66656e636564207375622d6163636f756e742c20717561727465726c79207265636f6e63696c696174696f6e2920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a285265706f7274696e673a20616e6e75616c20616c6c6f636174696f6e20616e6420696d70616374207265706f72742920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a282920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a2845787465726e616c207265766965773a207365636f6e642d7061727479206f70696e696f6e2070656e64696e67205c2873796e7468657469635c292920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a28537570706f727473207461786f6e6f6d79207461673a2049434d4120474250202f2052656e657761626c6520656e65726779202f20416c69676e65642920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313234370a2525454f460a	Green bond framework (ICMA GBP)	Simbarashe Marufu	2026-10-21 07:49:33.18+02
2405a470-64f9-4a5c-b0be-54e872deb9fd	1	\N	Counterparty	\N	Green_bond_framework_ICMA_alignment.pdf	application/pdf	1451	dbd7060380d9842a4ac83f08a1ac75018e32f13c7c535e93a87dba8b178fe0a6	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820383030203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a28477265656e20626f6e64206672616d65776f726b202d2049434d4120477265656e20426f6e64205072696e6369706c657320616c69676e6d656e742920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a28557365206f662070726f63656564733a2072656e657761626c6520656e65726779205c28736f6c61722c20736d616c6c20687964726f5c292c20677265656e206275696c64696e67732920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a2850726f6365737320666f722070726f6a656374206576616c756174696f6e3a204553472063726564697420636f6d6d69747465652073637265656e696e672920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a284d616e6167656d656e74206f662070726f63656564733a2072696e672d66656e636564207375622d6163636f756e742c20717561727465726c79207265636f6e63696c696174696f6e2920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a285265706f7274696e673a20616e6e75616c20616c6c6f636174696f6e20616e6420696d70616374207265706f72742920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a282920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a2845787465726e616c207265766965773a207365636f6e642d7061727479206f70696e696f6e2070656e64696e67205c2873796e7468657469635c292920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a28537570706f727473207461786f6e6f6d79207461673a2049434d4120474250202f2052656e657761626c6520656e65726779202f20416c69676e65642920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313234370a2525454f460a	Green bond framework (ICMA GBP)	Anesu Mutasa	2026-10-21 07:49:45.946+02
baf0cdd3-e2a2-452a-a398-35ddca9883a8	1	\N	Disclosure	\N	Board_ESG_committee_minutes_2026-Q3.pdf	application/pdf	1450	04d0a8da3de481e7bb19cb93ea1d830139f5fc42b55029dd0c910cde49974dc4	\\x255044462d312e340a312030206f626a0a3c3c202f54797065202f436174616c6f67202f5061676573203220302052203e3e0a656e646f626a0a322030206f626a0a3c3c202f54797065202f5061676573202f4b696473205b33203020525d202f436f756e742031203e3e0a656e646f626a0a332030206f626a0a3c3c202f54797065202f50616765202f506172656e74203220302052202f4d65646961426f78205b30203020353935203834325d202f5265736f7572636573203c3c202f466f6e74203c3c202f4631203420302052202f4632203520302052203e3e203e3e202f436f6e74656e7473203620302052203e3e0a656e646f626a0a342030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c766574696361203e3e0a656e646f626a0a352030206f626a0a3c3c202f54797065202f466f6e74202f53756274797065202f5479706531202f42617365466f6e74202f48656c7665746963612d426f6c64203e3e0a656e646f626a0a362030206f626a0a3c3c202f4c656e67746820373939203e3e0a73747265616d0a42540a2f46322031362054660a3530203739302054640a28426f6172642045534720636f6d6d6974746565202d206d696e757465732c20513320323032362920546a0a45540a42540a2f46312031302e352054660a3530203736322054640a2850726573656e743a20426f6172642063686169722c2043524f2c2048656164206f66205375737461696e6162696c6974792c2043464f205c2873796e7468657469635c292920546a0a45540a42540a2f46312031302e352054660a3530203734362054640a282920546a0a45540a42540a2f46312031302e352054660a3530203733302054640a28312e20436c696d617465207269736b2061707065746974653a2066696e616e63656420656d697373696f6e7320696e74656e736974792077697468696e2061707065746974652920546a0a45540a42540a2f46312031302e352054660a3530203731342054640a28322e20417070726f7665642032303330207461726765743a203330252063757420696e2053636f706520312b322076657273757320323032342920546a0a45540a42540a2f46312031302e352054660a3530203639382054640a28332e204e6f7465642032206f70656e2045534720696e636964656e74733b20636f727265637469766520616374696f6e73206f6e20747261636b2920546a0a45540a42540a2f46312031302e352054660a3530203638322054640a28342e20417070726f766564207075626c69636174696f6e206f6620746865204946525320533220646973636c6f7375726520666f7220323032352920546a0a45540a42540a2f46312031302e352054660a3530203636362054640a282920546a0a45540a42540a2f46312031302e352054660a3530203635302054640a28537570706f727473204946525320533220706172612036205c28676f7665726e616e63655c29206e61727261746976652920546a0a45540a42540a2f463120382054660a35302034302054640a2853594e544845544943205445535420444f43554d454e54202d204d417648552045534720706c6174666f726d2064656d6f2e204e6f742061207265616c207265636f72642e2920546a0a45540a656e6473747265616d0a656e646f626a0a787265660a3020370a303030303030303030302036353533352066200a30303030303030303039203030303030206e200a30303030303030303538203030303030206e200a30303030303030313135203030303030206e200a30303030303030323531203030303030206e200a30303030303030333231203030303030206e200a30303030303030333936203030303030206e200a747261696c65720a3c3c202f53697a652037202f526f6f74203120302052203e3e0a7374617274787265660a313234360a2525454f460a	Board ESG committee minutes Q3 2026	Anesu Mutasa	2026-10-21 07:49:48.78+02
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
FE-AGR-CBZ-CHIPINGE	AGR-CBZ-CHIPINGE	1330000.00	2026-Q3	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FE-AGR-FBB-MARONDERA	AGR-FBB-MARONDERA	1085000.00	2026-Q3	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FE-AGR-CBZ-MARONDERA	AGR-CBZ-MARONDERA	1820000.00	2026-Q3	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FE-AGR-CBZ-CHIREDZI	AGR-CBZ-CHIREDZI	3185000.00	2026-Q3	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FE-AGR-STB-NYANGA	AGR-STB-NYANGA	840000.00	2026-Q3	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
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
USR-PLATFORM-TAFADZWA	Tafadzwa Sibanda	tafadzwa.sibanda@cbz.co.zw	$2b$10$iug44mZTWsX.U094/0DBaezrQFaZ6DVYJGPshLSwBRFIT2B5cbHHe		CBZBANK	\N	auditor	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	t
USR-PLATFORM-NYASHA	Nyasha Dube	nyasha.dube@cbz.co.zw	$2b$10$sticoo.aRi5NwD7EPVMP2ex4cDhs3adJpD1Uk.TnZDij/Qby2RCee		CBZBANK	\N	approver	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	t
USR-PLATFORM-CHIPO	Chipo Mutasa	chipo.mutasa@cbz.co.zw	$2b$10$y/3Q9uUmhrtZmMSotTEpJuMU.fppMbgDXf/mOk3LZUQ.sKyRTsXFy		CBZBANK	\N	reader	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	t
\.


--
-- Data for Name: cbz_register_items; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_register_items (id, bank_id, register, entity_code, data, created_by, updated_by, created_at, updated_at) FROM stdin;
CBZ-TGT-2	1	targets	\N	{"name": "Portfolio PCAF data quality ≤ 3.0 by 2027", "unit": "score", "owner": "Tafara Chikwanha", "direction": "reduce", "framework": "PCAF Part A", "metricCode": "WEIGHTED_DQ", "targetYear": 2027, "targetValue": 3.0, "baselineYear": 2025, "baselineValue": 4.0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-TGT-3	1	targets	\N	{"name": "Women at least 45% of workforce by 2027", "unit": "%", "owner": "Head of HR", "direction": "increase", "framework": "GRI 405-1", "metricCode": "FEMALE_SHARE", "targetYear": 2027, "targetValue": 0.45, "baselineYear": 2025, "baselineValue": 0.42}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-APP-1	1	risk-appetite	\N	{"unit": "tCO2e per US$m", "limit": 400, "owner": "Chief Risk Officer", "metric": "Financed emissions intensity", "warning": 300, "direction": "max", "escalateTo": "Board Risk Committee", "metricCode": "FINANCED_INTENSITY"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-APP-2	1	risk-appetite	\N	{"unit": "% of outstanding", "limit": 0.25, "owner": "Chief Credit Officer", "metric": "Exposure to high transition-risk sectors", "warning": 0.15, "direction": "max", "escalateTo": "ALCO", "metricCode": "HIGH_TRANSITION_SHARE"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-APP-3	1	risk-appetite	\N	{"unit": "score", "limit": 4.0, "owner": "Head of Sustainability", "metric": "Portfolio weighted PCAF DQ score", "warning": 3.5, "direction": "max", "escalateTo": "Group ESG Committee", "metricCode": "WEIGHTED_DQ"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-ESC-1	1	escalations	\N	{"note": "MRV uplift on agri book agreed; DQ back within appetite", "limit": 4.0, "value": 4.1, "metric": "Portfolio weighted PCAF DQ score", "status": "Closed", "raisedAt": "2026-06-30", "raisedBy": "Tafara Chikwanha"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-ESC-2	1	escalations	\N	{"note": "Warning threshold crossed after mining exposure growth", "limit": 400, "value": 352, "metric": "Financed emissions intensity", "status": "Open", "raisedAt": "2026-09-15", "raisedBy": "Tafara Chikwanha"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-MAT-1	1	material-topics	\N	{"owner": "Chief Risk Officer", "topic": "Climate risk in the loan book", "pillar": "Environmental", "tnfdLeap": "Assess", "impactScore": 5, "frameworkRef": "IFRS S2; GRI 201-2", "stakeholders": "Regulator, investors", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-MAT-2	1	material-topics	\N	{"owner": "Head of Agribusiness", "topic": "Biodiversity and land use in agri lending", "pillar": "Environmental", "tnfdLeap": "Evaluate", "impactScore": 4, "frameworkRef": "TNFD; GRI 304", "stakeholders": "Communities, DFIs", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-MAT-3	1	material-topics	\N	{"owner": "Head of Retail", "topic": "Financial inclusion", "pillar": "Social", "tnfdLeap": "", "impactScore": 4, "frameworkRef": "GRI FS7; SDG 1, 5", "stakeholders": "Customers, RBZ", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-MAT-4	1	material-topics	\N	{"owner": "CISO", "topic": "Data privacy and cyber security", "pillar": "Governance", "tnfdLeap": "", "impactScore": 3, "frameworkRef": "GRI 418; SASB FN-CB-230a", "stakeholders": "Customers, regulator", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-STK-1	1	stakeholders	\N	{"name": "Reserve Bank of Zimbabwe", "group": "Regulator", "owner": "Head of Compliance", "contact": "Bank Supervision", "interest": 5, "influence": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-STK-2	1	stakeholders	\N	{"name": "DFI green credit line partner", "group": "Investor", "owner": "Treasurer", "contact": "Portfolio manager", "interest": 4, "influence": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-STK-3	1	stakeholders	\N	{"name": "Mutare farming community association", "group": "Community", "owner": "Head of Agribusiness", "contact": "Association chair", "interest": 4, "influence": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-ENG-1	1	engagements	\N	{"date": "2026-07-14", "owner": "Head of Compliance", "topics": "Climate risk guideline implementation", "channel": "Meeting", "outcome": "Agreed quarterly progress reporting", "followUp": "Submit Q3 progress pack", "stakeholder": "Reserve Bank of Zimbabwe"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-ENG-2	1	engagements	\N	{"date": "2026-08-22", "owner": "Head of Agribusiness", "topics": "Water use and irrigation loans", "channel": "Community forum", "outcome": "Borehole maintenance fund proposed", "followUp": "Feasibility note by October", "stakeholder": "Mutare farming community association"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-SUP-1	1	suppliers	\N	{"name": "Harare Fuel Distributors", "country": "Zimbabwe", "category": "Fleet fuel", "spendUsd": 420000, "socialRisk": 2, "esgScreened": true, "localSupplier": true, "governanceRisk": 2, "lastAssessment": "2026-05-30", "environmentalRisk": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-SUP-2	1	suppliers	\N	{"name": "Southern IT Solutions", "country": "South Africa", "category": "IT hardware", "spendUsd": 310000, "socialRisk": 3, "esgScreened": true, "localSupplier": false, "governanceRisk": 2, "lastAssessment": "2026-03-12", "environmentalRisk": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-SUP-3	1	suppliers	\N	{"name": "CleanPro Facilities", "country": "Zimbabwe", "category": "Cleaning & security", "spendUsd": 95000, "socialRisk": 4, "esgScreened": false, "localSupplier": true, "governanceRisk": 3, "lastAssessment": "2025-11-02", "environmentalRisk": 1}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-DEC-1	1	decarbonisation	CBZBANK	{"owner": "Facilities Manager", "status": "In progress", "dueDate": "2026-12-15", "milestone": "Commissioning", "programme": "Branch solarisation", "initiative": "Head office rooftop PV (250 kWp)", "expectedReductionTco2e": 180}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-DEC-2	1	decarbonisation	CBZBANK	{"owner": "Fleet Manager", "status": "Planned", "dueDate": "2027-03-31", "milestone": "Procurement approved", "programme": "Fleet transition", "initiative": "Replace 20 diesel pool cars with hybrids", "expectedReductionTco2e": 95}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-DEC-3	1	decarbonisation	CBZAGRO	{"owner": "Head of Digital", "status": "Done", "dueDate": "2026-06-30", "milestone": "Rolled out", "programme": "Paperless operations", "initiative": "Digital statements for all retail customers", "expectedReductionTco2e": 12}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-OWN-1	1	data-owners	CBZBANK	{"owner": "Facilities Manager", "dataset": "Scope 1 fleet fuel", "function": "Facilities", "frequency": "Monthly", "backupOwner": "Fleet Manager", "sourceSystem": "Fuel card portal"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-OWN-2	1	data-owners	CBZBANK	{"owner": "Tafara Chikwanha", "dataset": "Loan book (PCAF inputs)", "function": "Credit Risk", "frequency": "Quarterly", "backupOwner": "Credit Analyst", "sourceSystem": "Core banking"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-OWN-3	1	data-owners	CBZAGRO	{"owner": "Head of HR", "dataset": "Workforce metrics", "function": "Human Resources", "frequency": "Quarterly", "backupOwner": "HR Officer", "sourceSystem": "Payroll"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-COM-1	1	community-investment	CBZBANK	{"sdg": "SDG 4", "period": "2026-Q3", "location": "Harare", "spendUsd": 85000, "programme": "University bursaries (STEM)", "beneficiaries": 40, "volunteerHours": 120}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-COM-2	1	community-investment	CBZAGRO	{"sdg": "SDG 6", "period": "2026-Q2", "location": "Masvingo", "spendUsd": 42000, "programme": "Borehole drilling for rural schools", "beneficiaries": 1600, "volunteerHours": 60}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-RES-1	1	resource-use	CBZBANK	{"site": "Head office", "period": "2026-Q2", "waterM3": 2400, "wasteTonnes": 14.5, "dieselLitres": 6300, "recycledShare": 0.38, "electricityKwh": 183000}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-RES-2	1	resource-use	CBZBANK	{"site": "Head office", "period": "2026-Q3", "waterM3": 2250, "wasteTonnes": 13.8, "dieselLitres": 5900, "recycledShare": 0.42, "electricityKwh": 176000}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-RES-3	1	resource-use	CBZAGRO	{"site": "Main office", "period": "2026-Q3", "waterM3": 700, "wasteTonnes": 4.1, "dieselLitres": 1800, "recycledShare": 0.25, "electricityKwh": 54000}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-PRD-1	1	esg-products	CBZBANK	{"kpi": "MWh clean power generated", "type": "Sustainability-linked loan", "status": "On track", "product": "Sustainability-linked loan: solar IPP", "amountUsd": 2500000, "kpiActual": 19250, "kpiTarget": 18000, "counterparty": "Renewable energy borrower", "marginRatchetBps": -15}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-PRD-2	1	esg-products	CBZBANK	{"kpi": "Homes with solar + efficient geysers", "type": "Green retail loan", "status": "Off track", "product": "Green home improvement loan", "amountUsd": 900000, "kpiActual": 410, "kpiTarget": 600, "counterparty": "Retail customers", "marginRatchetBps": 0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-TGT-2	2	targets	\N	{"name": "Portfolio PCAF data quality ≤ 3.0 by 2027", "unit": "score", "owner": "Rumbidzai Ndlovu", "direction": "reduce", "framework": "PCAF Part A", "metricCode": "WEIGHTED_DQ", "targetYear": 2027, "targetValue": 3.0, "baselineYear": 2025, "baselineValue": 4.0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-TGT-3	2	targets	\N	{"name": "Women at least 45% of workforce by 2027", "unit": "%", "owner": "Head of HR", "direction": "increase", "framework": "GRI 405-1", "metricCode": "FEMALE_SHARE", "targetYear": 2027, "targetValue": 0.45, "baselineYear": 2025, "baselineValue": 0.42}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-APP-1	2	risk-appetite	\N	{"unit": "tCO2e per US$m", "limit": 400, "owner": "Chief Risk Officer", "metric": "Financed emissions intensity", "warning": 300, "direction": "max", "escalateTo": "Board Risk Committee", "metricCode": "FINANCED_INTENSITY"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-APP-2	2	risk-appetite	\N	{"unit": "% of outstanding", "limit": 0.25, "owner": "Chief Credit Officer", "metric": "Exposure to high transition-risk sectors", "warning": 0.15, "direction": "max", "escalateTo": "ALCO", "metricCode": "HIGH_TRANSITION_SHARE"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-APP-3	2	risk-appetite	\N	{"unit": "score", "limit": 4.0, "owner": "Head of Sustainability", "metric": "Portfolio weighted PCAF DQ score", "warning": 3.5, "direction": "max", "escalateTo": "Group ESG Committee", "metricCode": "WEIGHTED_DQ"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-ESC-1	2	escalations	\N	{"note": "MRV uplift on agri book agreed; DQ back within appetite", "limit": 4.0, "value": 4.1, "metric": "Portfolio weighted PCAF DQ score", "status": "Closed", "raisedAt": "2026-06-30", "raisedBy": "Rumbidzai Ndlovu"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-ESC-2	2	escalations	\N	{"note": "Warning threshold crossed after mining exposure growth", "limit": 400, "value": 352, "metric": "Financed emissions intensity", "status": "Open", "raisedAt": "2026-09-15", "raisedBy": "Rumbidzai Ndlovu"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-MAT-1	2	material-topics	\N	{"owner": "Chief Risk Officer", "topic": "Climate risk in the loan book", "pillar": "Environmental", "tnfdLeap": "Assess", "impactScore": 5, "frameworkRef": "IFRS S2; GRI 201-2", "stakeholders": "Regulator, investors", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-MAT-2	2	material-topics	\N	{"owner": "Head of Agribusiness", "topic": "Biodiversity and land use in agri lending", "pillar": "Environmental", "tnfdLeap": "Evaluate", "impactScore": 4, "frameworkRef": "TNFD; GRI 304", "stakeholders": "Communities, DFIs", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-MAT-3	2	material-topics	\N	{"owner": "Head of Retail", "topic": "Financial inclusion", "pillar": "Social", "tnfdLeap": "", "impactScore": 4, "frameworkRef": "GRI FS7; SDG 1, 5", "stakeholders": "Customers, RBZ", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-MAT-4	2	material-topics	\N	{"owner": "CISO", "topic": "Data privacy and cyber security", "pillar": "Governance", "tnfdLeap": "", "impactScore": 3, "frameworkRef": "GRI 418; SASB FN-CB-230a", "stakeholders": "Customers, regulator", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-STK-1	2	stakeholders	\N	{"name": "Reserve Bank of Zimbabwe", "group": "Regulator", "owner": "Head of Compliance", "contact": "Bank Supervision", "interest": 5, "influence": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-STK-2	2	stakeholders	\N	{"name": "DFI green credit line partner", "group": "Investor", "owner": "Treasurer", "contact": "Portfolio manager", "interest": 4, "influence": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-STK-3	2	stakeholders	\N	{"name": "Mutare farming community association", "group": "Community", "owner": "Head of Agribusiness", "contact": "Association chair", "interest": 4, "influence": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-ENG-1	2	engagements	\N	{"date": "2026-07-14", "owner": "Head of Compliance", "topics": "Climate risk guideline implementation", "channel": "Meeting", "outcome": "Agreed quarterly progress reporting", "followUp": "Submit Q3 progress pack", "stakeholder": "Reserve Bank of Zimbabwe"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-ENG-2	2	engagements	\N	{"date": "2026-08-22", "owner": "Head of Agribusiness", "topics": "Water use and irrigation loans", "channel": "Community forum", "outcome": "Borehole maintenance fund proposed", "followUp": "Feasibility note by October", "stakeholder": "Mutare farming community association"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-SUP-1	2	suppliers	\N	{"name": "Harare Fuel Distributors", "country": "Zimbabwe", "category": "Fleet fuel", "spendUsd": 420000, "socialRisk": 2, "esgScreened": true, "localSupplier": true, "governanceRisk": 2, "lastAssessment": "2026-05-30", "environmentalRisk": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-SUP-2	2	suppliers	\N	{"name": "Southern IT Solutions", "country": "South Africa", "category": "IT hardware", "spendUsd": 310000, "socialRisk": 3, "esgScreened": true, "localSupplier": false, "governanceRisk": 2, "lastAssessment": "2026-03-12", "environmentalRisk": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-SUP-3	2	suppliers	\N	{"name": "CleanPro Facilities", "country": "Zimbabwe", "category": "Cleaning & security", "spendUsd": 95000, "socialRisk": 4, "esgScreened": false, "localSupplier": true, "governanceRisk": 3, "lastAssessment": "2025-11-02", "environmentalRisk": 1}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-DEC-1	2	decarbonisation	STANBANK	{"owner": "Facilities Manager", "status": "In progress", "dueDate": "2026-12-15", "milestone": "Commissioning", "programme": "Branch solarisation", "initiative": "Head office rooftop PV (250 kWp)", "expectedReductionTco2e": 180}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-DEC-2	2	decarbonisation	STANBANK	{"owner": "Fleet Manager", "status": "Planned", "dueDate": "2027-03-31", "milestone": "Procurement approved", "programme": "Fleet transition", "initiative": "Replace 20 diesel pool cars with hybrids", "expectedReductionTco2e": 95}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-DEC-3	2	decarbonisation	STANWLTH	{"owner": "Head of Digital", "status": "Done", "dueDate": "2026-06-30", "milestone": "Rolled out", "programme": "Paperless operations", "initiative": "Digital statements for all retail customers", "expectedReductionTco2e": 12}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-OWN-1	2	data-owners	STANBANK	{"owner": "Facilities Manager", "dataset": "Scope 1 fleet fuel", "function": "Facilities", "frequency": "Monthly", "backupOwner": "Fleet Manager", "sourceSystem": "Fuel card portal"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-OWN-2	2	data-owners	STANBANK	{"owner": "Rumbidzai Ndlovu", "dataset": "Loan book (PCAF inputs)", "function": "Credit Risk", "frequency": "Quarterly", "backupOwner": "Credit Analyst", "sourceSystem": "Core banking"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-OWN-3	2	data-owners	STANWLTH	{"owner": "Head of HR", "dataset": "Workforce metrics", "function": "Human Resources", "frequency": "Quarterly", "backupOwner": "HR Officer", "sourceSystem": "Payroll"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-COM-1	2	community-investment	STANBANK	{"sdg": "SDG 4", "period": "2026-Q3", "location": "Harare", "spendUsd": 85000, "programme": "University bursaries (STEM)", "beneficiaries": 40, "volunteerHours": 120}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-COM-2	2	community-investment	STANWLTH	{"sdg": "SDG 6", "period": "2026-Q2", "location": "Masvingo", "spendUsd": 42000, "programme": "Borehole drilling for rural schools", "beneficiaries": 1600, "volunteerHours": 60}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-RES-1	2	resource-use	STANBANK	{"site": "Head office", "period": "2026-Q2", "waterM3": 1920, "wasteTonnes": 11.6, "dieselLitres": 5040, "recycledShare": 0.38, "electricityKwh": 146400}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-RES-2	2	resource-use	STANBANK	{"site": "Head office", "period": "2026-Q3", "waterM3": 1800, "wasteTonnes": 11.0, "dieselLitres": 4720, "recycledShare": 0.42, "electricityKwh": 140800}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-RES-3	2	resource-use	STANWLTH	{"site": "Main office", "period": "2026-Q3", "waterM3": 560, "wasteTonnes": 3.3, "dieselLitres": 1440, "recycledShare": 0.25, "electricityKwh": 43200}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-PRD-1	2	esg-products	STANBANK	{"kpi": "MWh clean power generated", "type": "Sustainability-linked loan", "status": "On track", "product": "Sustainability-linked loan: solar IPP", "amountUsd": 2000000, "kpiActual": 19250, "kpiTarget": 18000, "counterparty": "Renewable energy borrower", "marginRatchetBps": -15}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-PRD-2	2	esg-products	STANBANK	{"kpi": "Homes with solar + efficient geysers", "type": "Green retail loan", "status": "Off track", "product": "Green home improvement loan", "amountUsd": 720000, "kpiActual": 410, "kpiTarget": 600, "counterparty": "Retail customers", "marginRatchetBps": 0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-TGT-2	3	targets	\N	{"name": "Portfolio PCAF data quality ≤ 3.0 by 2027", "unit": "score", "owner": "Tsitsi Chinoda", "direction": "reduce", "framework": "PCAF Part A", "metricCode": "WEIGHTED_DQ", "targetYear": 2027, "targetValue": 3.0, "baselineYear": 2025, "baselineValue": 4.0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-TGT-3	3	targets	\N	{"name": "Women at least 45% of workforce by 2027", "unit": "%", "owner": "Head of HR", "direction": "increase", "framework": "GRI 405-1", "metricCode": "FEMALE_SHARE", "targetYear": 2027, "targetValue": 0.45, "baselineYear": 2025, "baselineValue": 0.42}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-APP-1	3	risk-appetite	\N	{"unit": "tCO2e per US$m", "limit": 400, "owner": "Chief Risk Officer", "metric": "Financed emissions intensity", "warning": 300, "direction": "max", "escalateTo": "Board Risk Committee", "metricCode": "FINANCED_INTENSITY"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-APP-2	3	risk-appetite	\N	{"unit": "% of outstanding", "limit": 0.25, "owner": "Chief Credit Officer", "metric": "Exposure to high transition-risk sectors", "warning": 0.15, "direction": "max", "escalateTo": "ALCO", "metricCode": "HIGH_TRANSITION_SHARE"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-APP-3	3	risk-appetite	\N	{"unit": "score", "limit": 4.0, "owner": "Head of Sustainability", "metric": "Portfolio weighted PCAF DQ score", "warning": 3.5, "direction": "max", "escalateTo": "Group ESG Committee", "metricCode": "WEIGHTED_DQ"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-ESC-1	3	escalations	\N	{"note": "MRV uplift on agri book agreed; DQ back within appetite", "limit": 4.0, "value": 4.1, "metric": "Portfolio weighted PCAF DQ score", "status": "Closed", "raisedAt": "2026-06-30", "raisedBy": "Tsitsi Chinoda"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-ESC-2	3	escalations	\N	{"note": "Warning threshold crossed after mining exposure growth", "limit": 400, "value": 352, "metric": "Financed emissions intensity", "status": "Open", "raisedAt": "2026-09-15", "raisedBy": "Tsitsi Chinoda"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-MAT-1	3	material-topics	\N	{"owner": "Chief Risk Officer", "topic": "Climate risk in the loan book", "pillar": "Environmental", "tnfdLeap": "Assess", "impactScore": 5, "frameworkRef": "IFRS S2; GRI 201-2", "stakeholders": "Regulator, investors", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-MAT-2	3	material-topics	\N	{"owner": "Head of Agribusiness", "topic": "Biodiversity and land use in agri lending", "pillar": "Environmental", "tnfdLeap": "Evaluate", "impactScore": 4, "frameworkRef": "TNFD; GRI 304", "stakeholders": "Communities, DFIs", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-MAT-3	3	material-topics	\N	{"owner": "Head of Retail", "topic": "Financial inclusion", "pillar": "Social", "tnfdLeap": "", "impactScore": 4, "frameworkRef": "GRI FS7; SDG 1, 5", "stakeholders": "Customers, RBZ", "financialScore": 3}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-MAT-4	3	material-topics	\N	{"owner": "CISO", "topic": "Data privacy and cyber security", "pillar": "Governance", "tnfdLeap": "", "impactScore": 3, "frameworkRef": "GRI 418; SASB FN-CB-230a", "stakeholders": "Customers, regulator", "financialScore": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-STK-1	3	stakeholders	\N	{"name": "Reserve Bank of Zimbabwe", "group": "Regulator", "owner": "Head of Compliance", "contact": "Bank Supervision", "interest": 5, "influence": 5}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-STK-2	3	stakeholders	\N	{"name": "DFI green credit line partner", "group": "Investor", "owner": "Treasurer", "contact": "Portfolio manager", "interest": 4, "influence": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-STK-3	3	stakeholders	\N	{"name": "Mutare farming community association", "group": "Community", "owner": "Head of Agribusiness", "contact": "Association chair", "interest": 4, "influence": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-ENG-1	3	engagements	\N	{"date": "2026-07-14", "owner": "Head of Compliance", "topics": "Climate risk guideline implementation", "channel": "Meeting", "outcome": "Agreed quarterly progress reporting", "followUp": "Submit Q3 progress pack", "stakeholder": "Reserve Bank of Zimbabwe"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-ENG-2	3	engagements	\N	{"date": "2026-08-22", "owner": "Head of Agribusiness", "topics": "Water use and irrigation loans", "channel": "Community forum", "outcome": "Borehole maintenance fund proposed", "followUp": "Feasibility note by October", "stakeholder": "Mutare farming community association"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-SUP-1	3	suppliers	\N	{"name": "Harare Fuel Distributors", "country": "Zimbabwe", "category": "Fleet fuel", "spendUsd": 420000, "socialRisk": 2, "esgScreened": true, "localSupplier": true, "governanceRisk": 2, "lastAssessment": "2026-05-30", "environmentalRisk": 4}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-SUP-2	3	suppliers	\N	{"name": "Southern IT Solutions", "country": "South Africa", "category": "IT hardware", "spendUsd": 310000, "socialRisk": 3, "esgScreened": true, "localSupplier": false, "governanceRisk": 2, "lastAssessment": "2026-03-12", "environmentalRisk": 2}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-SUP-3	3	suppliers	\N	{"name": "CleanPro Facilities", "country": "Zimbabwe", "category": "Cleaning & security", "spendUsd": 95000, "socialRisk": 4, "esgScreened": false, "localSupplier": true, "governanceRisk": 3, "lastAssessment": "2025-11-02", "environmentalRisk": 1}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-DEC-1	3	decarbonisation	FBCBANK	{"owner": "Facilities Manager", "status": "In progress", "dueDate": "2026-12-15", "milestone": "Commissioning", "programme": "Branch solarisation", "initiative": "Head office rooftop PV (250 kWp)", "expectedReductionTco2e": 180}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-DEC-2	3	decarbonisation	FBCBANK	{"owner": "Fleet Manager", "status": "Planned", "dueDate": "2027-03-31", "milestone": "Procurement approved", "programme": "Fleet transition", "initiative": "Replace 20 diesel pool cars with hybrids", "expectedReductionTco2e": 95}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-DEC-3	3	decarbonisation	FBCINS	{"owner": "Head of Digital", "status": "Done", "dueDate": "2026-06-30", "milestone": "Rolled out", "programme": "Paperless operations", "initiative": "Digital statements for all retail customers", "expectedReductionTco2e": 12}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-OWN-1	3	data-owners	FBCBANK	{"owner": "Facilities Manager", "dataset": "Scope 1 fleet fuel", "function": "Facilities", "frequency": "Monthly", "backupOwner": "Fleet Manager", "sourceSystem": "Fuel card portal"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-OWN-2	3	data-owners	FBCBANK	{"owner": "Tsitsi Chinoda", "dataset": "Loan book (PCAF inputs)", "function": "Credit Risk", "frequency": "Quarterly", "backupOwner": "Credit Analyst", "sourceSystem": "Core banking"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-OWN-3	3	data-owners	FBCINS	{"owner": "Head of HR", "dataset": "Workforce metrics", "function": "Human Resources", "frequency": "Quarterly", "backupOwner": "HR Officer", "sourceSystem": "Payroll"}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-COM-1	3	community-investment	FBCBANK	{"sdg": "SDG 4", "period": "2026-Q3", "location": "Harare", "spendUsd": 85000, "programme": "University bursaries (STEM)", "beneficiaries": 40, "volunteerHours": 120}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-COM-2	3	community-investment	FBCINS	{"sdg": "SDG 6", "period": "2026-Q2", "location": "Masvingo", "spendUsd": 42000, "programme": "Borehole drilling for rural schools", "beneficiaries": 1600, "volunteerHours": 60}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-RES-1	3	resource-use	FBCBANK	{"site": "Head office", "period": "2026-Q2", "waterM3": 1560, "wasteTonnes": 9.4, "dieselLitres": 4095, "recycledShare": 0.38, "electricityKwh": 118950}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-RES-2	3	resource-use	FBCBANK	{"site": "Head office", "period": "2026-Q3", "waterM3": 1463, "wasteTonnes": 9.0, "dieselLitres": 3835, "recycledShare": 0.42, "electricityKwh": 114400}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-RES-3	3	resource-use	FBCINS	{"site": "Main office", "period": "2026-Q3", "waterM3": 455, "wasteTonnes": 2.7, "dieselLitres": 1170, "recycledShare": 0.25, "electricityKwh": 35100}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-PRD-1	3	esg-products	FBCBANK	{"kpi": "MWh clean power generated", "type": "Sustainability-linked loan", "status": "On track", "product": "Sustainability-linked loan: solar IPP", "amountUsd": 1625000, "kpiActual": 19250, "kpiTarget": 18000, "counterparty": "Renewable energy borrower", "marginRatchetBps": -15}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-PRD-2	3	esg-products	FBCBANK	{"kpi": "Homes with solar + efficient geysers", "type": "Green retail loan", "status": "Off track", "product": "Green home improvement loan", "amountUsd": 585000, "kpiActual": 410, "kpiTarget": 600, "counterparty": "Retail customers", "marginRatchetBps": 0}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
CBZ-TGT-1	1	targets	\N	{"name": "Cut Scope 1+2 emissions 30% by 2030", "unit": "tCO2e", "owner": "Tafara Chikwanha", "direction": "reduce", "framework": "IFRS S2 §33-36", "metricCode": "SCOPE12_TCO2E", "targetYear": 2030, "targetValue": 482.5, "baselineYear": 2024, "baselineValue": 689.3, "targetIsRatio": true}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
STB-TGT-1	2	targets	\N	{"name": "Cut Scope 1+2 emissions 30% by 2030", "unit": "tCO2e", "owner": "Rumbidzai Ndlovu", "direction": "reduce", "framework": "IFRS S2 §33-36", "metricCode": "SCOPE12_TCO2E", "targetYear": 2030, "targetValue": 386.0, "baselineYear": 2024, "baselineValue": 551.4, "targetIsRatio": true}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
FBB-TGT-1	3	targets	\N	{"name": "Cut Scope 1+2 emissions 30% by 2030", "unit": "tCO2e", "owner": "Tsitsi Chinoda", "direction": "reduce", "framework": "IFRS S2 §33-36", "metricCode": "SCOPE12_TCO2E", "targetYear": 2030, "targetValue": 313.6, "baselineYear": 2024, "baselineValue": 448.0, "targetIsRatio": true}	Seed (synthetic demo data)	\N	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
\.


--
-- Data for Name: cbz_reporting_periods; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.cbz_reporting_periods (id, bank_id, period, status, locked_by, locked_at, created_at, updated_at) FROM stdin;
2	1	2026-Q4	open	\N	\N	2026-10-04 22:22:16.249842+02	2026-10-04 22:22:20.495499+02
4	1	2024-Q1	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
5	1	2024-Q2	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
6	1	2024-Q3	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
7	1	2024-Q4	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
8	2	2024-Q1	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
9	2	2024-Q2	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
10	2	2024-Q3	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
11	2	2024-Q4	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
12	3	2024-Q1	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
13	3	2024-Q2	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
14	3	2024-Q3	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
15	3	2024-Q4	locked	tendai.moyo@mavhu.africa	2025-03-31 17:00:00+02	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
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
1	6	1	7	Tea plucking 2024/25	2024-10-15 00:00:00+02	2025-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
2	6	1	7	Tea plucking 2025/26	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
3	7	2	8	Maize 2024/25	2024-10-15 00:00:00+02	2025-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
4	7	2	8	Maize 2025/26	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
5	8	3	16	Sugarcane ratoon 2024/25	2024-10-15 00:00:00+02	2025-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
6	8	3	16	Sugarcane ratoon 2025/26	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
7	9	4	18	Apples 2024/25	2024-10-15 00:00:00+02	2025-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
8	9	4	18	Apples 2025/26	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	Seeded by migration 006	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
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
1	Diesel	CO2	2.6800	1.0000	2.68 kg CO2 per litre of diesel burned (illustrative)	litre
2	Petrol	CO2	2.3100	1.0000	2.31 kg CO2 per litre of petrol burned (illustrative)	litre
3	Urea fertiliser	CO2e	1.8300	1.0000	1.83 kg CO2e per kg urea applied, incl. field N2O (illustrative)	kg
4	Ammonium nitrate	CO2e	3.4500	1.0000	3.45 kg CO2e per kg AN applied, incl. manufacture (illustrative)	kg
5	Grid electricity (Zimbabwe)	CO2	0.6500	1.0000	0.65 kg CO2 per kWh, location-based (illustrative)	kWh
\.


--
-- Data for Name: emissions_accounting; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.emissions_accounting (id, customer_id, estate_id, created_by, crop_cycle_id, emission_id, quantity, start_date, end_date, ton_co2e, scope, approved, approved_by, audit_trail, note, created_at, updated_at) FROM stdin;
1	6	1	7	2	1	27200.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	72.8960	1	t	14	Seeded by migration 006	seed-006:Diesel	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
2	6	1	7	2	3	80750.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	147.7725	1	t	14	Seeded by migration 006	seed-006:Urea fertiliser	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
3	6	1	7	2	5	119000.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	77.3500	2	f	\N	Seeded by migration 006	seed-006:Grid electricity (Zimbabwe)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
4	7	2	8	4	1	38400.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	102.9120	1	t	9	Seeded by migration 006	seed-006:Diesel	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
5	7	2	8	4	3	114000.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	208.6200	1	t	9	Seeded by migration 006	seed-006:Urea fertiliser	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
6	7	2	8	4	5	168000.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	109.2000	2	f	\N	Seeded by migration 006	seed-006:Grid electricity (Zimbabwe)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
7	8	3	16	6	1	67200.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	180.0960	1	t	15	Seeded by migration 006	seed-006:Diesel	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
8	8	3	16	6	3	199500.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	365.0850	1	t	15	Seeded by migration 006	seed-006:Urea fertiliser	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
9	8	3	16	6	5	294000.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	191.1000	2	f	\N	Seeded by migration 006	seed-006:Grid electricity (Zimbabwe)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
10	9	4	18	8	1	20480.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	54.8864	1	t	17	Seeded by migration 006	seed-006:Diesel	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
11	9	4	18	8	3	60800.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	111.2640	1	t	17	Seeded by migration 006	seed-006:Urea fertiliser	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
12	9	4	18	8	5	89600.0000	2025-10-15 00:00:00+02	2026-06-30 00:00:00+02	58.2400	2	f	\N	Seeded by migration 006	seed-006:Grid electricity (Zimbabwe)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
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
1	6	1	2024-01-15	0.620333000000000	0.480333000000000	0.700333000000000	0.060000000000000	0.115150000000000	-0.004850000000000	0.215150000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	21.6773	5.2026	12.6335	46.3651	39410.3313	56.5766	207.6361	176490.6725	215901.0038	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
2	7	2	2024-01-15	0.642820000000000	0.502820000000000	0.722820000000000	0.060000000000000	0.125269000000000	0.005269000000000	0.225269000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.1648	5.5596	13.5005	49.5467	59456.0745	58.4378	214.4669	257360.2841	316816.3586	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
3	8	3	2024-01-15	0.600333000000000	0.460333000000000	0.680333000000000	0.060000000000000	0.106150000000000	-0.013850000000000	0.206150000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.3977	4.8954	11.8878	43.6281	91619.1071	54.9212	201.5608	423277.6113	514896.7185	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
4	9	4	2024-01-15	0.600333000000000	0.460333000000000	0.680333000000000	0.060000000000000	0.106150000000000	-0.013850000000000	0.206150000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.3977	4.8954	11.8878	43.6281	27922.0136	54.9212	201.5608	128998.8911	156920.9047	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
5	6	1	2024-02-15	0.650667000000000	0.510667000000000	0.730667000000000	0.060000000000000	0.128800000000000	0.008800000000000	0.228800000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.6961	5.6871	13.8101	50.6829	43080.4797	59.0873	216.8503	184322.7700	227403.2497	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
6	7	2	2024-02-15	0.680667000000000	0.540667000000000	0.760667000000000	0.060000000000000	0.142300000000000	0.022300000000000	0.242300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.7854	6.1885	15.0277	55.1517	66182.0996	61.5704	225.9633	271155.9535	337338.0531	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
7	8	3	2024-02-15	0.644590000000000	0.504590000000000	0.724590000000000	0.060000000000000	0.126065000000000	0.006065000000000	0.226065000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.2841	5.5882	13.5700	49.8018	104583.6819	58.5843	215.0043	451509.1286	556092.8105	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
8	9	4	2024-02-15	0.587269000000000	0.447269000000000	0.667269000000000	0.060000000000000	0.100271000000000	-0.019729000000000	0.200271000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	19.5838	4.7001	11.4135	41.8874	26807.9333	53.8399	197.5923	126459.0920	153267.0253	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
9	6	1	2024-03-15	0.672962000000000	0.532962000000000	0.752962000000000	0.060000000000000	0.138833000000000	0.018833000000000	0.238833000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.2399	6.0576	14.7098	53.9851	45887.3374	60.9326	223.6227	190079.3248	235966.6622	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
10	7	2	2024-03-15	0.643487000000000	0.503487000000000	0.723487000000000	0.060000000000000	0.125569000000000	0.005569000000000	0.225569000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.2097	5.5703	13.5266	49.6427	59571.2908	58.4930	214.6694	257603.2968	317174.5877	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
11	8	3	2024-03-15	0.661000000000000	0.521000000000000	0.741000000000000	0.060000000000000	0.133450000000000	0.013450000000000	0.233450000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.4053	5.8573	14.2234	52.1999	109619.7019	59.9426	219.9892	461977.3870	571597.0889	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
12	9	4	2024-03-15	0.551000000000000	0.411000000000000	0.631000000000000	0.060000000000000	0.083950000000000	-0.036050000000000	0.183950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.4151	4.1796	10.1495	37.2488	23839.2569	50.8379	186.5750	119407.9891	143247.2460	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
13	6	1	2024-04-15	0.681333000000000	0.541333000000000	0.761333000000000	0.060000000000000	0.142600000000000	0.022600000000000	0.242600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.8329	6.1999	15.0554	55.2533	46965.3091	61.6256	226.1658	192240.9344	239206.2436	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
14	7	2	2024-04-15	0.541333000000000	0.401333000000000	0.621333000000000	0.060000000000000	0.079600000000000	-0.040400000000000	0.179600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	16.8596	4.0463	9.8258	36.0606	43272.7109	50.0378	183.6386	220366.2950	263639.0059	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
15	8	3	2024-04-15	0.645256000000000	0.505256000000000	0.725256000000000	0.060000000000000	0.126365000000000	0.006365000000000	0.226365000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.3291	5.5990	13.5962	49.8980	104785.8532	58.6395	215.2069	451934.4008	556720.2541	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
16	9	4	2024-04-15	0.501333000000000	0.361333000000000	0.581333000000000	0.060000000000000	0.061600000000000	-0.058400000000000	0.161600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	14.6608	3.5186	8.5443	31.3577	20068.9215	46.7270	171.4879	109752.2836	129821.2051	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
17	6	1	2024-05-15	0.673628000000000	0.533628000000000	0.753628000000000	0.060000000000000	0.139133000000000	0.019133000000000	0.239133000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.2869	6.0689	14.7372	54.0855	45972.6984	60.9878	223.8252	190251.4588	236224.1573	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
18	7	2	2024-05-15	0.401667000000000	0.261667000000000	0.481667000000000	0.060000000000000	0.016750000000000	-0.103250000000000	0.116750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	9.8772	2.3705	5.7564	21.1261	25351.2965	38.4776	141.2126	169455.1302	194806.4267	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
19	8	3	2024-05-15	0.601667000000000	0.461667000000000	0.681667000000000	0.060000000000000	0.106750000000000	-0.013250000000000	0.206750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.4817	4.9156	11.9368	43.8079	91996.5839	55.0316	201.9658	424128.1559	516124.7398	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
20	9	4	2024-05-15	0.451667000000000	0.311667000000000	0.531667000000000	0.060000000000000	0.039250000000000	-0.080750000000000	0.139250000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.1537	2.9169	7.0832	25.9952	16636.9560	42.6161	156.4009	100096.5782	116733.5342	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
21	6	1	2024-06-15	0.652000000000000	0.512000000000000	0.732000000000000	0.060000000000000	0.129400000000000	0.009400000000000	0.229400000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.7869	5.7089	13.8630	50.8773	43245.7349	59.1976	217.2553	184667.0380	227912.7728	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
22	7	2	2024-06-15	0.262000000000000	0.122000000000000	0.342000000000000	0.060000000000000	-0.046100000000000	-0.166100000000000	0.053900000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	4.8119	1.1549	2.8044	10.2921	12350.5743	26.9173	98.7866	118543.9654	130894.5397	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
23	8	3	2024-06-15	0.542000000000000	0.402000000000000	0.622000000000000	0.060000000000000	0.079900000000000	-0.040100000000000	0.179900000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	16.8976	4.0554	9.8479	36.1419	75897.9748	50.0929	183.8411	386066.2886	461964.2634	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
24	9	4	2024-06-15	0.415397000000000	0.275397000000000	0.495397000000000	0.060000000000000	0.022929000000000	-0.097071000000000	0.122929000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.4778	2.5147	6.1064	22.4106	14342.8015	39.6140	145.3836	93045.4753	107388.2768	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
25	6	1	2024-07-15	0.622333000000000	0.482333000000000	0.702333000000000	0.060000000000000	0.116050000000000	-0.003950000000000	0.216050000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	21.8075	5.2338	12.7094	46.6436	39647.0520	56.7421	208.2436	177007.0745	216654.1266	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
26	7	2	2024-07-15	0.159846000000000	0.019846000000000	0.239846000000000	0.060000000000000	-0.092069000000000	-0.212069000000000	0.007931000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.2841	0.5482	1.3312	4.8855	5862.6150	18.4621	67.7558	81306.9636	87169.5786	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
27	8	3	2024-07-15	0.482333000000000	0.342333000000000	0.562333000000000	0.060000000000000	0.053050000000000	-0.066950000000000	0.153050000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	13.6726	3.2814	7.9684	29.2441	61412.5907	45.1543	165.7164	348004.4213	409417.0120	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
28	9	4	2024-07-15	0.402333000000000	0.262333000000000	0.482333000000000	0.060000000000000	0.017050000000000	-0.102950000000000	0.117050000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	9.9059	2.3774	5.7732	21.1875	13560.0203	38.5327	141.4151	90505.6762	104065.6965	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
29	6	1	2024-08-15	0.592667000000000	0.452667000000000	0.672667000000000	0.060000000000000	0.102700000000000	-0.017300000000000	0.202700000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	19.9180	4.7803	11.6082	42.6021	36211.7752	54.2866	199.2319	169347.1111	205558.8863	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
30	7	2	2024-08-15	0.122667000000000	-0.017333000000000	0.202667000000000	0.060000000000000	-0.108800000000000	-0.228800000000000	-0.008800000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	1.6036	0.3849	0.9346	3.4300	4115.9985	15.3847	56.4619	67754.3069	71870.3054	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
31	8	3	2024-08-15	0.438744000000000	0.298744000000000	0.518744000000000	0.060000000000000	0.033435000000000	-0.086565000000000	0.133435000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.5416	2.7700	6.7264	24.6861	51840.7398	41.5464	152.4753	320198.1763	372038.9161	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
32	9	4	2024-08-15	0.416064000000000	0.276064000000000	0.496064000000000	0.060000000000000	0.023229000000000	-0.096771000000000	0.123229000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.5074	2.5218	6.1237	22.4740	14383.3644	39.6692	145.5861	93175.0821	107558.4465	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
33	6	1	2024-09-15	0.571038000000000	0.431038000000000	0.651038000000000	0.060000000000000	0.092967000000000	-0.027033000000000	0.192967000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.5969	4.4632	10.8382	39.7764	33809.9079	52.4965	192.6620	163762.6902	197572.5982	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
34	7	2	2024-09-15	0.160513000000000	0.020513000000000	0.240513000000000	0.060000000000000	-0.091769000000000	-0.211769000000000	0.008231000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.2975	0.5514	1.3390	4.9141	5896.8879	18.5173	67.9583	81549.9763	87446.8641	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
35	8	3	2024-09-15	0.423000000000000	0.283000000000000	0.503000000000000	0.060000000000000	0.026350000000000	-0.093650000000000	0.126350000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.8183	2.5964	6.3049	23.1390	48591.8181	40.2433	147.6929	310155.1902	358747.0083	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
36	9	4	2024-09-15	0.453000000000000	0.313000000000000	0.533000000000000	0.060000000000000	0.039850000000000	-0.080150000000000	0.139850000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.2178	2.9323	7.1205	26.1323	16724.6947	42.7264	156.8059	100355.7918	117080.4865	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
37	6	1	2024-10-15	0.563333000000000	0.423333000000000	0.643333000000000	0.060000000000000	0.089500000000000	-0.030500000000000	0.189500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.1377	4.3530	10.5706	38.7942	32975.0699	51.8587	190.3214	161773.2146	194748.2846	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
38	7	2	2024-10-15	0.263333000000000	0.123333000000000	0.343333000000000	0.060000000000000	-0.045500000000000	-0.165500000000000	0.054500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	4.8514	1.1643	2.8274	10.3766	12451.9070	27.0277	99.1917	119029.9908	131481.8978	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
39	8	3	2024-10-15	0.439410000000000	0.299410000000000	0.519410000000000	0.060000000000000	0.033735000000000	-0.086265000000000	0.133735000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.5728	2.7775	6.7446	24.7527	51980.7480	41.6016	152.6778	320623.4486	372604.1965	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
40	9	4	2024-10-15	0.503333000000000	0.363333000000000	0.583333000000000	0.060000000000000	0.062500000000000	-0.057500000000000	0.162500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	14.7669	3.5441	8.6062	31.5847	20214.1892	46.8925	172.0955	110141.1040	130355.2932	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
41	6	1	2024-11-15	0.571705000000000	0.431705000000000	0.651705000000000	0.060000000000000	0.093267000000000	-0.026733000000000	0.193267000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.6369	4.4728	10.8616	39.8619	33882.6541	52.5516	192.8645	163934.8243	197817.4783	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
42	7	2	2024-11-15	0.403667000000000	0.263667000000000	0.483667000000000	0.060000000000000	0.017650000000000	-0.102350000000000	0.117650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	9.9635	2.3912	5.8067	21.3107	25572.8577	38.6431	141.8201	170184.1684	195757.0261	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
43	8	3	2024-11-15	0.483667000000000	0.343667000000000	0.563667000000000	0.060000000000000	0.053650000000000	-0.066350000000000	0.153650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	13.7408	3.2978	8.0081	29.3899	61718.7783	45.2647	166.1214	348854.9658	410573.7442	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
44	9	4	2024-11-15	0.553667000000000	0.413667000000000	0.633667000000000	0.060000000000000	0.085150000000000	-0.034850000000000	0.185150000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.5701	4.2168	10.2398	37.5802	24051.3174	51.0586	187.3850	119926.4162	143977.7336	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
45	6	1	2024-12-15	0.594000000000000	0.454000000000000	0.674000000000000	0.060000000000000	0.103300000000000	-0.016700000000000	0.203300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.0010	4.8002	11.6566	42.7796	36362.6724	54.3970	199.6369	169691.3791	206054.0516	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
46	7	2	2024-12-15	0.544000000000000	0.404000000000000	0.624000000000000	0.060000000000000	0.080800000000000	-0.039200000000000	0.180800000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.0119	4.0829	9.9145	36.3864	43663.6432	50.2585	184.4486	221338.3459	265001.9891	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
47	8	3	2024-12-15	0.544000000000000	0.404000000000000	0.624000000000000	0.060000000000000	0.080800000000000	-0.039200000000000	0.180800000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.0119	4.0829	9.9145	36.3864	76411.3756	50.2585	184.4486	387342.1054	463753.4810	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
48	9	4	2024-12-15	0.590603000000000	0.450603000000000	0.670603000000000	0.060000000000000	0.101771000000000	-0.018229000000000	0.201771000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	19.7898	4.7496	11.5335	42.3280	27089.9353	54.1158	198.6049	127107.1259	154197.0612	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
49	6	1	2025-01-15	0.624333000000000	0.484333000000000	0.704333000000000	0.060000000000000	0.116950000000000	-0.003050000000000	0.216950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	21.9381	5.2652	12.7855	46.9230	39884.5154	56.9077	208.8511	177523.4766	217407.9920	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
50	7	2	2025-01-15	0.646820000000000	0.506820000000000	0.726820000000000	0.060000000000000	0.127069000000000	0.007069000000000	0.227069000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.4349	5.6244	13.6578	50.1243	60149.1254	58.7689	215.6820	258818.3604	318967.4859	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
51	8	3	2025-01-15	0.604333000000000	0.464333000000000	0.684333000000000	0.060000000000000	0.107950000000000	-0.012050000000000	0.207950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.6504	4.9561	12.0350	44.1686	92753.9768	55.2523	202.7758	425829.2449	518583.2217	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
52	9	4	2025-01-15	0.604333000000000	0.464333000000000	0.684333000000000	0.060000000000000	0.107950000000000	-0.012050000000000	0.207950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.6504	4.9561	12.0350	44.1686	28267.8786	55.2523	202.7758	129776.5318	158044.4104	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
53	6	1	2025-02-15	0.654667000000000	0.514667000000000	0.734667000000000	0.060000000000000	0.130600000000000	0.010600000000000	0.230600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.9693	5.7526	13.9693	51.2673	43577.2395	59.4184	218.0654	185355.5740	228932.8135	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
54	7	2	2025-02-15	0.684667000000000	0.544667000000000	0.764667000000000	0.060000000000000	0.144100000000000	0.024100000000000	0.244100000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	26.0710	6.2570	15.1942	55.7625	66915.0590	61.9015	227.1784	272614.0298	339529.0888	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
55	8	3	2025-02-15	0.648590000000000	0.508590000000000	0.728590000000000	0.060000000000000	0.127865000000000	0.007865000000000	0.227865000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.5548	5.6532	13.7278	50.3808	105799.7780	58.9154	216.2194	454060.7621	559860.5402	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
56	9	4	2025-02-15	0.591269000000000	0.451269000000000	0.671269000000000	0.060000000000000	0.102071000000000	-0.017929000000000	0.202071000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	19.8312	4.7595	11.5576	42.4164	27146.5212	54.1710	198.8074	127236.7327	154383.2539	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
57	6	1	2025-03-15	0.676962000000000	0.536962000000000	0.756962000000000	0.060000000000000	0.140633000000000	0.020633000000000	0.240633000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.5223	6.1254	14.8744	54.5891	46400.7502	61.2637	224.8378	191112.1289	237512.8790	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
58	7	2	2025-03-15	0.647487000000000	0.507487000000000	0.727487000000000	0.060000000000000	0.127369000000000	0.007369000000000	0.227369000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.4800	5.6352	13.6842	50.2209	60265.0430	58.8241	215.8845	259061.3732	319326.4162	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
59	8	3	2025-03-15	0.665000000000000	0.525000000000000	0.745000000000000	0.060000000000000	0.135250000000000	0.015250000000000	0.235250000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.6828	5.9239	14.3851	52.7934	110866.0445	60.2737	221.2043	464529.0206	575395.0650	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
60	9	4	2025-03-15	0.555000000000000	0.415000000000000	0.635000000000000	0.060000000000000	0.085750000000000	-0.034250000000000	0.185750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.6478	4.2355	10.2851	37.7464	24157.7166	51.1690	187.7900	120185.6298	144343.3464	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
61	6	1	2025-04-15	0.685333000000000	0.545333000000000	0.765333000000000	0.060000000000000	0.144400000000000	0.024400000000000	0.244400000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	26.1187	6.2685	15.2220	55.8647	47484.9879	61.9566	227.3809	193273.7385	240758.7264	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
62	7	2	2025-04-15	0.545333000000000	0.405333000000000	0.625333000000000	0.060000000000000	0.081400000000000	-0.038600000000000	0.181400000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.0883	4.1012	9.9591	36.5498	43859.8001	50.3688	184.8536	221824.3714	265684.1715	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
63	8	3	2025-04-15	0.649256000000000	0.509256000000000	0.729256000000000	0.060000000000000	0.128165000000000	0.008165000000000	0.228165000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.6001	5.6640	13.7541	50.4777	106003.1768	58.9706	216.4219	454486.0344	560489.2112	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
64	9	4	2025-04-15	0.505333000000000	0.365333000000000	0.585333000000000	0.060000000000000	0.063400000000000	-0.056600000000000	0.163400000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	14.8735	3.5696	8.6683	31.8125	20360.0059	47.0580	172.7030	110529.9244	130889.9302	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
65	6	1	2025-05-15	0.677628000000000	0.537628000000000	0.757628000000000	0.060000000000000	0.140933000000000	0.020933000000000	0.240933000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.5696	6.1367	14.9019	54.6901	46486.6099	61.3189	225.0403	191284.2629	237770.8728	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
66	7	2	2025-05-15	0.405667000000000	0.265667000000000	0.485667000000000	0.060000000000000	0.018550000000000	-0.101450000000000	0.118550000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.0502	2.4121	5.8573	21.4962	25795.4290	38.8086	142.4277	170913.2065	196708.6355	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
67	8	3	2025-05-15	0.605667000000000	0.465667000000000	0.685667000000000	0.060000000000000	0.108550000000000	-0.011450000000000	0.208550000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.7349	4.9764	12.0843	44.3495	93133.8932	55.3626	203.1809	426679.7894	519813.6826	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
68	9	4	2025-05-15	0.455667000000000	0.315667000000000	0.535667000000000	0.060000000000000	0.041050000000000	-0.078950000000000	0.141050000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.3465	2.9632	7.1955	26.4077	16900.8974	42.9471	157.6160	100874.2189	117775.1164	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
69	6	1	2025-06-15	0.656000000000000	0.516000000000000	0.736000000000000	0.060000000000000	0.131200000000000	0.011200000000000	0.231200000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.0607	5.7746	14.0226	51.4629	43743.4892	59.5287	218.4704	185699.8420	229443.3312	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
70	7	2	2025-06-15	0.266000000000000	0.126000000000000	0.346000000000000	0.060000000000000	-0.044300000000000	-0.164300000000000	0.055700000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	4.9309	1.1834	2.8737	10.5466	12655.8739	27.2484	100.0017	120002.0417	132657.9156	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
71	8	3	2025-06-15	0.546000000000000	0.406000000000000	0.626000000000000	0.060000000000000	0.081700000000000	-0.038300000000000	0.181700000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.1266	4.1104	9.9814	36.6317	76926.5897	50.4240	185.0562	388617.9221	465544.5118	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
72	9	4	2025-06-15	0.419397000000000	0.279397000000000	0.499397000000000	0.060000000000000	0.024729000000000	-0.095271000000000	0.124729000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.6562	2.5575	6.2104	22.7923	14587.0795	39.9451	146.5986	93823.1160	108410.1955	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
73	6	1	2025-07-15	0.626333000000000	0.486333000000000	0.706333000000000	0.060000000000000	0.117850000000000	-0.002150000000000	0.217850000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	22.0692	5.2966	12.8619	47.2032	40122.7217	57.0732	209.4587	178039.8786	218162.6003	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
74	7	2	2025-07-15	0.163846000000000	0.023846000000000	0.243846000000000	0.060000000000000	-0.090269000000000	-0.210269000000000	0.009731000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.3649	0.5676	1.3783	5.0582	6069.8225	18.7932	68.9709	82765.0399	88834.8624	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
75	8	3	2025-07-15	0.486333000000000	0.346333000000000	0.566333000000000	0.060000000000000	0.054850000000000	-0.065150000000000	0.154850000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	13.8777	3.3306	8.0879	29.6826	62333.5470	45.4854	166.9315	350556.0549	412889.6019	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
76	9	4	2025-07-15	0.406333000000000	0.266333000000000	0.486333000000000	0.060000000000000	0.018850000000000	-0.101150000000000	0.118850000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.0792	2.4190	5.8742	21.5582	13797.2501	38.8638	142.6302	91283.3169	105080.5670	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
77	6	1	2025-08-15	0.596667000000000	0.456667000000000	0.676667000000000	0.060000000000000	0.104500000000000	-0.015500000000000	0.204500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.1675	4.8402	11.7536	43.1358	36665.4531	54.6177	200.4470	170379.9152	207045.3682	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
78	7	2	2025-08-15	0.126667000000000	-0.013333000000000	0.206667000000000	0.060000000000000	-0.107000000000000	-0.227000000000000	-0.007000000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	1.6708	0.4010	0.9738	3.5737	4288.4489	15.7158	57.6770	69212.3832	73500.8321	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
79	8	3	2025-08-15	0.442744000000000	0.302744000000000	0.522744000000000	0.060000000000000	0.035235000000000	-0.084765000000000	0.135235000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.7293	2.8150	6.8358	25.0875	52683.7564	41.8775	153.6904	322749.8099	375433.5663	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
80	9	4	2025-08-15	0.420064000000000	0.280064000000000	0.500064000000000	0.060000000000000	0.025029000000000	-0.094971000000000	0.125029000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.6861	2.5647	6.2279	22.8563	14628.0026	40.0003	146.8011	93952.7228	108580.7254	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
81	6	1	2025-09-15	0.575038000000000	0.435038000000000	0.655038000000000	0.060000000000000	0.094767000000000	-0.025233000000000	0.194767000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.8376	4.5210	10.9786	40.2913	34247.6134	52.8275	193.8771	164795.4943	199043.1078	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
82	7	2	2025-09-15	0.164513000000000	0.024513000000000	0.244513000000000	0.060000000000000	-0.089969000000000	-0.209969000000000	0.010031000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.3785	0.5708	1.3862	5.0873	6104.7237	18.8483	69.1734	83008.0526	89112.7763	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
83	8	3	2025-09-15	0.427000000000000	0.287000000000000	0.507000000000000	0.060000000000000	0.028150000000000	-0.091850000000000	0.128150000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.9997	2.6399	6.4106	23.5271	49406.8419	40.5744	148.9080	312706.8237	362113.6656	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
84	9	4	2025-09-15	0.457000000000000	0.317000000000000	0.537000000000000	0.060000000000000	0.041650000000000	-0.078350000000000	0.141650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.4111	2.9787	7.2332	26.5459	16989.3616	43.0575	158.0210	101133.4325	118122.7941	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
85	6	1	2025-10-15	0.567333000000000	0.427333000000000	0.647333000000000	0.060000000000000	0.091300000000000	-0.028700000000000	0.191300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.3753	4.4101	10.7091	39.3025	33407.0979	52.1898	191.5365	162806.0187	196213.1166	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
86	7	2	2025-10-15	0.267333000000000	0.127333000000000	0.347333000000000	0.060000000000000	-0.043700000000000	-0.163700000000000	0.056300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	4.9709	1.1930	2.8970	10.6321	12758.5085	27.3588	100.4067	120488.0671	133246.5756	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
87	8	3	2025-10-15	0.443410000000000	0.303410000000000	0.523410000000000	0.060000000000000	0.035535000000000	-0.084465000000000	0.135535000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.7607	2.8226	6.8542	25.1547	52824.9518	41.9327	153.8929	323175.0821	376000.0340	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
88	9	4	2025-10-15	0.507333000000000	0.367333000000000	0.587333000000000	0.060000000000000	0.064300000000000	-0.055700000000000	0.164300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	14.9804	3.5953	8.7306	32.0412	20506.3716	47.2236	173.3105	110918.7447	131425.1163	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
89	6	1	2025-11-15	0.575705000000000	0.435705000000000	0.655705000000000	0.060000000000000	0.095067000000000	-0.024933000000000	0.195067000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	18.8779	4.5307	11.0020	40.3775	34320.8511	52.8827	194.0796	164967.6283	199288.4794	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
90	7	2	2025-11-15	0.407667000000000	0.267667000000000	0.487667000000000	0.060000000000000	0.019450000000000	-0.100550000000000	0.119450000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.1373	2.4330	5.9080	21.6825	26019.0108	38.9742	143.0352	171642.2447	197661.2555	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
91	8	3	2025-11-15	0.487667000000000	0.347667000000000	0.567667000000000	0.060000000000000	0.055450000000000	-0.064550000000000	0.155450000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	13.9464	3.3471	8.1280	29.8296	62642.1285	45.5958	167.3365	351406.5994	414048.7279	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
92	9	4	2025-11-15	0.557667000000000	0.417667000000000	0.637667000000000	0.060000000000000	0.086950000000000	-0.033050000000000	0.186950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.8038	4.2729	10.3760	38.0801	24371.2532	51.3897	188.6001	120704.0569	145075.3101	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
93	6	1	2025-12-15	0.598000000000000	0.458000000000000	0.678000000000000	0.060000000000000	0.105100000000000	-0.014900000000000	0.205100000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.2511	4.8603	11.8023	43.3145	36817.3366	54.7281	200.8520	170724.1832	207541.5198	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
94	7	2	2025-12-15	0.548000000000000	0.408000000000000	0.628000000000000	0.060000000000000	0.082600000000000	-0.037400000000000	0.182600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.2417	4.1380	10.0485	36.8779	44253.4958	50.5896	185.6637	222796.4222	267049.9180	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
95	8	3	2025-12-15	0.548000000000000	0.408000000000000	0.628000000000000	0.060000000000000	0.082600000000000	-0.037400000000000	0.182600000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.2417	4.1380	10.0485	36.8779	77443.6176	50.5896	185.6637	389893.7389	467337.3565	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
96	9	4	2025-12-15	0.594603000000000	0.454603000000000	0.674603000000000	0.060000000000000	0.103571000000000	-0.016429000000000	0.203571000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.0385	4.8093	11.6785	42.8600	27430.3786	54.4469	199.8199	127884.7666	155315.1452	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
97	6	1	2026-01-15	0.628333000000000	0.488333000000000	0.708333000000000	0.060000000000000	0.118750000000000	-0.001250000000000	0.218750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	22.2006	5.3281	12.9385	47.4843	40361.6710	57.2387	210.0662	178556.2806	218917.9517	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
98	7	2	2026-01-15	0.430820000000000	0.290820000000000	0.510820000000000	0.060000000000000	0.029869000000000	-0.090131000000000	0.129869000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.1745	2.6819	6.5125	23.9009	28681.0934	40.8906	150.0685	180082.2392	208763.3325	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
99	8	3	2026-01-15	0.608333000000000	0.468333000000000	0.688333000000000	0.060000000000000	0.109750000000000	-0.010250000000000	0.209750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.9047	5.0171	12.1832	44.7125	93896.1667	55.5833	203.9909	428380.8784	522277.0452	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
100	9	4	2026-01-15	0.608333000000000	0.468333000000000	0.688333000000000	0.060000000000000	0.109750000000000	-0.010250000000000	0.209750000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.9047	5.0171	12.1832	44.7125	28615.9746	55.5833	203.9909	130554.1725	159170.1471	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
101	6	1	2026-02-15	0.658667000000000	0.518667000000000	0.738667000000000	0.060000000000000	0.132400000000000	0.012400000000000	0.232400000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.2442	5.8186	14.1295	51.8553	44076.9834	59.7494	219.2804	186388.3781	230465.3615	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
102	7	2	2026-02-15	0.468667000000000	0.328667000000000	0.548667000000000	0.060000000000000	0.046900000000000	-0.073100000000000	0.146900000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.9841	3.1162	7.5672	27.7715	33325.7814	44.0231	161.5649	193877.9086	227203.6900	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
103	8	3	2026-02-15	0.652590000000000	0.512590000000000	0.732590000000000	0.060000000000000	0.129665000000000	0.009665000000000	0.229665000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.8272	5.7185	13.8865	50.9634	107023.2404	59.2465	217.4345	456612.3957	563635.6361	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
104	9	4	2026-02-15	0.595269000000000	0.455269000000000	0.675269000000000	0.060000000000000	0.103871000000000	-0.016129000000000	0.203871000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.0802	4.8192	11.7027	42.9490	27487.3357	54.5020	200.0225	128014.3734	155501.7090	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
105	6	1	2026-03-15	0.680962000000000	0.540962000000000	0.760962000000000	0.060000000000000	0.142433000000000	0.022433000000000	0.242433000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.8064	6.1935	15.0400	55.1967	46917.1559	61.5948	226.0529	192144.9329	239062.0889	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
106	7	2	2026-03-15	0.431487000000000	0.291487000000000	0.511487000000000	0.060000000000000	0.030169000000000	-0.089831000000000	0.130169000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.2052	2.6892	6.5304	23.9665	28759.7557	40.9458	150.2710	180325.2519	209085.0076	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
107	8	3	2026-03-15	0.669000000000000	0.529000000000000	0.749000000000000	0.060000000000000	0.137050000000000	0.017050000000000	0.237050000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.9619	5.9909	14.5478	53.3904	112119.7698	60.6047	222.4194	467080.6541	579200.4239	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
108	9	4	2026-03-15	0.559000000000000	0.419000000000000	0.639000000000000	0.060000000000000	0.087550000000000	-0.032450000000000	0.187550000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.8820	4.2917	10.4217	38.2475	24478.3907	51.5000	189.0051	120963.2705	145441.6611	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
109	6	1	2026-04-15	0.689333000000000	0.549333000000000	0.769333000000000	0.060000000000000	0.146200000000000	0.026200000000000	0.246200000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	26.4062	6.3375	15.3895	56.4796	48007.6630	62.2877	228.5959	194306.5425	242314.2056	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
110	7	2	2026-04-15	0.329333000000000	0.189333000000000	0.409333000000000	0.060000000000000	-0.015800000000000	-0.135800000000000	0.084200000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	7.0182	1.6844	4.0902	15.0111	18013.3408	32.4905	119.2402	143088.2501	161101.5909	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
111	8	3	2026-04-15	0.653256000000000	0.513256000000000	0.733256000000000	0.060000000000000	0.129965000000000	0.009965000000000	0.229965000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	23.8728	5.7295	13.9130	51.0609	107227.8673	59.3016	217.6370	457037.6680	564265.5353	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
112	9	4	2026-04-15	0.509333000000000	0.369333000000000	0.589333000000000	0.060000000000000	0.065200000000000	-0.054800000000000	0.165200000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	15.0877	3.6211	8.7931	32.2708	20653.2866	47.3891	173.9181	111307.5651	131960.8517	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
113	6	1	2026-05-15	0.681628000000000	0.541628000000000	0.761628000000000	0.060000000000000	0.142733000000000	0.022733000000000	0.242733000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	25.8539	6.2049	15.0676	55.2983	47003.5147	61.6500	226.2554	192317.0669	239320.5816	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
114	7	2	2026-05-15	0.409667000000000	0.269667000000000	0.489667000000000	0.060000000000000	0.020350000000000	-0.099650000000000	0.120350000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.2248	2.4540	5.9590	21.8697	26243.6035	39.1397	143.6427	172371.2828	198614.8863	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
115	8	3	2026-05-15	0.609667000000000	0.469667000000000	0.689667000000000	0.060000000000000	0.110350000000000	-0.009650000000000	0.210350000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.9898	5.0375	12.2328	44.8945	94278.5242	55.6937	204.3959	429231.4230	523509.9472	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
116	9	4	2026-05-15	0.459667000000000	0.319667000000000	0.539667000000000	0.060000000000000	0.042850000000000	-0.077150000000000	0.142850000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.5409	3.0098	7.3088	26.8235	17167.0158	43.2782	158.8310	101651.8596	118818.8754	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
117	6	1	2026-06-15	0.660000000000000	0.520000000000000	0.740000000000000	0.060000000000000	0.133000000000000	0.013000000000000	0.233000000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	24.3362	5.8407	14.1831	52.0520	44244.2281	59.8598	219.6855	186732.6461	230976.8742	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
118	7	2	2026-06-15	0.270000000000000	0.130000000000000	0.350000000000000	0.060000000000000	-0.042500000000000	-0.162500000000000	0.057500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	5.0514	1.2123	2.9439	10.8042	12965.0807	27.5795	101.2168	121460.1180	134425.1987	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
119	8	3	2026-06-15	0.550000000000000	0.410000000000000	0.630000000000000	0.060000000000000	0.083500000000000	-0.036500000000000	0.183500000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	17.3572	4.1657	10.1158	37.1250	77962.4599	50.7551	186.2712	391169.5557	469132.0156	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
120	9	4	2026-06-15	0.423397000000000	0.283397000000000	0.503397000000000	0.060000000000000	0.026529000000000	-0.093471000000000	0.126529000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.8362	2.6007	6.3154	23.1774	14833.5193	40.2762	147.8137	94600.7567	109434.2760	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
121	6	1	2026-07-15	0.630333000000000	0.490333000000000	0.710333000000000	0.060000000000000	0.119650000000000	-0.000350000000000	0.219650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	22.3324	5.3598	13.0153	47.7663	40601.3637	57.4043	210.6737	179072.6827	219674.0463	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
122	7	2	2026-07-15	0.167846000000000	0.027846000000000	0.247846000000000	0.060000000000000	-0.088469000000000	-0.208469000000000	0.011531000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.4471	0.5873	1.4262	5.2340	6280.8029	19.1242	70.1859	84223.1162	90503.9191	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
123	8	3	2026-07-15	0.490333000000000	0.350333000000000	0.570333000000000	0.060000000000000	0.056650000000000	-0.063350000000000	0.156650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	14.0843	3.3802	8.2083	30.1246	63261.6864	45.8165	168.1465	353107.6884	416369.3749	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
124	9	4	2026-07-15	0.410333000000000	0.270333000000000	0.490333000000000	0.060000000000000	0.020650000000000	-0.099350000000000	0.120650000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.2541	2.4610	5.9761	21.9322	14036.6360	39.1949	143.8452	92060.9576	106097.5936	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
125	6	1	2026-08-15	0.600667000000000	0.460667000000000	0.680667000000000	0.060000000000000	0.106300000000000	-0.013700000000000	0.206300000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	20.4187	4.9005	11.9000	43.6730	37122.0905	54.9488	201.6620	171412.7192	208534.8097	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
126	7	2	2026-08-15	0.130667000000000	-0.009333000000000	0.210667000000000	0.060000000000000	-0.105200000000000	-0.225200000000000	-0.005200000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	1.7395	0.4175	1.0138	3.7205	4464.6103	16.0469	58.8920	70670.4595	75135.0699	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
127	8	3	2026-08-15	0.446744000000000	0.306744000000000	0.526744000000000	0.060000000000000	0.037035000000000	-0.082965000000000	0.137035000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.9186	2.8605	6.9461	25.4923	53533.8988	42.2086	154.9054	325301.4434	378835.3422	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
128	9	4	2026-08-15	0.424064000000000	0.284064000000000	0.504064000000000	0.060000000000000	0.026829000000000	-0.093171000000000	0.126829000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	10.8664	2.6079	6.3329	23.2419	14874.8029	40.3314	148.0162	94730.3635	109605.1664	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
129	6	1	2026-09-15	0.579038000000000	0.439038000000000	0.659038000000000	0.060000000000000	0.096567000000000	-0.023433000000000	0.196567000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	19.0800	4.5792	11.1198	40.8097	34688.2690	53.1586	195.0921	165828.2984	200516.5674	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
130	7	2	2026-09-15	0.168513000000000	0.028513000000000	0.248513000000000	0.060000000000000	-0.088169000000000	-0.208169000000000	0.011831000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	2.4609	0.5906	1.4342	5.2636	6316.3335	19.1794	70.3884	84466.1289	90782.4624	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
131	8	3	2026-09-15	0.431000000000000	0.291000000000000	0.511000000000000	0.060000000000000	0.029950000000000	-0.090050000000000	0.129950000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	11.1828	2.6839	6.5173	23.9186	50228.9697	40.9055	150.1231	315258.4573	365487.4270	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
132	9	4	2026-09-15	0.461000000000000	0.321000000000000	0.541000000000000	0.060000000000000	0.043450000000000	-0.076550000000000	0.143450000000000	0.040000000000000	-0.150000000000000	-0.250000000000000	-0.050000000000000	0.030000000000000	12.6061	3.0255	7.3468	26.9628	17256.2060	43.3886	159.2361	101911.0732	119167.2792	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: mavhu; Owner: -
--

COPY mavhu.schema_migrations (id, filename, applied_at) FROM stdin;
1	001_add_platform_customer_identifier.sql	2026-09-24 08:21:43.609352+02
2	002_add_mavhu_admin_role.sql	2026-09-24 08:21:43.641469+02
3	004_multi_bank_platform_admin.sql	2026-10-04 22:10:18.087517+02
4	005_demo_data_other_banks.sql	2026-10-04 22:10:18.087517+02
5	006_rfp_readiness_features.sql	2026-10-21 07:10:51.523049+02
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
12	14	4	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
13	15	4	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
14	16	3	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
15	13	1	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
16	18	3	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
17	17	4	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
18	12	1	Provisioned by migration 006 (demo data)	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02
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
12	Tawanda Chikore	2	\N	tawanda.chikore@mavhu.africa	$2a$10$kEIQ8u1TucM.kT6kjq7oHuS7itwMEuyMBTFlYDMl7U2mz1QMURxhW	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
13	Nokuthula Ndlovu	2	\N	nokuthula.ndlovu@mavhu.africa	$2a$10$/21BM6koZtS4RcvXgrG/M.2dWjhaBBV6o8.N1DAwlUrPesobJMLnS	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
14	Tsungai Marange	6	\N	tsungai.marange@chipingetea.co.zw	$2a$10$2894B/Nms9fza2FHWLqmtu9eZBfuU2AF0cZBh2MN4wkGVjIoUKDxW	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
15	Lovemore Sithole	8	\N	lovemore.sithole@chiredzisugar.co.zw	$2a$10$kvZt8cptb/m88yuBzYnvbeaKFslYY1yhbiqmUepJu8J8WtxiJKijO	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
16	Gift Mabhena	8	\N	gift.mabhena@chiredzisugar.co.zw	$2a$10$ujDf2bgfmIpGuY9dOMTCyuMotn8DaP/NYs.af8zvTC/ERgSUuz6s6	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
17	Kundai Matare	9	\N	kundai.matare@nyangaorchards.co.zw	$2a$10$MZ55DrlQ.66/VcHvAtIbpumN.WdoxmcL0oB0tI3voCURgfyAAm45O	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
18	Tariro Nyamande	9	\N	tariro.nyamande@nyangaorchards.co.zw	$2a$10$CbtjWryrDbdz0GrajCSVJeJzEd2J0II94i99hC25QqaDf83qyMbEm	2026-10-21 07:10:51.523049+02	2026-10-21 07:10:51.523049+02	f
\.


--
-- Name: agri_field_verifications_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.agri_field_verifications_id_seq', 9, true);


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
-- Name: cbz_audit_log_seq_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.cbz_audit_log_seq_seq', 81, true);


--
-- Name: cbz_reporting_periods_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.cbz_reporting_periods_id_seq', 15, true);


--
-- Name: crop_cycles_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.crop_cycles_id_seq', 8, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.customers_id_seq', 9, true);


--
-- Name: emission_factors_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.emission_factors_id_seq', 5, true);


--
-- Name: emissions_accounting_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.emissions_accounting_id_seq', 14, true);


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

SELECT pg_catalog.setval('mavhu.satellite_ndvi_co2_id_seq', 132, true);


--
-- Name: schema_migrations_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.schema_migrations_id_seq', 5, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.user_roles_id_seq', 18, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: mavhu; Owner: -
--

SELECT pg_catalog.setval('mavhu.users_id_seq', 18, true);


--
-- Name: agri_field_verifications agri_field_verifications_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.agri_field_verifications
    ADD CONSTRAINT agri_field_verifications_pkey PRIMARY KEY (id);


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
-- Name: cbz_disclosures cbz_disclosures_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_disclosures
    ADD CONSTRAINT cbz_disclosures_pkey PRIMARY KEY (id);


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
-- Name: cbz_evidence cbz_evidence_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_evidence
    ADD CONSTRAINT cbz_evidence_pkey PRIMARY KEY (id);


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
-- Name: cbz_register_items cbz_register_items_pkey; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_register_items
    ADD CONSTRAINT cbz_register_items_pkey PRIMARY KEY (id);


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
-- Name: cbz_disclosures uq_cbz_disclosure_version; Type: CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_disclosures
    ADD CONSTRAINT uq_cbz_disclosure_version UNIQUE (bank_id, framework, period, version);


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
-- Name: idx_cbz_evidence_target; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_evidence_target ON mavhu.cbz_evidence USING btree (bank_id, target_type, target_id);


--
-- Name: idx_cbz_register_items_bank; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_register_items_bank ON mavhu.cbz_register_items USING btree (bank_id, register);


--
-- Name: idx_cbz_risk_entries_bank_id; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE INDEX idx_cbz_risk_entries_bank_id ON mavhu.cbz_risk_entries USING btree (bank_id);


--
-- Name: uq_cbz_audit_log_seq; Type: INDEX; Schema: mavhu; Owner: -
--

CREATE UNIQUE INDEX uq_cbz_audit_log_seq ON mavhu.cbz_audit_log USING btree (seq);


--
-- Name: agri_field_verifications agri_field_verifications_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER agri_field_verifications_updated_at BEFORE UPDATE ON mavhu.agri_field_verifications FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: bank_customers bank_customers_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER bank_customers_updated_at BEFORE UPDATE ON mavhu.bank_customers FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: banks banks_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER banks_updated_at BEFORE UPDATE ON mavhu.banks FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_audit_log cbz_audit_log_append_only; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_audit_log_append_only BEFORE DELETE OR UPDATE ON mavhu.cbz_audit_log FOR EACH ROW EXECUTE FUNCTION mavhu.cbz_audit_log_append_only();


--
-- Name: cbz_counterparties cbz_counterparties_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_counterparties_updated_at BEFORE UPDATE ON mavhu.cbz_counterparties FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_departments cbz_departments_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_departments_updated_at BEFORE UPDATE ON mavhu.cbz_departments FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: cbz_disclosures cbz_disclosures_immutable; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_disclosures_immutable BEFORE DELETE OR UPDATE ON mavhu.cbz_disclosures FOR EACH ROW EXECUTE FUNCTION mavhu.cbz_disclosures_immutable();


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
-- Name: cbz_register_items cbz_register_items_updated_at; Type: TRIGGER; Schema: mavhu; Owner: -
--

CREATE TRIGGER cbz_register_items_updated_at BEFORE UPDATE ON mavhu.cbz_register_items FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


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
-- Name: agri_field_verifications agri_field_verifications_created_by_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.agri_field_verifications
    ADD CONSTRAINT agri_field_verifications_created_by_fkey FOREIGN KEY (created_by) REFERENCES mavhu.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: agri_field_verifications agri_field_verifications_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.agri_field_verifications
    ADD CONSTRAINT agri_field_verifications_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: agri_field_verifications agri_field_verifications_estate_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.agri_field_verifications
    ADD CONSTRAINT agri_field_verifications_estate_id_fkey FOREIGN KEY (estate_id) REFERENCES mavhu.estates(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: cbz_counterparties cbz_counterparties_customer_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_counterparties
    ADD CONSTRAINT cbz_counterparties_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES mavhu.customers(id) ON UPDATE CASCADE ON DELETE SET NULL;


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
-- Name: cbz_disclosures cbz_disclosures_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_disclosures
    ADD CONSTRAINT cbz_disclosures_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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
-- Name: cbz_evidence cbz_evidence_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_evidence
    ADD CONSTRAINT cbz_evidence_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cbz_evidence cbz_evidence_entity_code_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_evidence
    ADD CONSTRAINT cbz_evidence_entity_code_fkey FOREIGN KEY (entity_code) REFERENCES mavhu.cbz_entities(code);


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
-- Name: cbz_register_items cbz_register_items_bank_id_fkey; Type: FK CONSTRAINT; Schema: mavhu; Owner: -
--

ALTER TABLE ONLY mavhu.cbz_register_items
    ADD CONSTRAINT cbz_register_items_bank_id_fkey FOREIGN KEY (bank_id) REFERENCES mavhu.banks(id) ON UPDATE CASCADE ON DELETE RESTRICT;


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

\unrestrict laSKlvqT0aGAhTzpPSgd7OuQbj4ar5hbYjRnNERILQZpmjkfBeTOJqtdHhMSftX

