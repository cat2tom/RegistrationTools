%calculates the derivative of kth basis function of a cubic B-spline
function value = bspline2(u,k)

switch k
    case(0) 
        value = ((1-u).^3)./6;
    case(1)
        value = (3*(u.^3)-6*(u.^2)+4)./6;
    case(2)
        value = (-3*(u.^3)+3*(u.^2)+ 3*u + 1)./6;
    case(3)
        value = (u.^3)./6;
end
