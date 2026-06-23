-- ============================================
-- Role Permissions (Join Table: Roles <-> APIs)
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.role_permissions (
    id          SERIAL  PRIMARY KEY,
    role_id     INTEGER NOT NULL REFERENCES mavhu.roles (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    api_id      INTEGER NOT NULL REFERENCES mavhu.apis (id)  ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT uq_role_api UNIQUE (role_id, api_id)
);