function error = elocal(base,mask,dgridx,dgridy,alpha)


%distance transforms of images.
distmask = bwdist(mask);
sz = size(dgridy);
sz2 = size(base);
error = zeros(sz(1),sz(2));
% alpha = 1;

        [image,distsource] = imrecreate(base,dgridx,dgridy);

%         distsource = bwdist(image);
        [LXx,LYx] = dLdx(base,dgridx,dgridy);
        [LXy,LYy] = dLdy(base,dgridx,dgridy);
        mstart = (((sz(1)/2)-6)*sz2(1)/(sz(1)-3))+0.5;
        mend = (((sz(1)/2)+3)*sz2(1)/(sz(1)-3))+0.5;
        nstart = (((sz(2)/2)-6)*sz2(2)/(sz(2)-3))+0.5;
        nend = (((sz(2)/2)+3)*sz2(2)/(sz(2)-3))+0.5;
        nspace = round(nend - nstart);
        mspace = round(mend - mstart);
for m = 2:sz(1)-1
    for n = 2:sz(2)-1
        mstart = ((m-6)*sz2(1)/(sz(1)-3))+0.5;
        mend = mstart + mspace;

        nstart = ((n-6)*sz2(2)/(sz(2)-3))+0.5;
        nend = nstart + nspace;

        
        xind = find( 1:sz2(2) > nstart &  1:sz2(2) < nend);
        yind= find( 1:sz2(1) > mstart & 1:sz2(1) < mend);
if isempty(xind)||isempty(yind)
    continue
else
    try
        error(m,n) = sum(sum( ((distmask(yind(1):yind(end),xind(1):xind(end))-distsource(yind(1):yind(end),xind(1):xind(end)))).^2))...
            +alpha*sum(sum(LXx(yind(1):yind(end),xind(1):xind(end)).^2 + LYx(yind(1):yind(end),xind(1):xind(end)).^2+...
            LXy(yind(1):yind(end),xind(1):xind(end)).^2+LYy(yind(1):yind(end),xind(1):xind(end)).^2));
    catch
        d = 1;
end
        
    end
end
end