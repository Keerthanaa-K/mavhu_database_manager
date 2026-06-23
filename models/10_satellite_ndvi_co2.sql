-- ============================================
-- Satellite NDVI / CO2 Table
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.satellite_ndvi_co2 (
    id                                  SERIAL          PRIMARY KEY,
    customer_id                         INTEGER         NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    estate_id                           INTEGER         NOT NULL REFERENCES mavhu.estates (id)   ON DELETE RESTRICT ON UPDATE CASCADE,
    date                                DATE            NOT NULL,

    ndvi_mean                           DECIMAL(16,15)  CHECK (ndvi_mean BETWEEN -1.0 AND 1.0),
    ndvi_min                            DECIMAL(16,15)  CHECK (ndvi_min  BETWEEN -1.0 AND 1.0),
    ndvi_max                            DECIMAL(16,15)  CHECK (ndvi_max  BETWEEN -1.0 AND 1.0),
    ndvi_std                            DECIMAL(16,15)  CHECK (ndvi_std  BETWEEN -1.0 AND 1.0),

    ndwi_mean                           DECIMAL(16,15)  CHECK (ndwi_mean BETWEEN -1.0 AND 1.0),
    ndwi_min                            DECIMAL(16,15)  CHECK (ndwi_min  BETWEEN -1.0 AND 1.0),
    ndwi_max                            DECIMAL(16,15)  CHECK (ndwi_max  BETWEEN -1.0 AND 1.0),
    ndwi_std                            DECIMAL(16,15)  CHECK (ndwi_std  BETWEEN -1.0 AND 1.0),

    ndbi_mean                           DECIMAL(16,15)  CHECK (ndbi_mean BETWEEN -1.0 AND 1.0),
    ndbi_min                            DECIMAL(16,15)  CHECK (ndbi_min  BETWEEN -1.0 AND 1.0),
    ndbi_max                            DECIMAL(16,15)  CHECK (ndbi_max  BETWEEN -1.0 AND 1.0),
    ndbi_std                            DECIMAL(16,15)  CHECK (ndbi_std  BETWEEN -1.0 AND 1.0),

    above_ground_biomass                DECIMAL(7,4),   -- 45.8 * (ndvi_max ^ 2.1)
    below_ground_biomass                DECIMAL(7,4),   -- 0.24 * above_ground_biomass
    biomass_carbon                      DECIMAL(7,4),   -- (above_ground_biomass + below_ground_biomass) * 0.47
    biomass_co2                         DECIMAL(7,4),   -- biomass_carbon * 3.67
    biomass_co2_total                   DECIMAL(10,4),  -- biomass_co2 * estates.hectares

    soil_organic_carbon                 DECIMAL(7,4),   -- (82.77 * ndvi_max) - 1.39
    soil_organic_carbon_co2             DECIMAL(7,4),   -- soil_organic_carbon * 3.67
    soil_organic_carbon_co2_total       DECIMAL(10,4),  -- soil_organic_carbon_co2 * estates.hectares

    net_co2_stock                       DECIMAL(10,4),  -- biomass_co2_total + soil_organic_carbon_co2_total

    created_at                          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                          TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_satellite_customer_estate_date UNIQUE (customer_id, estate_id, date)
);

-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS satellite_ndvi_co2_updated_at ON mavhu.satellite_ndvi_co2;

CREATE TRIGGER satellite_ndvi_co2_updated_at
    BEFORE UPDATE ON mavhu.satellite_ndvi_co2
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();