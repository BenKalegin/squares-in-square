# Lean formalization roadmap

## First objective

The first objective is complete: [TwoSquares.lean](../lean/TwoSquares.lean) proves $\operatorname{Packs}(2,2)$, together with $\forall L\in\mathbb{R},\quad\operatorname{Packs}(2,L)\implies 2\leq L$. The [two-square proof](08-two-square-proof.md) supplies the written argument and theorem map. This develops both construction and global exclusion from the start.

Then prove the five-square rotated construction and reproduce a classical lower-bound argument. Simulator exports and numerical search support the proof work as needed.

The repository now has a pinned Lean 4.24.0 project with mathlib revision `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Lean/elan is installed under `.tools/` for this checkout. See the [local setup instructions and successful build record](../lean/README.md); the [official install guide](https://lean-lang.org/install/) also covers independent installations.

Before extending the current representation, inspect the relevant modules of [evand/square-packing](https://github.com/evand/square-packing/tree/main/lean), [jlevy/squares](https://github.com/jlevy/squares), and [MacIver's research](https://github.com/DRMacIver/square-packing-research). Definitions and hypotheses must match this project's unrestricted problem; a successful upstream build alone does not establish that match.

## Mathematical interface

Use points in $\mathbb{R}^2$, a square center, and orientation $(c,s)$ with $c^2+s^2=1$. Define the square as

$$
Q(p,c,s)=\{p+\alpha(c,s)+\beta(-s,c):|\alpha|\leq1/2,\ |\beta|\leq1/2\}.
$$

For a family indexed by `Fin n`, $\operatorname{Packs}(n,L)$ asserts containment in $[0,L]^2$ and pairwise disjoint interiors. The formal definition should retain all real orientations. Finite angle grids can be special cases without replacing the general predicate.

Separate definitions for a concrete placement, existential packing feasibility, and the extremal quantity $s$. Initially prove statements about `Packs`; introduce the infimum and its properties after establishing a nonempty feasible set and a lower bound. Avoid a definition of optimum that hides these obligations.

## Milestones

| Stage | Deliverable | Why it matters |
| --- | --- | --- |
| L0 | Pinned project, a trivial theorem, clean reproducible build | Toolchain baseline |
| L1 | Unit-square definition, basis properties, vertices, containment lemma | Connect data to sets |
| L2 | Interior membership and the unavoidable-center lemma for $L<2$ | Prove a statement covering every position and orientation |
| L3 | Explicit two-square witness and $\operatorname{Packs}(2,L)\implies 2\leq L$ | Complete first optimality theorem |
| L4 | A sound separation-certificate lemma and five-square witness | Exercise exact algebraic coordinates and rotated contact |
| L5 | Reproduce a classical lower-bound proof, targeting five squares | Learn stronger global exclusion methods |
| L6 | Monotonicity and grid upper bound; later area lower bound | Reusable extremal facts; area needs measure-theoretic infrastructure |
| L7 | A new bounded lemma/proof campaign informed by current literature | Research after a complete reproducible proof cycle |

The first lower bound does not require a full separating-axis decision procedure or a measure-theoretic area theorem. For L4, proving that a supplied axis prevents interior overlap suffices to certify a feasible witness. Completeness of four-axis separation can be added when a verified general-purpose checker needs it.

L0–L3 are complete for the two-square development. The project proves only the direction from strict local coordinates to topological interior membership needed for this argument; a general interior-equality theorem is not required.

## Arithmetic and certificate strategy

Begin with hand-written exact rational examples. Add algebraic coordinates for the five-square witness. Generate arithmetic obligations and a selected separating direction per pair, while proving once that successful checks imply geometric feasibility.

Mathlib's [`linarith` and `nlinarith` documentation](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Tactic/Linarith/Frontend.html) describes proof-producing arithmetic automation. Use these where their fragment fits; they do not automatically solve arbitrary trigonometry, disjunctions, or global geometric optimization.

For a large external computation, choose explicitly between replaying a finite certificate inside Lean and retaining an external checker assumption. The latter is a conditional theorem and must be labeled accordingly. Record any use of native evaluation and the trust model of the pinned Lean release; avoid describing all computational proofs as having identical assurance.

## Reviewing a claimed formal result

Apply the [official validation guidance](https://lean-lang.org/doc/reference/latest/ValidatingProofs/) and record:

1. Exact theorem name and expanded statement, including all assumptions and definitions of overlap, unit square, and rotation.
2. Upstream commit, Lean/mathlib pins, build command, and which theorem modules actually built. A default build might omit a target.
3. Axiom output, including transitive dependencies. Flag `sorryAx`, custom assumptions, and native-evaluation dependencies for explicit review; standard logical axioms are expected.
4. Whether a fresh build or only reused compiled objects were checked. Record any additional kernel replay performed.
5. The bridge from the formal statement to the research claim. A theorem excluding only axis-aligned packings cannot prove the arbitrary-rotation optimum.

The two-square theorem meets the build and axiom-inspection criteria above; no additional external-kernel replay has been performed. Certificate generation and larger optimality results remain future work.
