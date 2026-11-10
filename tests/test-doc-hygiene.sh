#!/bin/bash
# Doc Hygiene Tests
# Tests scripts/doc-hygiene-check.py lint and guard against fixtures

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURES_DIR="$SCRIPT_DIR/fixtures/doc-hygiene"
CHECK="$(dirname "$SCRIPT_DIR")/scripts/doc-hygiene-check.py"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0

log_test() { echo -e "\n${YELLOW}[TEST]${NC} $1"; }
log_pass() { echo -e "${GREEN}[PASS]${NC} $1"; TESTS_PASSED=$((TESTS_PASSED + 1)); }
log_fail() { echo -e "${RED}[FAIL]${NC} $1"; TESTS_FAILED=$((TESTS_FAILED + 1)); }

echo "Doc Hygiene Tests"
echo "================="

# ============================================================
# Test 1: lint flags every history pattern in the dirty fixture
# ============================================================
log_test "lint flags history material"

OUT=$(python3 "$CHECK" lint "$FIXTURES_DIR/dirty.md" || true)
MISSING=0
for rule in version-token history-kept tldr-label tldr-duplicate history-block disposition-tag \
            carried-from change-narrative version-note retired-item vague-tbd tbd-source \
            amended-tag fence-odd anchor-broken; do
    if ! grep -q "\[$rule\]" <<< "$OUT"; then
        log_fail "lint did not report [$rule]"
        MISSING=$((MISSING + 1))
    fi
done
if [[ $MISSING -eq 0 ]]; then
    log_pass "lint reports all 15 rule types"
fi

# ============================================================
# Test 2: lint exits non-zero on hits
# ============================================================
log_test "lint exit code on hits"

if python3 "$CHECK" lint "$FIXTURES_DIR/dirty.md" > /dev/null; then
    log_fail "lint exited 0 on a dirty file"
else
    log_pass "lint exits non-zero on a dirty file"
fi

# ============================================================
# Test 3: lint passes a clean file (API paths, filenames, library versions, URLs skipped)
# ============================================================
log_test "lint passes a clean file"

if python3 "$CHECK" lint "$FIXTURES_DIR/clean.md" > /dev/null; then
    log_pass "clean fixture has no hits"
else
    log_fail "clean fixture flagged: $(python3 "$CHECK" lint "$FIXTURES_DIR/clean.md" | head -5)"
fi

# ============================================================
# Test 4: guard accepts a minimal reword
# ============================================================
log_test "guard accepts a minimal reword"

if python3 "$CHECK" guard "$FIXTURES_DIR/reworded.md" --against "$FIXTURES_DIR/orig.md" > /dev/null; then
    log_pass "reword adds no new words"
else
    log_fail "guard flagged a minimal reword"
fi

# ============================================================
# Test 5: guard catches invented content
# ============================================================
log_test "guard catches invented content"

OUT=$(python3 "$CHECK" guard "$FIXTURES_DIR/invented.md" --against "$FIXTURES_DIR/orig.md" || true)
if grep -q "seconds" <<< "$OUT"; then
    log_pass "guard lists the invented words"
else
    log_fail "guard missed invented words"
fi

# ============================================================
# Test 6: guard --git-ref and --against-dir
# ============================================================
log_test "guard --git-ref and --against-dir"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/repo" "$TMP/orig"
cp "$FIXTURES_DIR/orig.md" "$TMP/repo/page.md"
cp "$FIXTURES_DIR/orig.md" "$TMP/orig/page.md"
(cd "$TMP/repo" && git init -q && git add page.md && git -c user.email=t@example.com -c user.name=t commit -qm init)
cp "$FIXTURES_DIR/invented.md" "$TMP/repo/page.md"

GIT_OUT=$(python3 "$CHECK" guard "$TMP/repo/page.md" --git-ref HEAD || true)
DIR_OUT=$(python3 "$CHECK" guard "$TMP/repo/page.md" --against-dir "$TMP/orig" || true)
if grep -q "seconds" <<< "$GIT_OUT" && grep -q "seconds" <<< "$DIR_OUT"; then
    log_pass "both original sources work"
else
    log_fail "git-ref or against-dir comparison failed"
fi

# ============================================================
# Test 7: suppression marker
# ============================================================
log_test "hygiene-ok marker suppresses a line"

echo 'Uses the Agent contract v2 from the vendor. <!-- hygiene-ok -->' > "$TMP/ok.md"
if python3 "$CHECK" lint "$TMP/ok.md" > /dev/null; then
    log_pass "marked line is skipped"
else
    log_fail "marked line still flagged"
fi

# ============================================================
# Summary
# ============================================================
echo ""
echo "================="
echo "Test Summary"
echo "================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"

if [[ $TESTS_FAILED -gt 0 ]]; then
    exit 1
fi
exit 0
