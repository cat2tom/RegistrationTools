% imrecreate3D

% This function performs the deformation on 'base', the inputted volumetric
% data using the changes to the control grid in the x,y,z directions specified by
% dgridx,dgridy,dgridz. The deformation is performed using the cubic-B-spline
% interpolation technique outlined in Huang et al. 2006.
% image1 is the image after deformation
% imagedist is the distance transform of image1 

% Daniel Markel PMH 2007

% [1] Huang X., S. Zhang, Y. Wang, D. Metaxas, and D. Samaras, “A hierarchical 
%     framework for high resolution facial expression tracking.”, Proc. Third 
%     IEEE Workshop Articulated and Nonrigid Motion, in conjunction with CVPR ’04, July 2004.

function [image1,imagedist] = imrecreate3D3(base,dgridx,dgridy,dgridz)
sz = size(base);

if max(max(max(abs(dgridx)))) == 0 && max(max(max(abs(dgridy))))== 0 && max(max(max(abs(dgridz))))== 0 %if no deformations are being performed return input
image1 = base;
imagedist = bwdist(image1,'quasi-euclidean');
else
    
zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
X = repmat(1:sz(2),[sz(1),1,sz(3)]);
Y = repmat((1:sz(1))',[1,sz(2),sz(3)]);
Z = repmat(zarray,[sz(1),sz(2),1]);
X2 = X;
Y2 = Y;
Z2 = Z;
sz2 = size(dgridx);


        i = floor(((Y-0.5).*(sz2(1)-3)./sz(1)))+1;
        j = floor(((X-0.5).*(sz2(2)-3)./sz(2)))+1;
        k = floor(((Z-0.5).*(sz2(3)-3)./sz(3)))+1;        
        X = ((X-0.5).*(sz2(2)-3)./sz(2)) - floor(((X-0.5).*(sz2(2)-3)./sz(2)));
        Y = ((Y-0.5).*(sz2(1)-3)./sz(1)) - floor(((Y-0.5).*(sz2(1)-3)./sz(1)));
        Z = ((Z-0.5).*(sz2(3)-3)./sz(3)) - floor(((Z-0.5).*(sz2(3)-3)./sz(3)));
        for q = 0:3
            a = bspline2(X,q);
            for l = 0:3 
                b =a.*bspline2(Y,l);
                for r = 0:3 
                c = b.*bspline2(Z,r);
                ind = sub2ind(sz2,i+l,j+q,k+r);
                xproduct = c.*dgridx(ind);
                yproduct = c.*dgridy(ind);
                zproduct = c.*dgridz(ind);
                X2 = X2 + xproduct;
                Y2 = Y2 + yproduct;
                Z2 = Z2 + zproduct;
                end
            end 
        end
 clear a b c xproduct yproduct zproduct ind
X = repmat(1:sz(2),[sz(1),1,sz(3)]);
Y = repmat((1:sz(1))',[1,sz(2),sz(3)]);
Z = repmat(zarray,[sz(1),sz(2),1]);
image1 = interp3(X,Y,Z,base,X2,Y2,Z2,'linear');
% image1(image1>=0.32) = 1;
% image1(image1<0.32) = 0;
image1(isnan(image1)) = 0;

% imagedist = bwdist(image1,'quasi-euclidean');
imagedist = 0;
end
