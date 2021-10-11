function p = ddmr_bounds(p)
	% state bounds
    pi=180;
	XL = kron([0;0;-2*pi],ones(p.nt,1)); % lower
	XU = kron([10;10;2*pi],ones(p.nt,1)); % upper
    
	% control bounds
	UL = -5*ones(p.nt,p.nu); % lower
	UU = 5*ones(p.nt,p.nu); % upper
    
    % time bounds
    tL = 0;
    tU = p.prob.tmax;
	% combine to column vector
	p.xL = [reshape(XL,[],1);reshape(UL,[],1);tL]; 
	p.xU = [reshape(XU,[],1);reshape(UU,[],1);tU];
end