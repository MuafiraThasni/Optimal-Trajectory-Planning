function L = ddmrcgl_lagrange(x,p,i)
    X = reshape(x(1:p.ns*p.nt),p.nt,[]); % states
    U = reshape(x(p.ns*p.nt+1:end-1),p.nt,[]); % controls
    L = ones(p.Narray(i),1);
    
    
   %%Lagrange term values obstacle avoidance 
     %d_collision = p.prob.r_m + p.prob.r_ob;
     %d_sep =sqrt( (X(:,1)-p.prob.x_ob).^2 + (X(:,2)-p.prob.y_ob).^2 );
    % P = (d_sep - d_collision);
     %P2=P.^2;
     %Pnorm2 = 1/P2;
    %%L = ones(p.Narray(i),1) + (Pnorm2*ones(p.Narray(i),1));
   
    
 
end