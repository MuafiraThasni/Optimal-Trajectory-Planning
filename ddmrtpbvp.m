solinit = bvpinit(linspace(0,1),[2;3;1;1;2]);
sol = bvp4c(@ode, @bc, solinit);
y = sol.y;
time = y(6)*sol.x;
ut1 = -y(4,:);
ut2= -y(5,:);

figure 
plot(time,ut)
hold on
plot(time,y(1,:))

hold on
plot(time,y(2,:))
legend('u1(t)','x1(t)','x2(t)')
grid on
% -------------------------------------------------------------------------
% ODE's of augmented states

function dydt = ode(t,y)
dydt = y(5)*[ y(:,4).*cos(y(:,3));y(:,4).*sin(y(:,3));  y(:,5);  ];
 
end
% -------------------------------------------------------------------------
% boundary conditions:x1(0)=1;x2(0)=2, x1(tf)=3, p2(tf)=0;
% p1(tf)*x2(tf)-0.5*p2(2)^2
function res = bc(ya,yb)
res = [ ya(1) - 10; ya(2) - 20; ya(3) - pi/2;
yb(3)*yb(2)-0.5*yb(4)^2];
end


