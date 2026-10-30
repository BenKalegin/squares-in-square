# Lean proof: two squares

[TwoSquares.lean](TwoSquares.lean) contains a complete checked proof that two unit squares, with arbitrary independent rotations, fit at side two and cannot fit at any smaller side.

The headline statement is:

```lean
theorem two_square_optimal : Packs 2 2 ∧ ∀ L : ℝ, Packs 2 L → 2 ≤ L
```

All declarations are in the `SquaresInSquare` namespace. `Packs` uses containment of closed geometric squares and disjoint **topological interiors**, so shared boundary edges are allowed. Each orientation is a real pair $(c,s)$ satisfying $c^2+s^2=1$; no angle discretization is imposed. `mem_body_iff` connects the coordinate definition to the image of the usual closed unit square.

The proof's main ingredients are `contained_center_bounds`, `scalar_center_bound`, `container_center_mem_interior`, `two_square_lower_bound`, and `two_square_witness`. Read [the mathematical explanation](../docs/08-two-square-proof.md) alongside the source.

## Recheck on this Windows checkout

From the repository root:

```powershell
.\scripts\check-lean.ps1
```

The toolchain and dependencies are already installed locally for this checkout. For a fresh checkout, run:

```powershell
.\scripts\setup-lean.ps1
.\scripts\check-lean.ps1 -Fetch
```

The setup script installs elan and Lean under `.tools/` without changing the user's saved PATH. Dependencies and build products live under `lean/.lake/`. Both directories are ignored by Git. Initial setup requires network access and downloads a Lean toolchain and mathlib build artifacts.

If Lean/elan is already installed independently, the ordinary commands from this `lean/` directory are `lake update`, `lake exe cache get` and `lake build`. The `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json` files pin the environment.

## Verification record

Checked on **2026-10-30** using Lean **4.24.0** and mathlib commit **f897ebcf72cd16f89ab4577d0c826cd14afaafc7** (the `v4.24.0` release).

Command, from the repository root: `.\scripts\check-lean.ps1`.

Result:

```text
Built TwoSquares
'SquaresInSquare.two_square_optimal' depends on axioms:
  [propext, Classical.choice, Quot.sound]
Build completed successfully (1308 jobs).
```

The source contains no `sorry`, `admit`, custom axioms, or native-evaluation proofs. The reported dependencies are the standard logical axioms above. This record reports a successful Lean build and axiom inspection; an additional external-kernel replay has not been performed.

SHA-256 of the checked `TwoSquares.lean` source:

```text
DFCCCD58AEFF5E51103485017DE6662494C018CEF5F3A9C2A061CBC7E6F2365B
```

The theorem states attainment and a universal lower bound directly. An infimum-based function $s(n)$, uniqueness of optimal arrangements, and results for five squares remain future work.
