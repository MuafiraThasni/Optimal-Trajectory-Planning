clc
clear
close all
pi=3.141592654;
p.func.deriv = @ddmrcgl_deriv; % derivative function name
p.func.lagrange = @ddmrcgl_lagrange; % Lagrange term function name
p.func.mayer = @ddmrcgl_mayer; % Mayer term function name
p.func.path = @ddmrcgl_pathA % path constraint function name
p.func.boundary = @ddmrcgl_boundary; % boundary constraint function name
%p.func.plot = @ddmrcgl_plot; % plot function name
p.func.bounds = @ddmrcgl_bounds; % variables bounds function name
p.func.initial = @ddmrcgl_initial; % initial guess function name

% problem specific parameters
prob.d = 0.31;

prob.x0 = 0; prob.y0 = 0; prob.theta0 = 0; prob.v0=0; prob.w0=0; % initial conditions
prob.xf = 15; prob.yf = 15; prob.thetaf=pi/3; prob.vf=0; prob.wf=0; % final conditions
prob.tmax = 150; % maximum allowable tf
prob.t0 = 0; % initial time (required)
prob.tf = 500; % final time (required)

%t=p.tf;
p.ns = 5; % states
p.nu = 2; % controls 
% variable final time problem
p.varTF = 1; % 0:no, 1:yes

%obstacle avoidance
%..................................................................
prob.b = 0.29; prob.d = 0.31;
prob.r_m = sqrt(prob.b^2 + prob.d^2);  % robot circumcircle radius
prob.r_ob =[3,1,0.5]  % obstacle radius
prob.x_ob = [7,13,14]; % x coordinate of obstacle position
prob.y_ob = [3,9,13] ;  % y coordinate of obstacle position
p.prob = prob;





%--- options ---%
% pseudospectral method
p.opts.method = 'LGL'; % either LGL or CGL
% scale problem
p.opts.scale = 0; % 0:no, 1:yes
% plot flag
p.opts.plotflag = 1; % 0:no, 1:yes
% save flag
p.opts.saveflag = 1; % 0:no, 1:yes
% additional fmincon options
p.opts.fmincon.MaxIter = 2000;
% mesh number
mesh = 3 ;
% switch statement for case studies
switch mesh
    case 1
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 3; % number of nodes per segment (same size as p.Tarray)
    case 2
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 4; % number of nodes per segment
    case 3
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 5; % number of nodes per segment
    case 4
        p.Tarray = [0,1]; % segment boundaries
        p.Narray = 6; % number of nodes per segment
    case 5 
         p.Tarray = [0,1]; % segment boundaries
        p.Narray = 7;
    case 6
        p.Tarray = linspace(0,1,3); % segment boundaries
        p.Narray = 3*ones(1,length(p.Tarray)-1)+1;
        
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
[t,X,U,f,p,ef] = PS_Solve(p);
X(:,3)=(X(:,3)*180)/pi;
%interpolation 
 for i = 1:length(p.Narray)
        % interpolate based on method
        tarray1{i} = linspace(p.t0(i),p.tf(i),2000);
        interpX1{1,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpX1{2,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
        interpX1{3,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),3)',tarray1{i});
        interpX1{4,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),4)',tarray1{i});
        interpX1{5,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),5)',tarray1{i});
        interpU1{1,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpU1{2,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
 end
  tarray = cell2mat(tarray1)';
    interpX = cell2mat(interpX1)';
    interpU = cell2mat(interpU1)';
    
    
    %plots....................
    
    
   %trajectory
  %obstacle
  xob=prob.x_ob;
  yob=prob.y_ob;
  rob=prob.r_ob;
   th = 0:pi/50:2*pi;
   figure
   for k=1:length(xob)
xunit = rob(k) * cos(th) + xob(k);
yunit = rob(k) * sin(th) + yob(k);
plot(xunit, yunit,'r')
hold on
   end
   hold on
for j = 1:length(X(:,1))
     th = 0:pi/50:2*pi;
xunitm = prob.r_m * cos(th) + X(j,1);
yunitm = prob.r_m * sin(th) + X(j,2);
 plot(xunitm,yunitm,'black')
 hold on
end


   hold on
   plot(interpX(:,1),interpX(:,2),'linewidth',1)
   hold on
   plot(X(:,1),X(:,2),'linewidth',1.5,'linestyle','none','Marker','o')
   xlabel('x (m)')
   ylabel('y (m)')
   title('Trajectory')
   legend('trajectory','CGL nodes')
   %to change the angle unit into degree
 %  interpX(:,3)=(interpX(:,3)*180)/pi;
    figure
    h1 = plot(tarray,interpX,'linewidth',1); hold on
  h1(1).Color = [1 0 0];
    h1(2).Color = [0 0 1];
    h1(3).Color = [0 0 0];
    h1(4).Color = [1 0 1];
    h1(5).Color = [0.01 0.9 1];
    % plot CGL nodes
    h2 = plot(t,X,'linestyle','none','Marker','o','linewidth',1); 
 h2(1).Color = [1 0 0];
    h2(2).Color = [0 0 1];
    h2(3).Color = [0 0 0];
    h2(4).Color = [1 0 1];
    h2(5).Color = [0,01 0.9 0];
legend('x','y','$\phi$','v','$\omega$','x-CGL','y-CGL','$\phi-CGL$','v-CGL','$\omega$-CGL','interpreter','latex')
xlabel('time (s)')
ylabel('x(m) , y(m), $\phi$(degree) , v(m/s), $\omega$(rad/s)','interpreter','latex')
figure
    h3=plot(tarray,interpU,'linewidth',1);
    hold on;   
    h4 = plot (t,U,'linestyle','none','Marker','o','linewidth',1);
    legend('$u_1$','$u_2$','$u_1-CGL$','$u_2-CGL$','interpreter','latex')  

