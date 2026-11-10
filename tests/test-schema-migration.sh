#!/bin/bash
# Schema Migration Tests
# Tests that v1.0 and v1.1 progress files are handled correctly and migrate to v1.2

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

# Reference migration (mirrors .claude/skills/guided-workflow.md "Schema Migration")
# and v1.2 consistency check, shared by the tests below.
MIGRATE_PY=$(cat <<'PYEOF'
import copy, re, yaml

PHASES = ['intake', 'discovery', 'prioritize', 'define', 'design',
          'review', 'deliver', 'launch', 'measure']
DEFER_FIELDS = ['missing', 'owner', 'revisit_by', 'deferred_on', 'open_item']

def load(path):
    with open(path) as f:
        return yaml.safe_load(f)

def migrate(data):
    d = copy.deepcopy(data)
    if 'schema_version' not in d:                      # v1.0 -> v1.1
        d['schema_version'] = '1.1'
        stages = d.setdefault('artifact_stages', {})
        docs = {n for p in (d.get('phases') or {}).values()
                for n in ((p or {}).get('documents') or {})}
        if 'prd.md' in docs:
            stages.setdefault('prd', 'defined')
        if 'stories.md' in docs:
            stages.setdefault('estimation', 'fibonacci')
        for p in (d.get('phases') or {}).values():
            crit = (p or {}).get('exit_criteria')
            if isinstance(crit, dict):
                for k, v in list(crit.items()):
                    if isinstance(v, bool):
                        crit[k] = {'status': 'pass' if v else 'fail'}
        d.setdefault('reviews', {})
    if d['schema_version'] == '1.1':                   # v1.1 -> v1.2
        d['schema_version'] = '1.2'
        items = d.setdefault('open_items', [])
        nums = [int(m.group(1)) for i in items
                for m in [re.match(r'OI-(\d+)$', str(i.get('id', '')))] if m]
        n = max(nums, default=0)
        for phase_name, p in (d.get('phases') or {}).items():
            for doc_name, doc in ((p or {}).get('documents') or {}).items():
                if doc.get('status') != 'tbd':
                    continue
                n += 1
                revisit = phase_name if (phase_name in PHASES and
                    PHASES.index(phase_name) > PHASES.index('launch')) else 'launch'
                doc['status'] = 'deferred'
                doc['missing'] = doc.get('tbd_reason', 'TBD')
                doc['owner'] = 'TBD'
                doc['revisit_by'] = revisit
                doc['deferred_on'] = d.get('last_updated')
                doc['open_item'] = 'OI-%d' % n
                items.append({'id': 'OI-%d' % n, 'phase': phase_name, 'item': doc_name,
                              'missing': doc['missing'], 'owner': 'TBD',
                              'revisit_by': revisit, 'status': 'open'})
    return d

def check_v12(d):
    assert d.get('schema_version') == '1.2', 'schema_version not 1.2'
    assert isinstance(d.get('open_items'), list), 'open_items missing'
    by_id = {i['id']: i for i in d['open_items']}
    assert len(by_id) == len(d['open_items']), 'duplicate open item ids'
    for i in d['open_items']:
        for f in ['id', 'phase', 'item', 'missing', 'owner', 'revisit_by', 'status']:
            assert f in i, 'open item %s lacks %s' % (i.get('id'), f)
        assert i['status'] in ('open', 'resolved'), 'bad status ' + str(i['status'])
        assert i['revisit_by'] in PHASES, 'bad revisit_by ' + str(i['revisit_by'])
        if i['status'] == 'resolved':
            assert 'resolved_on' in i, i['id'] + ' resolved without resolved_on'
    for phase_name, p in (d.get('phases') or {}).items():
        p = p or {}
        entries = list((p.get('documents') or {}).items())
        crit = p.get('exit_criteria')
        if isinstance(crit, dict):
            entries += [(k, v) for k, v in crit.items() if isinstance(v, dict)]
        for name, e in entries:
            assert e.get('status') != 'tbd', name + ' still tbd'
            if e.get('status') != 'deferred':
                continue
            for f in DEFER_FIELDS:
                assert f in e, '%s deferred without %s' % (name, f)
            oi = by_id.get(e['open_item'])
            assert oi, name + ' links to unknown open item'
            assert oi['phase'] == phase_name and oi['item'] == name, name + ' open item mismatch'
            for f in ['missing', 'owner', 'revisit_by']:
                assert oi[f] == e[f], '%s: %s differs from open item' % (name, f)
            assert oi['status'] == 'open', name + ' deferred but open item resolved'
        if p.get('status') == 'complete_with_open_items':
            assert any(i['phase'] == phase_name and i['status'] == 'open'
                       for i in d['open_items']), phase_name + ' has no open items'
PYEOF
)

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
# Test 10: v1.2 fixture has schema_version and open_items
# ============================================================
log_test "v1.2 file has schema_version and open_items"

if grep -q 'schema_version: "1.2"' "$FIXTURES_DIR/progress-v1.2-deferred.yaml" && grep -q '^open_items:' "$FIXTURES_DIR/progress-v1.2-deferred.yaml"; then
    log_pass "v1.2 file has schema_version 1.2 and open_items"
else
    log_fail "v1.2 file missing schema_version 1.2 or open_items"
fi

# ============================================================
# Test 11: v1.2 deferred doc + criterion link to open items
# ============================================================
log_test "v1.2 deferred items are consistent with open_items"

V12_RESULT=$(python3 -c "$MIGRATE_PY
d = load('$FIXTURES_DIR/progress-v1.2-deferred.yaml')
check_v12(d)
define = d['phases']['define']
assert define['status'] == 'complete_with_open_items', 'phase status wrong'
assert define['documents']['metrics-framework.md']['status'] == 'deferred', 'doc not deferred'
assert define['exit_criteria']['success_metrics_have_baselines']['status'] == 'deferred', 'criterion not deferred'
assert define['exit_criteria']['success_metrics_have_baselines']['owner'] == 'TBD', 'owner TBD not allowed'
assert sum(1 for i in d['open_items'] if i['status'] == 'open') == 2, 'open count wrong'
print('OK')
" 2>&1)

if [[ "$V12_RESULT" == "OK" ]]; then
    log_pass "Deferred document and criterion match their open items"
else
    log_fail "v1.2 consistency issue: $V12_RESULT"
fi

# ============================================================
# Test 12: v1.1 -> v1.2 converts tbd documents to deferred
# ============================================================
log_test "v1.1 -> v1.2 migration converts tbd to deferred + open item"

M11_RESULT=$(python3 -c "$MIGRATE_PY
src = load('$FIXTURES_DIR/progress-v1.1-tbd.yaml')
d = migrate(src)
check_v12(d)
doc = d['phases']['define']['documents']['metrics-framework.md']
assert doc['status'] == 'deferred', 'status not deferred'
assert doc['missing'] == 'Activation-rate baseline not available yet', 'missing != tbd_reason'
assert doc['tbd_reason'] == 'Activation-rate baseline not available yet', 'tbd_reason dropped'
assert doc['owner'] == 'TBD', 'owner default wrong'
assert doc['revisit_by'] == 'launch', 'revisit_by default wrong'
assert doc['deferred_on'] == src['last_updated'], 'deferred_on wrong'
assert doc['reviewer'] == 'Jane Doe', 'custom field lost'
assert len(d['open_items']) == 1, 'expected one open item'
oi = d['open_items'][0]
assert oi['item'] == 'metrics-framework.md' and oi['phase'] == 'define' and oi['status'] == 'open'
assert d['phases']['define']['documents']['prd.md'] == src['phases']['define']['documents']['prd.md'], 'other doc changed'
assert d['phases']['intake'] == src['phases']['intake'], 'intake changed'
assert d['gates_passed'] == src['gates_passed'] and d['reviews'] == src['reviews'], 'top-level data changed'
assert src['phases']['define']['documents']['metrics-framework.md']['status'] == 'tbd', 'source mutated'
print('OK')
" 2>&1)

if [[ "$M11_RESULT" == "OK" ]]; then
    log_pass "tbd document migrated to deferred with matching open item, nothing lost"
else
    log_fail "v1.1 -> v1.2 migration issue: $M11_RESULT"
fi

# ============================================================
# Test 13: v1.0 -> v1.2 via v1.1 path
# ============================================================
log_test "v1.0 files migrate to v1.2 through v1.1"

M10_RESULT=$(python3 -c "$MIGRATE_PY
basic = migrate(load('$FIXTURES_DIR/progress-v1.0-basic.yaml'))
check_v12(basic)
assert basic['open_items'] == [], 'open_items not empty'
assert 'reviews' in basic, 'reviews missing'
assert basic['artifact_stages']['prd'] == 'defined', 'prd stage default missing'
assert basic['phases']['intake']['exit_criteria_passed'] == True, 'boolean lost'
custom = migrate(load('$FIXTURES_DIR/progress-v1.0-custom-fields.yaml'))
check_v12(custom)
assert custom['team_notes'] and custom['custom_metadata']['sprint'] == 12, 'custom fields lost'
assert custom['phases']['intake'].get('reviewer') == 'Jane Doe', 'phase custom field lost'
print('OK')
" 2>&1)

if [[ "$M10_RESULT" == "OK" ]]; then
    log_pass "v1.0 files reach v1.2 with empty open_items, data preserved"
else
    log_fail "v1.0 -> v1.2 migration issue: $M10_RESULT"
fi

# ============================================================
# Test 14: Migration leaves v1.2 files unchanged
# ============================================================
log_test "Migrating a v1.2 file is a no-op"

NOOP_RESULT=$(python3 -c "$MIGRATE_PY
d = load('$FIXTURES_DIR/progress-v1.2-deferred.yaml')
assert migrate(d) == d, 'v1.2 file changed by migration'
m = migrate(load('$FIXTURES_DIR/progress-v1.1-full.yaml'))
check_v12(m)
assert migrate(m) == m, 'migration not idempotent'
print('OK')
" 2>&1)

if [[ "$NOOP_RESULT" == "OK" ]]; then
    log_pass "v1.2 files unchanged; migration is idempotent"
else
    log_fail "Idempotence issue: $NOOP_RESULT"
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
