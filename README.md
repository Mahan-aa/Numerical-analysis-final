# Numerical Verification of the Mean Value Theorems Using MATLAB

## Overview

This project presents a numerical investigation of two fundamental results from calculus:

1. **Mean Value Theorem for Integrals**
2. **Mean Value Theorem for Derivatives**

Given a continuous function (F(x)) on an interval ([a,b]), the goal is to determine numerically the points guaranteed by these theorems using only numerical techniques.

The project was developed in **MATLAB** as a final project for the Numerical Analysis course.

---

## Problem Statement

For a given function (F(x)), determine numerically:

### Integral Mean Value Theorem

Find (c \in [a,b]) such that

[
F(c)=\frac{1}{b-a}\int_a^b F(t),dt.
]

### Derivative Mean Value Theorem

Find (c \in (a,b)) such that

[
F'(c)=\frac{F(b)-F(a)}{b-a}.
]

Only numerical methods are allowed. Symbolic differentiation, symbolic integration, and exact analytical solutions are not used.

---

## Numerical Techniques Employed

### Numerical Integration

The average value of the function is computed through numerical approximation of

[
\int_a^b F(t),dt.
]

### Root Finding

To locate the point satisfying the Integral Mean Value Theorem, the equation

[
F(x)-\frac{1}{b-a}\int_a^b F(t),dt = 0
]

is solved numerically.

### Numerical Differentiation

The derivative (F'(x)) is approximated using finite-difference formulas.

### Interpolation

Derivative values obtained at discrete nodes are interpolated to construct a continuous approximation of (F'(x)).

### Nonlinear Equation Solving

The point satisfying the Mean Value Theorem for Derivatives is obtained by solving

[
F'(x)-\frac{F(b)-F(a)}{b-a}=0.
]

---

## Methodology

### Part I: Integral Mean Value Theorem

1. Define the function (F(x)).
2. Compute the integral numerically on ([a,b]).
3. Evaluate the average value

[
A=\frac{1}{b-a}\int_a^b F(t),dt.
]

4. Define

[
G(x)=F(x)-A.
]

5. Apply a root-finding algorithm to determine (c).

---

### Part II: Derivative Mean Value Theorem

1. Compute the secant slope

[
m=\frac{F(b)-F(a)}{b-a}.
]

2. Approximate derivative values numerically.
3. Interpolate the derivative data.
4. Construct

[
H(x)=F'(x)-m.
]

5. Apply a root-finding algorithm to obtain (c).

---

## MATLAB Implementation

The implementation combines several topics from numerical analysis:

* Numerical Integration
* Numerical Differentiation
* Polynomial/Spline Interpolation
* Nonlinear Equation Solving

MATLAB was used for all computations, visualizations, and verification of results.

---

## Expected Output

The program computes:

* Numerical approximation of the integral mean-value point.
* Numerical approximation of the derivative mean-value point.
* Intermediate numerical approximations.
* Graphical verification of the obtained solutions.
* Error analysis (when applicable).

---

## Educational Objectives

This project demonstrates how classical existence theorems from calculus can be verified computationally using numerical methods alone. It illustrates the interaction between root-finding, interpolation, differentiation, and integration techniques in a practical setting.

---
