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
VERSION="1.4.0"

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
    echo "  - Copy/link .claude/agents, .claude/commands, .claude/skills"
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
        backup_file "$dest"
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
    
    log_info "Cursor support installed"
}

install_copy() {
    local target_dir="$1"
    local force="$2"
    local platform="$3"
    
    log_info "Installing Product OS (copy mode, platform: $platform)..."
    
    # Install Claude Code support
    if [[ "$platform" == "both" ]] || [[ "$platform" == "claude" ]]; then
        # Create .claude directory structure
        mkdir -p "$target_dir/.claude"
        
        # Copy agents, commands, AND skills
        safe_copy_dir "$PRODUCT_OS_DIR/.claude/agents" "$target_dir/.claude/agents" "$force"
        safe_copy_dir "$PRODUCT_OS_DIR/.claude/commands" "$target_dir/.claude/commands" "$force"
        safe_copy_dir "$PRODUCT_OS_DIR/.claude/skills" "$target_dir/.claude/skills" "$force"
        
        # Handle CLAUDE.md and AGENTS.md carefully
        merge_claude_md "$target_dir"
        merge_agents_md "$target_dir"
        
        log_info "Claude Code support installed"
    fi
    
    # Install Cursor support
    if [[ "$platform" == "both" ]] || [[ "$platform" == "cursor" ]]; then
        install_cursor "$target_dir" "$force"
    fi
    
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
    
    # Install Claude Code support
    if [[ "$platform" == "both" ]] || [[ "$platform" == "claude" ]]; then
        # Create symlinks to .claude directory (including skills)
        mkdir -p .claude
        
        # Remove old symlinks if they exist
        rm -f .claude/agents .claude/commands .claude/skills 2>/dev/null || true
        
        ln -sf ../product-os/.claude/agents .claude/agents
        ln -sf ../product-os/.claude/commands .claude/commands
        ln -sf ../product-os/.claude/skills .claude/skills
        log_info "Created symlinks for agents, commands, and skills"
        
        # Handle CLAUDE.md and AGENTS.md carefully
        merge_claude_md "$target_dir"
        merge_agents_md "$target_dir"
        
        log_info "Claude Code support installed"
    fi
    
    # Install Cursor support
    if [[ "$platform" == "both" ]] || [[ "$platform" == "cursor" ]]; then
        mkdir -p .cursor/rules
        if [[ -f "product-os/.cursor/rules/product-os.mdc" ]]; then
            ln -sf ../../product-os/.cursor/rules/product-os.mdc .cursor/rules/product-os.mdc
            log_info "Created symlink for Cursor rules"
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

echo ""
echo "================================"
log_info "Installation complete!"
echo ""
echo "Platform support installed:"
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "claude" ]]; then
    echo "  ✓ Claude Code (.claude/agents, .claude/commands, .claude/skills)"
fi
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "cursor" ]]; then
    echo "  ✓ Cursor (.cursor/rules/product-os.mdc)"
fi
echo ""
echo "Next steps:"
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "claude" ]]; then
    echo "  Claude Code:"
    echo "    1. If you have existing CLAUDE.md, merge from CLAUDE.product-os.md"
    echo "    2. Run /product-os:guide to start your first project"
fi
if [[ "$PLATFORM" == "both" ]] || [[ "$PLATFORM" == "cursor" ]]; then
    echo "  Cursor:"
    echo "    1. Restart Cursor to load .cursor/rules/product-os.mdc"
    echo "    2. Say 'Read .claude/agents/guide.md and help me start a project'"
fi
echo ""
echo "  Both:"
echo "    1. Copy .env.example to .env and add your Atlassian credentials"
echo "    2. Edit product-os.config.yaml with your Confluence/Jira settings"
echo ""
echo "Documentation: See README.md and docs/guides/platform-compatibility.md"
