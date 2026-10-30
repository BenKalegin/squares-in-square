# Sources and related projects

Initially reviewed on **2026-10-30** by reading public pages, repository listings, and selected documentation. During that literature review, no external code was installed or executed, no Lean project was built, and no interactive simulator was exercised. Descriptions below report source contents, not independent validation of those projects. The subsequent project-local Lean setup and successful two-square proof are recorded in [the verification record](../lean/README.md). This is a starting bibliography, not an exhaustive literature review.

## Historical orientation

**S1 — Erich Friedman, _Packing Unit Squares in Squares: A Survey and New Results_.** [Author's HTML](https://erich-friedman.github.io/papers/squares/squares.html), [PDF](https://erich-friedman.github.io/papers/squares.pdf), [2000 journal version](https://www.combinatorics.org/files/Surveys/ds7/ds7v2-2000/ds7-2000.html).

Read for constructions and lower-bound techniques. The journal and author versions are different historical snapshots; record the version used when citing a theorem. Their best-known tables should not serve as a current frontier.

**S2 — David Ellsworth / Erich Friedman, _Squares in Squares_.** [Catalogue and SVG editor](https://kingbird.myphotos.cc/packing/squares_in_squares.html).

A source of drawings, small-case attributions, and high-precision expressions. Its introduction documents drag/rotate/save controls and distinguishes double-precision editing from higher-precision SVG extraction. Cite the particular packing and its credited finder when importing it.

## Existing software and active research

**S3 — Joshua Levy and contributors, `jlevy/squares`.** [Repository](https://github.com/jlevy/squares), [public site](https://squaremath.org/), [workbench](https://squaremath.org/workbench/), [results register](https://github.com/jlevy/squares/blob/main/packing/frontier/RESULTS.md).

The repository combines numerical search, exact verification, formalization, and structured research records. It lists Python and Rust tooling plus a TypeScript workbench. Inspect its architecture and witness conventions before creating parallel infrastructure. This is an especially relevant reference for the proposed agent-assisted workflow.

**S4 — Evan Daniel, `evand/square-packing`.** [Repository](https://github.com/evand/square-packing), [Atlas](https://evand.github.io/square-packing/), [verification log](https://github.com/evand/square-packing/blob/main/VERIFICATION.md).

Combines an interactive catalogue with exact certificate checkers and Lean modules. Its README identifies which results have unconditional Lean statements, conditional statements, or external verification only, and says results are unrefereed. Inspect individual certificate bundles rather than treating the repository as one uniform assurance level.

**S5 — David Ellsworth, `packing_squares_in_squares__tools`.** [Repository](https://github.com/Davidebyzero/packing_squares_in_squares__tools).

The listing includes `parse_svg_packing.py`, `check_packing.py`, `refine_packing.cpp`, and a restricted-angle enumerator. Investigate the parser as an import adapter. Functionality and numerical guarantees have not been audited here.

**S6 — David R. MacIver, _Square Packing Research_.** [Research site](https://drmaciver.github.io/square-packing-research/), [repository](https://github.com/DRMacIver/square-packing-research).

Potentially useful geometry and Lean material, including the center-area lemma. The site explicitly describes AI-generated material and incomplete human review, and identifies machine-checking per result. Read theorem hypotheses and verification audits before building on a claim.

**S7 — Daniil Ostashev, `dostashev/square-packing`.** [Repository](https://github.com/dostashev/square-packing).

A compact reference for record packing certificates and verification code. Useful for studying how a proposed upper bound can be packaged for replay; a certificate for one packing does not establish its global optimality.

## A recent status change to track

On the consultation date, the [Squares Project overview](https://squaremath.org/) reports a proposed Lean proof of $s(12)=4$, dated 2026-10-25. It labels the result **reported, V0/C0**, says the build has not been replayed there, and describes finite computations using `native_decide`. Treat this as a current claim to audit, not a theorem verified by this repository. In particular, do not casually choose $n=12$ as an untouched open problem based on an older table.

The [Atlas overview](https://evand.github.io/square-packing/) also lists recent computer-checked results with per-result caveats. Consult the underlying artifact and its latest revision before using any frontier value.

## Lean primary documentation

| ID | Source | Use |
| --- | --- | --- |
| S8 | [Official installation guide](https://lean-lang.org/install/) | Windows setup; currently recommends VS Code and its Lean 4 extension |
| S9 | [Lean language reference](https://lean-lang.org/doc/reference/latest/) | Definitions, tactics, and the kernel; the moving `latest` page is not a version pin |
| S10 | [Validating a Lean proof](https://lean-lang.org/doc/reference/latest/ValidatingProofs/) | Statement review, axiom inspection, and additional proof checks |
| S11 | [Mathlib `linarith` / `nlinarith`](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Tactic/Linarith/Frontend.html) | Arithmetic automation and certificate checking |

## Reuse observations

These are observations of upstream notices, not a license chosen for this repository:

| Project | Notice observed | Follow-up when importing |
| --- | --- | --- |
| `jlevy/squares` | [LICENSE](https://github.com/jlevy/squares/blob/main/LICENSE) separates MIT code, CC BY 4.0 project material, and third-party exceptions | Record the applicable notice for each copied artifact |
| `evand/square-packing` | [MIT LICENSE](https://github.com/evand/square-packing/blob/main/LICENSE); README distinguishes catalogue-derived material | Preserve origin and notices for code and data separately |
| `dostashev/square-packing` | [MIT LICENSE](https://github.com/dostashev/square-packing/blob/main/LICENSE) | Retain notice with imported code |
| Ellsworth tools / catalogue | No license file was visible in the tools repository root listing inspected | Resolve reuse terms before copying source or redistributing drawings |

## Intake record for any dependency or result

Capture URL, access date, upstream commit or release, artifact hash, authorship, license/attribution, exact statement, assumptions, verification method, command, and observed result. A web-page read is `source-reviewed`; a successful local replay is a separate event. None of the moving repository URLs above is a pinned dependency yet.
