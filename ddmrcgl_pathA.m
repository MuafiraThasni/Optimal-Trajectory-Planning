function pathA = ddmrcgl_pathA(X,U,p)
% initialize
    pathA = [];
    d_collision=[];
    
       for j=1:3
     d_collision(j) = p.prob.r_m+ p.prob.r_ob(j);
       end
     d_sep21 = (X(:,1)-p.prob.x_ob(1)).^2 + (X(:,2)-p.prob.y_ob(1)).^2 ;
     d_sep22 = (X(:,1)-p.prob.x_ob(2)).^2 + (X(:,2)-p.prob.y_ob(2)).^2 ;
     d_sep23 = (X(:,1)-p.prob.x_ob(3)).^2 + (X(:,2)-p.prob.y_ob(3)).^2 ;
     
     path1 = d_collision(1)^2 - d_sep21 ;
      path2 = d_collision(2)^2 - d_sep22 ;
       path3 = d_collision(3)^2 - d_sep23;
     path=[path1;path2;path3];
    % combine
     pathA = [pathA;reshape(path,[],1)];  
     
end 