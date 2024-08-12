%recreate an image based on it's deformation control point grid
function [image1,imagedist] = imrecreate3D2(base,dgridx,dgridy,dgridz)
sz = size(base);
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
sz2 = size(dgridx);
% xsum = 0;
% ysum = 0;
% zsum = 0;
% 
%         i = floor(((y-0.5).*(sz2(1)-3)./sz(1))+2)-1;
%         j = floor(((x-0.5).*(sz2(2)-3)./sz(2))+2)-1;
%         k = floor(((z-0.5).*(sz2(3)-3)./sz(3))+2)-1;
%         u = ((X-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((X-0.5).*(sz2(2)-3)./sz(2))+2);
%         v = ((Y-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((Y-0.5).*(sz2(1)-3)./sz(1))+2);
%         w = ((Z-0.5).*(sz2(3)-3)./sz(3))+2 - floor(((Z-0.5).*(sz2(3)-3)./sz(3))+2);
%         for q = 0:3
%             for l = 0:3      
%                 for r = 0:3 
%                 ind = sub2ind(sz2,i+l,j+q,k+r);
%                 xproduct = bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*reshape(dgridx(ind),sz(1),sz(2),sz(3));
%                 yproduct = bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*reshape(dgridy(ind),sz(1),sz(2),sz(3));
%                 zproduct = bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*reshape(dgridz(ind),sz(1),sz(2),sz(3));
%                 xsum = xsum + xproduct;
%                 ysum = ysum + yproduct;
%                 zsum = zsum + zproduct;
%                 end
%             end 
%         end
% X = X + xsum;
% Y = Y + ysum;
% Z = Z + zsum;

% zarray = zeros(1,1,sz(3));
% zarray(:) = 1:sz(3);
gridx = repmat(1:sz2(2),[sz2(1),1,sz2(3)]);
gridy = repmat((1:sz2(1))',[1,sz2(2),sz2(3)]);
% gridz = repmat(zarray,[sz2(1),sz2(2),1]);
gridx = (gridx-2).*sz(2)/(sz2(2)-3) + 0.5;
gridy = (gridy-2).*sz(1)/(sz2(1)-3) + 0.5;
% gridz = (gridz-2).*sz(3)/(sz2(3)-3) + 0.5;
zarray1 = zeros(1,1,sz2(3));
zarray2 = zeros(1,1,sz(3)+2);
zarray1(:) = 1:sz2(3);
zarray2(:) = 1:(sz2(3)-1)/(sz(3)+1):sz2(3) ;
gridx = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),gridx,repmat(1:sz2(2),[sz2(1),1,sz(3)+2]),repmat((1:sz2(1))',[1,sz2(2),sz(3)+2]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');
gridy = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),gridy,repmat(1:sz2(2),[sz2(1),1,sz(3)+2]),repmat((1:sz2(1))',[1,sz2(2),sz(3)+2]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');
% gridz = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),gridz,repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');
dgridx2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),dgridx,repmat(1:sz2(2),[sz2(1),1,sz(3)+2]),repmat((1:sz2(1))',[1,sz2(2),sz(3)+2]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');
dgridy2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),dgridy,repmat(1:sz2(2),[sz2(1),1,sz(3)+2]),repmat((1:sz2(1))',[1,sz2(2),sz(3)+2]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');
% dgridz2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),dgridz,repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz(3)]),repmat(zarray2,[sz2(1),sz2(2),1]),'cubic');

image1 = zeros(sz);

if max(max(max(abs(dgridx)))) == 0 && max(max(max(abs(dgridy))))== 0 && max(max(max(abs(dgridz))))== 0
image1 = base;
else
%     image1 = interp3(gridx,gridy,gridz,base,X,Y,Z,'spline');
% gridx2 = gridx - dgridx;
% gridy2 = gridy - dgridy;
% gridz2 = gridz - dgridz;

% ind = [ind;ind2];
%scan Z
ind = find(~isnan(padarray(dgridx2(2:end-1,2:end-1,1),[1,1],NaN)));
for m = 1:sz(3)
gridx2 = gridx(:,:,m+1) - dgridx2(:,:,m+1);
gridy2 = gridy(:,:,m+1) - dgridy2(:,:,m+1);
% ind = find(gridx);
% try
X = gridx(:,:,m+1);
Y = gridy(:,:,m+1);

TFORM= cp2tform([gridx2(ind),gridy2(ind)],[X(ind),Y(ind)],'Piecewise Linear');
temp = imtransform(base(:,:,m),TFORM);
image1(:,:,m) = temp(1:sz(1),1:sz(2));
disp(num2str(m));
end
image1 = round(image1);

zarray = zeros(1,1,sz2(3));
zarray(:) = 1:sz2(3);
% gridx = repmat(1:sz2(2),[sz2(1),1,sz2(3)]);
gridy = repmat((1:sz2(1))',[1,sz2(2),sz2(3)]);
gridz = repmat(zarray,[sz2(1),sz2(2),1]);
% gridx = (gridx-2).*sz(2)/(sz2(2)-3) + 0.5;
gridy = (gridy-2).*sz(1)/(sz2(1)-3) + 0.5;
gridz = (gridz-2).*sz(3)/(sz2(3)-3) + 0.5;
% zarray1 = zeros(1,1,sz2(3));
% % zarray2 = zeros(1,1,sz(3));
% zarray1(:) = 1:sz2(3);
% zarray2(:) = 1:(sz2(3)-1)/(sz(3)-1):sz2(3);
% gridx = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),gridx,repmat(1:(sz2(2)-1)/(sz(2)-1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2),sz2(3)]),repmat(zarray1,[sz2(1),sz(2),1]),'cubic');
gridy = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray,[sz2(1),sz2(2),1]),gridy,repmat(1:(sz2(2)-1)/(sz(2)+1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2)+2,sz2(3)]),repmat(zarray,[sz2(1),sz(2)+2,1]),'cubic');
gridz = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray,[sz2(1),sz2(2),1]),gridz,repmat(1:(sz2(2)-1)/(sz(2)+1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2)+2,sz2(3)]),repmat(zarray,[sz2(1),sz(2)+2,1]),'cubic');
% dgridx2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),dgridx,repmat(1:(sz2(2)-1)/(sz(2)-1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2),sz2(3)]),repmat(zarray1,[sz2(1),sz(2),1]),'cubic');
% dgridy2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray1,[sz2(1),sz2(2),1]),dgridy,repmat(1:(sz2(2)-1)/(sz(2)-1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2),sz2(3)]),repmat(zarray1,[sz2(1),sz(2),1]),'cubic');
dgridz2 = interp3(repmat(1:sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz2(2),sz2(3)]),repmat(zarray,[sz2(1),sz2(2),1]),dgridz,repmat(1:(sz2(2)-1)/(sz(2)+1):sz2(2),[sz2(1),1,sz2(3)]),repmat((1:sz2(1))',[1,sz(2)+2,sz2(3)]),repmat(zarray,[sz2(1),sz(2)+2,1]),'cubic');
for m = 1:sz(2)
% ind = find(abs(reshape(dgridz2(:,m+1,:),[sz2(1),sz2(3)]))>=0);
ind = find(~isnan(reshape(padarray(dgridz2(2:end-1,m+1,2:end-1),[1,0,1],NaN),[sz2(1),sz2(3)])));

gridz2 = reshape(gridz(:,m+1,:) - dgridz2(:,m+1,:),[sz2(1),sz2(3)]);
% ind = find(gridx);
% try
Y = reshape(gridy(:,m+1,:),[sz2(1),sz2(3)]);
Z = reshape(gridz(:,m+1,:),[sz2(1),sz2(3)]);
TFORM= cp2tform([Y(ind),gridz2(ind)],[Y(ind),Z(ind)],'Piecewise Linear');
temp = imtransform(reshape(image1(:,m,:),[sz(1),sz(3)]),TFORM);
image1(:,m,:) = reshape(temp(1:sz(1),1:sz(3)),[sz(1),1,sz(3)]);
disp(num2str(m));
end
end

% ind = find(gridx >= 0 | gridx <= 0);
% X = [gridy(ind),gridx(ind),gridz(ind)];
% U = [gridy2(ind),gridx2(ind),gridz2(ind)];
% T = maketform('custom',3,3,X,U);
% R = makeresampler('cubic','fill');
% try
% image1 = tformarray(base,T,R,[1 2 3],[1 2 3],sz,[],0);
% catch
%     % if folds exist in control grid (ie. dissapearing voxels) use smooth
%     % function to blur the delta control grid (through a convolution using a gaussian kernel) in hopes smoothing the
%     % deformation, similar results can be attained by increasing the alpha
%     % variable in gradgrid3D.m. 
%     dgridx = smooth3(dgridx,'gaussian',[3,3,3],0.35);
%     dgridy = smooth3(dgridy,'gaussian',[3,3,3],0.35);
%     dgridz = smooth3(dgridz,'gaussian',[3,3,3],0.35);
%     gridx2 = gridx - dgridx;
%     gridy2 = gridy - dgridy;
%     gridz2 = gridz - dgridz;
%     ind = find(gridx);
%     X = [gridy(ind),gridx(ind),gridz(ind)];
%     U = [gridy2(ind),gridx2(ind),gridz2(ind)];
%     T = maketform('custom',3,3,X,U);
%     R = makeresampler('cubic','fill');
%     try
%     image1 = tformarray(base,T,R,[1 2 3],[1 2 3],sz,[],0);
%     catch
%         % if folds still exist,try ironing out folds in control grid..3 times just in case. Iron
%         %grid becomes more successful the more times it is run. However,
%         %using it runs the risk of creating minor deformations in the shape
%         %of the intended final control grid. 
%    [gridx2,gridy2,gridz2] = irongrid3D(gridx2,gridy2,gridz2);
%    [gridx2,gridy2,gridz2] = irongrid3D(gridx2,gridy2,gridz2);
%    [gridx2,gridy2,gridz2] = irongrid3D(gridx2,gridy2,gridz2);
%     ind = find(gridx);
%     X = [gridy(ind),gridx(ind),gridz(ind)];
%     U = [gridy2(ind),gridx2(ind),gridz2(ind)];
%     T = maketform('custom',3,3,X,U);
%     R = makeresampler('cubic','fill');
%        image1 = tformarray(base,T,R,[1 2 3],[1 2 3],sz,[],0);
%     end
% end
% end
% % ind = [ind;ind2];
% ind = find(abs(dgridx)>=0);
% gridx2 = gridx - dgridx;
% gridy2 = gridy - dgridy;
% gridz2 = gridz - dgridz;
% % ind = find(gridx);
% try
% TFORM= cp2tform([gridx2(ind),gridy2(ind)],[gridx(ind),gridy(ind)],'Piecewise Linear');
% image1 = imtransform(base,TFORM);
% catch
%     %if voxels are dissapearing, iron out wrinkles in control grid
%    [gridx2,gridy2] = irongrid(gridx2,gridy2);
%    [gridx2,gridy2] = irongrid(gridx2,gridy2);
%    [gridx2,gridy2] = irongrid(gridx2,gridy2);
%    try
%    TFORM= cp2tform([gridx2(ind),gridy2(ind)],[gridx(ind),gridy(ind)],'Piecewise Linear');
%    image1 = imtransform(base,TFORM);
% 
%    catch
%        image1 = ones(sz);
%    end
% end
% 
% end

%    if size(image1)~= size(base)
%        sz3 = size(image1);
%        X = repmat([1:sz3(2)],[sz3(1),1]);
%        Y = repmat([1:sz3(1)]',[1,sz3(2)]);
%        X = (X-1).*(sz(2)-1)/(sz3(2)-1)+1;
%        Y = (Y-1).*(sz(1)-1)/(sz3(1)-1)+1;
%        image1 = interp2(X,Y,image1,repmat([1:sz(2)],[sz(1),1]),repmat([1:sz(1)]',[1,sz(2)]));
%        round(image1);
%    end


clear array base dgridx dgridy dgridz gridz gridy gridz sz sz2 zarray dgridx2 dgridz2 dgridy2 gridx2 gridy2 gridz2 X Y Z temp zarray1 zarray 2 zarray


imagedist = bwdist(image1,'quasi-euclidean');
% image = disttrans(coords,sz);

