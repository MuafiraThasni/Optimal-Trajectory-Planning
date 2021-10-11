x=[0 1 2 3 4 5 6];
y=[0 .8415 .9093 .1411 -.7568 -.9589 -.2794];
sum=0;
for i=1:length(x)
    p=1;
    for j=1:length(x)
        if j~=i
            c = poly(x(j))/(x(i)-x(j));
            p = conv(p,c);
        end
    end
    term = p*y(i);
    sum= sum + term;
end
disp(sum);
figure
plot(sum)