% amvd3D

% This function checks to see whether or not a set of control grid points
% are folded or will cause subsequent folding if interpolated to a finer
% mesh. However, the function only checks on layer of a 3D matrix at a time.
% the inputs dgridx,dgridy,dgridz are only 3 layers of the volumetric data
% checking the middle layer for folding, thus in order to check a complete
% 3D control grid, this function must be run for each layer of matrix
% except for the outer layers since they are missing a surrounding layer of
% points to check against. This isn't necessary however since checking the
% inside layers will ensure against mesh folding on the outside anyways. 
% Maximum Voxel Displacement corrections are also applied with a maximum 
% of 25 pixels, assuming a resolution of 1.568 mm per pixel, this results
% in an upper bound of 4cm based on the 3cm tumor movement observed in
% Barbeco et al. 2005, this seems reasonable.

% Daniel Markel PMH 2007

% [1] Berbeco R.I., S. Nishioka, H. Shirato, G.T. Chen, S.B. Jiang, “Residual 
%     motion of lung tumours in gated radiotherapy with external respiratory surrogates.”, 
%     Phys Med Biol. 2005 Aug 21;50(16):3655-67. 


function [dgridx,dgridy,dgridz] = amvd3D(sz3,sz4,sz,dgridx,dgridy,dgridz)


% sz2 = size(dgridx(:,:,2));

%ensuring bone structure is preserved
% base2 = base(:,:,2);
% base2(base(:,:,2)<1150) = 0;
% base2 = bwmorph(base2,'clean');
% base2 = bwmorph(base2,'close');
% base2 = imfill(base2,'holes');
% dgridx2 = dgridx(:,:,2);
% dgridy2 = dgridy(:,:,2);
% 
% bound = bwboundaries(base2);
% 
% %cycling through the different bones and ensuring their movement is uniform
% for t = 1:length(bound)
%     
%     xmax = max(bound{t}(:,2));
%     xmin = min(bound{t}(:,2));
%     ymax = max(bound{t}(:,1));
%     ymin = min(bound{t}(:,1));
%     
%     [y2,x2] = find(base2 == 1);
%     
%     y = y2;
%     x = x2;
%     y(y2 < ymin-1 | y2 > ymax+1 | x2 < xmin-1 | x2 > xmax+1) = [];
%     x(x2 < xmin-1 | x2 > xmax+1 | y2 < ymin-1 | y2 > ymax+1) = [];
%     clear y2 x2
%    y = ((y-0.5).*(sz2(1)-3)./sz(1))+2;
%    x = ((x-0.5).*(sz2(2)-3)./sz(2))+2; 
%    x = [ceil(x);floor(x);ceil(x);floor(x)];
%    y = [ceil(y);floor(y);floor(y);ceil(y)];
%    ind = sub2ind(sz2,y,x);
%    ind = unique(ind);
%    [y,x] = ind2sub(sz2,ind);
%    ind = sub2ind(sz2,y,x);
%    dgridx2(ind)= mean(dgridx2(ind));
%    dgridy2(ind)= mean(dgridy2(ind));
%    dgridx(:,:,2) = dgridx2;
%    dgridy(:,:,2) = dgridy2;
% end

sz2 = size(dgridx);  
% maximum volume displacement on a scale of up to 25 pixels max movement. 

mvd = exp(-0.1*(sqrt(dgridx(:,:,2).^2+dgridy(:,:,2).^2+dgridz(:,:,2).^2)./25).^6);
mvd(isnan(mvd)) = 0;
mvd = mvd./max(max(mvd));

dgridx(:,:,2) = dgridx(:,:,2).*mvd;
dgridy(:,:,2) = dgridy(:,:,2).*mvd;
dgridz(:,:,2) = dgridz(:,:,2).*mvd;
% clear dgridx2 dgridy2

%apply the inbox check to eliminate folding of the control grid
zarray = zeros(1,1,sz(3));
array = 1:sz(3);
zarray(1:sz(3) > 0) = array(1:sz(3) > 0);
gridx = repmat(1:sz2(2),[sz2(1),1,sz2(3)]);
gridy = repmat((1:sz2(1))',[1,sz2(2),sz2(3)]);
gridz = repmat(zarray,[sz2(1),sz2(2),1]);
gridx = (gridx-2).*sz(2)/(sz2(2)-3) + 0.5;%convert to embedded space units
gridy = (gridy-2).*sz(1)/(sz2(1)-3) + 0.5;
gridz = (gridz-2).*sz3(3)/(sz4(3)-3) + 0.5;
gridx2 = gridx-dgridx;
gridy2 = gridy-dgridy;
gridz2 = gridz-dgridz;
for n = 2:sz2(2)-1
    points = [gridx2(2:end-1,n,2),gridy2(2:end-1,n,2),gridz2(2:end-1,n,2)];
    bnd = [gridx2(2:end-1,n-1,2),gridy2(2:end-1,n-1,2),gridz2(2:end-1,n-1,2),gridx2(1:end-2,n,2),gridy2(1:end-2,n,2),gridz2(1:end-2,n,2),...
        gridx2(2:end-1,n+1,2),gridy2(2:end-1,n+1,2),gridz2(2:end-1,n+1,2),gridx2(3:end,n,2),gridy2(3:end,n,2),gridz2(3:end,n,2),...
        gridx2(2:end-1,n,1),gridy2(2:end-1,n,1),gridz2(2:end-1,n,1),gridx2(2:end-1,n,3),gridy2(2:end-1,n,3),gridz2(2:end-1,n,3)];
     warning off all
    [condition,intersection] = inbox(points,bnd);
    condition = logical([0 ; condition ; 0]); %#ok<AGROW>
    intersection = [0,0,0;intersection;0,0,0]; %#ok<AGROW>
    gridx2(condition,n,2) = intersection(condition,1);
    gridy2(condition,n,2) = intersection(condition,2);
    gridz2(condition,n,2) = intersection(condition,3);
end

dgridx = -(gridx2-gridx);
dgridy = -(gridy2-gridy);
dgridz = -(gridz2-gridz);
end


%function to determine if a point or list of points is within an octahedron with
%vertices defined by the m by 18 vector or list of vectors denoting the 3-D
%set of 6 coordinates of the vertices. 
%ie, one set = [x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4 ...etc.], 
%points is a m by 3 matrix listing the x, y and z coordinates of the points in question.
%condition is a logical array m units long with 1 (true) denoting that the
%coinciding point falls outside the given octahedron. and 0 (false) if it doesn't.
%intersection is an m by 3 matrix listing the new coordinates of the point
%if it does fall outside the boundaries.
%-Daniel Markel PMH 2007
function [condition,intersection] = inbox(points,bnd)
% 
centre = [(bnd(:,1)+ bnd(:,4)+ bnd(:,7)+ bnd(:,10)+ bnd(:,13) + bnd(:,16))./6,(bnd(:,2)+ bnd(:,5)+ bnd(:,8)+ bnd(:,11)+ bnd(:,14)+ bnd(:,17))./6,...
            (bnd(:,3)+ bnd(:,6)+ bnd(:,9)+ bnd(:,12)+ bnd(:,15) + bnd(:,18))./6];
        
sz3 = size(points);
%the 6 normal vectors of the planes surrounding the points in question
vectorsa =  [cross([bnd(:,4)-bnd(:,13),bnd(:,5)-bnd(:,14),bnd(:,6)-bnd(:,15)],[bnd(:,1)-bnd(:,13),bnd(:,2)-bnd(:,14),bnd(:,3)-bnd(:,15)]),...
            cross([bnd(:,1)-bnd(:,13),bnd(:,2)-bnd(:,14),bnd(:,3)-bnd(:,15)],[bnd(:,10)-bnd(:,13),bnd(:,11)-bnd(:,14),bnd(:,12)-bnd(:,15)]),...
            cross([bnd(:,10)-bnd(:,13),bnd(:,11)-bnd(:,14),bnd(:,12)-bnd(:,15)],[bnd(:,7)-bnd(:,13),bnd(:,8)-bnd(:,14),bnd(:,9)-bnd(:,15)]),...
            cross([bnd(:,7)-bnd(:,13),bnd(:,8)-bnd(:,14),bnd(:,9)-bnd(:,15)],[bnd(:,4)-bnd(:,13),bnd(:,5)-bnd(:,14),bnd(:,6)-bnd(:,15)]),...
            cross([bnd(:,4)-bnd(:,16),bnd(:,5)-bnd(:,17),bnd(:,6)-bnd(:,18)],[bnd(:,7)-bnd(:,16),bnd(:,8)-bnd(:,17),bnd(:,9)-bnd(:,18)]),...
            cross([bnd(:,1)-bnd(:,16),bnd(:,2)-bnd(:,17),bnd(:,3)-bnd(:,18)],[bnd(:,4)-bnd(:,16),bnd(:,5)-bnd(:,17),bnd(:,6)-bnd(:,18)]),...
            cross([bnd(:,10)-bnd(:,16),bnd(:,11)-bnd(:,17),bnd(:,12)-bnd(:,18)],[bnd(:,1)-bnd(:,16),bnd(:,2)-bnd(:,17),bnd(:,3)-bnd(:,18)]),...
            cross([bnd(:,7)-bnd(:,16),bnd(:,8)-bnd(:,17),bnd(:,9)-bnd(:,18)],[bnd(:,10)-bnd(:,16),bnd(:,11)-bnd(:,17),bnd(:,12)-bnd(:,18)])];
%The origin coordinates of the planes
vectorsc = [bnd(:,13),bnd(:,14),bnd(:,15),bnd(:,13),bnd(:,14),bnd(:,15),bnd(:,13),bnd(:,14),bnd(:,15),bnd(:,13),bnd(:,14),bnd(:,15),...
             bnd(:,16),bnd(:,17),bnd(:,18), bnd(:,16),bnd(:,17),bnd(:,18), bnd(:,16),bnd(:,17),bnd(:,18), bnd(:,16),bnd(:,17),bnd(:,18)];
%grid coordinate displacement vectors    
vectorsb = [points(:,1)-centre(:,1),points(:,2)-centre(:,2),points(:,3)-centre(:,3)];  
%angle between the displacement vector and the normal vectors of the surrounding planes 
angles = [asind(dot(vectorsa(:,1:3),vectorsb,2)./(sqrt(dot(vectorsa(:,1:3),vectorsa(:,1:3),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,4:6),vectorsb,2)./(sqrt(dot(vectorsa(:,4:6),vectorsa(:,4:6),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,7:9),vectorsb,2)./(sqrt(dot(vectorsa(:,7:9),vectorsa(:,7:9),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,10:12),vectorsb,2)./(sqrt(dot(vectorsa(:,10:12),vectorsa(:,10:12),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,13:15),vectorsb,2)./(sqrt(dot(vectorsa(:,13:15),vectorsa(:,13:15),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,16:18),vectorsb,2)./(sqrt(dot(vectorsa(:,16:18),vectorsa(:,16:18),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,19:21),vectorsb,2)./(sqrt(dot(vectorsa(:,19:21),vectorsa(:,19:21),2)).*sqrt(dot(vectorsb,vectorsb,2)))),...
          asind(dot(vectorsa(:,22:24),vectorsb,2)./(sqrt(dot(vectorsa(:,22:24),vectorsa(:,22:24),2)).*sqrt(dot(vectorsb,vectorsb,2))))];
%find which plane the displacement vector could intersect by taking the
%minimum of the angles between it and the plane normals
sz = size(vectorsa);
[y,v]= min(abs(angles),[],2);
ind = sub2ind(sz,(1:sz(1))',3*v-2);
ind2 = sub2ind(sz,(1:sz(1))',3*v-1);
ind3 = sub2ind(sz,(1:sz(1))',3*v);
vectorsa = [vectorsa(ind),vectorsa(ind2),vectorsa(ind3)];
vectorsc = [vectorsc(ind),vectorsc(ind2),vectorsc(ind3)];

  %At what magnitude does the vector intersect the given plane            
 t =(dot(vectorsc,vectorsa,2)-dot(centre,vectorsa,2))./dot(vectorsb,vectorsa,2);
 %is the magnitude of the displacement vector greater than this
 %intersection magnitude?
 condition = sqrt(sum((vectorsb.*repmat(t,[1,3])).^2,2)) <= sqrt(sum(vectorsb.^2,2));

%if so the control grid vertice has exceeded the octahedron boundary and is
%set to the center of the octahedron.
intersection = zeros(sz3(1),3);
intersection(condition,:) = centre(condition,:);

end



