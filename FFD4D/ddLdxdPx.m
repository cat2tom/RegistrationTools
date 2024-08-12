%determine the change in deformation in the x direction for the mth by nth
%control point
function values = ddLdxdPx(base,sz2,sz,m,n,i1,j1)
sz3 = size(base);
[y,x] = find(base >= 0);
locations = find(base >= 0);
X = zeros(sz3(1),sz3(2));
Y = zeros(sz3(1),sz3(2));
X(locations) = x(locations)+j1;
Y(locations) = y(locations)+i1;
values = zeros(sz3(1),sz3(2));
dudx = (sz2(2)-3)/sz(2);

         i = floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
        j = floor(((X-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        indices = find( m-i >=0 & m-i <=3 & n-j >=0 & n-j <=3); 
%             u = X(indices).*(sz2(2)-3)./(sz(2)-1)+1 - floor(X(indices).*(sz2(2)-3)./(sz(2)-1)+1);
%             v = Y(indices).*(sz2(1)-3)./(sz(1)-1)+1 - floor(Y(indices).*(sz2(1)-3)./(sz(1)-1)+1);
%             u = rem(X(indices),(sz(2)/((sz2(2)-3))+1));
%             v = rem(Y(indices),(sz(1)/((sz2(1)-3))+1));

              u = ((X(indices)-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X(indices)-0.5).*(sz2(2)-3)./sz(2))+2);
              v = ((Y(indices)-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y(indices)-0.5).*(sz2(1)-3)./sz(1))+2);
            xsum = dbspline(u,n-j(indices)).*bspline(v,m-i(indices)).*dudx;

        values(indices) = xsum;

