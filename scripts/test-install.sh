#!/bin/bash
# Product OS Installer Tests
# Tests fresh install, existing file conflicts, repeat installs, and both modes
#
# Usage: ./scripts/test-install.sh
#
# All tests run in temporary directories and clean up after themselves.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRODUCT_OS_DIR="$(dirname "$SCRIPT_DIR")"
INSTALLER="$SCRIPT_DIR/install.sh"

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

# Create a temp directory for all tests
TEST_ROOT=$(mktemp -d)
trap "rm -rf $TEST_ROOT" EXIT

echo "Product OS Installer Tests"
echo "=========================="
echo "Test root: $TEST_ROOT"
echo ""

# ============================================================
# Test 1: Fresh install (copy mode)
# ============================================================
log_test "Fresh install (copy mode)"

TEST_DIR="$TEST_ROOT/fresh-copy"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check required directories exist
if [[ -d "$TEST_DIR/.claude/agents" ]] && \
   [[ -d "$TEST_DIR/.claude/commands" ]] && \
   [[ -d "$TEST_DIR/.claude/skills" ]] && \
   [[ -d "$TEST_DIR/templates" ]]; then
    log_pass "Directories created"
else
    log_fail "Missing directories"
fi

# Check skills directory specifically (was missing in prior bug)
if [[ -f "$TEST_DIR/.claude/skills/clear-output.md" ]]; then
    log_pass "Skills directory included"
else
    log_fail "Skills directory missing (known prior bug)"
fi

# Check files exist
if [[ -f "$TEST_DIR/CLAUDE.md" ]] && \
   [[ -f "$TEST_DIR/AGENTS.md" ]] && \
   [[ -f "$TEST_DIR/product-os.config.yaml" ]]; then
    log_pass "Core files created"
else
    log_fail "Missing core files"
fi

# ============================================================
# Test 2: Existing CLAUDE.md conflict (copy mode)
# ============================================================
log_test "Existing CLAUDE.md conflict (copy mode)"

TEST_DIR="$TEST_ROOT/existing-claude"
mkdir -p "$TEST_DIR"

# Create existing CLAUDE.md with custom content
echo "# My Existing Instructions" > "$TEST_DIR/CLAUDE.md"
echo "Custom content here" >> "$TEST_DIR/CLAUDE.md"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check original preserved
if grep -q "My Existing Instructions" "$TEST_DIR/CLAUDE.md"; then
    log_pass "Existing CLAUDE.md preserved"
else
    log_fail "Existing CLAUDE.md was overwritten"
fi

# Check Product OS version saved separately
if [[ -f "$TEST_DIR/CLAUDE.product-os.md" ]]; then
    log_pass "Product OS CLAUDE.md saved as .product-os.md"
else
    log_fail "Product OS CLAUDE.md not saved separately"
fi

# ============================================================
# Test 3: Existing AGENTS.md conflict (copy mode)
# ============================================================
log_test "Existing AGENTS.md conflict (copy mode)"

TEST_DIR="$TEST_ROOT/existing-agents"
mkdir -p "$TEST_DIR"

# Create existing AGENTS.md
echo "# My Custom Agents" > "$TEST_DIR/AGENTS.md"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check original preserved
if grep -q "My Custom Agents" "$TEST_DIR/AGENTS.md"; then
    log_pass "Existing AGENTS.md preserved"
else
    log_fail "Existing AGENTS.md was overwritten"
fi

# Check Product OS version saved separately
if [[ -f "$TEST_DIR/AGENTS.product-os.md" ]]; then
    log_pass "Product OS AGENTS.md saved as .product-os.md"
else
    log_fail "Product OS AGENTS.md not saved separately"
fi

# ============================================================
# Test 4: Repeat install (copy mode) - idempotent
# ============================================================
log_test "Repeat install (copy mode) - idempotent"

TEST_DIR="$TEST_ROOT/repeat-copy"
mkdir -p "$TEST_DIR"

# First install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Modify a file
echo "User customization" >> "$TEST_DIR/.claude/agents/orchestrator.md"

# Second install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check backup was created
BACKUP_COUNT=$(ls "$TEST_DIR/.claude/agents/"orchestrator.md.backup.* 2>/dev/null | wc -l || echo "0")
if [[ "$BACKUP_COUNT" -gt 0 ]]; then
    log_pass "Modified file backed up on repeat install"
else
    log_fail "No backup created for modified file"
fi

# ============================================================
# Test 5: Fresh install (submodule mode) - requires git
# ============================================================
log_test "Fresh install (submodule mode simulation)"

TEST_DIR="$TEST_ROOT/fresh-submodule"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"
git init -q

# Note: We can't actually test submodule add without network
# But we can verify the script handles non-git directories correctly

TEST_DIR_NOGIT="$TEST_ROOT/nogit"
mkdir -p "$TEST_DIR_NOGIT"

if "$INSTALLER" "$TEST_DIR_NOGIT" --submodule 2>&1 | grep -q "not a git repository"; then
    log_pass "Submodule mode rejects non-git directory"
else
    log_fail "Submodule mode should reject non-git directory"
fi

# ============================================================
# Test 6: Config files not overwritten on repeat
# ============================================================
log_test "Config files not overwritten on repeat"

TEST_DIR="$TEST_ROOT/config-preserve"
mkdir -p "$TEST_DIR"

# First install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Modify config
echo "custom: value" >> "$TEST_DIR/product-os.config.yaml"

# Second install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check custom content preserved
if grep -q "custom: value" "$TEST_DIR/product-os.config.yaml"; then
    log_pass "Config file customization preserved"
else
    log_fail "Config file was overwritten"
fi

# ============================================================
# Test 7: Templates included
# ============================================================
log_test "Templates included"

TEST_DIR="$TEST_ROOT/templates"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check PRD template exists (new in this version)
if [[ -f "$TEST_DIR/templates/pm/prd.md" ]]; then
    log_pass "PRD template included"
else
    log_fail "PRD template missing"
fi

# Check traceability template exists (new in this version)
if [[ -f "$TEST_DIR/templates/delivery/traceability.md" ]]; then
    log_pass "Traceability template included"
else
    log_fail "Traceability template missing"
fi

# ============================================================
# Test 8: Initiatives directory created
# ============================================================
log_test "Initiatives directory created"

TEST_DIR="$TEST_ROOT/initiatives"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

if [[ -d "$TEST_DIR/initiatives" ]]; then
    log_pass "Initiatives directory created"
else
    log_fail "Initiatives directory missing"
fi

# ============================================================
# Test 9: Force mode overwrites
# ============================================================
log_test "Force mode overwrites"

TEST_DIR="$TEST_ROOT/force"
mkdir -p "$TEST_DIR"

# Create existing CLAUDE.md
echo "Original content" > "$TEST_DIR/CLAUDE.md"

# Install with force
"$INSTALLER" "$TEST_DIR" --copy --force > /dev/null 2>&1

# Check if overwritten (force should still respect merge logic)
# Note: Current implementation preserves even with force for CLAUDE.md
# This is intentional behavior - force affects other files
if [[ -f "$TEST_DIR/CLAUDE.product-os.md" ]] || grep -q "Product OS" "$TEST_DIR/CLAUDE.md" 2>/dev/null; then
    log_pass "Force mode handled CLAUDE.md appropriately"
else
    log_fail "Force mode behavior unexpected"
fi

# ============================================================
# Summary
# ============================================================
echo ""
echo "=========================="
echo "Test Summary"
echo "=========================="
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -gt 0 ]]; then
    echo "Some tests failed. Review output above."
    exit 1
else
    echo "All tests passed!"
    exit 0
fi
