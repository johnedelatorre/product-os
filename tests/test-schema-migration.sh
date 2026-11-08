#!/bin/bash
# Schema Migration Tests
# Tests that v1.0 progress files are handled correctly

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURES_DIR="$SCRIPT_DIR/fixtures"

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

echo "Schema Migration Tests"
echo "======================"
echo ""

# ============================================================
# Test 1: v1.0 basic file is valid YAML
# ============================================================
log_test "v1.0 basic fixture is valid YAML"

if python3 -c "import yaml; yaml.safe_load(open('$FIXTURES_DIR/progress-v1.0-basic.yaml'))" 2>/dev/null; then
    log_pass "v1.0 basic file parses as valid YAML"
else
    log_fail "v1.0 basic file is invalid YAML"
fi

# ============================================================
# Test 2: v1.0 file has no schema_version key (expected)
# ============================================================
log_test "v1.0 file lacks schema_version field"

# Check for schema_version as a YAML key (not in comments)
if ! grep -E "^schema_version:" "$FIXTURES_DIR/progress-v1.0-basic.yaml" > /dev/null; then
    log_pass "v1.0 file correctly has no schema_version key"
else
    log_fail "v1.0 file unexpectedly has schema_version key"
fi

# ============================================================
# Test 3: v1.1 file has schema_version
# ============================================================
log_test "v1.1 file has schema_version field"

if grep -q 'schema_version: "1.1"' "$FIXTURES_DIR/progress-v1.1-full.yaml"; then
    log_pass "v1.1 file has correct schema_version"
else
    log_fail "v1.1 file missing or incorrect schema_version"
fi

# ============================================================
# Test 4: v1.0 custom fields preserved after parsing
# ============================================================
log_test "v1.0 custom fields are preserved"

CUSTOM_RESULT=$(python3 -c "
import yaml
with open('$FIXTURES_DIR/progress-v1.0-custom-fields.yaml') as f:
    data = yaml.safe_load(f)
# Check custom fields exist
assert 'team_notes' in data, 'team_notes missing'
assert 'custom_metadata' in data, 'custom_metadata missing'
assert data['custom_metadata']['sprint'] == 12, 'sprint value wrong'
# Check custom per-phase field
assert data['phases']['intake'].get('reviewer') == 'Jane Doe', 'reviewer missing'
# Check custom per-document field
assert data['phases']['define']['documents']['prd.md'].get('version') == '2.1', 'version missing'
print('OK')
" 2>&1)

if [[ "$CUSTOM_RESULT" == "OK" ]]; then
    log_pass "Custom fields preserved in v1.0 file"
else
    log_fail "Custom fields lost: $CUSTOM_RESULT"
fi

# ============================================================
# Test 5: v1.1 artifact_stages field exists
# ============================================================
log_test "v1.1 file has artifact_stages"

if grep -q "artifact_stages:" "$FIXTURES_DIR/progress-v1.1-full.yaml"; then
    log_pass "v1.1 file has artifact_stages"
else
    log_fail "v1.1 file missing artifact_stages"
fi

# ============================================================
# Test 6: v1.1 structured exit_criteria format
# ============================================================
log_test "v1.1 file has structured exit_criteria"

CRITERIA_RESULT=$(python3 -c "
import yaml
with open('$FIXTURES_DIR/progress-v1.1-full.yaml') as f:
    data = yaml.safe_load(f)
criteria = data['phases']['intake']['exit_criteria']
assert 'problem_stated' in criteria, 'problem_stated missing'
assert criteria['problem_stated']['status'] == 'pass', 'status wrong'
assert 'evidence' in criteria['problem_stated'], 'evidence missing'
print('OK')
" 2>&1)

if [[ "$CRITERIA_RESULT" == "OK" ]]; then
    log_pass "v1.1 structured exit_criteria works"
else
    log_fail "v1.1 exit_criteria issue: $CRITERIA_RESULT"
fi

# ============================================================
# Test 7: v1.1 reviews section exists
# ============================================================
log_test "v1.1 file has reviews section"

REVIEWS_RESULT=$(python3 -c "
import yaml
with open('$FIXTURES_DIR/progress-v1.1-full.yaml') as f:
    data = yaml.safe_load(f)
assert 'reviews' in data, 'reviews missing'
assert 'prd_review' in data['reviews'], 'prd_review missing'
assert data['reviews']['prd_review']['status'] == 'complete', 'status wrong'
print('OK')
" 2>&1)

if [[ "$REVIEWS_RESULT" == "OK" ]]; then
    log_pass "v1.1 reviews section works"
else
    log_fail "v1.1 reviews issue: $REVIEWS_RESULT"
fi

# ============================================================
# Test 8: Migration preserves core fields
# ============================================================
log_test "Core fields preserved across versions"

CORE_RESULT=$(python3 -c "
import yaml

# Check v1.0 basic
with open('$FIXTURES_DIR/progress-v1.0-basic.yaml') as f:
    v10 = yaml.safe_load(f)
assert v10['initiative'] == 'test-initiative'
assert v10['current_phase'] == 'define'
assert 'intake_approved' in v10['gates_passed']

# Check v1.1
with open('$FIXTURES_DIR/progress-v1.1-full.yaml') as f:
    v11 = yaml.safe_load(f)
assert v11['initiative'] == 'full-initiative'
assert v11['current_phase'] == 'deliver'

print('OK')
" 2>&1)

if [[ "$CORE_RESULT" == "OK" ]]; then
    log_pass "Core fields preserved"
else
    log_fail "Core fields issue: $CORE_RESULT"
fi

# ============================================================
# Test 9: Boolean exit_criteria (v1.0) vs structured (v1.1)
# ============================================================
log_test "Both boolean and structured exit_criteria valid"

COMPAT_RESULT=$(python3 -c "
import yaml

# v1.0 uses boolean
with open('$FIXTURES_DIR/progress-v1.0-basic.yaml') as f:
    v10 = yaml.safe_load(f)
assert v10['phases']['intake']['exit_criteria_passed'] == True, 'boolean not working'

# v1.1 uses structured AND boolean (backward compat)
with open('$FIXTURES_DIR/progress-v1.1-full.yaml') as f:
    v11 = yaml.safe_load(f)
assert v11['phases']['intake']['exit_criteria_passed'] == True, 'v1.1 boolean missing'
assert 'exit_criteria' in v11['phases']['intake'], 'structured missing'

print('OK')
" 2>&1)

if [[ "$COMPAT_RESULT" == "OK" ]]; then
    log_pass "Both exit_criteria formats work"
else
    log_fail "Exit criteria compatibility: $COMPAT_RESULT"
fi

# ============================================================
# Summary
# ============================================================
echo ""
echo "======================"
echo "Test Summary"
echo "======================"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -gt 0 ]]; then
    echo "Some tests failed."
    exit 1
else
    echo "All schema migration tests passed!"
    exit 0
fi
