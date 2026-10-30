# Implementation roadmap

The priority is a complete mathematical proof cycle. The first two-square cycle now has a successful Lean build; later unchecked stages remain proposed work. Select a new research target after reproducing a classical result and checking the current literature.

## Phase 1 — First complete optimality theorem

- [x] Write the [two-square proof](08-two-square-proof.md), including arbitrary orientations and strict interior overlap.
- [x] Set up a pinned Lean/mathlib project.
- [x] Formalize the square, the needed interior-membership lemma, and containment bounds.
- [x] Prove the unavoidable-center lemma for $L<2$.
- [x] Construct the side-two packing and prove $\operatorname{Packs}(2,L)\implies 2\leq L$.
- [x] Record theorem names, build output, and axiom dependencies in the [verification record](../lean/README.md).

**Done when:** the unrestricted two-square construction and lower bound have reproducible Lean proofs and reviewed statements.

## Phase 2 — Rotated construction and a stronger lower bound

- [ ] Prove a sound separation-certificate lemma.
- [ ] Formalize the five-square construction at $L=2+\frac{1}{\sqrt{2}}$.
- [ ] Read the classical five-square lower bound and list its precise lemmas.
- [ ] Reproduce the lower bound with an informal proof and Lean development.
- [ ] Record reusable geometric facts and any remaining proof gaps.

**Done when:** a rotated construction is checked and the stronger lower-bound argument is either formalized or decomposed into explicit, tracked obligations. Label partial progress as partial; full five-square optimality requires both sides.

## Phase 3 — Bounded proof research

- [ ] Choose a current lower-bound target or a useful structural lemma.
- [ ] Freeze definitions, assumptions, prerequisites, and the desired statement.
- [ ] Explore geometric proofs, unavoidable sets, or certified case analysis.
- [ ] Use counterexample search to test proposed lemmas.
- [ ] Give agents bounded proof obligations with reproducible outputs.

**Done when:** the campaign yields a checked theorem, a rigorous counterexample, or a documented obstruction and next lemma. Report exact optimality only when all smaller sides are excluded.

## Supporting track — Visualization and certificates

- [ ] Use the existing workbench to inspect constructions and test geometric ideas.
- [ ] Run the [simulator trial](03-simulator.md) when an export/adapter is needed.
- [ ] Implement a shared representation and independent diagnostics for imported witnesses.
- [ ] Produce rigorous certificate reports tied to input hashes.
- [ ] Build a custom viewer only if observed research needs justify it.

**Done when needed:** a construction moves between exploration and proof without losing coordinates, conventions, or provenance.

## Supporting track — Numerical construction search

- [ ] Choose a construction target, reference witness, and fixed resource budget.
- [ ] Record solver/checker revisions, configurations, and seeds.
- [ ] Preserve failures and independently verify promising candidates.
- [ ] Reconstruct exact coordinates or sound enclosures for claimed upper bounds.

**Done when needed:** another person can reproduce and rigorously check a proposed upper-bound improvement. This track can suggest proof ideas but cannot infer a global lower bound from failed searches.

## Proposed future layout

```text
apps/viewer/          UI or adapter around a reused simulator
packages/geometry/   UI-independent exploratory geometry
schemas/             machine-readable interchange definitions
search/              headless search programs and locked configurations
verification/        rigorous checkers and reports
lean/                formal definitions, witnesses, and proofs
data/reference/      attributed, pinned imported artifacts
data/candidates/     preserved candidate witnesses
experiments/         manifests, logs, summaries, and artifact hashes
docs/                orientation, decisions, and research notes
```

Create additional directories as their first implementation arrives. The `lean/` project and `scripts/` setup/check helpers now exist alongside the documentation.

## Upcoming decisions

1. Which upstream geometric definitions can be reused without changing the unrestricted problem.
2. Whether future upstream proof reuse needs a toolchain upgrade beyond the current compatible pins.
3. Which classical lower-bound argument to reproduce after two squares.
4. Which new theorem has a plausible proof strategy after a fresh literature review.
5. What visualization, certificate, and compute support that proof strategy actually needs.
