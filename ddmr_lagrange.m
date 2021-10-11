function L = ddmr_lagrange(x,p,i)
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
    % Lagrange term values for this segment
    L = zeros(p.Narray(i),1);
    
end