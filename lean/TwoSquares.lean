import Mathlib.Data.Real.Basic
import Mathlib.Topology.Algebra.Ring.Real
import Mathlib.Topology.Constructions.SumProd
import Mathlib.Topology.Order.OrderClosed
import Mathlib.Topology.Order.DenselyOrdered
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Two unit squares need a container of side at least two

Squares may rotate independently and may touch at their boundaries.
`Packs` uses actual set containment and disjoint topological interiors.

The lower bound uses one unavoidable point: when `L < 2`, every contained
unit square has the container center strictly inside it.

See `docs/08-two-square-proof.md` for the written mathematical argument.
-/

namespace SquaresInSquare

noncomputable section

abbrev Point := ℝ × ℝ

/-- An arbitrarily rotated unit square. The edge basis is `(c,s), (-s,c)`. -/
structure UnitSquare where
  x : ℝ
  y : ℝ
  c : ℝ
  s : ℝ
  unit : c ^ 2 + s ^ 2 = 1

namespace UnitSquare

def localX (q : UnitSquare) (z : Point) : ℝ :=
  q.c * (z.1 - q.x) + q.s * (z.2 - q.y)

def localY (q : UnitSquare) (z : Point) : ℝ :=
  -q.s * (z.1 - q.x) + q.c * (z.2 - q.y)

/-- The closed geometric square, expressed in its own orthonormal coordinates. -/
def body (q : UnitSquare) : Set Point :=
  {z | |q.localX z| ≤ 1 / 2 ∧ |q.localY z| ≤ 1 / 2}

/-- The square's strict local-coordinate region. -/
def strictBody (q : UnitSquare) : Set Point :=
  {z | |q.localX z| < 1 / 2 ∧ |q.localY z| < 1 / 2}

def point (q : UnitSquare) (a b : ℝ) : Point :=
  (q.x + a * q.c - b * q.s, q.y + a * q.s + b * q.c)

theorem localX_point (q : UnitSquare) (a b : ℝ) :
    q.localX (q.point a b) = a := by
  calc
    q.localX (q.point a b) = a * (q.c ^ 2 + q.s ^ 2) := by
      dsimp [localX, point]
      ring
    _ = a := by rw [q.unit]; ring

theorem localY_point (q : UnitSquare) (a b : ℝ) :
    q.localY (q.point a b) = b := by
  calc
    q.localY (q.point a b) = b * (q.c ^ 2 + q.s ^ 2) := by
      dsimp [localY, point]
      ring
    _ = b := by rw [q.unit]; ring

theorem point_local (q : UnitSquare) (z : Point) :
    q.point (q.localX z) (q.localY z) = z := by
  apply Prod.ext
  · calc
      (q.point (q.localX z) (q.localY z)).1 =
          q.x + (z.1 - q.x) * (q.c ^ 2 + q.s ^ 2) := by
            dsimp [point, localX, localY]
            ring
      _ = z.1 := by rw [q.unit]; ring
  · calc
      (q.point (q.localX z) (q.localY z)).2 =
          q.y + (z.2 - q.y) * (q.c ^ 2 + q.s ^ 2) := by
            dsimp [point, localX, localY]
            ring
      _ = z.2 := by rw [q.unit]; ring

theorem point_mem (q : UnitSquare) {a b : ℝ}
    (ha : |a| ≤ 1 / 2) (hb : |b| ≤ 1 / 2) : q.point a b ∈ q.body := by
  change |q.localX (q.point a b)| ≤ 1 / 2 ∧ |q.localY (q.point a b)| ≤ 1 / 2
  rw [q.localX_point, q.localY_point]
  exact ⟨ha, hb⟩

/-- The coordinate definition is exactly the image of the closed unit square. -/
theorem mem_body_iff (q : UnitSquare) (z : Point) :
    z ∈ q.body ↔ ∃ a b : ℝ, |a| ≤ 1 / 2 ∧ |b| ≤ 1 / 2 ∧ q.point a b = z := by
  constructor
  · intro hz
    exact ⟨q.localX z, q.localY z, hz.1, hz.2, q.point_local z⟩
  · rintro ⟨a, b, ha, hb, rfl⟩
    exact q.point_mem ha hb

theorem continuous_localX (q : UnitSquare) : Continuous q.localX := by
  unfold localX
  fun_prop

theorem continuous_localY (q : UnitSquare) : Continuous q.localY := by
  unfold localY
  fun_prop

theorem isOpen_strictBody (q : UnitSquare) : IsOpen q.strictBody := by
  exact (isOpen_lt q.continuous_localX.abs continuous_const).inter
    (isOpen_lt q.continuous_localY.abs continuous_const)

/-- Strict local-coordinate inequalities imply genuine topological interior membership. -/
theorem strictBody_subset_interior (q : UnitSquare) :
    q.strictBody ⊆ interior q.body := by
  apply interior_maximal _ q.isOpen_strictBody
  intro z hz
  exact ⟨le_of_lt hz.1, le_of_lt hz.2⟩

def absSum (q : UnitSquare) : ℝ := |q.c| + |q.s|

theorem absSum_pos (q : UnitSquare) : 0 < q.absSum := by
  have hc := abs_nonneg q.c
  have hs := abs_nonneg q.s
  by_contra h
  have hz : |q.c| + |q.s| ≤ 0 := le_of_not_gt h
  have hc0 : q.c = 0 := abs_eq_zero.mp (by linarith)
  have hs0 : q.s = 0 := abs_eq_zero.mp (by linarith)
  have hu := q.unit
  rw [hc0, hs0] at hu
  norm_num at hu

end UnitSquare

/-- The container, including its boundary. -/
def box (L : ℝ) : Set Point :=
  {z | 0 ≤ z.1 ∧ z.1 ≤ L ∧ 0 ≤ z.2 ∧ z.2 ≤ L}

def UnitSquare.Fits (q : UnitSquare) (L : ℝ) : Prop := q.body ⊆ box L

/-- A packing of `n` unit squares with independently chosen real orientations. -/
def Packs (n : ℕ) (L : ℝ) : Prop :=
  ∃ squares : Fin n → UnitSquare,
    (∀ i, (squares i).Fits L) ∧
    (∀ i j, i ≠ j → Disjoint (interior (squares i).body) (interior (squares j).body))

/-- Four contained vertices yield the sharp axis-aligned bounds on the center. -/
theorem contained_center_bounds (q : UnitSquare) {L : ℝ} (hfit : q.Fits L) :
    q.absSum / 2 ≤ q.x ∧ q.x ≤ L - q.absSum / 2 ∧
      q.absSum / 2 ≤ q.y ∧ q.y ≤ L - q.absSum / 2 := by
  have hpp := hfit (q.point_mem (a := 1 / 2) (b := 1 / 2) (by norm_num) (by norm_num))
  have hpm := hfit (q.point_mem (a := 1 / 2) (b := -(1 / 2)) (by norm_num) (by norm_num))
  have hmp := hfit (q.point_mem (a := -(1 / 2)) (b := 1 / 2) (by norm_num) (by norm_num))
  have hmm := hfit (q.point_mem (a := -(1 / 2)) (b := -(1 / 2)) (by norm_num) (by norm_num))
  dsimp [box, UnitSquare.point] at hpp hpm hmp hmm
  unfold UnitSquare.absSum
  rcases le_total 0 q.c with hc | hc <;> rcases le_total 0 q.s with hs | hs
  · rw [abs_of_nonneg hc, abs_of_nonneg hs]
    exact ⟨by linarith [hmp.1], by linarith [hpm.2.1],
      by linarith [hmm.2.2.1], by linarith [hpp.2.2.2]⟩
  · rw [abs_of_nonneg hc, abs_of_nonpos hs]
    exact ⟨by linarith [hmm.1], by linarith [hpp.2.1],
      by linarith [hpm.2.2.1], by linarith [hmp.2.2.2]⟩
  · rw [abs_of_nonpos hc, abs_of_nonneg hs]
    exact ⟨by linarith [hpp.1], by linarith [hmm.2.1],
      by linarith [hmp.2.2.1], by linarith [hpm.2.2.2]⟩
  · rw [abs_of_nonpos hc, abs_of_nonpos hs]
    exact ⟨by linarith [hpm.1], by linarith [hmp.2.1],
      by linarith [hpp.2.2.1], by linarith [hmm.2.2.2]⟩

/-- The central scalar inequality in the unavoidable-point argument. -/
theorem scalar_center_bound {q L : ℝ} (hq : 0 < q) (hL : L < 2) :
    q * (L / 2 - q / 2) < 1 / 2 := by
  have hmul : 0 < (2 - L) * q := mul_pos (sub_pos.mpr hL) hq
  nlinarith [sq_nonneg (q - 1)]

theorem projection_bound {a b dx dy D : ℝ}
    (hx : |dx| ≤ D) (hy : |dy| ≤ D) :
    |a * dx + b * dy| ≤ (|a| + |b|) * D := by
  calc
    |a * dx + b * dy| ≤ |a * dx| + |b * dy| := abs_add_le _ _
    _ = |a| * |dx| + |b| * |dy| := by rw [abs_mul, abs_mul]
    _ ≤ |a| * D + |b| * D := add_le_add
      (mul_le_mul_of_nonneg_left hx (abs_nonneg a))
      (mul_le_mul_of_nonneg_left hy (abs_nonneg b))
    _ = (|a| + |b|) * D := by ring

/-- Every contained unit square covers the container center strictly when `L < 2`. -/
theorem container_center_mem_interior (q : UnitSquare) {L : ℝ}
    (hfit : q.Fits L) (hL : L < 2) : (L / 2, L / 2) ∈ interior q.body := by
  obtain ⟨hxlo, hxhi, hylo, hyhi⟩ := contained_center_bounds q hfit
  have hx : |L / 2 - q.x| ≤ L / 2 - q.absSum / 2 :=
    abs_le.mpr ⟨by linarith, by linarith⟩
  have hy : |L / 2 - q.y| ≤ L / 2 - q.absSum / 2 :=
    abs_le.mpr ⟨by linarith, by linarith⟩
  have hb := scalar_center_bound q.absSum_pos hL
  apply q.strictBody_subset_interior
  change |q.c * (L / 2 - q.x) + q.s * (L / 2 - q.y)| < 1 / 2 ∧
    |-q.s * (L / 2 - q.x) + q.c * (L / 2 - q.y)| < 1 / 2
  constructor
  · exact lt_of_le_of_lt (projection_bound hx hy) hb
  · have hp := projection_bound (a := -q.s) (b := q.c) hx hy
    rw [abs_neg, add_comm |q.s| |q.c|] at hp
    exact lt_of_le_of_lt hp hb

/-- No two-square packing, at any orientations, has container side below two. -/
theorem two_square_lower_bound {L : ℝ} (h : Packs 2 L) : 2 ≤ L := by
  obtain ⟨squares, hfit, hdisjoint⟩ := h
  by_contra hL
  have hlt : L < 2 := lt_of_not_ge hL
  exact Set.disjoint_left.mp (hdisjoint 0 1 (by decide))
    (container_center_mem_interior (squares 0) (hfit 0) hlt)
    (container_center_mem_interior (squares 1) (hfit 1) hlt)

def axisSquare (x y : ℝ) : UnitSquare := ⟨x, y, 1, 0, by norm_num⟩

theorem axisSquare_body (x y : ℝ) :
    (axisSquare x y).body =
      Set.Icc (x - 1 / 2) (x + 1 / 2) ×ˢ Set.Icc (y - 1 / 2) (y + 1 / 2) := by
  ext z
  simp only [UnitSquare.body, UnitSquare.localX, UnitSquare.localY, axisSquare,
    Set.mem_setOf_eq, Set.mem_prod, Set.mem_Icc, one_mul, zero_mul,
    neg_zero, zero_add, add_zero]
  rw [abs_le, abs_le]
  constructor <;> rintro ⟨⟨h1, h2⟩, ⟨h3, h4⟩⟩ <;>
    exact ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩

/-- An explicit feasible packing: two upright squares sharing a vertical edge. -/
theorem two_square_witness : Packs 2 2 := by
  let left := axisSquare (1 / 2) (1 / 2)
  let right := axisSquare (3 / 2) (1 / 2)
  have hleft : left.body = Set.Icc (0 : ℝ) 1 ×ˢ Set.Icc (0 : ℝ) 1 := by
    dsimp [left]
    rw [axisSquare_body]
    norm_num
  have hright : right.body = Set.Icc (1 : ℝ) 2 ×ˢ Set.Icc (0 : ℝ) 1 := by
    dsimp [right]
    rw [axisSquare_body]
    norm_num
  have hfleft : left.Fits 2 := by
    intro z hz
    rw [hleft] at hz
    rcases hz with ⟨⟨hx0, hx1⟩, ⟨hy0, hy1⟩⟩
    exact ⟨hx0, by linarith, hy0, by linarith⟩
  have hfright : right.Fits 2 := by
    intro z hz
    rw [hright] at hz
    rcases hz with ⟨⟨hx1, hx2⟩, ⟨hy0, hy1⟩⟩
    exact ⟨by linarith, hx2, hy0, by linarith⟩
  have hd : Disjoint (interior left.body) (interior right.body) := by
    rw [hleft, hright]
    simp only [interior_prod_eq, interior_Icc]
    apply Set.disjoint_left.mpr
    intro z hzleft hzright
    have hxlt : z.1 < 1 := hzleft.1.2
    have hxgt : 1 < z.1 := hzright.1.1
    linarith
  refine ⟨fun i => if i = 0 then left else right, ?_, ?_⟩
  · intro i
    fin_cases i
    · simpa using hfleft
    · simpa using hfright
  · intro i j hij
    fin_cases i <;> fin_cases j
    · exact False.elim (hij rfl)
    · simpa using hd
    · simpa using hd.symm
    · exact False.elim (hij rfl)

/-- Side two is attainable and is a lower bound for every two-square packing. -/
theorem two_square_optimal : Packs 2 2 ∧ ∀ L : ℝ, Packs 2 L → 2 ≤ L :=
  ⟨two_square_witness, fun _ h => two_square_lower_bound h⟩

-- Audit the headline theorem's transitive axioms when this file is checked.
#print axioms two_square_optimal

end

end SquaresInSquare
