-- ============================================
-- Bank Customers (Join Table: Banks <-> Customers)
-- ============================================

CREATE TABLE IF NOT EXISTS  mavhu.bank_customers (
    id                          SERIAL          PRIMARY KEY,
    bank_id                     INTEGER         NOT NULL REFERENCES mavhu.banks (id)     ON DELETE RESTRICT ON UPDATE CASCADE,
    customer_id                 INTEGER         NOT NULL REFERENCES mavhu.customers (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    customer_reference_number   VARCHAR(255)    NOT NULL,
    created_at                  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT uq_bank_customer UNIQUE (bank_id, customer_id),
    CONSTRAINT uq_bank_customer_reference_number    UNIQUE (bank_id, customer_reference_number)

);

-- ============================================
-- Auto-update updated_at via trigger
-- ============================================
DROP TRIGGER IF EXISTS bank_customers_updated_at ON mavhu.bank_customers;

CREATE TRIGGER bank_customers_updated_at
    BEFORE UPDATE ON mavhu.bank_customers
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at();