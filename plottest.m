x=[0 1 2 3 4 5 6];
y=[0 .8415 .9093 .1411 -.7568 -.9589 -.2794];
k=LagrangeInter(x,y,x)
plot(k)
z=interp(k,5);
plot(z)
