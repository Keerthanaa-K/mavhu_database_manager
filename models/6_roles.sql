-- ============================================
-- Roles Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.roles (
    id      SERIAL          PRIMARY KEY,
    name    VARCHAR(255)    NOT NULL UNIQUE
);

-- ============================================
-- Seed initial roles
-- ============================================

INSERT INTO mavhu.roles (name) VALUES
    ('AUDITOR'),
    ('ESG_TEAM'),
    ('MANAGER');

-- ============================================
-- Script to add roles in the future
--INSERT INTO mavhu.roles (name) VALUES ('NEW_ROLE');
-- ============================================

