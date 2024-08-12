function [DVH,max_vol] = calcDVH(doses3D,contour,rez)

sz = size(contour);
edgevol = sum(sum(sum(contour)))*0.5*rez(1)*rez(2)*rez(3); %this volume is subtracted from the final volume, it is an approximation of the excess
%volume introduced from using cubic voxels at the edge of the ROI as opposed to using more precise
%geometry using the contour edge coordinates. It allows volume calculations
%within 1.7% of the actual volume calculated on pinnacle. 
edgedose = doses3D.*contour;
edgevoxels = contour;
for n = 1:sz(3)
    slice = contour(:,:,n);
    slice = bwmorph(slice, 'bridge');
%     slice = bwmorph(slice, 'bothat');
contour(:,:,n) = imfill(double(slice));
% contour(:,:,n) = bwmorph(contour(:,:,n), 'tophat');

end
doses3D = doses3D.*contour;
limit = mean(mean(mean(doses3D(contour == 1 & ~isnan(doses3D)))));
len = round(max(max(max(doses3D)))/50)*50;
x = 0:50:len;
y = zeros(len/50,1);
max_vol = sum(sum(sum(contour)))*rez(1)*rez(2)*rez(3)-edgevol;
for n = 0:len/50
    if n == 0
        voxels = contour;  
    else
    voxels = doses3D > n*50;
    edgevoxels = edgedose > n*50;
    end
    y(n+1) = (sum(sum(sum(voxels)))-(sum(sum(sum(edgevoxels)))*0.5))*rez(1)*rez(2)*rez(3)/max_vol;
    
end
DVH = [x',y];

    
    