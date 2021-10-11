clc
clear
close all
pi=3.141592654;
p.func.deriv = @sys_kinematics; 
p.func.lagrange = @ddmrcgl_lagrange; 
p.func.mayer = @ddmrcgl_mayer; 
p.func.path = @ddmrcgl_path; 
p.func.boundary = @sys_boundary; 
%p.func.plot = @ddmrcgl_plot; 
p.func.bounds = @sys_bounds; 
p.func.initial = @sys_initial; 
prob.x0 = 0; prob.y0 = 0; prob.theta0 = 0; 
prob.xf = 50; prob.yf = 50; prob.thetaf=pi/2;
prob.tmax = 150; 
prob.t0 = 0; 
prob.tf = 500;
p.prob = prob;
p.ns = 3;
p.nu = 2;
p.varTF = 1; 
p.opts.method = 'CGL'; 
p.opts.scale = 0; 
p.opts.plotflag = 1;
p.opts.saveflag = 1; 
p.opts.fmincon.MaxIter = 2000;
p.Tarray = [0,1]; 
p.Narray = 4;    
[t,X,U,f,p,ef] = PS_Solve(p);

%interpolation 
 for i = 1:length(p.Narray)
        % interpolate based on method
        tarray1{i} = linspace(p.t0(i),p.tf(i),2000);
        interpX1{1,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpX1{2,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
        interpX1{3,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),3)',tarray1{i}); interpU1{1,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpU1{2,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
 end
  tarray = cell2mat(tarray1)';
  interpX = cell2mat(interpX1)';
  interpU = cell2mat(interpU1)';
   %plots....................
    
    
   %trajectory
   figure
   plot(interpX(:,1),interpX(:,2),'linewidth',1)
   hold on
   plot(X(:,1),X(:,2),'linewidth',1.5,'linestyle','none','Marker','o')
   xlabel('x (m)')
   ylabel('y (m)')
   title('Trajectory')
   legend('trajectory','CGL nodes')
   
    figure
    h1 = plot(tarray,interpX,'linewidth',1); hold on
    h1(1).Color = [1 0 0];
    h1(2).Color = [0 0 1];
    h1(3).Color = [0 0 0];
    % plot CGL nodes
    h2 = plot(t,X,'linestyle','none','Marker','o','linewidth',1); 
    h2(1).Color = [1 0 0];
    h2(2).Color = [0 0 1];
    h2(3).Color = [0 0 0];
legend('x','y','$\theta$','x-CGL','y-CGL','$\theta-CGL$','interpreter','latex')
xlabel('time (s)')
ylabel('x(m) , y(m), $\theta$(rad)','interpreter','latex')
figure
    h3=plot(tarray,interpU,'linewidth',1);
    hold on;
    h4 = plot (t,U,'linestyle','none','Marker','o','linewidth',1);
    legend('$u_1$','$u_2$','$u_1-CGL$','$u_2-CGL$','interpreter','latex')  
    
        