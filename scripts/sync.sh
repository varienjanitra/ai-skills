#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Unified AI Skills Monorepo Sync-Back Helper
# Syncs modified rules and skills from a project workspace (or --global) back
# into the appropriate suite folder in this monorepo so they can be committed.
#
# Usage:
#   ./scripts/sync.sh <suite-or-alias> [source-project-dir | --global]
# ==============================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <suite-or-alias> [source-project-dir | --global]"
    exit 1
fi

RAW_SUITE="$1"
SOURCE="${2:-.}"

resolve_suite() {
    case "$1" in
        mentor|principal-mentor|principal-software-eng-mentor)
            echo "principal-software-eng-mentor"
            ;;
        product-engineering|products-engineering|sdlc|product-engineering-sdlc)
            echo "product-engineering-sdlc"
            ;;
        *)
            if [ -d "$REPO_ROOT/$1" ]; then
                echo "$1"
            else
                echo "Error: Unknown skill suite '$1'." >&2
                exit 1
            fi
            ;;
    esac
}

SUITE_DIR_NAME="$(resolve_suite "$RAW_SUITE")"
SUITE_PATH="$REPO_ROOT/$SUITE_DIR_NAME"

if [ "$SOURCE" = "--global" ] || [ "$SOURCE" = "-g" ]; then
    SRC_SKILLS_DIR="$HOME/.gemini/config/skills"
    SRC_RULE_FILE="$HOME/.gemini/config/GEMINI.md"
else
    ABS_SOURCE="$(cd "$SOURCE" && pwd)"
    SRC_SKILLS_DIR="$ABS_SOURCE/.agents/skills"
    if [ -f "$ABS_SOURCE/.agents/rules/$SUITE_DIR_NAME.md" ]; then
        SRC_RULE_FILE="$ABS_SOURCE/.agents/rules/$SUITE_DIR_NAME.md"
    else
        SRC_RULE_FILE="$ABS_SOURCE/AGENTS.md"
    fi
fi

echo -e "${BLUE}=== Syncing updates back into suite [$SUITE_DIR_NAME] ===${NC}"

if [ -f "$SRC_RULE_FILE" ]; then
    cp "$SRC_RULE_FILE" "$SUITE_PATH/AGENTS.md"
    echo "  ✓ Synced rule -> $SUITE_DIR_NAME/AGENTS.md"
fi

if [ -d "$SUITE_PATH/skills" ] && [ -d "$SRC_SKILLS_DIR" ]; then
    for skill_dir in "$SUITE_PATH"/skills/*/; do
        skill_name="$(basename "$skill_dir")"
        if [ -d "$SRC_SKILLS_DIR/$skill_name" ]; then
            rm -rf "$SUITE_PATH/skills/$skill_name"
            cp -R "$SRC_SKILLS_DIR/$skill_name" "$SUITE_PATH/skills/$skill_name"
            echo "  ✓ Synced skill -> $SUITE_DIR_NAME/skills/$skill_name"
        fi
    done
fi

echo -e "${GREEN}✓ Sync complete! Review changes with: git -C $REPO_ROOT status && git -C $REPO_ROOT diff${NC}"
