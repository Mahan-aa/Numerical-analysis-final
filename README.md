# Numerical Verification of Mean Value Theorems
Final project for the Numerical Analysis course.

**Live presentation:** https://mahan-aa.github.io/Numerical-analysis-final-presentation/

## Description

This project numerically computes the points guaranteed by the Mean Value Theorem for Integrals and the Mean Value Theorem for Derivatives using MATLAB.

Given 
```math
F(x)=\int_{0}^{\tan(x)} e^{-(t-1)^2}\,dt
```
defined on an interval `[0,0.5]`, the program determines:

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

Only numerical methods are used. Symbolic differentiation and symbolic integration are not employed.

---

## Numerical Methods Used

### Numerical Integration

Computes the average value

```math
\frac{1}{b-a}\int_a^b F(t)\,dt
```

using MATLAB numerical integration routines.

### Root Finding

Determines the required value(s) of `c` by solving nonlinear equations numerically.

### Numerical Differentiation

Approximates derivative values using finite-difference formulas.

### Interpolation

Constructs a continuous approximation of the derivative from discrete derivative samples.

---

## Algorithm

### Integral Mean Value Point

1. Compute the average value of the function on `[a,b]`.
2. Define

```math
G(x)=F(x)-\frac{1}{b-a}\int_a^bF(t)\,dt
```

3. Find a root of `G(x)`.

### Derivative Mean Value Point

1. Compute the secant slope

```math
m=\frac{F(b)-F(a)}{b-a}
```

2. Approximate `F'(x)` numerically.
3. Interpolate the derivative values.
4. Define

```math
H(x)=F'(x)-m
```

5. Find a root of `H(x)`.

---

## Topics

* Numerical Integration
* Numerical Differentiation
* Interpolation
* Root Finding
* Mean Value Theorem
* MATLAB

---

## Figures

Running `src/ploting.m` generates and saves the following PNGs to `figures/`:

* `comparison.png` — custom F(x) vs. MATLAB's built-in integration
* `F_error.png` — error between custom F(x) and the built-in integration, y-axis zoomed to the error's own range
* `error_bounds.png` — 4th derivatives of the integrand and of F(x), used for the Simpson's rule error bound
* `integral_mvt.png` — F(x), its average value, and the Integral Mean Value Theorem point (c, F(c))
* `derivative_mvt.png` — F'(x) samples, the interpolating polynomial, and the Derivative Mean Value Theorem point (c, p(c))

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
