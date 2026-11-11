#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Unified AI Skills Monorepo Installer
# Usage:
#   ./scripts/install.sh <suite-or-alias> [target-project-dir]
#   ./scripts/install.sh <suite-or-alias> --global
#
# Suites & Aliases:
#   - principal-software-eng-mentor (Aliases: mentor, principal-mentor)
#   - product-engineering-sdlc      (Aliases: product-engineering, products-engineering, sdlc)
#   - Or any future <suite-folder> at the root of this repository
# ==============================================================================

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ $# -lt 1 ]; then
    echo "Usage:"
    echo "  $0 <suite-or-alias> [target-project-dir]   (defaults to current directory '.')"
    echo "  $0 <suite-or-alias> --global               (installs to ~/.gemini/config)"
    echo ""
    echo "Available suites:"
    echo "  - mentor              -> principal-software-eng-mentor"
    echo "  - product-engineering -> product-engineering-sdlc"
    exit 1
fi

RAW_SUITE="$1"
TARGET="${2:-.}"

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

if [ "$TARGET" = "--global" ] || [ "$TARGET" = "-g" ]; then
    GLOBAL_CONFIG_DIR="$HOME/.gemini/config"
    GLOBAL_SKILLS_DIR="$GLOBAL_CONFIG_DIR/skills"
    GLOBAL_RULES_DIR="$GLOBAL_CONFIG_DIR/rules"

    echo -e "${BLUE}=== Installing Suite [$SUITE_DIR_NAME] Globally to $GLOBAL_CONFIG_DIR ===${NC}"
    mkdir -p "$GLOBAL_SKILLS_DIR" "$GLOBAL_RULES_DIR"

    if [ -d "$SUITE_PATH/skills" ]; then
        cp -R "$SUITE_PATH"/skills/* "$GLOBAL_SKILLS_DIR/"
    fi

    if [ -f "$SUITE_PATH/AGENTS.md" ]; then
        cp "$SUITE_PATH/AGENTS.md" "$GLOBAL_CONFIG_DIR/GEMINI.md"
        cp "$SUITE_PATH/AGENTS.md" "$GLOBAL_RULES_DIR/$SUITE_DIR_NAME.md"
    fi

    echo -e "${GREEN}✓ Successfully installed [$SUITE_DIR_NAME] globally!${NC}"
else
    mkdir -p "$TARGET"
    ABS_TARGET="$(cd "$TARGET" && pwd)"
    echo -e "${BLUE}=== Installing Suite [$SUITE_DIR_NAME] to Project: $ABS_TARGET ===${NC}"

    mkdir -p "$ABS_TARGET/.agents/skills" "$ABS_TARGET/.agents/rules"

    if [ -d "$SUITE_PATH/skills" ]; then
        cp -R "$SUITE_PATH"/skills/* "$ABS_TARGET/.agents/skills/"
    fi

    if [ -f "$SUITE_PATH/AGENTS.md" ]; then
        cp "$SUITE_PATH/AGENTS.md" "$ABS_TARGET/AGENTS.md"
        cp "$SUITE_PATH/AGENTS.md" "$ABS_TARGET/.agents/rules/$SUITE_DIR_NAME.md"
    fi

    if [ "$SUITE_DIR_NAME" = "principal-software-eng-mentor" ]; then
        mkdir -p "$ABS_TARGET/docs/mentor-notes"
    fi

    echo -e "${GREEN}✓ Successfully installed [$SUITE_DIR_NAME] into $ABS_TARGET!${NC}"
    echo -e "${YELLOW}  - Rule installed to:   $ABS_TARGET/AGENTS.md (and .agents/rules/$SUITE_DIR_NAME.md)${NC}"
    echo -e "${YELLOW}  - Skills installed to: $ABS_TARGET/.agents/skills/${NC}"
fi
