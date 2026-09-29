-- ============================================
-- Adds the PLATFORM customer type, used for the operator organisation
-- (Mavhu Africa) that owns the admin users.
-- ============================================

ALTER TYPE customer_identifier ADD VALUE IF NOT EXISTS 'PLATFORM';
