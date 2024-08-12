%determine the change in deformation in the x direction for the mth by nth
%control point
function [values] = ddLdydPy2(base,dgrid,m,n)

sz = size(base);
[y,x] = find(base >= 0);

sz2 = size(dgrid);
values = zeros(sz(1),sz(2));
dvdy = sz2(1)/sz(1);
for t = 1:length(x)
        i = floor(((x(t)-0.5)*(sz2(2)-3)/sz(2))+2)-1;
        j = floor(((y(t)-0.5)*(sz2(1)-3)/sz(1))+2)-1;
        if m-i >=0 && m-i <=3 && n-j >=0 && n-j <=3 
            u = x(t)*sz2(2)/sz(2) - floor(x(t)*sz2(2)/sz(2));
            v = y(t)*sz2(1)/sz(1) - floor(y(t)*sz2(1)/sz(1));
            ysum = bspline(u,m-i)*dbspline(v,n-j)*dvdy;
         else
            ysum = 0;
        end    
        values(y(t),x(t)) = ysum;
end
