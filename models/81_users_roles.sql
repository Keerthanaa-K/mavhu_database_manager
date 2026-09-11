-- ============================================
-- User Role Mapping
-- ============================================


CREATE TABLE IF NOT EXISTS mavhu.user_roles(

     id          SERIAL          PRIMARY KEY,
     user_id     INTEGER         NOT NULL REFERENCES mavhu.users (id)     ON DELETE RESTRICT ON UPDATE CASCADE,
     role_id     INTEGER         NOT NULL REFERENCES mavhu.roles (id)     ON DELETE RESTRICT ON UPDATE CASCADE,
     audit_trail TEXT,
     created_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
     updated_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP

);

-- ============================================
-- Auto-update updated_at via trigger (UTC)
-- ============================================

DROP TRIGGER IF EXISTS user_roles_updated_at ON mavhu.user_roles;

CREATE TRIGGER user_roles_updated_at
    BEFORE UPDATE ON mavhu.user_roles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();
