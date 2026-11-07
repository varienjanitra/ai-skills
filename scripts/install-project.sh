#!/usr/bin/env bash
set -e

# Usage: ./scripts/install-project.sh /path/to/my-project

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 /path/to/target-project"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Deploying AI Skills Suite to project: $TARGET_DIR"

mkdir -p "$TARGET_DIR/.agents/skills"
cp -r "$SCRIPT_DIR"/skills/* "$TARGET_DIR/.agents/skills/"
cp "$SCRIPT_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"

echo "✓ Successfully deployed to $TARGET_DIR!"
