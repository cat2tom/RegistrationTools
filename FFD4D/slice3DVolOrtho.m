function [slc, slcRowV, slcColV] = slice3DVolOrtho(data3M, xV, yV, zV, coord, dim, interpMtd)
%"slice3DVolOrtho"
%   Slice data3M in dimension dim at coordinate coord, without rotation.

switch dim
    case 1
        slice = interp1(xV, 1:length(xV), coord);
        %             slice = finterp1(xV, 1:length(xV), coord);
    case 2
        slice = interp1(yV, 1:length(yV), coord);
        %             slice = finterp1(yV, 1:length(yV), coord);
    case 3
        slice = interp1(zV, 1:length(zV), coord);
        %             slice = finterp1(zV, 1:length(zV), coord);
end

lowerSlcNum = floor(slice);
upperSlcNum = ceil(slice);
lowerSlcRatio = (upperSlcNum - slice);
upperSlcRatio = 1 - lowerSlcRatio;

switch dim
    case 1
        permuteM     = [3 2 1];
        lowerSlc = data3M(:,lowerSlcNum,:);
        upperSlc = data3M(:,upperSlcNum,:);
        slcColV = yV;
        slcRowV = zV;
    case 2
        permuteM     = [3 1 2];
        lowerSlc = data3M(lowerSlcNum,:,:);
        upperSlc = data3M(upperSlcNum,:,:);
        slcColV = xV;
        slcRowV = zV;
    case 3
        permuteM     = [1 2 3];
        lowerSlc = data3M(:,:,lowerSlcNum);
        upperSlc = data3M(:,:,upperSlcNum);
        slcColV = xV;
        slcRowV = yV;
end

if strcmpi(interpMtd, 'linear')
    slc = double(lowerSlc)*(lowerSlcRatio) + double(upperSlc)*(upperSlcRatio);
elseif strcmpi(interpMtd, 'nearest')
    if lowerSlcRatio < .5
        slc = lowerSlc;
    else
        slc = upperSlc;
    end
else
    error('Unknown interpolation method specified.')
end
slc = permute(slc, permuteM);
slc = squeeze(slc);
slc = double(slc);