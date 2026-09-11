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
    ('AUDITOR'), -- ALL DATA ACCESS
    ('ESG_READER'),  -- ESG METRICS READ ONLY
    ('ESG_CONTRIBUTOR'), -- ESG WRITE METRICS
    ('ESG_APPROVER'); -- FOR MANAGERS TO APPROVE THE FILLED ESG DATA



-- ============================================
-- Script to add roles in the future
--INSERT INTO mavhu.roles (name) VALUES ('NEW_ROLE');
-- ============================================

--- ROLE_USERS table : 1 user can have multiple roles
---
