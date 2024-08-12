%calculate the derivative of the change in the tensor product for a free
%form deformation by the change in x.
function [xsum,ysum,zsum] = dLdx3D(sz,dgridx,dgridy,dgridz)

% sz = size(base);
% [y,x] = find(base >= 0);
% z = ceil(x./sz(2));
% x = rem(x,sz(2));
% locations = find(base >= 0);
% X = zeros(sz(1),sz(2),sz(3));
% Y = zeros(sz(1),sz(2),sz(3));
% Z = zeros(sz(1),sz(2),sz(3));
% X(locations) = x(locations);
% Y(locations) = y(locations);
% Z(locations) = ceil(x(locations)./sz(2));
zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
X = repmat(1:sz(2),[sz(1),1,sz(3)]);
Y = repmat((1:sz(1))',[1,sz(2),sz(3)]);
Z = repmat(zarray,[sz(1),sz(2),1]);
sz2 = size(dgridx);
xsum = 0;
ysum = 0;
zsum = 0;

dudx = (sz2(2)-3)/sz(2);
% 
        i = floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
        j = floor(((X-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        k = floor(((Z-0.5).*(sz2(3)-3)./sz(3))+2)-1;
        u = ((X-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X-0.5).*(sz2(2)-3)./sz(2))+2);
        v = ((Y-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2);
        w = ((Z-0.5).*(sz2(3)-3)./sz(3))+2 - floor(((Z-0.5).*(sz2(3)-3)./sz(3))+2);
        clear X Y Z
        for q = 0:3
            a = dbspline2(u,q);
            for l = 0:3    
                b = bspline2(v,l);
                for r = 0:3 
                  c =  bspline2(w,r);

                ind = sub2ind(sz2,i+l,j+q,k+r);
                xproduct = a.*b.*c.*dgridx(ind).*dudx;
                yproduct = a.*b.*c.*dgridy(ind).*dudx;
                zproduct = a.*b.*c.*dgridz(ind).*dudx;
                xsum = xsum + xproduct;
                ysum = ysum + yproduct;
                zsum = zsum + zproduct;
                end
            end 
        end





