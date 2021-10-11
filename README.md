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





















export_fig
==========

A toolbox for exporting figures from MATLAB to standard image and document formats nicely.

### Overview
Exporting a figure from MATLAB the way you want it (hopefully the way it looks on screen), can be a real headache for the unitiated, thanks to all the settings that are required, and also due to some eccentricities (a.k.a. features and bugs) of functions such as `print`. The first goal of export_fig is to make transferring a plot from screen to document, just the way you expect (again, assuming that's as it appears on screen), a doddle.
  
The second goal is to make the output media suitable for publication, allowing you to publish your results in the full glory that you originally intended. This includes embedding fonts, setting image compression levels (including lossless), anti-aliasing, cropping, setting the colourspace, alpha-blending and getting the right resolution.

Perhaps the best way to demonstrate what export_fig can do is with some examples.

*Note: `export_fig` currently supports only figures created with the `figure` function, or GUIDE. Figures created using `uifigure` or AppDesigner are only partially supported. See issues [#287](https://github.com/altmany/export_fig/issues/287), [#261](https://github.com/altmany/export_fig/issues/261) for details.*
  
### Examples
**Visual accuracy** - MATLAB's exporting functions, namely `saveas` and `print`, change many visual properties of a figure, such as size, axes limits and ticks, and background colour, in unexpected and unintended ways. Export_fig aims to faithfully reproduce the figure as it appears on screen. For example:  
```Matlab
plot(cos(linspace(0, 7, 1000)));
set(gcf, 'Position', [100 100 150 150]);
saveas(gcf, 'test.png');
export_fig test2.png
```
generates the following:

| Figure: | test.png: | test2.png: |
|:-------:|:---------:|:----------:|
|![](https://farm6.staticflickr.com/5616/15589249291_16e485c29a_o_d.png)|![](https://farm4.staticflickr.com/3944/15406302850_4d2e1c7afa_o_d.png)|![](https://farm6.staticflickr.com/5607/15568225476_8ce9bd5f6b_o_d.png)|

Note that the size and background colour of test2.png (the output of export_fig) are the same as those of the on screen figure, in contrast to test.png. Of course, if you want the figure background to be white (or any other colour) in the exported file then you can set this prior to exporting using:
```Matlab
set(gcf, 'Color', 'w');
```
  
Notice also that export_fig crops and anti-aliases (smooths, for bitmaps only) the output by default. However, these options can be disabled; see the Tips section below for details.
  
**Resolution** - by default, export_fig exports bitmaps at screen resolution. However, you may wish to save them at a different resolution. You can do this using either of two options: `-m<val>`, where <val> is a positive real number, magnifies the figure by the factor <val> for export, e.g. `-m2` produces an image double the size (in pixels) of the on screen figure; `-r<val>`, again where <val> is a positive real number, specifies the output bitmap to have <val> pixels per inch, the dimensions of the figure (in inches) being those of the on screen figure. For example, using:  
```Matlab
export_fig test.png -m2.5
```
on the figure from the example above generates:

![](https://farm4.staticflickr.com/3937/15591910915_dc7040c477_o_d.png)

Sometimes you might have a figure with an image in. For example:
```Matlab
imshow(imread('cameraman.tif'))
hold on
plot(0:255, sin(linspace(0, 10, 256))*127+128);
set(gcf, 'Position', [100 100 150 150]);
```
generates this figure:

![](https://farm4.staticflickr.com/3942/15589249581_ff87a56a3f_o_d.png)
  
Here the image is displayed in the figure at resolution lower than its native resolution. However, you might want to export the figure at a resolution such that the image is output at its native (i.e. original) size (in pixels). Ordinarily this would require some non-trivial computation to work out what that resolution should be, but export_fig has an option to do this for you. Using:
```Matlab
export_fig test.png -native
```
produces:

![](https://farm6.staticflickr.com/5604/15589249591_da2b2652e4_o_d.png)

with the image being the size (in pixels) of the original image. Note that if you want an image to be a particular size, in pixels, in the output (other than its original size) then you can resize it to this size and use the `-native` option to achieve this.

All resolution options (`-m<val>`, `-q<val>` and `-native`) correctly set the resolution information in PNG and TIFF files, as if the image were the dimensions of the on screen figure.

**Shrinking dots & dashes** - when exporting figures with dashed or dotted lines using either the ZBuffer or OpenGL (default for bitmaps) renderers, the dots and dashes can appear much shorter, even non-existent, in the output file, especially if the lines are thick and/or the resolution is high. For example:  
```Matlab
plot(sin(linspace(0, 10, 1000)), 'b:', 'LineWidth', 4);
hold on
plot(cos(linspace(0, 7, 1000)), 'r--', 'LineWidth', 3);
grid on
export_fig test.png
```
generates:

![](https://farm4.staticflickr.com/3956/15592747732_f943d4aa0a_o_d.png)

This problem can be overcome by using the painters renderer. For example:
```Matlab
export_fig test.png -painters
```
used on the same figure generates:

![](https://farm4.staticflickr.com/3945/14971168504_77692f11f5_o_d.png)

Note that not only are the plot lines correct, but the grid lines are too.

