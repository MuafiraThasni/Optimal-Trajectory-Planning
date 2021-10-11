function b = ddmrcgl_boundary(X,U,p)
    % initialize boundary constraint
    b = [];
    % initial boundary constraints
    b = [b;X(1,1)-p.prob.x0;X(1,2)-p.prob.y0;X(1,3)-p.prob.theta0;X(1,4)-p.prob.v0;X(1,5)-p.prob.w0;];
    % final boundary constraints
    b = [b;X(end,1)-p.prob.xf;X(end,2)-p.prob.yf;X(end,3)-p.prob.thetaf];
end