# Problem and research questions

## Scope and notation

Let $\operatorname{Packs}(n,L)$ mean that $n$ closed unit squares can be placed inside $[0,L]^2$, with pairwise disjoint interiors. Their boundaries may touch. Each square may rotate independently. For $n\geq 1$, define

$$
s(n)=\inf\{L\geq 0:\operatorname{Packs}(n,L)\}.
$$

Using an infimum avoids assuming existence of a minimizer in the definition. An eventual formal development should prove attainment if it needs a minimum. An equivalent normalization fixes the container side to one and maximizes the common small-square side, $a(n)=1/s(n)$.

This is different from tiling a square with unequal integer squares, covering a square with overlapping squares, and packing congruent axis-aligned squares. Rotation is a central degree of freedom here. Friedman's [survey](https://erich-friedman.github.io/papers/squares/squares.html) is a historical introduction to this formulation.

## What counts as a result?

| Claim | Required evidence |
| --- | --- |
| Candidate placement | Coordinates and an exploratory numerical diagnostic |
| Feasible packing, hence upper bound $s(n)\leq U$ | A witness whose containment and non-overlap are rigorously checked at side $U$ |
| Lower bound $s(n)\geq B$ | An argument excluding **all** admissible packings with side below $B$ |
| Exact value $s(n)=L$ | Matching upper and lower bounds |
| Local optimum | A neighborhood statement, with the neighborhood and assumptions specified |

A failed optimizer does not establish a lower bound. A rigid-looking drawing does not establish optimality. A lower bound for a restricted angle set is not automatically a lower bound for arbitrary rotations.

## Elementary facts to reproduce

For $n\geq 1$,

$$
\sqrt n\leq s(n)\leq\lceil\sqrt n\rceil.
$$

The first inequality comes from area; a grid gives the second. Removing squares establishes monotonicity, $s(n)\leq s(n+1)$, and $s(k^2)=k$ for positive integers $k$. These elementary bounds and the classical five-square value are recorded in the [survey](https://erich-friedman.github.io/papers/squares/squares.html).

Useful learning fixtures:

| Case | Reference behavior | Purpose |
| --- | --- | --- |
| $n=1$ | $s(1)=1$ | Coordinate conventions, walls, exact certificate |
| $n=2$ | $s(2)=2$ | Contacts and a small lower-bound exercise |
| $n\in\{4,9\}$ | Grid sides $2,3$ | Multiple contacts and symmetry |
| $n=5$ | $s(5)=2+\frac{1}{\sqrt{2}}$ | A rotated witness and algebraic coordinates |
| $n=10$ | Catalogue gives $s(10)=3+\frac{1}{\sqrt{2}}$ | Import a larger rotated reference |

The small-case reference values and attributions are in [Ellsworth's catalogue](https://kingbird.myphotos.cc/packing/squares_in_squares.html). Their proofs have not been replayed here.

## A useful five-square construction

Set $L=2+\frac{1}{\sqrt{2}}$. Put four axis-aligned squares at the corners of the container, with centers

$$
\left(\frac12,\frac12\right),\quad
\left(L-\frac12,\frac12\right),\quad
\left(\frac12,L-\frac12\right),\quad
\left(L-\frac12,L-\frac12\right).
$$

Put a fifth square at $(L/2,L/2)$, rotated by $\pi/4$. Each corner-facing edge of the central square touches a corner square. For example, the central diamond's southwest edge has equation $x+y=2$, meeting the lower-left square at $(1,1)$. Its vertices remain within the container. This supplies an explicit upper-bound witness; proving that no smaller container works is a separate task.

## Questions worth exploring

1. Which manual moves change the contact structure enough to escape a local minimum?
2. Does a search method find distinct arrangements, or mostly relabeled/symmetric copies?
3. Can a numerical improvement be repaired into a rigorous witness at a slightly larger side that still improves the reference?
4. Which recurring contact patterns admit exact reconstruction or a compact formal proof?
5. Which small geometric lemmas would support several lower-bound arguments?

Start by reproducing known packings. Select an open research target only after checking a dated source: the recent ecosystem includes new optimality claims, and old lists of open cases can be stale. See [sources](02-sources.md), especially the reported 12-square development.
