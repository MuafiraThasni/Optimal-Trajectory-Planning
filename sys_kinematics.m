function f = ddmr_deriv(tau,X,U,t0,tf,p)
    
    f(:,1) = U(:,1).*cos(X(:,3)); % x
   
    f(:,2) = U(:,1).*sin(X(:,3)); % y
   
    f(:,3) = U(:,2) % theta
end
