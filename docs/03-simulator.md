# Simulator evaluation and build decision

## Recommendation

Try the existing workbench first, use the catalogue editor as a second comparison, and build a local editor if their data interchange or interaction model blocks research. This is a provisional decision based on documentation. The acceptance trial below has not been run.

| Candidate | Documented behavior | Research fit and unknowns |
| --- | --- | --- |
| [Squares Project workbench](https://squaremath.org/workbench/) | Pack/animate/search modes, keyboard movement and rotation, snapshot import/export, seeded searches and ledger export | Closest apparent match. Test pointer editing, offline/local use, schema stability, and independent replay |
| [Ellsworth catalogue](https://kingbird.myphotos.cc/packing/squares_in_squares.html) | SVG edit mode: drag, Shift-constrained movement, Ctrl-rotation, save with `S`; recursive pushing is documented as unfinished | Quick access to known layouts. Test exports and collision behavior; editing uses double precision |
| [Square Packing Atlas](https://evand.github.io/square-packing/explore.html) | Pan/zoom, square inspection, angle groups, contacts and gaps | Strong visual reference. The inspected page does not establish arbitrary square editing; verify that separately |

The workbench documents exploratory browser results and a warning that animation values are not published evidence. Keep every exported edit at candidate status until checked. The [source register](02-sources.md) records repository and reuse details.

## A bounded acceptance trial

Use $n=1$, a $2\times 2$ grid, and the [five-square construction](01-problem.md). Record one row per tool and keep its original export unchanged.

1. Load a reference packing. Identify its container side, unit scale, center/corner convention, angle units, and vertical axis direction.
2. Translate and rotate one square; try exact edge contact, a small gap, and a small overlap. Determine whether the tool blocks, pushes, resolves, or merely marks collisions.
3. Change the container side. Check wall feedback and whether the reported side rescales the small squares.
4. Save, reload, and compare every pose and the side, not only the rendered image. Measure coordinate drift and record serialization precision.
5. Transfer the export through a small adapter into the proposed [witness format](04-geometry-and-data.md). Check it independently.
6. Repeat a seeded search if provided; compare exported results under the same settings. Capture solver version and budget.
7. Record missing features, required source changes, and the effort to maintain an adapter.

Reuse wins if these fixtures survive round trips, poses are accessible, manual rotation works, and a checker can consume the result. A small adapter is preferable when the only gap is serialization. Build locally when editing or reproducibility needs substantial upstream surgery.

## Minimal local editor, if needed

Proposed implementation choice: TypeScript with SVG for a modest number of squares. SVG offers direct hit testing and inspection; benchmark before choosing Canvas for larger scenes. No framework or dependency has been selected or installed.

First capabilities:

- Arbitrary $n$, container side $L$, center dragging, rotation handle, and numeric pose editing.
- Explicit optional snapping; retain unrestricted angles as the default research mode.
- Undo/redo, stable IDs, reset, and import/export with provenance.
- Clear wall violations and pair overlap diagnostics, with contact and uncertainty shown separately.
- Fit-to-view, zoom, and SVG export for notes.
- A reproducible snapshot that a headless checker can consume.

Store geometry in a UI-independent module. Draw with a camera transform from mathematical coordinates; do not rewrite the stored poses merely to fit the viewport. Numerical search should run off the UI thread and return ordinary snapshots.

Physics-based pushing can come later. It is an interaction aid and a heuristic, with behavior distinct from a feasibility checker. Preserve the ability to inspect an invalid placement while repairing it.

## Completion criteria for a first local prototype

A user can load the five-square witness, edit and undo a pose, see overlaps and wall violations, save/reload the same coordinates, and send the saved data to a headless diagnostic. The screen shows the diagnostic's assurance level. No optimality badge is inferred from a solver stopping.
