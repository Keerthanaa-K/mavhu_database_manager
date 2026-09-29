-- ============================================
-- Adds the MAVHU_ADMIN role: Mavhu Africa platform administrators.
-- Admins are provisioned by the system (never self-registered).
-- ============================================

INSERT INTO mavhu.roles (name) VALUES ('MAVHU_ADMIN')
ON CONFLICT (name) DO NOTHING;
