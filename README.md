Introduction to Pseudo Spectral Optimal Control
===============================================
Pseudo spectral methods were originally developed for the solution of partial differential equations and have become a widely applied computational tool in fluid dynamics and also optimal control problem. Pseudo spectral methods are global because they use information over
samples of the whole domain of the function to approximate its derivatives at selected points.
Using these methods, the state and control functions are approximated as a weighted sum of
smooth basis functions, which are often chosen to be Legendre or Chebyshev polynomials in
the interval [-1 1], and collocation of the differential-algebraic equations is performed at orthogonal
collocation points, which are selected to yield interpolation. One of the main advantages
of pseudo spectral methods is the exponential (or spectral) rate of convergence, which is faster.
Another advantage is the good accuracy due to the relatively coarse grids. In cases where global
collocation is unsuitable (for example, when the solution exhibits discontinuities), multi-domain pseudo spectral techniques have been proposed, where the problem is divided into a number of sub-intervals and global collocation is performed along each sub-interval.

Pseudo spectral methods directly discretize the original optimal control problem to formulate
a nonlinear programming problem, which is then solved numerically using a sparse nonlinear
programming solver to find approximate local optimal solutions. For differentiation,
the derivatives of the state functions at the discretization nodes are easily computed by multiplying
a constant differentiation matrix by a matrix with the state values at the nodes. Thus,
the differential equations of the optimal control problem are approximated by a set of algebraic
equations. The integration in the cost functional of an optimal control problem is approximated
by well known Gauss quadrature rules, consisting of a weighted sum of the function values at
the discretization nodes. Moreover, as is the case with other direct methods for optimal control,
it is easy to represent state and control dependent constraints.
In this thesis, Chebyshev Pseudo Spectral method is used, in which the basis polynomial
is the Chebyshev polynomial and interpolation nodes are the roots of Chebyshev Polynomial.



Documentation: [Slides](https://github.com/MuafiraThasni/Optimal-Trajectory-Planning/blob/main/viva%20july%2015.pdf), [Report](https://github.com/MuafiraThasni/Optimal-Trajectory-Planning/blob/main/muafirathesisreportjuly7.pdf)

















