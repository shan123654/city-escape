# AI Handoff

## Current Task

Task ID: TASK-004
Status: READY_FOR_REVIEW
Assigned To: Reviewer

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

Implementation to review: `builder/task-004`, commit `f123cc5`.
Branch: https://github.com/shan123654/city-escape/tree/builder/task-004
The implementation branch remains unmerged. This coordination branch changes only
`AI_HANDOFF.md`; review the Godot implementation on the Builder branch.

Implemented void-fall death using the existing guarded `die()` and deferred scene
reload. `fall_death_distance` is configurable in the Inspector (default: 100 world
units), measured from the player's original world-space spawn height. At the current
spawn Y of 0.5, death occurs at Y <= -99.5 after movement.

Files changed:
- `scripts/player.gd`: configurable fall distance, captured spawn height, and fall
  threshold check calling the existing death flow.
- `AI_HANDOFF.md`: Builder Report and handoff to Reviewer, published separately on
  `handoff/task-004-ready-for-review`.

Validation: Godot 4.7.2 headless project startup and a temporary windowed integration
test passed without warnings or runtime errors. Checked platform safety, the 99/100
unit boundary, duplicate-death protection, actually walking off the platform and
falling under gravity, original player/monster spawn restoration, movement/chase/
camera/cursor controls after respawn, and monster-contact death after a fall restart.
Temporary test files were removed. `git diff --check` passed.

Manual reproduction: launch with F5, hold Right to leave the platform and outrun the
monster, then wait for the fall to restart the level. After respawn, verify movement
and mouse orbit, then stand still to verify monster-contact restart.

---

## Reviewer Report

No review yet; new task.

---

## Next Action

Reviewer should inspect TASK-004 and its validation, then record the review outcome.
