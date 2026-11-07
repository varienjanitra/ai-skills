#!/usr/bin/env bash
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GLOBAL_CONFIG_DIR="$HOME/.gemini/config"
GLOBAL_SKILLS_DIR="$GLOBAL_CONFIG_DIR/skills"

echo -e "${BLUE}=== Deploying AI Skills Suite Globally to Antigravity ===${NC}"

# Create target directories
mkdir -p "$GLOBAL_SKILLS_DIR"

# Copy or symlink skills
echo "Deploying skills from: $SCRIPT_DIR/skills"
cp -r "$SCRIPT_DIR"/skills/* "$GLOBAL_SKILLS_DIR/"

# Deploy Global Directive / Rule
if [ -f "$SCRIPT_DIR/AGENTS.md" ]; then
    echo "Installing Engineering Lead Directive to $GLOBAL_CONFIG_DIR/GEMINI.md"
    cp "$SCRIPT_DIR/AGENTS.md" "$GLOBAL_CONFIG_DIR/GEMINI.md"
fi

echo -e "${GREEN}✓ Successfully deployed 9 skills and Director rule globally!${NC}"
echo -e "You can now use all skills across any workspace in Antigravity."
