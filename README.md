# Master AI Skills & Rules Monorepo (`ai-skills`)

Central monorepo housing self-contained **AI Skill Suites & Workspace Rules** for different modes of software engineering—ranging from **First-Principles Human Mentorship** to **Autonomous End-to-End Product Delivery**.

Each suite lives in its own top-level folder with its own `AGENTS.md` (rule) and `skills/` directory so incompatible operating modes never clash.

---

## 📦 Suites Catalog

| Suite Folder | Short Aliases | Operating Mode | What It Does | Docs |
| :--- | :--- | :--- | :--- | :--- |
| **[`principal-software-eng-mentor/`](principal-software-eng-mentor/)** | `mentor`, `principal-mentor` | **AI-Augmented Mentorship** *(Human writes the code)* | Veteran Senior Principal Engineer, Polymath & Science Communicator ("Troglodyte-to-Hero"). Teaches systems thinking, cybernetics, architecture, CS theory with 4-layer mechanical empathy, spec-first idioms, Socratic debugging, and `Level N -> N+1` recursive notebooks. | [Suite README](principal-software-eng-mentor/README.md) |
| **[`product-engineering-sdlc/`](product-engineering-sdlc/)** | `product-engineering`, `products-engineering`, `sdlc` | **Autonomous SDLC Team** *(AI executes the pipeline)* | 9-skill cross-functional product & engineering suite (`engineering-orchestrator`, `idea-to-prd`, `prd-to-uiux-design`, `prd-to-tech-design`, `qa-test-planner`, `spec-to-backlog`, `tdd-task-executor`, `engineering-drift-auditor`, `ops-rollout-runbook`). | [Suite README](product-engineering-sdlc/README.md) |

---

## ⚡ Quick Usage: Pulling & Updating Skills (AI Prompt or Manual CLI)

### 1. Pulling a Skill Suite into Any Project (or Globally)

**Option A — Just Ask Your AI (One Sentence):**
- *"Pull the `mentor` skill from `https://github.com/varienjanitra/ai-skills` into this project."*
- *"Pull the `product-engineering` skills from `https://github.com/varienjanitra/ai-skills` into this workspace."*
- *(Add `"globally"` if you want it installed to `~/.gemini/config` for all workspaces).*

**Option B — Manual CLI (One Command):**
```bash
# Install into a specific project workspace:
./scripts/install.sh mentor /path/to/my-project
./scripts/install.sh product-engineering /path/to/my-project

# Or install globally (~/.gemini/config):
./scripts/install.sh mentor --global
./scripts/install.sh product-engineering --global
```

---

### 2. Committing & Pushing Skill Updates Back to GitHub

Whenever you refine a skill or rule inside a project workspace (or globally):

**Option A — Just Ask Your AI (One Sentence):**
- *"Sync and commit my `mentor` skill updates back to `https://github.com/varienjanitra/ai-skills`."*
- *"Sync and commit my `product-engineering` skill updates back to GitHub."*

**Option B — Manual CLI:**
```bash
# Sync modified AGENTS.md and .agents/skills/* from your project back into this monorepo:
./scripts/sync.sh mentor /path/to/my-project
# (Or from global config: ./scripts/sync.sh mentor --global)

# Review, commit, and push:
git status && git diff
git add -A && git commit -m "feat(mentor): refine skill instructions" && git push
```

---

## 🤖 Execution Runbook for AI Agents

> [!IMPORTANT]
> **Instructions for AI Agents reading this repository**: When the user asks you to pull/install a skill suite or commit/push skill updates, execute the exact steps below.

### Agent Workflow A: "Pull the `<suite>` skills here"
1. Clone or pull the latest monorepo into `/tmp/ai-skills-sync` (or use the local checkout if already present):
   ```bash
   git clone https://github.com/varienjanitra/ai-skills.git /tmp/ai-skills-sync 2>/dev/null || git -C /tmp/ai-skills-sync pull --ff-only
   ```
2. Run the unified installer targeting the current workspace `.` (or `--global` if requested):
   ```bash
   bash /tmp/ai-skills-sync/scripts/install.sh <suite-or-alias> .
   ```

### Agent Workflow B: "Commit / push the `<suite>` skills update"
1. Locate the local monorepo checkout (e.g., `/home/varien/repository/labs/ai-skills`) or clone `https://github.com/varienjanitra/ai-skills.git`, and run `git pull --rebase`.
2. Sync the updated rule and skills from the active workspace (or `--global`) back into the suite directory:
   ```bash
   bash ./scripts/sync.sh <suite-or-alias> /path/to/active-workspace
   ```
3. Verify `git diff`, stage, commit with a descriptive Conventional Commit message, and run `git push origin main`.

---

## ➕ Adding a New Suite in the Future

To add a new skill suite `<new-suite-name>` to this monorepo:
1. Create `<new-suite-name>/AGENTS.md` (optional workspace rule) and `<new-suite-name>/skills/<skill-name>/SKILL.md`.
2. `./scripts/install.sh <new-suite-name> /path/to/project` and `./scripts/sync.sh <new-suite-name> /path/to/project` will automatically recognize the new folder with zero script changes required (and you can optionally add a shorthand alias in `scripts/install.sh` and `scripts/sync.sh`).
