#!/usr/bin/env bash
# ============================================
# run_migrations.sh
# Runs every .sql file in migrations/ that hasn't been applied yet,
# in filename order. Tracks applied migrations in a table
# (mavhu.schema_migrations) so re-running this script is safe —
# already-applied migrations are skipped.
#
# Each migration runs inside its own transaction. If a migration
# fails, that transaction rolls back and the script stops — earlier
# migrations in the same run remain applied (each had its own commit).
#
# Written using only POSIX sh features (no arrays, no mapfile, no
# process substitution, no herestrings) so this also runs correctly
# if invoked as `sh run_migrations.sh`, which ignores the bash shebang.
# ============================================

set -eu

# ---- Configuration ----
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-mavhu_db}"
DB_USER="${DB_USER:-postgres}"

# Resolve paths relative to this script's location (project_root/scripts/),
# not the caller's current directory. Override with MIGRATIONS_DIR=/some/path if needed.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MIGRATIONS_DIR="${MIGRATIONS_DIR:-$PROJECT_ROOT/migrations}"
MIGRATIONS_SCHEMA="${MIGRATIONS_SCHEMA:-mavhu}"
MIGRATIONS_TABLE="${MIGRATIONS_TABLE:-schema_migrations}"

export PGPASSWORD="${DB_PASSWORD:-}"

run_psql() {
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 "$@"
}

if [ ! -d "$MIGRATIONS_DIR" ]; then
    echo "Error: migrations directory not found at '$MIGRATIONS_DIR'" >&2
    exit 1
fi

# ---- Temp files (cleaned up on exit) ----
SETUP_SQL="$(mktemp)"
FILE_LIST="$(mktemp)"
APPLIED_LIST="$(mktemp)"
RUN_SQL="$(mktemp)"
trap 'rm -f "$SETUP_SQL" "$FILE_LIST" "$APPLIED_LIST" "$RUN_SQL"' EXIT

# ---- Ensure tracking schema/table exists ----
cat > "$SETUP_SQL" << SQL
CREATE SCHEMA IF NOT EXISTS ${MIGRATIONS_SCHEMA};

CREATE TABLE IF NOT EXISTS ${MIGRATIONS_SCHEMA}.${MIGRATIONS_TABLE} (
    id          SERIAL          PRIMARY KEY,
    filename    VARCHAR(255)    NOT NULL UNIQUE,
    applied_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SQL

run_psql -q -f "$SETUP_SQL"

# ---- Collect migration files in natural/version order ----
find "$MIGRATIONS_DIR" -maxdepth 1 -name "*.sql" -print | sort -V > "$FILE_LIST"

FILE_COUNT="$(wc -l < "$FILE_LIST" | tr -d ' ')"

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No .sql files found in '$MIGRATIONS_DIR'"
    exit 0
fi

# ---- Get list of already-applied filenames ----
run_psql -t -A -c "SELECT filename FROM ${MIGRATIONS_SCHEMA}.${MIGRATIONS_TABLE};" > "$APPLIED_LIST"

is_applied() {
    target="$1"
    grep -Fxq "$target" "$APPLIED_LIST" 2>/dev/null
}

RAN_COUNT=0
SKIPPED_COUNT=0

while IFS= read -r file; do
    basefile="$(basename "$file")"

    if is_applied "$basefile"; then
        echo "Skipping already-applied migration: $basefile"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        continue
    fi

    echo ">>> Applying migration: $basefile"

    # Wrap the migration file content + tracking insert in a single transaction.
    # If the migration SQL fails, the INSERT into schema_migrations is rolled
    # back too, so it will be retried on the next run.
    : > "$RUN_SQL"
    echo "BEGIN;" >> "$RUN_SQL"
    cat "$file" >> "$RUN_SQL"
    echo "" >> "$RUN_SQL"
    echo "INSERT INTO ${MIGRATIONS_SCHEMA}.${MIGRATIONS_TABLE} (filename) VALUES ('${basefile}');" >> "$RUN_SQL"
    echo "COMMIT;" >> "$RUN_SQL"

    run_psql -f "$RUN_SQL"

    echo ">>> Applied: $basefile"
    echo ""
    RAN_COUNT=$((RAN_COUNT + 1))
done < "$FILE_LIST"

echo "Migration run complete. Applied: $RAN_COUNT, Skipped (already applied): $SKIPPED_COUNT."
