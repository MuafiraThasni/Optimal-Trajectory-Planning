function pathtest = ddmrcgl_pathtest(X,U,p)
% initialize
    pathtest = [];
        
     d_collision = p.prob.r_m + p.prob.r_ob;
     d_sep2 = (X(:,1)-p.prob.x_ob).^2 + (X(:,2)-p.prob.y_ob).^2 ;
     path1 = d_collision^2 - d_sep2 ;
  % end
    % combine
     pathtest = [pathtest;reshape(path1,[],1)];  
end 