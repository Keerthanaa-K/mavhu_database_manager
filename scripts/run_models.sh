#!/usr/bin/env bash
# ============================================
# run_models.sh
# Runs every .sql file in models/ in filename order.
# Intended for: initial schema setup / full rebuild.
# Re-running this will re-execute every model file —
# make sure your model SQL is idempotent (CREATE TABLE IF NOT EXISTS  ,
# CREATE OR REPLACE, etc.) if you plan to run this more than once
# against an existing database.
# ============================================

set -euo pipefail

# ---- Configuration ----
# Override any of these via environment variables, e.g.:
#   DB_NAME=mavhu_db DB_USER=postgres ./run_models.sh
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-mavhu_db}"
DB_USER="${DB_USER:-postgres}"

# Resolve paths relative to this script's location (project_root/scripts/),
# not the caller's current directory. This means the script works the same
# whether invoked as `./run_models.sh`, `./scripts/run_models.sh`, or with
# an absolute path. Override with MODELS_DIR=/some/path if needed.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MODELS_DIR="${MODELS_DIR:-$PROJECT_ROOT/models}"

export PGPASSWORD="${DB_PASSWORD:-}"

if [ ! -d "$MODELS_DIR" ]; then
    echo "Error: models directory not found at '$MODELS_DIR'" >&2
    exit 1
fi

# Collect .sql files, sorted naturally
#  10_x.sql runs after 2_x.sql (not before, as plain lexical sort would do).
# Written without process substitution / mapfile / arrays so this also runs
# correctly if invoked as `sh run_models.sh` (which ignores the bash shebang).
FILE_LIST="$(mktemp)"
trap 'rm -f "$FILE_LIST"' EXIT

find "$MODELS_DIR" -maxdepth 1 -name "*.sql" -print | sort -V > "$FILE_LIST"

FILE_COUNT="$(wc -l < "$FILE_LIST" | tr -d ' ')"

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No .sql files found in '$MODELS_DIR'"
    exit 0
fi

echo "Found $FILE_COUNT model file(s) in '$MODELS_DIR':"
sed 's/^/  /' "$FILE_LIST"
echo ""

while IFS= read -r file; do
    echo ">>> Running $file"
    psql \
        -h "$DB_HOST" \
        -p "$DB_PORT" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -v ON_ERROR_STOP=1 \
        -f "$file"
    echo ">>> Done: $file"
    echo ""
done < "$FILE_LIST"

echo "All model files executed successfully."
