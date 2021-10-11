function path = ddmrcgl_path(X,U,p)
% initialize
    path = [];
    % position path constraint
  
     d_collision = p.prob.r_m + p.prob.r_ob
  % for k = 1:p.Narray
     dist = [X(:,1),X(:,2);p.x_ob,p.y_ob];
 d = pdist(dist,'euclidean');
 d_sep2=d*d.';
     %d_sep2 = (p.x_ob - X(:,1))*(p.x_ob - X(:,1)).' + (p.y_ob - X(:,2))*(p.y_ob - X(:,2)).';
     path1 = d_collision^2 - d_sep2 ;
  % end
    % combine
     path = [path;reshape(path1,[],1)];  
end 