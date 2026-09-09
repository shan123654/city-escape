# AI Handoff

## Current Task

Task ID: TASK-004
Status: READY_FOR_BUILD
Assigned To: Builder

---

## Distributor Instructions

Add player death and respawn after falling into the void.

Requirements:

1. Detect when the player has fallen approximately 100 Godot world units below the
   level's starting/platform height.
2. Treat reaching that fall threshold as player death and reuse the existing death
   flow rather than creating a separate, conflicting respawn path.
3. After death, restore the player at the level's original starting position. The
   current scene-reload behavior is acceptable if it reliably produces that result.
4. Preserve the existing monster-collision death behavior, movement, and camera
   controls.
5. Keep the threshold clear and maintainable (for example, as a named configurable
   value rather than an unexplained number embedded in movement code).

Acceptance criteria:

- Walking or standing on the platform does not trigger death.
- Falling roughly 100 world units below the starting/platform height triggers death
  once.
- The player then reappears at the original level spawn near `(0, 0.5, 0)` and can
  move normally again.
- Monster contact still triggers the same death/restart behavior.
- Relevant Godot project validation or a documented manual test is performed when
  possible.

---

## Builder Report

No report yet; new task.

---

## Reviewer Report

No review yet; new task.

---

## Next Action

Builder should implement TASK-004, test it when possible, update `Builder Report`, and
transition the handoff to `READY_FOR_REVIEW / Reviewer`.
