-- ============================================
-- Emission Factors Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.emission_factors (
    id          SERIAL          PRIMARY KEY,
    name        VARCHAR(255)    NOT NULL,
    component   VARCHAR(255)    NOT NULL,
    factor      DECIMAL(10,4)   NOT NULL,
    gwp         DECIMAL(10,4)   NOT NULL,
    description VARCHAR(1000), --- used to display tooltips / comments. Has emissions factor together with the units
    unit        VARCHAR(255)    NOT NULL,

    CONSTRAINT uq_emission_factors_name_component UNIQUE (name, component)
);