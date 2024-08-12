%calculate the derivative of the change in the tensor product for a free
%form deformation by the change in y.
function [xsum,ysum] = dLdy(base,dgridx,dgridy)

sz = size(base);
[y,x] = find(base >= 0);
locations = find(base >= 0);
X = zeros(sz(1),sz(2));
Y = zeros(sz(1),sz(2));
X(locations) = x(locations);
Y(locations) = y(locations);
sz2 = size(dgridx);
% LX = zeros(sz(1),sz(2));
% LY = zeros(sz(1),sz(2));
dvdy = (sz2(1)-3)/sz(1);
xsum = 0;
ysum = 0;
        i = floor(((y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
        j = floor(((x-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        for k = 0:3
            for l = 0:3            
%             u = X*sz2(2)./sz(2) - floor(X.*sz2(2)./sz(2));
%             v = Y*sz2(1)./sz(1) - floor(Y.*sz2(1)./sz(1));
              u = ((X-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X-0.5).*(sz2(2)-3)./sz(2))+2);
              v = ((Y-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2);

            ind = sub2ind(sz2,i+l,j+k);
            xproduct = bspline2(u,k).*dbspline2(v,l).*reshape(dgridx(ind),sz(1),sz(2)).*dvdy;
            yproduct = bspline2(u,k).*dbspline2(v,l).*reshape(dgridy(ind),sz(1),sz(2)).*dvdy;
            xsum = xsum + xproduct;
            ysum = ysum + yproduct;
            end
        end        
%         LX(locations) = xsum;
%         LY(locations) = ysum;

