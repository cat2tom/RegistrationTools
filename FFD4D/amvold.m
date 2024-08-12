%amvold.m applies a formula similar to the maximum volume displacement but
%as a check for volume expansion/compression of voxels. This should also
%help safegaurd against meshfolding

%-Daniel Markel

function [dgridx,dgridy,dgridz] = amvold(dgridx,dgridy,dgridz,ratiolimit)

volume = recalcvol(size(dgridx)-3,dgridx,dgridy,dgridz);

%determine expansion/compression ratios
volume2 = 1./volume;
volume3 = volume./1;

%taking only positive values from each compression and expansion are
%treated equally in equation
ind = find(volume2 >= 1);
volume(ind) = volume2(ind);
ind = find(volume3 >= 1);
volume(ind) = volume3(ind);

clear volume2 volume3 ind

amv = exp(-0.1*((volume./ratiolimit).^6));
amv2 = (amv(1:end-1,1:end-1,1:end-1)+ amv(2:end,1:end-1,1:end-1)+amv(1:end-1,2:end,1:end-1)+amv(1:end-1,1:end-1,2:end)+amv(1:end-1,2:end,2:end)+amv(2:end,1:end-1,2:end)+amv(2:end,2:end,1:end-1)+amv(2:end,2:end,2:end))/8;
clear amv
dgridx(3:end-2,3:end-2,3:end-2) = dgridx(3:end-2,3:end-2,3:end-2).*amv2;
dgridy(3:end-2,3:end-2,3:end-2) = dgridy(3:end-2,3:end-2,3:end-2).*amv2;
dgridz(3:end-2,3:end-2,3:end-2) = dgridz(3:end-2,3:end-2,3:end-2).*amv2;