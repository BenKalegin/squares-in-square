# Squares in a square

A research workspace for packing $n$ congruent unit squares into the smallest enclosing square, allowing independent rotations and boundary contact.

The main objective is **mathematical proofs of packing bounds and optimality, formalized in Lean**. The workflow is **precise conjecture → geometric lemmas → proof → Lean verification**. Interactive exploration and numerical optimization supply constructions and counterexamples; agent-assisted work will target explicit lemmas and proof obligations.

## Current state

At initial inspection on 2026-10-30 this repository contained only Git metadata. It now contains the research notes and a [checked Lean proof of two-square optimality](lean/TwoSquares.lean). The project uses Lean 4.24.0 and a pinned mathlib release, installed locally under ignored directories. See the [Lean setup and verification record](lean/README.md) to recheck it. No simulator or search campaign has been implemented.

The working interpretation is equal squares with arbitrary rotation. Unequal-square tilings, square covering, and axis-aligned-only packing are different problems. Revisit this assumption if the research direction changes.

## Reading map

| Document | Purpose |
| --- | --- |
| [Research evolution and handoff](evolution.md) | Approaches tried, decisions, verified results, and where the next agent should resume |
| [Lean source and verification](lean/README.md) | The compiled two-square theorem, environment pins, and recheck commands |
| [Problem and research questions](docs/01-problem.md) | Definitions, elementary bounds, baseline cases, and target selection |
| [Sources and related projects](docs/02-sources.md) | Dated primary-source reading list and verification limits |
| [Simulator evaluation](docs/03-simulator.md) | Reuse candidates, a hands-on evaluation protocol, and a minimal local editor |
| [Geometry and data contract](docs/04-geometry-and-data.md) | Coordinates, collision formulas, precision, and witness interchange |
| [Lean roadmap](docs/05-lean.md) | Small proof milestones and the boundary between certificates and global optimality |
| [First optimality proof: two squares](docs/08-two-square-proof.md) | The mathematical explanation of the checked Lean proof |
| [Agent-assisted search](docs/06-agent-search.md) | Worker roles, experiment contracts, reproducibility, and promotion of results |
| [Implementation roadmap](docs/07-roadmap.md) | Ordered deliverables with concrete completion criteria |
| [Experiment template](docs/templates/experiment.md) | Copyable record for a bounded search or proof attempt |
| [Research log](docs/research-log.md) | Starting observations and decisions still to make |

## Current milestone and next step

The [two-square optimality proof](docs/08-two-square-proof.md) is formalized and compiles: a packing exists at side two, and every unit square inside any smaller container contains the container's center in its interior. Two such squares must overlap. Read and recheck it with `.\scripts\check-lean.ps1`.

Next formalize the rotated five-square construction and study its classical lower bound. Use the existing [Squares Project workbench](https://squaremath.org/workbench/) for visual exploration. A custom editor and large optimization campaigns are optional supporting work; they are not prerequisites for starting the proofs. The earlier [simulator evaluation plan](docs/03-simulator.md) remains available when data interchange is needed.

Research sources were consulted on **2026-10-30**. Recent claims can change quickly; the [source register](docs/02-sources.md) preserves the distinction between an author's report and a result reproduced in this repository.
