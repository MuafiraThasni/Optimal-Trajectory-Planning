clc
clear
close all
pi=3.14;
p.func.deriv = @ddmr_deriv; % derivative function name
p.func.lagrange = @ddmr_lagrange; % Lagrange term function name
p.func.mayer = @ddmr_mayer; % Mayer term function name
p.func.path = @ddmr_path; % path constraint function name
p.func.boundary = @ddmr_boundary; % boundary constraint function name
p.func.plot = @ddmr_plot; % plot function name
p.func.bounds = @ddmr_bounds; % variables bounds function name
p.func.initial = @ddmr_initial; % initial guess function name
% problem specific parameters
prob.d=0.04;
prob.x0 = 0; prob.y0 = 0; prob.theta0 = 0; prob.v0=0; prob.w0=0; % initial conditions
prob.xf = 20; prob.yf = 10; prob.thetaf=pi/2; prob.vf=1; prob.wf=0; % final conditions
prob.tmax = 100; % maximum allowable tf
prob.t0 = 0; % initial time (required)
prob.tf = 10; % final time (required)
p.prob = prob;
%t=p.tf;
p.ns = 3; % states
p.nu = 2; % controls
% variable final time problem
p.varTF = 1; % 0:no, 1:yes
%--- options ---%
% pseudospectral method
p.opts.method = 'CGL'; % either LGL or CGL
% scale problem
p.opts.scale = 0; % 0:no, 1:yes
% plot flag
p.opts.plotflag = 1; % 0:no, 1:yes
% save flag
p.opts.saveflag = 1; % 0:no, 1:yes
% additional fmincon options
p.opts.fmincon.MaxIter = 2000;
% mesh number
mesh = 2;
% switch statement for case studies
switch mesh
    case 1
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 5; % number of nodes per segment (same size as p.Tarray)
    case 2
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 8; % number of nodes per segment
    case 3
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 15; % number of nodes per segment
    case 4
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 20; % number of nodes per segment
    case 5
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 10*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 6
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 7
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 4*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 8
        p.Tarray = linspace(0,1,4); % segment boundaries
        p.Narray = 6*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 9
        p.Tarray = linspace(0,1,6); % segment boundaries
        p.Narray = 5*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
    case 10
        p.Tarray = linspace(0,1,8); % segment boundaries
        p.Narray = 4*ones(1,length(p.Tarray)-1)+1; % number of nodes per segment
end
%--- solve and plot ---%
% solve the problem
[t,X,U,f,p,e] = PS_Solve(p);
% plot the solution
if p.opts.plotflag
    p.func.plot(t,X,U,f,p)
end
figure
plot(t,X(:,1))
hold on 
plot(t,X(:,2))
legend('x','y')
