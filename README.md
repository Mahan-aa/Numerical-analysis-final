# Numerical Verification of Mean Value Theorems

Final project for the Numerical Analysis course.

## Description

This project numerically computes the points guaranteed by the Mean Value Theorem for Integrals and the Mean Value Theorem for Derivatives using MATLAB.

Given a function `F(x)` defined on an interval `[a,b]`, the program determines:

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

## Author

Mahan Rahimi





Numerical Analysis Final Project

2026
