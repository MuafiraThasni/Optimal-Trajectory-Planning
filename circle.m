clc;
x = 5;
y = 3;
r=3;
%hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit)
hold off
a=[1,2]
b=[0,0]

 norm=norm(a-b)