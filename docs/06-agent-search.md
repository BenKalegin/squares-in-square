# Agent-assisted solution search

## Role of agents

The primary output is a precise geometric lemma with a checked proof, or a counterexample that improves the conjecture. Use agents to propose arguments, find missing hypotheses, formalize lemmas, and review theorem statements. Numerical workers can also search for constructions and counterexamples using deterministic programs with recorded configurations. A language model's confidence and agreement among several agents are not mathematical evidence.

This document proposes a future workflow. No agent swarm or background campaign has been launched. The [two-square optimality theorem](08-two-square-proof.md) is now checked; the next proof target is the rotated five-square construction and its supporting lemmas. Start from [the current handoff](../evolution.md); viewer and optimization work is supporting infrastructure.

## Proof work units

For each lemma, freeze the statement and relevant definitions before assigning work. Specify allowed assumptions, available prerequisite lemmas, expected output, and a budget. Good initial units are containment bounds, strict local coordinates implying interior membership, the unavoidable-center lemma, and assembly of the two-square lower bound.

Separate mathematical discovery, counterexample search, formalization, and statement review as tasks. Early on they can be done sequentially by one agent. A formalization that needs a changed hypothesis returns a revised conjecture for review rather than silently weakening the theorem. A completed unit records its theorem name, source revision, build output, and axiom dependencies.

Keep an informal proof beside the Lean development. The proof should explain why the result holds; the formal artifact establishes that the stated argument has been checked. A counterexample task must preserve the witness and distinguish numerical evidence from a rigorous refutation.

## Candidate pipeline

```text
reference or manual placement
          |
          v
perturb / construct / change contacts
          |
          v
local refinement -----> failed-run archive
          |
          v
numerical screening -> diversity filter -> candidate archive
                                             |
                                             v
                               independent rigorous verification
                                             |
                                             v
                              upper-bound record / Lean witness

lower-bound conjecture -> explicit proof plan -> formal proof or certified exclusion
```

The two branches answer different questions. Improving an explicit packing improves an upper bound. A lower-bound campaign needs a complete mathematical reduction or a certified covering of the admissible configuration space.

## Start with a small team design

| Role | Input | Required output |
| --- | --- | --- |
| Coordinator | One hypothesis, baseline, fixed budget | Work units, accepted artifacts, decision log |
| Explorer | Seed placement and mutation family | Full candidate poses, seeds, logs, failed attempts |
| Refiner | Candidate and locked solver settings | Refined witness and diagnostics |
| Verifier | Frozen witness and stated claim | Reproducible report, counterexample, or `inconclusive` |
| Formalizer | A precise lemma or certificate interface | Lean statement, proof, pins, build and axiom evidence |

Initially combine coordination and refinement. Add roles only when tasks can be specified clearly and measured. Agents may propose checker changes, but results should be evaluated against a frozen checker version; changing the solver and its acceptance rule together makes comparisons ambiguous.

## First search families

- Random restarts and perturbations of known packings, including symmetry-breaking perturbations.
- Simulated annealing over center positions, angles, and container side, followed by local refinement.
- Manual surgery: remove/reinsert a square, alter a tilted strip, or move a small cluster.
- Fix orientations and chosen signed separating axes/orders, then solve the resulting linear position/side subproblem. This explores one restricted cell; it is not a global bound.
- Use contact graphs to suggest moves and track diversity, while allowing contacts to change.

A simple exploratory loss is

$$
E=\lambda_p\sum_{i<j}\max(0,-g^*_{ij})^2
 +\lambda_w\sum_{i,k}\max(0,-w_{ik})^2+\lambda_L L,
$$

where $g^*$ is the maximum pair separation margin and $w$ ranges over wall margins from the [geometry contract](04-geometry-and-data.md). This loss is nonsmooth and its minimizers may overlap. A finite penalty is a heuristic, so retain raw violations and independently check returned coordinates. Treat the loss and weights as experimental choices.

## Work-unit contract

Each task declares one target $n$, one baseline artifact and side, one falsifiable hypothesis, one method/configuration, disjoint seed assignments, and a stop budget. Record PRNG algorithm as well as seed. Give a verifier a claim such as “this witness fits at side U,” not “prove this is good.”

Prefer function-evaluation or step budgets for algorithm comparisons; also record wall time and hardware. Set limits on worker count, CPU/memory, model calls/tokens, retained artifacts, and total campaign duration before launching. A model-driven change of method creates a new experiment configuration.

Preserve original witnesses. Store every result with configuration and witness hashes. On a shared checkout, workers should own distinct files or work in isolated checkouts; one coordinator integrates accepted changes. Code under evaluation and generated experiment output should not be mixed silently.

## Diversity and comparison

Deduplicate using square permutation and the eight symmetries of the square container. Square orientation is periodic modulo $\pi/2$. Approximate pose hashes and contact graphs can help cluster outputs but can merge distinct arrangements or split equivalent ones near thresholds; keep their tolerances and do not delete the only raw copy.

Track feasible candidates, distinct arrangement clusters, best checked side, success rate across seeds, and cost per useful result. Improvement over a reference upper bound is different from a proven gap to the optimum. If only $B\leq s(n)\leq U$ is known, the bound gap is $U-B$ and density is $n/U^2$ for a feasible witness at $U$.

For the first comparison, use a proposed fixed set of 20 seeds and the same step budget for two mutation strategies. Count invalid and inconclusive results. Pilot the budget locally before choosing it; no runtime estimate is assumed here.

## Promoting a result

1. `candidate`: saved poses and complete provenance.
2. `numerically-checked`: a specified approximate checker accepts under documented tolerances.
3. `rigorously-verified`: exact or sound interval evidence establishes the stated claim; unresolved signs remain inconclusive.
4. `lean-checked`: a named theorem and recorded dependencies establish the statement under its declared trust model.

Store claim kind separately: feasibility, upper bound, lower bound, equality, or local property. Human review and publication status are also separate fields. Before reporting a new record, recheck the current frontier and original attribution, then reproduce the candidate using the archived artifact. Several agents repeating the same checker is not independent mathematical verification.
