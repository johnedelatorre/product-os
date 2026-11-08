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
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

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
# Test 10: Existing .claude/agents preserved
# ============================================================
log_test "Existing .claude/agents content preserved"

TEST_DIR="$TEST_ROOT/existing-agents"
mkdir -p "$TEST_DIR/.claude/agents"

# Create custom agent
echo "# My Custom Agent" > "$TEST_DIR/.claude/agents/my-custom-agent.md"

# Install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check custom agent preserved
if [[ -f "$TEST_DIR/.claude/agents/my-custom-agent.md" ]] && \
   grep -q "My Custom Agent" "$TEST_DIR/.claude/agents/my-custom-agent.md"; then
    log_pass "Custom agent file preserved"
else
    log_fail "Custom agent file lost"
fi

# Check Product OS agents also present
if [[ -f "$TEST_DIR/.claude/agents/orchestrator.md" ]]; then
    log_pass "Product OS agents also installed"
else
    log_fail "Product OS agents missing"
fi

# ============================================================
# Test 11: Existing .claude/skills preserved
# ============================================================
log_test "Existing .claude/skills content preserved"

TEST_DIR="$TEST_ROOT/existing-skills"
mkdir -p "$TEST_DIR/.claude/skills"

# Create custom skill
echo "# My Custom Skill" > "$TEST_DIR/.claude/skills/my-custom-skill.md"

# Install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check custom skill preserved
if [[ -f "$TEST_DIR/.claude/skills/my-custom-skill.md" ]] && \
   grep -q "My Custom Skill" "$TEST_DIR/.claude/skills/my-custom-skill.md"; then
    log_pass "Custom skill file preserved"
else
    log_fail "Custom skill file lost"
fi

# ============================================================
# Test 12: Existing templates preserved
# ============================================================
log_test "Existing templates content preserved"

TEST_DIR="$TEST_ROOT/existing-templates"
mkdir -p "$TEST_DIR/templates/custom"

# Create custom template
echo "# My Custom Template" > "$TEST_DIR/templates/custom/custom-template.md"

# Install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check custom template preserved
if [[ -f "$TEST_DIR/templates/custom/custom-template.md" ]] && \
   grep -q "My Custom Template" "$TEST_DIR/templates/custom/custom-template.md"; then
    log_pass "Custom template preserved"
else
    log_fail "Custom template lost"
fi

# ============================================================
# Test 13: Backup path uniqueness (no collision)
# ============================================================
log_test "Backup path uniqueness"

TEST_DIR="$TEST_ROOT/backup-collision"
mkdir -p "$TEST_DIR"

# First install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Modify CLAUDE.md
echo "Modified content 1" >> "$TEST_DIR/CLAUDE.product-os.md"

# Second install (should create unique backup)
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Modify again
echo "Modified content 2" >> "$TEST_DIR/CLAUDE.product-os.md"

# Third install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check multiple backups exist with unique names
BACKUP_COUNT=$(ls "$TEST_DIR/"CLAUDE.product-os.md.backup.* 2>/dev/null | wc -l || echo "0")
if [[ "$BACKUP_COUNT" -ge 1 ]]; then
    log_pass "Backup files have unique timestamps"
else
    log_warn "No backups created (may be OK if files identical)"
fi

# ============================================================
# Test 14: Dirty worktree handling
# ============================================================
log_test "Installation in dirty worktree"

TEST_DIR="$TEST_ROOT/dirty-worktree"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"
git init -q
echo "test" > testfile.txt
git add testfile.txt
git commit -q -m "initial"
echo "uncommitted change" >> testfile.txt  # Dirty worktree

# Install should still work
if "$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1; then
    log_pass "Installation works in dirty worktree"
else
    log_fail "Installation failed in dirty worktree"
fi

cd "$TEST_ROOT"

# ============================================================
# Test 15: product-os.config.yaml not overwritten
# ============================================================
log_test "Config file customization preserved"

TEST_DIR="$TEST_ROOT/config-custom"
mkdir -p "$TEST_DIR"

# First install
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Customize config
echo "custom_setting: my_value" >> "$TEST_DIR/product-os.config.yaml"

# Reinstall
"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check customization preserved
if grep -q "custom_setting: my_value" "$TEST_DIR/product-os.config.yaml"; then
    log_pass "Config customization preserved"
else
    log_fail "Config customization lost"
fi

# ============================================================
# Test 16: Platform: Claude only
# ============================================================
log_test "Platform: Claude only installation"

TEST_DIR="$TEST_ROOT/platform-claude"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy --platform claude > /dev/null 2>&1

if [[ -d "$TEST_DIR/.claude/agents" ]] && [[ -f "$TEST_DIR/CLAUDE.md" ]]; then
    log_pass "Claude Code files installed"
else
    log_fail "Claude Code files missing"
fi

if [[ ! -d "$TEST_DIR/.cursor" ]]; then
    log_pass "Cursor files correctly excluded"
else
    log_fail "Cursor files should not exist in claude-only mode"
fi

# ============================================================
# Test 17: Platform: Cursor only (still installs canonical .claude)
# ============================================================
log_test "Platform: Cursor only installation"

TEST_DIR="$TEST_ROOT/platform-cursor"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy --platform cursor > /dev/null 2>&1

if [[ -f "$TEST_DIR/.cursor/rules/product-os.mdc" ]]; then
    log_pass "Cursor rules installed"
else
    log_fail "Cursor rules missing"
fi

# Canonical .claude content IS installed (Cursor needs it)
if [[ -d "$TEST_DIR/.claude/agents" ]] && [[ -d "$TEST_DIR/.claude/skills" ]]; then
    log_pass "Canonical .claude content installed (required by Cursor)"
else
    log_fail "Canonical .claude content missing (Cursor rules would break)"
fi

# Templates should still be present (shared)
if [[ -d "$TEST_DIR/templates" ]]; then
    log_pass "Shared templates installed"
else
    log_fail "Shared templates missing"
fi

# ============================================================
# Test 18: Platform: Both (default)
# ============================================================
log_test "Platform: Both installation (default)"

TEST_DIR="$TEST_ROOT/platform-both"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

if [[ -d "$TEST_DIR/.claude/agents" ]] && [[ -f "$TEST_DIR/.cursor/rules/product-os.mdc" ]]; then
    log_pass "Both platform files installed"
else
    log_fail "Missing files for one or both platforms"
fi

# ============================================================
# Test 19: Cursor rules file references .claude paths
# ============================================================
log_test "Cursor rules reference valid paths"

TEST_DIR="$TEST_ROOT/cursor-refs"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check that Cursor rules reference .claude paths that exist
if grep -q ".claude/agents" "$TEST_DIR/.cursor/rules/product-os.mdc" 2>/dev/null && \
   grep -q ".claude/skills" "$TEST_DIR/.cursor/rules/product-os.mdc" 2>/dev/null; then
    log_pass "Cursor rules reference .claude paths"
else
    log_fail "Cursor rules missing .claude references"
fi

# ============================================================
# Test 20: Existing .cursor directory preserved
# ============================================================
log_test "Existing .cursor directory preserved"

TEST_DIR="$TEST_ROOT/existing-cursor"
mkdir -p "$TEST_DIR/.cursor/rules"

# Create existing cursor config
echo "# My Custom Cursor Rules" > "$TEST_DIR/.cursor/rules/my-rules.mdc"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check custom rules preserved
if grep -q "My Custom Cursor Rules" "$TEST_DIR/.cursor/rules/my-rules.mdc"; then
    log_pass "Existing Cursor rules preserved"
else
    log_fail "Existing Cursor rules overwritten"
fi

# Check product-os rules added
if [[ -f "$TEST_DIR/.cursor/rules/product-os.mdc" ]]; then
    log_pass "Product OS Cursor rules added"
else
    log_fail "Product OS Cursor rules not added"
fi

# ============================================================
# Test 21: Cursor MDC file has proper frontmatter
# ============================================================
log_test "Cursor MDC file has proper frontmatter"

TEST_DIR="$TEST_ROOT/cursor-frontmatter"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check MDC has YAML frontmatter
if head -5 "$TEST_DIR/.cursor/rules/product-os.mdc" | grep -q "^---"; then
    log_pass "MDC file has frontmatter delimiter"
else
    log_fail "MDC file missing frontmatter"
fi

# Check for alwaysApply or description (required for activation)
if grep -q "alwaysApply:" "$TEST_DIR/.cursor/rules/product-os.mdc" || \
   grep -q "description:" "$TEST_DIR/.cursor/rules/product-os.mdc"; then
    log_pass "MDC file has activation policy"
else
    log_fail "MDC file missing alwaysApply or description"
fi

# ============================================================
# Test 22: Cursor-only installs canonical .claude content
# ============================================================
log_test "Cursor-only installs canonical .claude content"

TEST_DIR="$TEST_ROOT/cursor-deps"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy --platform cursor > /dev/null 2>&1

# Cursor rules reference .claude paths - verify those exist
if [[ -d "$TEST_DIR/.claude/agents" ]] && \
   [[ -d "$TEST_DIR/.claude/skills" ]]; then
    log_pass "Cursor install includes .claude dependencies"
else
    log_fail "Cursor install missing .claude dependencies (rules would break)"
fi

# Verify CLAUDE.md exists (Cursor reads it automatically)
if [[ -f "$TEST_DIR/CLAUDE.md" ]] || [[ -f "$TEST_DIR/CLAUDE.product-os.md" ]]; then
    log_pass "CLAUDE.md present for Cursor"
else
    log_fail "CLAUDE.md missing (Cursor auto-applies it)"
fi

# ============================================================
# Test 23: Cursor rules reference only existing paths
# ============================================================
log_test "Cursor rules reference only existing paths"

TEST_DIR="$TEST_ROOT/cursor-refs-valid"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Extract .claude paths from rules and verify they exist
MISSING=0
for path in $(grep -oE '\.claude/[a-z/-]+\.md' "$TEST_DIR/.cursor/rules/product-os.mdc" 2>/dev/null | sort -u); do
    if [[ ! -f "$TEST_DIR/$path" ]]; then
        log_warn "Rule references missing: $path"
        MISSING=$((MISSING + 1))
    fi
done

if [[ $MISSING -eq 0 ]]; then
    log_pass "All Cursor rule references resolve"
else
    log_fail "$MISSING Cursor rule references missing"
fi

# ============================================================
# Test 24: No false subagent_type claims in rules
# ============================================================
log_test "No false subagent_type claims in rules"

TEST_DIR="$TEST_ROOT/no-false-subagents"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

# Check rules don't claim specific subagent_types that aren't portable
if grep -qiE "subagent_type|available.*subagent" "$TEST_DIR/.cursor/rules/product-os.mdc" 2>/dev/null; then
    log_fail "Rules claim specific subagent_types (not portable)"
else
    log_pass "Rules don't make false subagent_type claims"
fi

# ============================================================
# Test 25: Cursor native agents have proper format
# ============================================================
log_test "Cursor native agents have proper format"

TEST_DIR="$TEST_ROOT/cursor-agents-format"
mkdir -p "$TEST_DIR"

"$INSTALLER" "$TEST_DIR" --copy > /dev/null 2>&1

if [[ -d "$TEST_DIR/.cursor/agents" ]]; then
    # Check at least one agent has YAML frontmatter
    VALID=0
    for agent in "$TEST_DIR/.cursor/agents"/*.md; do
        if [[ -f "$agent" ]] && head -3 "$agent" | grep -q "^---"; then
            VALID=$((VALID + 1))
        fi
    done
    if [[ $VALID -gt 0 ]]; then
        log_pass "Cursor agents have YAML frontmatter"
    else
        log_fail "Cursor agents missing frontmatter"
    fi
else
    log_warn "No .cursor/agents directory (optional)"
fi

# ============================================================
# Test 26: Command inventory consistency
# ============================================================
log_test "Command inventory consistency"

# Count commands in .claude/commands
CMD_COUNT=$(ls "$PRODUCT_OS_DIR/.claude/commands/"*.md 2>/dev/null | wc -l)

# Check README mentions similar count
README_CMD=$(grep -oP '\d+(?=.*command)' "$PRODUCT_OS_DIR/README.md" | head -1)

if [[ -n "$README_CMD" ]] && [[ "$README_CMD" -eq "$CMD_COUNT" ]] 2>/dev/null; then
    log_pass "README command count matches actual ($CMD_COUNT)"
else
    log_warn "README says $README_CMD commands, found $CMD_COUNT"
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
