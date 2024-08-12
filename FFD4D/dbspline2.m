%calculates the derivative of kth basis function of a cubic B-spline
function value = dbspline2(u,k);

switch k
    case(0) 
        value = (-3*(1-u).^2)./6;
    case(1)
        value = (9*(u.^2)-12*(u))./6;
    case(2)
        value = (-9*(u.^2)+6*(u)+ 3)./6;
    case(3)
        value = (3*u.^2)./6;
end
