function f = ddmr_deriv(tau,X,U,t0,tf,p)
    % state 1 derivative
    f(:,1) = U(:,1).*cos(X(:,3)); % x
    % state 2 derivative
    f(:,2) = U(:,1).*sin(X(:,3)); % y
    % state 3 derivative
    f(:,3) = U(:,2) % theta
end