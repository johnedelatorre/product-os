#!/bin/bash
# Product OS Installation Script
# Installs Product OS into a target project
#
# Features:
# - Non-destructive: backs up existing files, never overwrites without asking
# - Includes all components: agents, commands, skills, templates
# - Supports copy and submodule modes
# - Idempotent: safe to run multiple times

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRODUCT_OS_DIR="$(dirname "$SCRIPT_DIR")"
VERSION="1.5.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    echo "Product OS Installer v${VERSION}"
    echo ""
    echo "Usage: $0 <target-directory> [options]"
    echo ""
    echo "Options:"
    echo "  --copy         Copy files directly (default, you own the files)"
    echo "  --submodule    Install as git submodule (auto-updates)"
    echo "  --platform X   Platform to install for: both, claude, cursor (default: both)"
    echo "  --register-plugin  Enable the product-os Claude Code plugin in the target (needs the claude CLI)"
    echo "  --force        Overwrite existing files without backup (use with caution)"
    echo "  --help         Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/my-project                    # Install for both platforms"
    echo "  $0 /path/to/my-project --platform claude  # Claude Code only"
    echo "  $0 /path/to/my-project --platform cursor  # Cursor only"
    echo "  $0 /path/to/my-project --submodule"
    echo "  $0 /path/to/my-project --force"
    echo ""
    echo "The installer will:"
    echo "  - Back up existing CLAUDE.md/AGENTS.md (if present)"
    echo "  - Copy/link .claude/agents and .claude/skills"
    echo "  - Copy/link a reference copy of the commands to .claude/product-os/commands"
    echo "  - Claude Code commands come from the product-os plugin (/product-os:<command>)"
    echo "  - Copy .cursor/rules/ for Cursor support"
    echo "  - Copy templates/ directory"
    echo "  - Copy config templates (product-os.config.yaml, .env.example)"
    echo "  - Create initiatives/ directory"
    echo ""
    echo "Platform Support:"
    echo "  - Claude Code: Full slash commands, native subagent delegation"
    echo "  - Cursor: Project rules, role-based invocation, some native subagents"
    echo ""
    echo "To update an existing installation, run the installer again."
}

backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        cp "$file" "$backup"
        log_info "Backed up $file to $backup"
        echo "$backup"
    fi
}

safe_copy() {
    local src="$1"
    local dest="$2"
    local force="$3"
    
    if [[ -f "$dest" ]] && [[ "$force" != "true" ]]; then
        # Check if files are identical
        if cmp -s "$src" "$dest" 2>/dev/null; then
            log_info "Skipping $dest (identical)"
            return 0
        fi
        # Non-destructive: backup and copy
        backup_file "$dest"
        cp "$src" "$dest"
        log_info "Updated $dest (backup saved)"
        return 0
    elif [[ -f "$dest" ]] && [[ "$force" == "true" ]]; then
        cp "$src" "$dest"
        log_info "Forced update $dest"
        return 0
    fi
    cp "$src" "$dest"
    log_info "Copied $dest"
}

safe_copy_dir() {
    local src="$1"
    local dest="$2"
    local force="$3"
    
    mkdir -p "$dest"
    
    # Copy each file, backing up modified ones
    for src_file in "$src"/*; do
        local filename=$(basename "$src_file")
        local dest_file="$dest/$filename"
        
        if [[ -d "$src_file" ]]; then
            # Recursively handle subdirectories
            safe_copy_dir "$src_file" "$dest_file" "$force"
        elif [[ -f "$src_file" ]]; then
            if [[ -f "$dest_file" ]] && [[ "$force" != "true" ]]; then
                # Check if files differ
                if ! cmp -s "$src_file" "$dest_file" 2>/dev/null; then
                    backup_file "$dest_file"
                fi
            fi
            cp "$src_file" "$dest_file"
        fi
    done
    log_info "Copied directory $dest"
}

warn_legacy_commands() {
    local legacy_dir="$1"
    [[ -d "$legacy_dir" ]] || return 0
    local found=()
    for src_file in "$PRODUCT_OS_DIR/.claude/commands"/*.md; do
        local name=$(basename "$src_file")
        [[ -f "$legacy_dir/$name" ]] && found+=("$name")
        [[ -f "$legacy_dir/product-os-$name" ]] && found+=("product-os-$name")
    done
    if [[ ${#found[@]} -gt 0 ]]; then
        log_warn "Found ${#found[@]} Product OS command files from an older install in $legacy_dir"
        log_warn "They register un-namespaced commands. Remove them once the plugin is enabled:"
        for name in "${found[@]}"; do echo "    $legacy_dir/$name"; done
    fi
}

register_plugin() {
    local target_dir="$1"
    local marketplace_source="$2"
    if ! command -v claude > /dev/null 2>&1; then
        log_warn "claude CLI not found; skipping plugin registration"
        return 0
    fi
    (
        cd "$target_dir"
        claude plugin marketplace add "$marketplace_source" --scope project
        claude plugin install product-os@product-os --scope project
    ) && log_info "Enabled the product-os plugin for $target_dir (project scope)"
}

print_plugin_steps() {
    local target_dir="$1"
    local marketplace_source="$2"
    echo "  Claude Code commands come from the product-os plugin (/product-os:<command>):"
    echo "    cd \"$target_dir\""
    echo "    claude plugin marketplace add \"$marketplace_source\" --scope project"
    echo "    claude plugin install product-os@product-os --scope project"
    echo "  Or rerun the installer with --register-plugin to do this for you."
}

merge_claude_md() {
    local target_dir="$1"
    local target_file="$target_dir/CLAUDE.md"
    local source_file="$PRODUCT_OS_DIR/CLAUDE.md"
    
    if [[ -f "$target_file" ]]; then
        log_warn "Existing CLAUDE.md found"
        log_info "Your existing CLAUDE.md has been preserved."
        log_info "Product OS CLAUDE.md saved as CLAUDE.product-os.md"
        cp "$source_file" "$target_dir/CLAUDE.product-os.md"
        echo ""
        echo "To use Product OS, add this line to your CLAUDE.md:"
        echo "  See CLAUDE.product-os.md for Product OS instructions."
        echo ""
        echo "Or manually merge the Product OS sections you want."
    else
        cp "$source_file" "$target_file"
        log_info "Copied CLAUDE.md"
    fi
}

merge_agents_md() {
    local target_dir="$1"
    local target_file="$target_dir/AGENTS.md"
    local source_file="$PRODUCT_OS_DIR/AGENTS.md"
    
    if [[ -f "$target_file" ]]; then
        log_warn "Existing AGENTS.md found"
        log_info "Your existing AGENTS.md has been preserved."
        log_info "Product OS AGENTS.md saved as AGENTS.product-os.md"
        cp "$source_file" "$target_dir/AGENTS.product-os.md"
    else
        cp "$source_file" "$target_file"
        log_info "Copied AGENTS.md"
    fi
}

install_cursor() {
    local target_dir="$1"
    local force="$2"
    
    log_info "Installing Cursor support..."
    
    # Create .cursor/rules directory
    mkdir -p "$target_dir/.cursor/rules"
    
    # Copy Product OS rules file
    if [[ -f "$PRODUCT_OS_DIR/.cursor/rules/product-os.mdc" ]]; then
        safe_copy "$PRODUCT_OS_DIR/.cursor/rules/product-os.mdc" "$target_dir/.cursor/rules/product-os.mdc" "$force"
    else
        log_warn "Cursor rules file not found in Product OS source"
    fi
    
    # Copy Cursor native agents if they exist
    if [[ -d "$PRODUCT_OS_DIR/.cursor/agents" ]]; then
        safe_copy_dir "$PRODUCT_OS_DIR/.cursor/agents" "$target_dir/.cursor/agents" "$force"
        log_info "Cursor native agents installed"
    fi
    
    log_info "Cursor support installed"
}

install_copy() {
    local target_dir="$1"
    local force="$2"
    local platform="$3"
    
    log_info "Installing Product OS (copy mode, platform: $platform)..."
    
    # ALWAYS install canonical content (.claude/) - it's the shared source of truth
    # Both Cursor and Claude Code read from .claude/ for agents, skills, and commands
    # Cursor also reads CLAUDE.md and AGENTS.md automatically
    
    # Create .claude directory structure
    mkdir -p "$target_dir/.claude"
    
    # Copy agents and skills (required for both platforms)
    safe_copy_dir "$PRODUCT_OS_DIR/.claude/agents" "$target_dir/.claude/agents" "$force"
    safe_copy_dir "$PRODUCT_OS_DIR/.claude/skills" "$target_dir/.claude/skills" "$force"

    # Commands are a reference copy only. Claude Code gets them from the
    # product-os plugin as /product-os:<command>. Copying them into
    # .claude/commands/ would register un-namespaced names (/status, /plan,
    # /next) that collide with Claude Code built-ins.
    safe_copy_dir "$PRODUCT_OS_DIR/.claude/commands" "$target_dir/.claude/product-os/commands" "$force"
    warn_legacy_commands "$target_dir/.claude/commands"
    
    # Handle CLAUDE.md and AGENTS.md (read by both Cursor and Claude Code)
    merge_claude_md "$target_dir"
    merge_agents_md "$target_dir"
    
    log_info "Canonical content (.claude/) installed"
    
    # Install Cursor-specific support (native .cursor/rules/ and .cursor/agents/)
    if [[ "$platform" == "both" ]] || [[ "$platform" == "cursor" ]]; then
        install_cursor "$target_dir" "$force"
    fi
    
    # Note: Claude Code uses .claude/commands/ for slash commands
    # Cursor doesn't have native slash commands but reads the content
    
    # Copy templates (shared by both platforms)
    safe_copy_dir "$PRODUCT_OS_DIR/templates" "$target_dir/templates" "$force"
    
    # Copy config templates (don't overwrite if exist)
    if [[ ! -f "$target_dir/product-os.config.yaml" ]]; then
        cp "$PRODUCT_OS_DIR/product-os.config.yaml" "$target_dir/"
        log_info "Copied product-os.config.yaml"
    else
        log_info "Skipping product-os.config.yaml (exists)"
    fi
    
    if [[ ! -f "$target_dir/.env.example" ]]; then
        cp "$PRODUCT_OS_DIR/.env.example" "$target_dir/"
        log_info "Copied .env.example"
    else
        log_info "Skipping .env.example (exists)"
    fi
    
    # Copy scripts
    mkdir -p "$target_dir/scripts"
    if [[ -f "$PRODUCT_OS_DIR/scripts/atlassian-fallback.py" ]]; then
        safe_copy "$PRODUCT_OS_DIR/scripts/atlassian-fallback.py" "$target_dir/scripts/atlassian-fallback.py" "$force"
    fi
    if [[ -f "$PRODUCT_OS_DIR/scripts/doc-hygiene-check.py" ]]; then
        safe_copy "$PRODUCT_OS_DIR/scripts/doc-hygiene-check.py" "$target_dir/scripts/doc-hygiene-check.py" "$force"
    fi
    
    # Create initiatives directory
    mkdir -p "$target_dir/initiatives"
    touch "$target_dir/initiatives/.gitkeep"
    
    log_info "Copy installation complete"
}

install_submodule() {
    local target_dir="$1"
    local force="$2"
    local platform="$3"
    
    log_info "Installing Product OS (submodule mode, platform: $platform)..."
    
    cd "$target_dir"
    
    if [[ ! -d ".git" ]]; then
        log_error "Target is not a git repository. Use --copy mode or initialize git first."
        exit 1
    fi
    
    # Add submodule if not already present
    if [[ ! -d "product-os" ]]; then
        git submodule add https://github.com/johnedelatorre/product-os.git product-os
        log_info "Added product-os as submodule"
    else
        log_info "Submodule product-os already exists"
        cd product-os && git pull origin main && cd ..
        log_info "Updated product-os submodule"
    fi
    
    # ALWAYS install canonical content (.claude/) - required for both platforms
    # Create symlinks to .claude directory (including skills)
    mkdir -p .claude
    
    # Remove old symlinks if they exist
    rm -f .claude/agents .claude/skills 2>/dev/null || true
    # Older installs symlinked commands here; drop only that symlink
    if [[ -L .claude/commands ]] && [[ "$(readlink .claude/commands)" == "../product-os/.claude/commands" ]]; then
        rm -f .claude/commands
        log_info "Removed legacy .claude/commands symlink (commands now come from the plugin)"
    fi
    
    ln -sf ../product-os/.claude/agents .claude/agents
    mkdir -p .claude/product-os
    rm -f .claude/product-os/commands 2>/dev/null || true
    ln -sf ../../product-os/.claude/commands .claude/product-os/commands
    ln -sf ../product-os/.claude/skills .claude/skills
    log_info "Created symlinks for agents, skills, and the commands reference copy"
    
    # Handle CLAUDE.md and AGENTS.md (read by both Cursor and Claude Code)
    merge_claude_md "$target_dir"
    merge_agents_md "$target_dir"
    
    log_info "Canonical content (.claude/) installed"
    
    # Install Cursor-specific support (non-destructive)
    if [[ "$platform" == "both" ]] || [[ "$platform" == "cursor" ]]; then
        mkdir -p .cursor/rules
        if [[ -f "product-os/.cursor/rules/product-os.mdc" ]]; then
            local target_rule=".cursor/rules/product-os.mdc"
            if [[ -e "$target_rule" ]] && [[ ! -L "$target_rule" ]]; then
                # User has existing file - don't replace
                log_info "Skipping $target_rule (exists, not a symlink)"
            elif [[ -L "$target_rule" ]]; then
                # Replace existing symlink
                rm -f "$target_rule"
                ln -s ../../product-os/.cursor/rules/product-os.mdc "$target_rule"
                log_info "Updated symlink for Cursor rules"
            else
                # Create new symlink
                ln -s ../../product-os/.cursor/rules/product-os.mdc "$target_rule"
                log_info "Created symlink for Cursor rules"
            fi
        fi
        if [[ -d "product-os/.cursor/agents" ]]; then
            mkdir -p .cursor/agents
            for agent in product-os/.cursor/agents/*.md; do
                if [[ -f "$agent" ]]; then
                    local agent_name
                    agent_name="$(basename "$agent")"
                    local target_agent=".cursor/agents/$agent_name"
                    if [[ -e "$target_agent" ]] && [[ ! -L "$target_agent" ]]; then
                        # User has existing file - don't replace
                        log_info "Skipping $target_agent (exists, not a symlink)"
                    elif [[ -L "$target_agent" ]]; then
                        # Replace existing symlink
                        rm -f "$target_agent"
                        ln -s "../../$agent" "$target_agent"
                    else
                        # Create new symlink
                        ln -s "../../$agent" "$target_agent"
                    fi
                fi
            done
            log_info "Installed Cursor native agent symlinks"
        fi
    fi
    
    # Symlink templates (shared by both platforms)
    if [[ ! -L "templates" ]] && [[ ! -d "templates" ]]; then
        ln -sf product-os/templates templates
        log_info "Created symlink for templates"
    fi
    
    # Copy config templates (don't overwrite)
    if [[ ! -f "product-os.config.yaml" ]]; then
        cp product-os/product-os.config.yaml .
        log_info "Copied product-os.config.yaml"
    fi
    
    if [[ ! -f ".env.example" ]]; then
        cp product-os/.env.example .
        log_info "Copied .env.example"
    fi
    
    # Create initiatives directory
    mkdir -p initiatives
    touch initiatives/.gitkeep
    
    log_info "Submodule installation complete"
}

# Parse arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    usage
    exit 0
fi

TARGET_DIR="$1"
shift

METHOD="copy"
FORCE="false"
REGISTER_PLUGIN="false"
PLATFORM="both"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --copy)
            METHOD="copy"
            ;;
        --submodule)
            METHOD="submodule"
            ;;
        --platform)
            shift
            if [[ -z "$1" ]] || [[ "$1" == --* ]]; then
                log_error "--platform requires a value: both, claude, or cursor"
                exit 1
            fi
            case "$1" in
                both|claude|cursor)
                    PLATFORM="$1"
                    ;;
                *)
                    log_error "Invalid platform: $1 (must be: both, claude, or cursor)"
                    exit 1
                    ;;
            esac
            ;;
        --register-plugin)
            REGISTER_PLUGIN="true"
            ;;
        --force)
            FORCE="true"
            log_warn "Force mode: existing files will be overwritten"
            ;;
        *)
            log_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

# Validate target directory
if [[ ! -d "$TARGET_DIR" ]]; then
    log_error "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

# Convert to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

echo ""
echo "Product OS Installer v${VERSION}"
echo "================================"
echo "Target: $TARGET_DIR"
echo "Method: $METHOD"
echo "Platform: $PLATFORM"
echo "Force: $FORCE"
echo ""

# Run installation
case "$METHOD" in
    copy)
        install_copy "$TARGET_DIR" "$FORCE" "$PLATFORM"
        ;;
    submodule)
        install_submodule "$TARGET_DIR" "$FORCE" "$PLATFORM"
        ;;
esac

# The marketplace source the plugin is installed from: the submodule
# checkout, or this Product OS clone.
if [[ "$METHOD" == "submodule" ]]; then
    MARKETPLACE_SOURCE="$TARGET_DIR/product-os"
else
    MARKETPLACE_SOURCE="$PRODUCT_OS_DIR"
fi

if [[ "$REGISTER_PLUGIN" == "true" ]] && { [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "claude" ]]; }; then
    register_plugin "$TARGET_DIR" "$MARKETPLACE_SOURCE"
fi

echo ""
echo "================================"
log_info "Installation complete!"
echo ""
echo "Platform support installed:"
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "claude" ]]; then
    echo "  ✓ Claude Code (.claude/agents, .claude/skills; commands via the product-os plugin)"
fi
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "cursor" ]]; then
    echo "  ✓ Cursor (.cursor/rules/product-os.mdc)"
fi
echo ""
echo "Next steps:"
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "claude" ]]; then
    echo "  Claude Code:"
    echo "    1. If you have existing CLAUDE.md, merge from CLAUDE.product-os.md"
    if [[ "$REGISTER_PLUGIN" != "true" ]]; then
        print_plugin_steps "$TARGET_DIR" "$MARKETPLACE_SOURCE"
    fi
    echo "    2. Run /product-os:guide to start your first project"
fi
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "cursor" ]]; then
    echo "  Cursor:"
    echo "    1. Restart Cursor to load .cursor/rules/product-os.mdc"
    echo "    2. Say 'Read .claude/agents/guide.md and help me start a project'"
fi
echo ""
echo "  Both:"
echo "    1. Edit product-os.config.yaml with your Confluence/Jira settings"
echo "    2. Atlassian MCP connected? No credentials needed. Otherwise copy .env.example to .env for the REST fallback"
echo ""
echo "Documentation: See README.md and docs/guides/platform-compatibility.md"
