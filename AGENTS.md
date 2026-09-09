# Agent Workflow

All agents must read `AI_HANDOFF.md` before starting work.

The `Assigned To` field in `AI_HANDOFF.md` determines which agent should perform the next action.

---

## Builder

When `Assigned To: Builder`:

1. Read `Distributor Instructions`.
2. Read `Reviewer Report`.
3. Make the requested code changes.
4. Test the implementation when possible.
5. Update `Builder Report`.
6. Set:

Status: READY_FOR_REVIEW
Assigned To: Reviewer

Do not modify the Reviewer Report.

---

## Reviewer

When `Assigned To: Reviewer`:

1. Read `Distributor Instructions`.
2. Read `Builder Report`.
3. Inspect the actual code changes.
4. Run relevant tests when possible.
5. Check whether the implementation satisfies the task requirements.

If the implementation is acceptable, set:

Status: APPROVED
Assigned To: Distributor

If changes are required:

1. Write all issues under `Reviewer Report`.
2. Set:

Status: CHANGES_REQUESTED
Assigned To: Builder

Do not fix the implementation yourself.

---

## Distributor

The Distributor manages the task.

The Distributor may:

- create a new task
- define requirements
- assign work to Builder
- request a review
- decide what happens after approval

Distributor writes instructions under `Distributor Instructions`.

---

## General Rules

- Always inspect the real project files before making decisions.
- Do not rely only on another agent's report.
- Keep reports concise and specific.
- Mention the files changed or reviewed.
- Do not delete another agent's report unless starting a new task.