function [t,X,U,F] = ddmrcgl_solution(t,p,flag)
    % large number of points? otherwise use original
    if flag == 1
        t = linspace(t(1),t(end),10000)';
    end
    X = [];
    t = tin;
    F = prob.tf;
end