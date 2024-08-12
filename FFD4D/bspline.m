%calculates the derivative of kth basis function of a cubic B-spline
function value = bspline(u,k)

sz =size(u);
value = zeros(sz(1),sz(2));
loc = find(k == 0); 
    value(loc) = ((1-u(loc)).^3)./6;
loc = find(k == 1);
    value(loc) = (3*(u(loc).^3)-6*(u(loc).^2)+4)./6;
loc = find(k == 2);
        value(loc) = (-3*(u(loc).^3)+3*(u(loc).^2)+ 3*u(loc) + 1)./6;
loc = find(k == 3);
        value(loc) = (u(loc).^3)./6;

