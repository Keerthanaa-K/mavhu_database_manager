-- ============================================
-- APIs Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.apis (
    id      SERIAL          PRIMARY KEY,
    name    VARCHAR(255)    NOT NULL UNIQUE
);
