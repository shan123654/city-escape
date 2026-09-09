# Agent Workflow

All agents must read `AI_HANDOFF.md` before starting work.

The `Assigned To` field in `AI_HANDOFF.md` determines which agent should perform the next action.

---

## Workflow State Transitions

`Status` and `Assigned To` in `AI_HANDOFF.md` must be updated together according to
this state machine:

| Current status | Agent that acts | Allowed next status | Next assigned agent |
| --- | --- | --- | --- |
| `IDLE` | Distributor | `READY_FOR_BUILD` | Builder |
| `READY_FOR_BUILD` | Builder | `READY_FOR_REVIEW` | Reviewer |
| `READY_FOR_REVIEW` | Reviewer | `CHANGES_REQUESTED` | Builder |
| `READY_FOR_REVIEW` | Reviewer | `APPROVED` | Distributor |
| `CHANGES_REQUESTED` | Builder | `READY_FOR_REVIEW` | Reviewer |
| `APPROVED` | Distributor | `IDLE` | Distributor |

Only the agent named in `Assigned To` may perform the next transition. If the current
`Status` and `Assigned To` combination does not match this table, do not guess or
modify implementation files; report the inconsistent workflow state.

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

During normal task operation, the Reviewer must only modify `AI_HANDOFF.md` unless
explicitly instructed otherwise.

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

During normal task assignment, the Distributor should only modify `AI_HANDOFF.md`
unless explicitly instructed otherwise.

### Coordination Git Handoff

When the Distributor or Reviewer needs to return an `AI_HANDOFF.md` coordination
change to the shared `main` branch:

1. Commit the change on the current working branch.
2. Create a pull request targeting `main`.
3. Mark the pull request with the `agent-handoff` label. Do not apply this label to
   Builder implementation pull requests or other non-coordination changes.
4. Let the agent handoff GitHub Actions workflow enable squash auto-merge. The agent
   must not attempt to enable auto-merge from the Codex Cloud shell.
5. Do not ask the user to merge the pull request manually.
6. Do not bypass branch protection, required checks, or review requirements.
7. If auto-merge cannot be enabled because of permissions, authentication, repository
   settings, conflicts, or failed checks, report the exact blocker instead of force
   merging.
8. Never force-push directly to `main`.

This rule applies only to Distributor- and Reviewer-owned coordination changes.

---

## General Rules

- Always inspect the real project files before making decisions.
- Do not rely only on another agent's report.
- Keep reports concise and specific.
- Mention the files changed or reviewed.
- Do not delete another agent's report unless starting a new task.
