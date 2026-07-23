# Numerical Verification of Mean Value Theorems

Final project for the Numerical Analysis course.

**Live presentation:** https://mahan-aa.github.io/Numerical-analysis-final-presentation/

## Description

This project numerically verifies the Mean Value Theorem for Integrals and the Mean Value Theorem for Derivatives, applied to the function

```math
F(x)=\int_{0}^{\tan(x)} e^{-(t-1)^2}\,dt
```

on the interval `[0, 0.5]`. The integrand `exp(-(t-1)^2)` has no elementary antiderivative, and the upper limit `tan(x)` is itself transcendental, so `F(x)` cannot be evaluated in closed form — every value of `F` used anywhere in the project is produced numerically.

The project determines:

### Mean Value Theorem for Integrals

Find `c ∈ [a,b]` such that

```math
F(c)=\frac{1}{b-a}\int_a^b F(t)\,dt
```

### Mean Value Theorem for Derivatives

Find `c ∈ (a,b)` such that

```math
F'(c)=\frac{F(b)-F(a)}{b-a}
```

Only numerical methods are used to solve the problem itself. The Symbolic Math Toolbox is used only in supporting scripts — to build interpolating polynomials symbolically and to compute exact higher-order derivatives for error-bound analysis — never to differentiate or integrate `F` directly.

---

## Numerical Methods Used

### Custom Evaluation of F(x)

`F.m` implements the integral defining `F(x)` entirely from elementary arithmetic, without calling any built-in transcendental or integration function:

* `exp(x)` and `tan(x)` (via `sin(x)/cos(x)`) are each computed with a 51-term truncated **Taylor series**, valid because the arguments involved stay small on `[0, 0.5]`.
* The integral from `0` to `tan(x)` of `exp(-(t-1)^2)` is computed with **composite Simpson's 1/3 rule** using 1000 subintervals.

### Numerical Integration

`integral_of_F.m` computes

```math
\int_0^{0.5} F(t)\,dt
```

using composite Simpson's rule (1000 subintervals) applied to the custom `F(x)` itself, then divides by the interval length to get the average value of `F` on `[0, 0.5]`.

### Root Finding

* **Integral MVT** (`integral_mvt_root_finding.m`): a two-stage hybrid method — first, 5 iterations of bisection using exact symbolic (rational) arithmetic to narrow the bracket around the root; then, the derivative `F'(c)` is estimated with a centered three-point finite difference and used to run 6 steps of a Newton-style fixed-point iteration for fast refinement.
* **Derivative MVT** (`derivative_mvt.m`): straightforward bisection (tolerance `1e-8`) on the interpolated derivative function.

### Numerical Differentiation

`F'(x)` is never computed symbolically. It is sampled at 20 equally spaced points on `[0, 0.5]` using the **centered three-point (central difference) formula**:

```math
F'(x) \approx \frac{F(x+h)-F(x-h)}{2h}
```

### Interpolation

The 20 discrete `F'(x)` samples are turned into a continuous function `p(x) ≈ F'(x)` using a hand-built **Lagrange interpolating polynomial** (`derivative_mvt.m`, `ploting.m`). A second, alternative construction of the same kind of interpolant — via **Newton's forward-difference formula** for equally spaced points — is provided separately in `intpol_coeffs.m`.

---

## Algorithm

### Integral Mean Value Point

1. Compute the average value of `F` on `[a,b]` via Simpson's rule (`integral_of_F.m`).
2. Define

```math
G(x)=F(x)-\frac{1}{b-a}\int_a^bF(t)\,dt
```

3. Find a root of `G(x)` using symbolic bisection followed by a fixed-point (quasi-Newton) refinement (`integral_mvt_root_finding.m`).

### Derivative Mean Value Point

1. Compute the secant slope

```math
m=\frac{F(b)-F(a)}{b-a}
```

(with `F(0) = 0`, so `m = F(0.5)/0.5` on this interval).

2. Approximate `F'(x)` at 20 sample points using the centered three-point finite-difference formula.
3. Interpolate the derivative samples with a Lagrange polynomial `p(x)`.
4. Define

```math
H(x)=p(x)-m
```

5. Find a root of `H(x)` using bisection (`derivative_mvt.m`).

---

## Verification and Error Analysis

* **`verify_F.m`** sanity-checks the custom `F(x)` (Taylor series + Simpson's rule) against MATLAB's built-in adaptive quadrature (`integral`) applied to the true integrand and upper limit, confirming agreement to many decimal places.
* **`error_bounds.m`** symbolically computes the exact 4th derivatives of the integrand `g(t) = exp(-(t-1)^2)` and of `F(x)`, then uses `fminbnd` to find the maximum absolute value of each on `[0, 0.5]`. These maxima bound the theoretical error of the Simpson's rule approximation used inside `F.m`, and can be compared against the error actually observed in `verify_F.m`.

---

## Topics

* Numerical Integration (Simpson's rule)
* Numerical Differentiation (centered finite differences)
* Interpolation (Lagrange, Newton forward-difference)
* Root Finding (bisection, fixed-point iteration)
* Simpson's Rule Error Bounds
* Mean Value Theorem
* MATLAB / GNU Octave

---

## Files

| File | Purpose |
|---|---|
| `F.m` | Custom numerical evaluation of `F(x)` using Taylor series (`exp`, `tan`) and Simpson's rule |
| `verify_F.m` | Compares custom `F(x)` against MATLAB's built-in `integral` |
| `integral_of_F.m` | Computes `∫₀^0.5 F(t) dt` via Simpson's rule, for the Integral MVT target average |
| `integral_mvt_root_finding.m` | Solves the Integral MVT via symbolic bisection + fixed-point iteration |
| `derivative_mvt.m` | Solves the Derivative MVT via central-difference sampling, Lagrange interpolation, and bisection |
| `intpol_coeffs.m` | Alternative interpolating-polynomial coefficients via Newton's forward-difference formula |
| `error_bounds.m` | Computes exact 4th derivatives and their maxima on `[0, 0.5]` for the Simpson's rule error bound |
| `ploting.m` | Generates and saves all five figures |

---

## Figures

Running `src/ploting.m` generates and saves the following PNGs to `figures/`:

* `comparison.png` — custom `F(x)` vs. MATLAB's built-in integration
* `F_error.png` — error between custom `F(x)` and the built-in integration, y-axis zoomed to the error's own range
* `error_bounds.png` — 4th derivatives of the integrand and of `F(x)`, used for the Simpson's rule error bound
* `integral_mvt.png` — `F(x)`, its average value, and the Integral Mean Value Theorem point `(c, F(c))`
* `derivative_mvt.png` — `F'(x)` samples, the interpolating polynomial, and the Derivative Mean Value Theorem point `(c, p(c))`

---

## Dependencies

* **MATLAB** (R2016b or later, for local functions in script files)
  * **Symbolic Math Toolbox** — required for `syms`/`sym`, `int`, `diff`, `matlabFunction`, `vpa`, and `coeffs`, used in `derivative_mvt.m`, `error_bounds.m`, `integral_mvt_root_finding.m`, `intpol_coeffs.m`, and `ploting.m`
  * **Optimization Toolbox** — required for `fminbnd`, used in `error_bounds.m`

Running with **GNU Octave** instead of MATLAB also works, but requires the `symbolic` package:

```
pkg install -forge symbolic
pkg load symbolic
```

No other third-party packages or toolboxes are used.

---

## Authors

Mahan Rahimi
Shima Khalilpuor
Matin Abasi
Zahra Taheri
Masoome Mortazavi

Numerical Analysis Final Project

2026