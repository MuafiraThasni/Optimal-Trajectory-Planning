function p = ddmrcgl_bounds(p)
pi=3.141592654;
xL=kron([-inf;-inf;-pi;-6;-10],ones(p.nt,1));
xU=kron([inf;inf;pi;6;10],ones(p.nt,1));
uL=-5*ones(p.nt,p.nu);
uU=5*ones(p.nt,p.nu);
tL=0;
tU=p.prob.tmax;
%combine to column vector
p.xL=[reshape(xL,[],1);reshape(uL,[],1);tL];
p.xU=[reshape(xU,[],1);reshape(uU,[],1);tU];
end
