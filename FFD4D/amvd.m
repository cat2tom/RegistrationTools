%amvd function outlines bone structures and ensures that deformations are
%uniform in their vicinity thus preventing unrealistic deformations to bone structures yet allowing translational movement
%of the bones. Future work includes scaling the effect to take into account
% other dense structures that may be stubborn to deformation. 

function [dgridx,dgridy] = amvd(base,dgridx,dgridy)

sz = size(base);
sz2 = size(dgridx);

%bone
base(base<1150) = 0;
base = bwmorph(base,'clean');
base = bwmorph(base,'close');
base = imfill(base,'holes');

bound = bwboundaries(base);

%cycling through the different bones
for t = 1:length(bound)
    
    xmax = max(bound{t}(:,2));
    xmin = min(bound{t}(:,2));
    ymax = max(bound{t}(:,1));
    ymin = min(bound{t}(:,1));
    
    [y2,x2] = find(base == 1);
    
    y = y2;
    x = x2;
    y(y2 < ymin-1 | y2 > ymax+1 | x2 < xmin-1 | x2 > xmax+1) = [];
    x(x2 < xmin-1 | x2 > xmax+1 | y2 < ymin-1 | y2 > ymax+1) = [];
    clear y2 x2
   x = ((y-0.5).*(sz2(1)-3)./sz(1))+2;
   y = ((x-0.5).*(sz2(2)-3)./sz(2))+2; 
   x = [ceil(x);floor(x);ceil(x);floor(x)];
   y = [ceil(y);floor(y);floor(y);ceil(y)];
   ind = sub2ind(sz2,y,x);
   ind = unique(ind);
   [y,x] = ind2sub(sz2,ind);
   ind = sub2ind(sz2,y,x);
   dgridx(ind)= mean(dgridx(ind));
   dgridy(ind)= mean(dgridy(ind));
end
   
%maximum volume displacement on a scale of up to 50 pixels max movement. 
% X = repmat(1:sz(2),[sz(1),1]);
% Y = repmat((1:sz(1))',[1,sz(2)]);
% Xi = ((repmat(1:sz2(2),[sz2(1),1])-2).*sz(2)./(sz2(2)-3)) + 0.5;
% Yi = ((repmat((1:sz2(1))',[1,sz2(2)])-2).*sz(1)./(sz2(1)-3)) + 0.5; 

%continue here, convert dgrid XY to base units, then match base pixels to
%dgrid pixels so that any dgrid pixels that bone pixels in base touch
%become uniform.
% base = (interp2(X,Y,base./(max(max(base))),Xi,Yi,'nearest'));
% mvd = exp(-0.1*(interp2(X,Y,base./(max(max(base))),Xi,Yi,'linear')).^2);
% mvd(isnan(mvd)) = 0;
% mvd = mvd./max(max(mvd));
% % almvd = exp(-0.1*(sqrt(dgridx.^2+dgridy.^2)./mvd).^6);
% % kernal = zeros(sz2);
% % % kernal(round(sz2(1)/4):round(sz2(1)*3/4),round(sz2(2)/4):round(sz2(2)*3/4))=1/((round(sz2(1)*3/4)-round(sz2(1)/4))*(round(sz2(2)*3/4)-round(sz2(2)/4)));
% % kernal(round(sz2(1)*4/10):round(sz2(1)*6/10),round(sz2(2)*4/10):round(sz2(2)*6/10))=1;
% % kernal = fft(kernal);
% % dgridx2 = fft(dgridx);
% % dgridy2 = fft(dgridy);
% % dgridy2 = dgridy2./kernal;
% % dgridx2 = dgridx2./kernal;
% % dgridx2 = ifft(dgridx2);
% % dgridy2 = ifft(dgridy2);
% % dgridx2 = [dgridx2(round(sz2(1)/2)+1:end,:) ;dgridx2(1:round(sz2(1)/2),:)];
% % dgridy2 = [dgridy2(round(sz2(1)/2)+1:end,:) ;dgridy2(1:round(sz2(1)/2),:)];
% se = strel('ball',10,10);
% dgridx2 = imerode(dgridx,se);
% dgridy2 = imerode(dgridy,se);
% dgridx = dgridx.*(1-mvd) + dgridx2.*mvd;
% dgridy = dgridy.*(1-mvd) + dgridy2.*mvd;

%apply the inbox check

gridx = repmat(1:sz2(2),[sz2(1),1]);
gridy = repmat((1:sz2(1))',[1,sz2(2)]);
gridx = (gridx-2).*sz(2)/(sz2(2)-3) + 0.5;
gridy = (gridy-2).*sz(1)/(sz2(1)-3) + 0.5;
gridx2 = gridx - dgridx;
gridy2 = gridy - dgridy;
for n = 2:sz2(1)-1
    points = [gridx2(2:end-1,n),gridy2(2:end-1,n)];
    bnd = [gridx2(2:end-1,n-1),gridy2(2:end-1,n-1),gridx2(1:end-2,n),gridy2(1:end-2,n),gridx2(2:end-1,n+1),gridy2(2:end-2,n+1),gridx2(3:end,n),gridy2(3:end,n)];
    [condition,intersection] = inbox(points,bnd);
    condition = [0 ; condition ; 0]; %#ok<AGROW>
    intersection = [0,0;intersection;0,0]; %#ok<AGROW>
    gridx2(condition,n) = intersection(condition,1);
    gridy2(condition,n) = intersection(condition,2);
end

dgridx = -(gridx2-gridx);
dgridy = -(gridy2-gridy);
end


%function to determine if a point or list of points is within a box with
%vertices defined by the m by 8 vector or list of vectors denoting the 2-D
%set of 4 coordinates of the vertices. 
%ie, one set = [x1,y1,x2,y2,x3,y3,x4,y4], points is a m by 2 matrix listing
%the points in questions.
%condition is a logical array m units long with 1 (true) denoting that the
%coinciding point falls outside the given box. and 0 (false) if it doesn't.
%intersection is an m by 2 matrix listing the intersection coordinates of
%the points with their boundary box if there is one, no intersection
%coordinates are given in the point falls within the box. Ie, condition is
%zero
%-Daniel Markel PMH 2007
function [condition,intersection] = inbox(points,bnd)

centre = [(bnd(:,1)+ bnd(:,3)+ bnd(:,5)+ bnd(:,7))./4,(bnd(:,2)+ bnd(:,4)+ bnd(:,6)+ bnd(:,8))./4];
coeffa = [((bnd(:,3)-bnd(:,1)).*(points(:,1)-centre(:,1)))./((bnd(:,4)-bnd(:,2)).*(points(:,1)-centre(:,1))-(bnd(:,3)-bnd(:,1)).*(points(:,2)-centre(:,2))),...
          ((bnd(:,5)-bnd(:,3)).*(points(:,1)-centre(:,1)))./((bnd(:,6)-bnd(:,4)).*(points(:,1)-centre(:,1))-(bnd(:,5)-bnd(:,3)).*(points(:,2)-centre(:,2))),...
          ((bnd(:,7)-bnd(:,5)).*(points(:,1)-centre(:,1)))./((bnd(:,8)-bnd(:,6)).*(points(:,1)-centre(:,1))-(bnd(:,7)-bnd(:,5)).*(points(:,2)-centre(:,2))),...
          ((bnd(:,1)-bnd(:,7)).*(points(:,1)-centre(:,1)))./((bnd(:,2)-bnd(:,8)).*(points(:,1)-centre(:,1))-(bnd(:,1)-bnd(:,7)).*(points(:,2)-centre(:,2)))];
    

coeffb = [((bnd(:,3)-bnd(:,1)).*(points(:,2)-centre(:,2))*centre(:,1)-(bnd(:,4)-bnd(:,2)).*(points(:,1)-centre(:,1)).*bnd(:,1))./((bnd(:,3)-bnd(:,1)).*(points(:,1)-centre(:,1))),...
          ((bnd(:,5)-bnd(:,3)).*(points(:,2)-centre(:,2))*centre(:,1)-(bnd(:,6)-bnd(:,4)).*(points(:,1)-centre(:,1)).*bnd(:,3))./((bnd(:,5)-bnd(:,3)).*(points(:,1)-centre(:,1))),...
          ((bnd(:,7)-bnd(:,5)).*(points(:,2)-centre(:,2))*centre(:,1)-(bnd(:,8)-bnd(:,6)).*(points(:,1)-centre(:,1)).*bnd(:,5))./((bnd(:,7)-bnd(:,5)).*(points(:,1)-centre(:,1))),...
          ((bnd(:,1)-bnd(:,7)).*(points(:,2)-centre(:,2))*centre(:,1)-(bnd(:,2)-bnd(:,8)).*(points(:,1)-centre(:,1)).*bnd(:,7))./((bnd(:,1)-bnd(:,7)).*(points(:,1)-centre(:,1)))];

coeffc = [centre(:,2)-bnd(:,2), centre(:,2)-bnd(:,4),centre(:,2)-bnd(:,6),centre(:,2)-bnd(:,8)];     
      
xsol = (coeffc-coeffb).*coeffa;

%reject boundary lines that are parallel to the center control grid
%deformation vector
% xsol(isinf(xsol))= NaN;
%reject solutions that occur outside the boundary

xsol(xsol(:,1)<bnd(:,1) | xsol(:,1)>=bnd(:,3),1) = inf;
xsol(xsol(:,2)<bnd(:,3) | xsol(:,2)>=bnd(:,5),2) = inf;
xsol(xsol(:,3)>bnd(:,5) | xsol(:,3)<=bnd(:,7),3) = inf;
xsol(xsol(:,4)>bnd(:,7) | xsol(:,4)<=bnd(:,1),4) = inf;

ysol = [((points(:,2)-centre(:,2))./(points(:,1)-centre(:,1))).*(xsol(:,1)-centre(:,1))+centre(:,2),...
        ((points(:,2)-centre(:,2))./(points(:,1)-centre(:,1))).*(xsol(:,2)-centre(:,1))+centre(:,2),...
        ((points(:,2)-centre(:,2))./(points(:,1)-centre(:,1))).*(xsol(:,3)-centre(:,1))+centre(:,2),...
        ((points(:,2)-centre(:,2))./(points(:,1)-centre(:,1))).*(xsol(:,4)-centre(:,1))+centre(:,2)];
    %ensuring only solutions in the direction of the point displacement are
    %accepted. Ie. determining which wall of the boundary box they
    %intersect.
xsol(isinf(xsol)) = 0;
xsol((xsol(:,1)-centre(:,1)).*(points(:,1)-centre(:,1)) <= 0 ,1) = 0;
xsol((xsol(:,2)-centre(:,1)).*(points(:,1)-centre(:,1)) <= 0 ,2) = 0; 
xsol((xsol(:,3)-centre(:,1)).*(points(:,1)-centre(:,1)) <= 0 ,3) = 0; 
xsol((xsol(:,4)-centre(:,1)).*(points(:,1)-centre(:,1)) <= 0 ,4) = 0; 
ysol(isinf(ysol)) = 0;
ysol((ysol(:,1)-centre(:,2)).*(points(:,2)-centre(:,2)) <= 0 ,1) = 0;  
ysol((ysol(:,2)-centre(:,2)).*(points(:,2)-centre(:,2)) <= 0 ,2) = 0; 
ysol((ysol(:,3)-centre(:,2)).*(points(:,2)-centre(:,2)) <= 0 ,3) = 0; 
ysol((ysol(:,4)-centre(:,2)).*(points(:,2)-centre(:,2)) <= 0 ,4) = 0; 
xsol = max(xsol,[],2);
ysol = max(ysol,[],2);

%which points actually fall outside this intersection
condition = (sqrt(xsol.^2+ysol.^2)>sqrt(points(:,1).^2+points(:,2).^2));

sz = size(points);
intersection = zeros(sz(1),2);
intersection(condition,:) = [xsol(condition),ysol(condition)];
end



