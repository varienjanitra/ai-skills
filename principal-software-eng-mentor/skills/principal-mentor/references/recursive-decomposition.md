# Reference Playbook: Recursive Zoom (`Level N -> N+1`) Scratchpad Protocol

Use this playbook whenever:
1. The user asks a **broad architectural, system design, or multi-layered theoretical question** that cannot be deeply derived in a single pass without becoming shallow.
2. You are operating as a **smaller or faster AI model** (e.g., Flash/Lite tiers) where trying to hold Level 0 through Level 3 in a single generation pass causes instruction drop or superficial answers.
3. The user explicitly asks to **walk or document a topic progressively** in their engineering notebook (`docs/mentor-notes/`).

> [!IMPORTANT]
> **Voice Reminder**: Both in chat AND inside `docs/mentor-notes/<topic-slug>.md`, write with the **Polymath Science Communicator Voice** (**Idea First, Name Second**). Your notebook files should read like a crystal-clear, illustrated engineering field guide that the user will love re-reading months from now—never like a dry corporate specification.

---

## 1. Why Recursive File-Backed Decomposition Works
Frontier models can hold a large tree of constraints in latent working memory; smaller models cannot. By externalizing the state tree into a structured Markdown notebook (`docs/mentor-notes/<topic-slug>.md`) and solving **strictly one zoom level (`Level N`) per turn**:
- Each turn gets 100% of the model's reasoning budget for a single abstraction layer.
- Rules and promises (**Invariants**) decided at `Level N` are written to disk and read back before drafting `Level N+1`.
- The user finishes with a permanent, version-controlled **Engineering Design & Study Notebook** inside their repo.

---

## 2. The 4 Canonical Zoom Levels (`Level 0` $\to$ `Level 3`)

Never skip from `Level 0` straight to `Level 3` code structure. Walk down the tree one level at a time:

| Zoom Level | Name | Everyday Questions Answered at This Level |
| :--- | :--- | :--- |
| **`Level 0`** | **Purpose, Problem Forces & Core Promises** | *Why does this thing need to exist at all?* What is the real-world problem (**Essential Complexity**) vs. self-inflicted tool pain (**Accidental Complexity**)? What promises (**Invariants**) must never be broken? |
| **`Level 1`** | **Big-Picture Flow & System Dynamics** | What are the main rooms in the building? Where do things pile up (**Stocks**), how fast do they move (**Flows**), and how does the system push back when overloaded (**Balancing Feedback Loops / Backpressure**)? |
| **`Level 2`** | **Module Boundaries & 3 AM Failure Stories** | How do we hide messy details behind simple doorways (**Deep Modules**)? What happens when a step fails halfway through or messages arrive twice (**Idempotency / Sagas**)? |
| **`Level 3`** | **Mechanical Empathy & Idiomatic Blueprint** | How does this physically run on the CPU, RAM cache lines, OS kernel, and language runtime? What does the spec-first idiomatic type skeleton look like? |

---

## 3. The Turn-by-Turn Execution Loop

Follow this exact 4-step loop on every turn of a recursive decomposition:

### Step 1: Read Existing State (If `Level N > 0`)
- Check if `docs/mentor-notes/<topic-slug>.md` already exists.
- If it exists, read it first so you anchor your reasoning in the locked-in promises of `Level 0 .. Level N-1`.

### Step 2: Explain ONLY Current `Level N` in Chat (Science Communicator Style)
- Focus your entire explanation on **current `Level N`**.
- Open with an everyday physical analogy (**Idea First**), weave in formal terms inline (**Name Second**), draw a visual diagram, and highlight **2–3 Locked Promises (Invariants)** established at this level.

### Step 3: Persist `Level N` to `docs/mentor-notes/<topic-slug>.md`
- Create or update `docs/mentor-notes/<topic-slug>.md` using the template below.
- Mark `Level N` as `[IN REVIEW]` or `[LOCKED]` and leave `Level N+1` as `[PENDING NEXT ZOOM]` with open questions.

### Step 4: Close with Breadcrumbs + One Checkpoint Prompt Before Zooming to `Level N+1`
- Include **🔭 Rabbit-Hole Breadcrumbs** (2–3 adjacent concepts teased in plain English).
- End with **🧭 One Socratic Checkpoint** verifying the user is happy with `Level N`'s trade-offs before zooming into `Level N+1`.

---

## 4. Notebook File Template (`docs/mentor-notes/<topic-slug>.md`)

```markdown
# Engineering Notebook: <Topic Title>

- **Current Zoom Level**: Level <N> (<Level Name>)
- **Status**: In Progress (`Level 0` -> `Level 3`)

## Level 0: Purpose, Problem Forces & Core Promises [LOCKED]
- **Everyday Problem (Why This Exists)**: ...
- **Essential vs. Accidental Complexity**: ...
- **Unbreakable Promises (Core Invariants)**:
  1. ...

## Level 1: Big-Picture Flow & System Dynamics [IN REVIEW]
- **Where State Lives (Stocks) & How It Moves (Flows)**: ...
- **Pushback & Safety Valves (Balancing Feedback Loops)**: ...
- **Visual Map**:
  ```mermaid
  flowchart LR
    ...
  ```
- **Trade-Off Chosen & Why**: ...

## Level 2: Module Boundaries & 3 AM Failure Stories [PENDING NEXT ZOOM]
- *Open Question to Resolve Next*: ...

## Level 3: Mechanical Empathy & Idiomatic Blueprint [PENDING]
- *To be derived after Level 2 boundaries are locked.*
```
