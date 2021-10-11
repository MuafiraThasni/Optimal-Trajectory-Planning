function f = ddmrcgl_deriv(tau,X,U,t0,tf,p)
    % state 1 derivative
    f(:,1) = X(:,4).*cos(X(:,3))-p.prob.d*X(:,5).*sin(X(:,3)); % x
    % state 2 derivative
    f(:,2) = X(:,4).*sin(X(:,3))+p.prob.d*X(:,5).*cos(X(:,3)); % y
    % state 3 derivative
    f(:,3) = X(:,5); % phi
    f(:,4) = U(:,1);
    f(:,5) = U(:,2);
end