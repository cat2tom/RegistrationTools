%determine the change in deformation in the x direction for the mth by nth
%control point
function dLXdpx = dLdPx(base,sz2,sz,m,n,i1,j1)

sz3 = size(base);
[y,x] = find(base >= 0);
locations = find(base >= 0);
X = zeros(sz3(1),sz3(2));
Y = zeros(sz3(1),sz3(2));
X(locations) = x(locations)+j1;
Y(locations) = y(locations)+i1;
dLXdpx = zeros(sz3(1),sz3(2));




        i = floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
        j = floor(((X-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        loc = find(m-i >=0 & m-i <=3 & n-j >=0 & n-j <=3); 
%             u = X(loc).*sz2(2)./sz(2) - floor(X(loc).*sz2(2)./sz(2));
%             v = Y(loc).*sz2(1)./sz(1) - floor(Y(loc).*sz2(1)./sz(1));
%             u = rem(X(loc),(sz(2)/((sz2(2)-3))+1));
%             v = rem(Y(loc),(sz(1)/((sz2(1)-3))+1));
              u = ((X(loc)-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X(loc)-0.5).*(sz2(2)-3)./sz(2))+2);
              v = ((Y(loc)-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y(loc)-0.5).*(sz2(1)-3)./sz(1))+2);
            xsum = bspline(u,n-j(loc)).*bspline(v,m-i(loc));

%      
        dLXdpx(loc) = xsum;

