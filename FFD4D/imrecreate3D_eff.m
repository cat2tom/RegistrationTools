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

function [image1] = imrecreate3D(image1,dgridx,dgridy,dgridz)
sz = size(image1);

if max(max(max(abs(dgridx)))) == 0 && max(max(max(abs(dgridy))))== 0 && max(max(max(abs(dgridz))))== 0 %if no deformations are being performed return input

% imagedist = bwdist(image1,'quasi-euclidean');
else
    
zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
u = repmat(1:sz(2),[sz(1),1,sz(3)]);
v = repmat((1:sz(1))',[1,sz(2),sz(3)]);
w = repmat(zarray,[sz(1),sz(2),1]);
X2 = u;
Y2 = v;
Z2 = w;
sz2 = size(dgridx);


        i = floor(((u-0.5).*(sz2(1)-3)./sz(1)))+1;
        j = floor(((v-0.5).*(sz2(2)-3)./sz(2)))+1;
        k = floor(((w-0.5).*(sz2(3)-3)./sz(3)))+1;
        save('temp_rec.m','i','j','k','image1','dgridx','dgridy','dgridz');
        clear i j k image1 dgridx dgridy dgridz
        u = ((u-0.5).*(sz2(2)-3)./sz(2)) - floor(((u-0.5).*(sz2(2)-3)./sz(2)));
%         clear X;
        v = ((v-0.5).*(sz2(1)-3)./sz(1)) - floor(((v-0.5).*(sz2(1)-3)./sz(1)));
%         clear Y;
        w = ((w-0.5).*(sz2(3)-3)./sz(3)) - floor(((w-0.5).*(sz2(3)-3)./sz(3)));
        save('temp_rec.m','u','v','w','-append');
%         clear Z;
        for q = 0:3
            load('temp_rec.m','u','-mat');
            a = bspline2(u,q);
            clear u
            for l = 0:3 
                load('temp_rec.m','v','-mat');
                b =a.*bspline2(v,l);
                clear v
                for r = 0:3 
                load('temp_rec.m','w','i','j','k','dgridx','dgridy','dgridz','-mat');
                c = b.*bspline2(w,r);
                clear w
                ind = sub2ind(sz2,i+l,j+q,k+r);
                clear i j k
%                 xproduct = c.*dgridx(ind);
%                 yproduct = c.*dgridy(ind);
%                 zproduct = c.*dgridz(ind);
%                load('temp_rec.m','w','i','j','k','-mat');
                X2 = X2 + c.*dgridx(ind);
                Y2 = Y2 + c.*dgridy(ind);
                Z2 = Z2 + c.*dgridz(ind);
%                 clear dgridx dgridy dgridz 
%                 save('temp_rec.m','X2','v','w','-append');
                end
                save('temp_rec.m','X2','Y2','Z2','-append');
            end 
        end
        clear ind c b a i j k
X = repmat(1:sz(2),[sz(1),1,sz(3)]);
Y = repmat((1:sz(1))',[1,sz(2),sz(3)]);
Z = repmat(zarray,[sz(1),sz(2),1]);
image1 = interp3(X,Y,Z,image1,X2,Y2,Z2,'linear');
% image1(image1>=0.32) = 1;
% image1(image1<0.32) = 0;
image1(isnan(image1)) = 0;

% imagedist = bwdist(image1,'quasi-euclidean');
end
