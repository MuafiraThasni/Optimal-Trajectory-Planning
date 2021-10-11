function b = ddmrcgl_boundary(X,U,p)
    b = [];
    b = [b;X(1,1)-p.prob.x0;X(1,2)-p.prob.y0;X(1,3)-p.prob.theta0;];
    b = [b;X(end,1)-p.prob.xf;X(end,2)-p.prob.yf];
end