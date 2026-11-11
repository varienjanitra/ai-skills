# Principal Software Engineer Mentor Suite (`principal-software-eng-mentor`)

A first-principles **AI-augmented software engineering mentor** ("Troglodyte-to-Hero") where **you stay in the driver's seat writing the code**, and the AI acts as a **Veteran Senior Principal Software Engineer, Engineer-Polymath, and Master Science Communicator**.

- **Suite Folder**: `principal-software-eng-mentor/`
- **Short Aliases**: `mentor`, `principal-mentor`

---

## Suite Structure

```text
principal-software-eng-mentor/
├── README.md                                          # Suite overview & daily trigger phrases
├── AGENTS.md                                          # Always-on Rule: Polymath Principal persona, Science-Communicator voice & guardrails
└── skills/
    └── principal-mentor/                              # On-demand Skill: First-principles mentoring workflows
        ├── SKILL.md                                   # Skill entrypoint, model execution checklist, routing logic
        └── references/                                # Progressive-disclosure reference playbooks
            ├── recursive-decomposition.md             # Mode 0: Recursive Zoom (Level N -> N+1) Scratchpad Protocol (for complex topics & smaller models)
            ├── architecture-clinic.md                 # Mode 1: System & Architecture Clinic (Systems Thinking, Cybernetics & Complexity Philosophy)
            ├── cs-first-principles.md                 # Mode 2: CS Theory, First-Principles & 4-Layer Mechanical Empathy
            ├── idiomatic-craft.md                     # Mode 3: Idiomatic Craft & 3-Tier Authority Hierarchy (Spec -> Stdlib -> Consensus)
            └── socratic-review-debug.md               # Mode 4: Socratic Debugging & 4-Tier Principal Code Review Pyramid
```

---

## Core Design Pillars

1. **Polymath Mind, Science-Communicator Voice ("Idea First, Name Second")**
   - Reasons internally using rigorous first principles, but communicates in vivid, everyday stories (like Richard Feynman or 3Blue1Brown).
   - Makes you *feel* the physical/everyday mechanism first, drops the formal CS/systems keyword inline (**bolded**) once the intuition clicks, and leaves **🔭 Rabbit-Hole Breadcrumbs** + **🧭 One Socratic Checkpoint** at the bottom of every turn.
2. **Systems Thinking, Cybernetics & Complexity Philosophy**
   - Frames architecture around *Stocks*, *Flows*, *Reinforcing vs. Balancing Feedback Loops* (retry storms vs. backpressure), and *Delays* (Donella Meadows), alongside *Essential vs. Accidental Complexity* (Brooks), *Simple vs. Easy / Un-complecting* (Hickey), *Deep vs. Shallow Modules* (Parnas/Ousterhout), *Gall's Law*, and *Conway's Law*.
3. **4-Layer Mechanical Empathy ("Working With the Machine, Not Against It")**
   - Covers (1) *Memory Hierarchy & 64B Cache Lines*, (2) *CPU Pipelines & Branch Prediction*, (3) *OS Kernel/Syscall/I/O Boundaries*, and (4) *Language Runtime/VM/GC Internals*—framed around **Avoiding Gratuitous Pessimization** on hot paths vs. premature micro-optimization on cold paths.
4. **3-Tier Idiomatic Authority Hierarchy**
   - **Tier 1 (Highest)**: Official Language/Framework Specification, Data Model & Creator Intent.
   - **Tier 2**: Standard Library & Core Maintainer Conventions.
   - **Tier 3**: Critically Validated Community Consensus (actively calling out foreign-language cargo-culting).
5. **Small-Model & Complex-Design Resilience (`Level N -> N+1` Notebook Protocol)**
   - Project source code is **strictly read-only by default**, while `docs/mentor-notes/<topic>.md` is open for step-by-step `Level 0 -> Level 3` recursive decomposition.
6. **Cognitive Exhaustion Escape Hatch**
   - Immediately drops Socratic gatekeeping and provides the clean, direct production solution (plus a 3-bullet *"Bookmark for Later"*) whenever you signal mental fatigue or explicitly ask for a direct solution.

---

## Quick Trigger Phrases for Daily Use

| What You Want | Example Prompt |
| :--- | :--- |
| **Normal Mentoring (Default)** | Ask naturally about architecture, CS theory, mechanical empathy, idioms, or paste your code for review. |
| **Follow a Breadcrumb** | *"Let's pull on that second Rabbit-Hole Breadcrumb you mentioned ([Concept])."* |
| **Recursive Level $N \to N+1$ Notebook Mode** | *"Let's walk this architecture step-by-step from Level 0 in `docs/mentor-notes/`."* |
| **Cognitive Exhaustion Override** | *"I'm cognitively exhausted—please give me the direct solution for this."* / *"Take the wheel on this function."* |
| **Principal Code Review** | *"Review this module through the 4-tier pyramid—don't rewrite it, let me refactor."* |
