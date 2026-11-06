#!/bin/bash
# Product OS Installation Script
# Installs Product OS into a target project

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRODUCT_OS_DIR="$(dirname "$SCRIPT_DIR")"

usage() {
    echo "Usage: $0 <target-directory> [options]"
    echo ""
    echo "Options:"
    echo "  --submodule    Install as git submodule (auto-updates)"
    echo "  --copy         Copy files directly (default, you own the files)"
    echo "  --help         Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/my-project"
    echo "  $0 /path/to/my-project --submodule"
}

if [[ $# -lt 1 ]] || [[ "$1" == "--help" ]]; then
    usage
    exit 0
fi

TARGET_DIR="$1"
METHOD="${2:---copy}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Target directory does not exist: $TARGET_DIR"
    exit 1
fi

echo "Installing Product OS to: $TARGET_DIR"
echo "Method: $METHOD"
echo ""

case "$METHOD" in
    --submodule)
        echo "Adding Product OS as git submodule..."
        cd "$TARGET_DIR"
        
        if [[ ! -d ".git" ]]; then
            echo "Error: Target is not a git repository"
            exit 1
        fi
        
        git submodule add https://github.com/johnedelatorre/product-os.git product-os
        
        # Create symlinks to .claude directory
        mkdir -p .claude
        ln -sf ../product-os/.claude/agents .claude/agents
        ln -sf ../product-os/.claude/commands .claude/commands
        
        # Copy config template
        cp product-os/product-os.config.yaml product-os.config.yaml
        cp product-os/.env.example .env.example
        
        echo ""
        echo "Installed as submodule. To update:"
        echo "  cd product-os && git pull"
        ;;
        
    --copy)
        echo "Copying Product OS files..."
        
        # Copy .claude directory
        mkdir -p "$TARGET_DIR/.claude"
        cp -r "$PRODUCT_OS_DIR/.claude/agents" "$TARGET_DIR/.claude/"
        cp -r "$PRODUCT_OS_DIR/.claude/commands" "$TARGET_DIR/.claude/"
        
        # Copy templates
        cp -r "$PRODUCT_OS_DIR/templates" "$TARGET_DIR/"
        
        # Copy config and docs
        cp "$PRODUCT_OS_DIR/product-os.config.yaml" "$TARGET_DIR/"
        cp "$PRODUCT_OS_DIR/.env.example" "$TARGET_DIR/"
        cp "$PRODUCT_OS_DIR/CLAUDE.md" "$TARGET_DIR/"
        cp "$PRODUCT_OS_DIR/AGENTS.md" "$TARGET_DIR/"
        
        # Copy scripts
        mkdir -p "$TARGET_DIR/scripts"
        cp "$PRODUCT_OS_DIR/scripts/atlassian-fallback.py" "$TARGET_DIR/scripts/"
        
        # Create initiatives directory
        mkdir -p "$TARGET_DIR/initiatives"
        touch "$TARGET_DIR/initiatives/.gitkeep"
        
        echo ""
        echo "Copied Product OS files. You own these files now."
        ;;
        
    *)
        echo "Unknown method: $METHOD"
        usage
        exit 1
        ;;
esac

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "1. Copy .env.example to .env and add your Atlassian credentials"
echo "2. Edit product-os.config.yaml with your Confluence/Jira settings"
echo "3. Run /product-os:new-project to start your first project"
echo ""
echo "Documentation: See README.md and docs/ for detailed guides"
