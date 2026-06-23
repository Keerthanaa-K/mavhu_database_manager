-- ============================================
-- Users Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.users (
    id          SERIAL          PRIMARY KEY,
    name        VARCHAR(255)    NOT NULL,
    customer_id INTEGER         NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    estate_id   INTEGER                  REFERENCES mavhu.estates (id)   ON DELETE SET NULL ON UPDATE CASCADE,
    email       VARCHAR(255)    NOT NULL UNIQUE,
    password    VARCHAR(255)    NOT NULL, -- password hashed at application layer
    role_id     INTEGER         NOT NULL REFERENCES mavhu.roles (id)     ON DELETE RESTRICT ON UPDATE CASCADE,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS users_updated_at ON mavhu.users;

CREATE TRIGGER users_updated_at
    BEFORE UPDATE ON mavhu.users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();