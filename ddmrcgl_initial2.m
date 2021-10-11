function x0 = ddmrcgl_initial2(p)   
	% linear guess functions
	fX0 = @(t) (p.prob.xf - p.prob.x0)/(p.t{end}(end) - 2*p.t{1}(1))*t + p.prob.x0;
    fY0 = @(t) (p.prob.yf - p.prob.y0)/3*(p.t{end}(end) - p.t{1}(1))*t + p.prob.y0;
	ftheta0 = @(t,theta0,thetaf) (2*thetaf - theta0)/(p.t{end}(end) - p.t{1}(1))*t + theta0;
    fv0 = @(t) (p.prob.vf-p.prob.v0)/(p.t{end}(end) - p.t{1}(1))*t + 1.5*p.prob.v0;
     fw0 = @(t) (p.prob.wf-p.prob.w0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.w0;
    
	fU10 = @(t,u10,u1f) (u1f - u10)/(p.t{end}(end) - p.t{1}(1))*t + u10;
    fU20 = @(t,u20,u2f) (u2f - u20)/(p.t{end}(end) - p.t{1}(1))*t + u20;
	Xguess = []; Yguess = []; thetaguess = []; U1guess = [];U2guess = [];
    Vguess = []; Wguess= [];
	for i = 1:length(p.Narray)
	    Xguess = [Xguess;fX0(p.t{i})]; % x initial guess
        Yguess = [Yguess;fY0(p.t{i})]; % y initial guess
	    thetaguess = [thetaguess;ftheta0(p.t{i},0,1)]; % v initial guess
	    U1guess = [U1guess;fU10(p.t{i},0,pi)]; % u initial guess
        U2guess = [U2guess;fU20(p.t{i},0,pi)];
        Vguess = [Vguess;fv0(p.t{i})];
        Wguess = [Wguess;fw0(p.t{i})];
        
	end
    % final time guess
    tguess = p.t{end}(end);
	% combine to column vector
	x0 = [reshape(Xguess,[],1);reshape(Yguess,[],1);reshape(thetaguess,[],1);...
        reshape(Vguess,[],1); reshape(Wguess,[],1);reshape(U1guess,[],1);reshape(U2guess,[],1);tguess];
    
end