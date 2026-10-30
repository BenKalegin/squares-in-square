# Research evolution and agent handoff

This is the approach-level history and the starting point for an agent continuing the work. Add a dated section for each materially different approach, including unsuccessful ones. Preserve the original idea, state what was actually attempted, and record evidence before calling a result proved. Use [the research log](docs/research-log.md) for shorter events and [the roadmap](docs/07-roadmap.md) for task status.

## Current handoff — 2026-10-30

**Research objective:** prove bounds and optimality for packing congruent unit squares in a square, with arbitrary independent rotations and boundary contact allowed. The simulator supplies constructions and counterexamples; Lean checks the mathematical arguments.

**Completed result:** the first Lean development proves

$$
\operatorname{Packs}(2,2)
\quad\text{and}\quad
\forall L\in\mathbb{R},\quad \operatorname{Packs}(2,L)\implies 2\leq L.
$$

Thus the optimal side for two squares is $s(2)=2$. The formal statement expresses attainment and the universal lower bound directly; the code does not yet define an infimum-based function $s$.

**Read first:** [TwoSquares.lean](lean/TwoSquares.lean), [the written proof](docs/08-two-square-proof.md), and [the build and axiom record](lean/README.md). The headline declaration is `SquaresInSquare.two_square_optimal`.

**Recheck from the repository root:**

```powershell
.\scripts\check-lean.ps1
```

On a fresh Windows checkout, first run:

```powershell
.\scripts\setup-lean.ps1
.\scripts\check-lean.ps1 -Fetch
```

The pins are Lean 4.24.0 and mathlib commit `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Transitive dependencies are locked in `lean/lake-manifest.json`. The `.tools/` installation and `lean/.lake/` dependencies/build products are ignored by Git and are not delivered by a clone.

**Next bounded task:** prove a reusable sufficient separation condition, then formalize the exact five-square rotated construction at

$$
L_5=2+\frac{1}{\sqrt{2}}.
$$

That construction establishes an upper bound. A proof that it is optimal still needs an argument excluding every smaller side. No five-square theorem, custom simulator, optimizer, or agent swarm has been implemented in this repository. An additional external-kernel replay of the two-square proof has not been run.

## Approach 1 — Simulator-led exploration and certificate pipeline — 2026-10-30

**Initial idea:** build or reuse a drag/rotate simulator, run reproducible numerical searches, rigorously verify promising configurations, and eventually connect their certificates to Lean. The suggested pipeline was exploration → search → certificates → formal proofs.

**Work performed:** inspected the initially empty repository and reviewed primary public documentation for Friedman's survey, Ellsworth's catalogue/editor, the Squares Project workbench, the Square Packing Atlas, and selected exact-verification and formalization repositories. Created the problem statement, source register, simulator evaluation protocol, geometry/data proposal, experiment template, and initial roadmap.

**Relevant artifacts:** [sources](docs/02-sources.md), [simulator evaluation](docs/03-simulator.md), [geometry and interchange](docs/04-geometry-and-data.md), and [experiment template](docs/templates/experiment.md).

**Outcome and limits:** documentation identified existing software worth reusing. The local agent did not exercise the browser editor, import an exported layout, install an external packing project, or run a search. The user subsequently explored the Squaremath workbench and found it useful. Its optimization capability did not change the distinction between finding a layout and proving a global optimum.

**Decision:** retain this as supporting infrastructure. The user wanted the research to emphasize mathematical proof, so a new editor and numerical campaign stopped being prerequisites. Resume the simulator acceptance trial only when a proof task needs imported coordinates or visual counterexample exploration.

## Approach 2 — Proof-led research and bounded lemma search — 2026-10-30

**Motivation:** an optimizer supplies feasible candidates and upper bounds, while optimality requires a statement about every admissible packing. Move the main workflow to precise conjecture → geometric lemmas → mathematical proof → Lean verification.

**Work performed:** separated construction, local optimality, and global lower bounds in the research plan. Discussed unavoidable points/weighted covers and certified exhaustive case analysis as possible lower-bound methods. Proposed assigning future agents specific lemmas, counterexample searches, formalizations, and statement reviews. No such campaign has been launched.

For a proposed best side $L_*$, the two required obligations are

$$
\operatorname{Packs}(n,L_*)
\qquad\text{and}\qquad
\forall L\in\mathbb{R},\quad \operatorname{Packs}(n,L)\implies L_*\leq L.
$$

**Relevant artifacts:** [Lean roadmap](docs/05-lean.md), [agent workflow](docs/06-agent-search.md), and [implementation roadmap](docs/07-roadmap.md).

**Outcome:** the user accepted starting with a complete small optimality proof, followed by a rotated construction and stronger lower-bound techniques. The two-square case was selected as a learning and infrastructure target, not a novel result.

**Constraints for future attempts:** fixed-angle or fixed-contact arguments need explicit restrictions; failed optimization does not prove a lower bound. Excluding one side $L_*-\varepsilon$, where $\varepsilon>0$, does not by itself exclude every side below $L_*$. A theorem about the global best side need not establish uniqueness of the layout.

## Approach 3 — First implemented proof: an unavoidable center for two squares — 2026-10-30

**Key idea:** if $L<2$, every unit square contained in $[0,L]^2$ contains the container's center strictly inside it. Two contained squares would therefore have intersecting interiors.

**Mathematical representation:** use a center $p=(x,y)$ and real orientation coefficients $(c,s)$ satisfying $c^2+s^2=1$. The edge directions are $u=(c,s)$ and $v=(-s,c)$. Let

$$
q=|c|+|s|,\qquad h=\frac q2,\qquad
m=\left(\frac L2,\frac L2\right),\qquad D=\frac L2-h.
$$

Containment gives $h\leq x\leq L-h$ and $h\leq y\leq L-h$. Each local coordinate of $m$ has absolute value at most $qD$. The decisive inequality is

$$
qD=\frac{Lq-q^2}{2}
<\frac{2q-q^2}{2}
=\frac12-\frac{(q-1)^2}{2}
\leq\frac12,
$$

using $q>0$ and $L<2$. Both local coordinates are strictly between $-\tfrac12$ and $\tfrac12$, placing $m$ in the square's interior. A pair of upright unit squares sharing an edge supplies the side-two construction.

**Implementation:** [TwoSquares.lean](lean/TwoSquares.lean) defines the closed square with inverse orthonormal coordinates. `UnitSquare.mem_body_iff` proves equivalence with the usual image of a closed unit square. `UnitSquare.strictBody_subset_interior` uses continuity and openness to establish genuine topological interior membership. `Packs` uses actual set containment and disjoint topological interiors; it does not assume non-overlap from a numerical tolerance or restricted angle set.

**Reusable declarations:**

| Declaration | Role |
| --- | --- |
| `UnitSquare.localX_point`, `localY_point`, `point_local` | Coordinate inversion |
| `UnitSquare.mem_body_iff` | Bridge to the geometric square |
| `UnitSquare.strictBody_subset_interior` | Strict coordinates imply topological interior membership |
| `contained_center_bounds` | Sharp center bounds from four contained vertices |
| `scalar_center_bound`, `projection_bound` | Arithmetic and projection estimates |
| `container_center_mem_interior` | Unavoidable-center lemma |
| `two_square_lower_bound` | Universal lower bound |
| `two_square_witness`, `two_square_optimal` | Construction and complete optimality result |

**What changed during implementation:** established the topological bridge directly, avoiding the need for a full separating-axis decision procedure or an area theorem. Compiler feedback required an arithmetic lemma-name correction, explicitly handling reversed disjointness, and closing an unnamed section. These were implementation repairs; the mathematical strategy stayed the same.

**Verification observed:** `.\scripts\check-lean.ps1` completed successfully. The source contains no `sorry`, `admit`, custom axioms, or native-evaluation proofs. The transitive axiom report for the headline theorem is:

```text
[propext, Classical.choice, Quot.sound]
```

These are Lean's standard logical axioms. The checked source SHA-256 is:

```text
DFCCCD58AEFF5E51103485017DE6662494C018CEF5F3A9C2A061CBC7E6F2365B
```

**Outcome:** a complete Lean-checked proof of the best two-square side, with an ordinary mathematical explanation. No novel packing result or uniqueness statement is claimed.

**Open work:** a sufficient separation-certificate lemma; the exact five-square construction; a stronger classical lower-bound proof; eventually a carefully selected new theorem. The current code only proves the interior-membership direction needed here, not a general equality between `strictBody` and the topological interior. The source and scripts should remain unchanged when only documenting this result so the recorded source hash stays valid.

## Recording the next approach

For each new approach, add a dated section with the target theorem, motivation, hypotheses, mathematical idea, files and theorem names, commands, observed result, trust/precision limits, failed cases or obstruction, and the next bounded task. Distinguish proposed, attempted, numerically supported, and Lean-checked results. Update the current handoff above when priorities change; preserve earlier sections as history. Use inline `$...$` and display `$$...$$` for mathematics, and code formatting for literal Lean, identifiers, paths, and commands.
