%--------------------------------------------------------------------------
% Brach_initial.m
% Brachistochrone initial guess function
% outputs and initial guess for the given mesh
%--------------------------------------------------------------------------
% f = Brach_initial(tau,X,U,t0,tf,p)
%  p: parameter structure
% x0: initial guess vector
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/basic-multiple-interval-pseudospectral
%--------------------------------------------------------------------------
function x0 = ddmr_initial(p)   
	% linear guess functions
	fX0 = @(t) (p.prob.xf - p.prob.x0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.x0;
    fY0 = @(t) (p.prob.yf - p.prob.y0)/(p.t{end}(end) - p.t{1}(1))*t + p.prob.y0;
	ftheta0 = @(t,theta0,thetaf) (thetaf - theta0)/(p.t{end}(end) - p.t{1}(1))*t + theta0;
	%fU10 = @(t,u10,u1f) (u1f - u10)/(p.t{end}(end) - p.t{1}(1))*t + u10;
    %fU20 = @(t,u20,u2f) (u2f - u20)/(p.t{end}(end) - p.t{1}(1))*t + u20;
	Xguess = []; Yguess = []; thetaguess = []; U1guess = [];U2guess = [];
	for i = 1:length(p.Narray)
	    Xguess = [Xguess;fX0(p.t{i})]; % x initial guess
        Yguess = [Yguess;fY0(p.t{i})]; % y initial guess
	    thetaguess = [thetaguess;ftheta0(p.t{i},0,1)]; % v initial guess
	    U1guess = [U1guess;0]; % u initial guess
        U2guess = [U2guess;0]; 
	end
    % final time guess
    tguess = p.t{end}(end);
	% combine to column vector
	x0 = [reshape(Xguess,[],1);reshape(Yguess,[],1);reshape(thetaguess,[],1);...
        reshape(U1guess,[],1);reshape(U1guess,[],1);tguess];
    
end