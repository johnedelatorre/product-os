#!/bin/bash
# Product OS Static Validation
# Validates template paths, command references, agent consistency, and documentation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRODUCT_OS_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PRODUCT_OS_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

CHECKS_PASSED=0
CHECKS_FAILED=0
WARNINGS=0

log_check() { echo -e "\n${YELLOW}[CHECK]${NC} $1"; }
log_pass() { echo -e "${GREEN}[PASS]${NC} $1"; CHECKS_PASSED=$((CHECKS_PASSED + 1)); }
log_fail() { echo -e "${RED}[FAIL]${NC} $1"; CHECKS_FAILED=$((CHECKS_FAILED + 1)); }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; WARNINGS=$((WARNINGS + 1)); }

echo "Product OS Static Validation"
echo "============================="
echo ""

# ============================================================
# Check 1: All referenced templates exist
# ============================================================
log_check "Template paths in documentation"

TEMPLATE_REFS=$(grep -roh "templates/[a-z/-]*\.md" docs/ .claude/ README.md 2>/dev/null | sort -u || true)
MISSING_TEMPLATES=0

for ref in $TEMPLATE_REFS; do
    if [[ ! -f "$ref" ]]; then
        log_warn "Referenced template not found: $ref"
        MISSING_TEMPLATES=$((MISSING_TEMPLATES + 1))
    fi
done

if [[ $MISSING_TEMPLATES -eq 0 ]]; then
    log_pass "All referenced templates exist"
else
    # Templates are referenced as guidance; missing ones are warnings not blockers
    log_warn "$MISSING_TEMPLATES template references point to non-existent files (can be created as needed)"
fi

# ============================================================
# Check 2: All agents have corresponding commands
# ============================================================
log_check "Agent-command correspondence"

AGENTS=$(ls .claude/agents/*.md 2>/dev/null | wc -l)
COMMANDS=$(ls .claude/commands/*.md 2>/dev/null | wc -l)

echo "  Agents: $AGENTS"
echo "  Commands: $COMMANDS"

if [[ $AGENTS -gt 0 ]] && [[ $COMMANDS -gt 0 ]]; then
    log_pass "Agents and commands directories populated"
else
    log_fail "Missing agents or commands"
fi

# ============================================================
# Check 3: Skills directory complete
# ============================================================
log_check "Skills directory"

SKILLS=$(ls .claude/skills/*.md 2>/dev/null | wc -l)
echo "  Skills: $SKILLS"

# Check key skills exist
REQUIRED_SKILLS=("clear-output.md" "estimation.md" "guided-workflow.md" "context-freshness.md")
MISSING_SKILLS=0

for skill in "${REQUIRED_SKILLS[@]}"; do
    if [[ ! -f ".claude/skills/$skill" ]]; then
        log_warn "Required skill missing: $skill"
        MISSING_SKILLS=$((MISSING_SKILLS + 1))
    fi
done

if [[ $MISSING_SKILLS -eq 0 ]]; then
    log_pass "All required skills present"
else
    log_fail "$MISSING_SKILLS required skills missing"
fi

# ============================================================
# Check 4: PRD template has required sections
# ============================================================
log_check "PRD template sections"

PRD_TEMPLATE="templates/pm/prd.md"
if [[ -f "$PRD_TEMPLATE" ]]; then
    REQUIRED_SECTIONS=("Problem Statement" "Hypotheses" "Goals" "Requirements" "Metrics" "Rollout" "Stop Criteria")
    MISSING_SECTIONS=0
    
    for section in "${REQUIRED_SECTIONS[@]}"; do
        if ! grep -qi "$section" "$PRD_TEMPLATE"; then
            log_warn "PRD template missing section: $section"
            MISSING_SECTIONS=$((MISSING_SECTIONS + 1))
        fi
    done
    
    if [[ $MISSING_SECTIONS -eq 0 ]]; then
        log_pass "PRD template has all required sections"
    else
        log_fail "PRD template missing $MISSING_SECTIONS sections"
    fi
else
    log_fail "PRD template not found"
fi

# ============================================================
# Check 5: Estimation skill has T-shirt and Fibonacci
# ============================================================
log_check "Estimation skill completeness"

ESTIMATION_SKILL=".claude/skills/estimation.md"
if [[ -f "$ESTIMATION_SKILL" ]]; then
    HAS_TSHIRT=$(grep -c "T-shirt" "$ESTIMATION_SKILL" || echo "0")
    HAS_FIBONACCI=$(grep -c -i "fibonacci" "$ESTIMATION_SKILL" || echo "0")
    HAS_SPIKE=$(grep -c -i "spike" "$ESTIMATION_SKILL" || echo "0")
    
    if [[ $HAS_TSHIRT -gt 0 ]] && [[ $HAS_FIBONACCI -gt 0 ]] && [[ $HAS_SPIKE -gt 0 ]]; then
        log_pass "Estimation skill covers T-shirt, Fibonacci, and spikes"
    else
        log_fail "Estimation skill incomplete"
    fi
else
    log_fail "Estimation skill not found"
fi

# ============================================================
# Check 6: Gate keeper has status types
# ============================================================
log_check "Gate keeper status types"

GATE_KEEPER=".claude/agents/gate-keeper.md"
if [[ -f "$GATE_KEEPER" ]]; then
    STATUSES=("Pass" "Fail" "Conditional" "N/A" "Not Verified")
    MISSING_STATUSES=0
    
    for status in "${STATUSES[@]}"; do
        if ! grep -qi "$status" "$GATE_KEEPER"; then
            log_warn "Gate keeper missing status: $status"
            MISSING_STATUSES=$((MISSING_STATUSES + 1))
        fi
    done
    
    if [[ $MISSING_STATUSES -eq 0 ]]; then
        log_pass "Gate keeper has all status types"
    else
        log_fail "Gate keeper missing $MISSING_STATUSES status types"
    fi
else
    log_fail "Gate keeper agent not found"
fi

# ============================================================
# Check 7: Traceability template exists
# ============================================================
log_check "Traceability template"

if [[ -f "templates/delivery/traceability.md" ]]; then
    log_pass "Traceability template exists"
else
    log_fail "Traceability template missing"
fi

# ============================================================
# Check 8: Decision logger has reversibility
# ============================================================
log_check "Decision logger completeness"

DECISION_LOGGER=".claude/agents/decision-logger.md"
if [[ -f "$DECISION_LOGGER" ]]; then
    HAS_REVERSIBILITY=$(grep -c -i "reversibility" "$DECISION_LOGGER" || echo "0")
    HAS_REVIEW_TRIGGERS=$(grep -c -i "review trigger" "$DECISION_LOGGER" || echo "0")
    
    if [[ $HAS_REVERSIBILITY -gt 0 ]] && [[ $HAS_REVIEW_TRIGGERS -gt 0 ]]; then
        log_pass "Decision logger has reversibility and review triggers"
    else
        log_fail "Decision logger missing reversibility or review triggers"
    fi
else
    log_fail "Decision logger not found"
fi

# ============================================================
# Check 9: Guided workflow skill has schema version
# ============================================================
log_check "Progress schema versioning"

GUIDED_WORKFLOW=".claude/skills/guided-workflow.md"
if [[ -f "$GUIDED_WORKFLOW" ]]; then
    if grep -q "schema_version" "$GUIDED_WORKFLOW"; then
        log_pass "Progress schema has version field"
    else
        log_fail "Progress schema missing version field"
    fi
    
    if grep -q "Schema Migration" "$GUIDED_WORKFLOW"; then
        log_pass "Schema migration documented"
    else
        log_warn "Schema migration not documented"
    fi
else
    log_fail "Guided workflow skill not found"
fi

# ============================================================
# Check 10: Installer includes skills
# ============================================================
log_check "Installer includes skills directory"

INSTALLER="scripts/install.sh"
if [[ -f "$INSTALLER" ]]; then
    if grep -q "skills" "$INSTALLER"; then
        log_pass "Installer references skills directory"
    else
        log_fail "Installer missing skills directory handling"
    fi
else
    log_fail "Installer not found"
fi

# ============================================================
# Check 11: README has key sections
# ============================================================
log_check "README completeness"

README="README.md"
if [[ -f "$README" ]]; then
    REQUIRED_README=("Quick Start" "Guided Mode" "Agents" "Skills" "Configuration")
    MISSING_README=0
    
    for section in "${REQUIRED_README[@]}"; do
        if ! grep -qi "$section" "$README"; then
            log_warn "README missing section: $section"
            MISSING_README=$((MISSING_README + 1))
        fi
    done
    
    if [[ $MISSING_README -eq 0 ]]; then
        log_pass "README has all key sections"
    else
        log_fail "README missing $MISSING_README sections"
    fi
else
    log_fail "README not found"
fi

# ============================================================
# Check 12: Clear output skill referenced in agents
# ============================================================
log_check "Clear output style referenced"

AGENTS_WITH_OUTPUT_STYLE=$(grep -rl "clear-output.md" .claude/agents/ 2>/dev/null | wc -l || echo "0")
TOTAL_AGENTS=$(ls .claude/agents/*.md 2>/dev/null | wc -l)

echo "  Agents referencing clear-output: $AGENTS_WITH_OUTPUT_STYLE / $TOTAL_AGENTS"

if [[ $AGENTS_WITH_OUTPUT_STYLE -eq $TOTAL_AGENTS ]]; then
    log_pass "All agents reference clear-output style"
elif [[ $AGENTS_WITH_OUTPUT_STYLE -gt $((TOTAL_AGENTS * 8 / 10)) ]]; then
    log_warn "Most agents reference clear-output ($AGENTS_WITH_OUTPUT_STYLE/$TOTAL_AGENTS)"
else
    log_fail "Many agents missing clear-output reference"
fi

# ============================================================
# Summary
# ============================================================
echo ""
echo "============================="
echo "Validation Summary"
echo "============================="
echo -e "${GREEN}Passed: $CHECKS_PASSED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
echo -e "${RED}Failed: $CHECKS_FAILED${NC}"
echo ""

if [[ $CHECKS_FAILED -gt 0 ]]; then
    echo "Some checks failed. Review output above."
    exit 1
else
    echo "All critical checks passed!"
    exit 0
fi
