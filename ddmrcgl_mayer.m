function m = ddmrcgl_mayer(x,p)
    % extract from optimization vector
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
	tf = x(end); % final time
    % Lagrange term values for this segment
    m = 0;
end