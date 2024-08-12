%determine the change in deformation in the x direction for the mth by nth
%control point
function values = ddLdxdPx3D(sz3,sz2,sz,m,n,p,i1,j1,k1)
% sz3 = size(base);
% [y,x] = find(base >= 0);
% % z = ceil(x./sz(2));
% x = rem(x,sz(2));
% locations = find(base >= 0);
% X = zeros(sz(1),sz(2),sz(3));
% Y = zeros(sz(1),sz(2),sz(3));
% Z = zeros(sz(1),sz(2),sz(3));
% X(locations) = x(locations)+j1;
% Y(locations) = y(locations)+i1;
% Z(locations) = ceil(x(locations)./sz(2))+k1;
zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
X = repmat(1:sz(2),[sz(1),1,sz(3)])+j1;
Y = repmat((1:sz(1))',[1,sz(2),sz(3)])+i1;
Z = repmat(zarray,[sz(1),sz(2),1])+k1;
values = zeros(sz3(1),sz3(2),sz3(3));
dudx = (sz2(2)-3)/sz(2);

        i = floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
        j = floor(((X-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        k = floor(((Z-0.5).*(sz2(3)-3)./sz(3))+2)-1;
        indices = find( m-i >=0 & m-i <=3 & n-j >=0 & n-j <=3 & p-k >=0 & p-k <=3); 

              u = ((X(indices)-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X(indices)-0.5).*(sz2(2)-3)./sz(2))+2);
              v = ((Y(indices)-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y(indices)-0.5).*(sz2(1)-3)./sz(1))+2);
              w = ((Z(indices)-0.5).*(sz2(3)-3)./sz(3))+2 - floor(((Z(indices)-0.5).*(sz2(3)-3)./sz(3))+2);
            xsum = dbspline(u,n-j(indices)).*bspline(v,m-i(indices)).*bspline(w,p-k(indices)).*dudx;

        values(indices) = xsum;

