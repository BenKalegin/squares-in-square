# Research log

## 2026-10-30 — Initial foundation

**Observed locally:** repository contains Git metadata only; `main` has no commits. The configured remote is `https://github.com/BenKalegin/squares-in-square.git`. No applicable `AGENTS.md` was found in the repository or its inspected ancestors. Node and Python are on PATH; Lean tooling was not found there.

**Working scope:** congruent unit squares in a square, arbitrary independent rotations, boundary contact allowed. This interpretation follows the proposed simulator and solution-search direction and remains open to revision.

**Research performed:** reviewed primary public documentation for the historical survey, Ellsworth catalogue/tools, Squares Project, Square Packing Atlas, selected certificate/formalization repositories, and official Lean/mathlib documentation. No external code or theorem was replayed. Sources and consultation limits are in [the source register](02-sources.md).

**Provisional choices:** evaluate an existing workbench before implementing an editor; use an independent geometry checker; share a witness format between visualization, search, and formalization; begin Lean with explicit feasible constructions; run agent campaigns only after experiments are reproducible.

**Important status observation:** the Squares Project reports a recent 12-square optimality claim with replay still pending there. Current target selection requires checking primary artifacts rather than relying on historical open-case lists.

**Next concrete action:** run the three-fixture simulator trial and record the exports, coordinate conventions, interaction behavior, and adapter effort. Then decide the implementation stack from observed requirements.

## 2026-10-30 — Proofs become the main research direction

**User direction:** the existing Squaremath workbench is useful, while the intended research should emphasize mathematical proofs and Lean. The proposed progression through a complete two-square optimum, a rotated five-square construction, and stronger lower-bound arguments was accepted.

**Updated priority:** prove precise statements and reusable geometric lemmas. Use the simulator for exploration and counterexamples. Custom viewer work and numerical optimization are supporting tracks.

**Written result:** [the two-square proof](08-two-square-proof.md) gives an explicit construction at side two and excludes every smaller side via a common interior point. It includes arbitrary orientations, the scalar inequality, and intended Lean dependencies. It has not been formalized or compiled.

**Next concrete action:** choose compatible Lean/mathlib pins and formalize the scalar inequality, square definition, containment bounds, and unavoidable-center lemma. No Lean installation or agent campaign has been started.

## 2026-10-30 — First Lean proof compiled

**Implemented:** [TwoSquares.lean](../lean/TwoSquares.lean) defines unit squares, closed-set containment, and packing via disjoint topological interiors. It proves the full two-square construction and universal lower bound, including arbitrary independent orientations.

**Environment:** Lean 4.24.0 with mathlib commit `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`; transitive revisions are locked in `lean/lake-manifest.json`. Toolchain and caches are local to ignored directories in this checkout. Setup and check scripts are under `scripts/`.

**Observed verification:** `.\scripts\check-lean.ps1` completed successfully. `#print axioms SquaresInSquare.two_square_optimal` reports only `propext`, `Classical.choice`, and `Quot.sound`. Source hash and recheck instructions are in [the verification record](../lean/README.md). No external-kernel replay was run.

**Next mathematical task:** prove a reusable separation-certificate lemma and the exact rotated five-square construction. No agent campaign has been started.

## 2026-10-30 — Approach history and LaTeX handoff

**Added:** [evolution.md](../evolution.md), with separate sections for simulator-led exploration, the proof-led research plan, and the implemented two-square proof. The current handoff includes environment pins, verification evidence, limits, and the next bounded task. Later agents should append materially different approaches and update that handoff.

**Formatting:** mathematical prose now uses inline `$...$` and display `$$...$$` LaTeX delimiters. Literal Lean, identifiers, paths, commands, and data examples retain code formatting. Source line endings are pinned to LF so the recorded Lean source hash survives a fresh checkout.

**Verification:** the Lean build was rechecked successfully before preparing the initial commit. All 191 extracted mathematical expressions rendered successfully with KaTeX 0.16.22; local links, delimiter balance, whitespace, and recorded source hashes also passed checks. The Lean source and its recorded hash are unchanged.

## Entry template

### YYYY-MM-DD — <event>

- Question or decision:
- Evidence, source revision, or experiment ID:
- Result and assurance level:
- Correction to earlier understanding, if any:
- Next bounded action:
