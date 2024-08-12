%Imdeform3D
% This function calculates the optimized control grid parameters
% (dgridx,dgridy,dgridz) necessary to register image1 to image2. Image 1
% and 2 are assumed to be globally registered binary contours of matching
% resolution. dimage is the deformed contour image1 after optimization.
% The definitions of the remaining inputs are as follows
%                                                 Recommended  
% Alpha (smoothness weighting factor)                 1-5
% Beta (feature point weighting factor)               5-10
% Gamma (initial step size multiplying                0.2-2
%        factor)
% Iterations (number of times the                     1-3  
%             gradient is recalculated 
%             per level)
% Steps (number of steps evaluated per                3-10
%        gradient calculation to 
%        determine optimal step size)
%       
% fpoints(Mx3 array of coordinates of features points
%         in the source image)
% fpoints2(Mx3 array of the coordinates of the matching 
%          feature points in the target image. fpoints 
%          must be the same size as fpoints2, points 
%          are matched based on their corresponding 
%          order in the arrays, ie. the 8th coord in 
%          fpoints corresponds to the 8th coord in 
%          fpoints2) 
% res1 (the resolution of the first level            [22,22,22]
%       of the control grid mesh, remember  
%       that the actual resolution will  
%       be 2 units smallers in each 
%       dimension due to an assumed           
%       padding around the control grid)
% res2 (resolution of the second level, a finer      [42,42,42]
%       mesh used to match more detailed 
%       regions of the contour)

% Daniel Markel PMH 2007
function [dimage,dgridx,dgridy,dgridz] = imdeform3D(image1,image2,alpha,beta,gamma,iterations,steps,fpoints,fpoints2,res1,res2)

sze = size(image1);
sze2 = size(image2);
if sze(1) ~= sze2(1) || sze(2) ~= sze2(2) || sze(3) ~= sze2(3)
    error('Target and Source image sizes do not match');
end
sz = size(image1);
M = res1(1);
N = res1(2);
P = res1(3);
image2 = bwdist(image2,'quasi-euclidean');
dgridx = zeros(M,N,P);
dgridy = zeros(M,N,P);
dgridz = zeros(M,N,P);
errorinit = elocal3D(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
for j = 1:iterations
   
    [gradgridx,gradgridy,gradgridz] = calcgrad3D2(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
    gradgridx = gradgridx./max(max(max(abs(gradgridx))));
    gradgridy = gradgridy./max(max(max(abs(gradgridy))));
    gradgridz = gradgridz./max(max(max(abs(gradgridz))));
    gamma1 = gamma*(max(max(max(image2)))-0.5)*(((res1(1)+res1(1)+res1(1))/3)-3)/((sz(1)+sz(2)+sz(3))/3);
        k = 1;
        while k <= steps
        dgridx = dgridx - gamma1.*gradgridx;
        dgridy = dgridy - gamma1.*gradgridy;
        dgridz = dgridz - gamma1.*gradgridz;
            %perform corrections
              %voxel displacement and mesh folding check
            for t = 2:res1(3)-1 
                [dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1)] = amvd3D(sz,res1,[sz(1),sz(2),3],dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1));
            end 
              % maximum volume expansion/compression check
%             [dgridx,dgridy,dgridz] = amvold(dgridx,dgridy,dgridz,110);
            
        errorloc = elocal3D(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
        
        if sum(sum(sum(errorloc)))>= sum(sum(sum(errorinit)))
            k = k+1;
            dgridx = dgridx + gamma1.*gradgridx;
            dgridy = dgridy + gamma1.*gradgridy;
            dgridz = dgridz + gamma1.*gradgridz;
            gamma1= gamma1./1.5;
        else
            gamma1 = gamma1./1.5;
            errorinit = errorloc;
            k = k+1;
        end
        
        end
end
zarray1 = zeros(1,1,res1(3));
zarray2 = zeros(1,1,res2(3));
zarray1(:) = 1:res1(3);
zarray2(:) = 1:(res1(3)-1)/(res2(3)-1):res1(3);
dgridx = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridx,repmat(1:(res1(2)-1)/(res2(2)-1):res1(2),[res2(1),1,res2(3)]),repmat((1:(res1(1)-1)/(res2(1)-1):res1(1))',[1,res2(2),res2(3)]),repmat(zarray2,[res2(1),res2(2),1]),'linear');
dgridy = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridy,repmat(1:(res1(2)-1)/(res2(2)-1):res1(2),[res2(1),1,res2(3)]),repmat((1:(res1(1)-1)/(res2(1)-1):res1(1))',[1,res2(2),res2(3)]),repmat(zarray2,[res2(1),res2(2),1]),'linear');
dgridz = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridz,repmat(1:(res1(2)-1)/(res2(2)-1):res1(2),[res2(1),1,res2(3)]),repmat((1:(res1(1)-1)/(res2(1)-1):res1(1))',[1,res2(2),res2(3)]),repmat(zarray2,[res2(1),res2(2),1]),'linear');

errorinit = elocal3D(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
for j = 1:iterations
   

 
    [gradgridx,gradgridy,gradgridz] = calcgrad3D2(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
    gradgridx = gradgridx./max(max(max(abs(gradgridx))));
    gradgridy = gradgridy./max(max(max(abs(gradgridy))));
    gradgridz = gradgridz./max(max(max(abs(gradgridz))));
    gamma1 = gamma*(max(max(max(image2)))-0.5)*(((res2(1)+res2(2)+res2(3))/3)-3)/((sz(1)+sz(2)+sz(3))/3);

        k = 1;
        while k <= steps
        dgridx = dgridx - gamma1.*gradgridx;
        dgridy = dgridy - gamma1.*gradgridy;
        dgridz = dgridz - gamma1.*gradgridz;

        %yup corrections again
for t = 2:res2(3)-1
    [dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1)] = amvd3D(sz,res2,[sz(1),sz(2),3],dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1));
end 
%  [dgridx,dgridy,dgridz] = amvold(dgridx,dgridy,dgridz,110);
        errorloc = elocal3D(image1,image2,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2);
        

        if sum(sum(sum(errorloc)))>= sum(sum(sum(errorinit)))
            k = k+1;
            dgridx = dgridx + gamma1.*gradgridx;
            dgridy = dgridy + gamma1.*gradgridy;
            dgridz = dgridz + gamma1.*gradgridz;
            gamma1= gamma1./1.5;
        else
            gamma1 = gamma1./1.5;
            errorinit = errorloc;
            k = k+1;
        end
        
        end
end
[dimage,imagedist] = imrecreate3D(image1,dgridx,dgridy,dgridz);
