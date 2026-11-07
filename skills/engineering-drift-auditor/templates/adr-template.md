# [ADR-{NUMBER}] {Short Title of Architectural Decision / Deviation}

**Status:** Proposed | Accepted | Rejected | Superseded  
**Date:** {YYYY-MM-DD}  
**Author(s):** {Engineer / Tech Lead}  
**Originating Audit:** [`docs/audits/{feature-name}-conformance-audit.md`](../audits/{feature-name}-conformance-audit.md)  
**Document Path:** `docs/adr/{NUMBER}-{short-slug}.md`

---

## 1. Context & Problem Statement
* What deviation occurred during implementation, or what new constraint was discovered?
* Why did the original Technical Design Doc (`docs/architecture/{feature}-tech-design.md`) become suboptimal or unfeasible in practice?

---

## 2. Decision
* What is the new approved architectural or design choice?
* What changes in the code are officially accepted as the new standard?

---

## 3. Consequences & Trade-Offs

### 3.1 Positive Impacts
- {e.g. Reduced query latency by 40% using Redis hash instead of relational query}
- {e.g. Simplified client state management}

### 3.2 Negative Impacts / Liabilities Accepted
- {e.g. Introduced eventual consistency window of 500ms}
- {e.g. Requires additional memory allocation on Redis instance}

---

## 4. Compliance & Reconciliation Actions
- [ ] Technical Design Doc referenced and annotated with this ADR link.
- [ ] OpenAPI / Data schema contracts updated to reflect the new structure.
- [ ] Team notified in engineering channel.
