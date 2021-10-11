function ddmrcgl_plot(t,X,U,f,p)
    %% --- interpolate
    % interpolate the solution with the specified polynomials
    interpN = 2000; % number of linearly spaced interpolation points
    for i = 1:length(p.Narray)
        % interpolate based on method
        tarray1{i} = linspace(p.t0(i),p.tf(i),interpN);
        interpX1{1,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpX1{2,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
        interpX1{3,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),3)',tarray1{i});
        interpX1{4,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),4)',tarray1{i});
        interpX1{5,i} = LagrangeInter(p.t{i}',X(p.cumN(i)+1:p.cumN(i+1),5)',tarray1{i});
        interpU1{1,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),1)',tarray1{i});
        interpU1{2,i} = LagrangeInter(p.t{i}',U(p.cumN(i)+1:p.cumN(i+1),2)',tarray1{i});
    end
    % create column vectors
    tarray = cell2mat(tarray1)';
    interpX = cell2mat(interpX1)';
    interpU = cell2mat(interpU1)';
    %% --- plot parameters
    % fonts
    font1 = 18; % font size parameter
    font2 = 12;
    % colors
    wcolor = [1 1 1]; % white color
    bcolor = [0 0 0]; % black color
    xc = [1 1 0];
    yc = [1 0 1];
    vc = [0 1 1];
    phic= [0 1 0];
    wc= [0 0 1];
    u1c = [0 0 0];
    u2c=[0.5 0.5 0.5];
    lc = [76,175,80]/255;
    % defaults
    set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
    set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
    set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
    %% --- plot states and control
    hf = figure;
    hf.Color = wcolor; % change the figure background color
    
    % plot lagrange polynomials
    h1 = plot(tarray,[interpX,interpU],'linewidth',2); hold on
    h1(1).Color = xc;
    h1(2).Color = yc;
    h1(3).Color = phic;
    h1(4).Color = vc;
    h1(5).Color = wc;
    h1(6).Color = u1c;
    h1(7).Color = u2c
    % plot DT nodes
    h2 = plot(t,[X,U],'linestyle','none','Marker','o','linewidth',2); hold on
    h2(1).Color = xc;
    h2(2).Color = yc;
    h2(3).Color = phic;
    h2(4).Color = vc;
     h2(5).Color = wc;
     h2(6).Color = u1c;
    h2(7).Color = u2c;
    % labels
    ylabel('$x$, $y$, $\phi$, $v$, $w$, $u_1$ ,$u_2$',...
        'interpreter','latex','fontsize',font1);
    xlabel('$t$ (s)','interpreter','latex','fontsize',font1);
    % axis color
    ha = gca; % get current axis handle
    ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
    ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
    % legend
    hL = legend('$x_{\mathrm{interp}}$','$y_{\mathrm{interp}}$',...
        '$\phi_{\mathrm{interp}}$','$v_{\mathrm{interp}}$','$w_{\mathrm{interp}}$','$u1_{\mathrm{interp}}$','$u2_{\mathrm{interp}}$');
    set(hL,'orientation','horizontal','interpreter','latex',...
        'box','off')
    set(hL,'interpreter','latex','fontsize',font1-6);
    hL.AutoUpdate = 'off';
    % segment boundaries
    for i = 1:length(p.tf)
        h3 = plot([p.tf(i),p.tf(i)],[ha.YLim(1),ha.YLim(2)],'--','Color',lc); hold on
        uistack(h3, 'bottom')
    end
    
    %% --- plot animate line in x-y space
    hf = figure;
    hf.Color = wcolor; % change the figure background color
    
    % plot lagrange polynomials
    h1 = plot(interpX(:,1),-interpX(:,2),'linewidth',1); hold on
    h1(1).Color = xc;
    % labels
    xlabel('$x$','interpreter','latex','fontsize',font1);
    ylabel('$-y$','interpreter','latex','fontsize',font1);
    % axis color
    ha = gca; % get current axis handle
    ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
    ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
    
    % animated line
    hani = animatedline('color','k','linewidth',2);
    tani = unique([tarray(1):0.02:tarray(end),tarray(end)]);
    Nani = length(tani);
    dtani = tani(2)-tani(1);
    [Tani,Iinterp,~] = unique(tarray);
    Xani = interp1(Tani,interpX(Iinterp,:),tani);
    for k = 1:Nani
        addpoints(hani,Xani(k,1),-Xani(k,2));
        hdot = plot(Xani(k,1),-Xani(k,2),'ko','markersize',12);
        drawnow
        pause(dtani*2)
        delete(hdot)
    end
    
    % results 
    results.Nt = length(U);
    results.NI = length(p.Narray);
    results.f = f;
  
    %results.ferror = abs(f - factual);
    % display results
    format shortE
    disp(results)
    
   
end
 
    
   
   