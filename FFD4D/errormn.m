function error = errormn(base,mask,dgridx,dgridy,m,n);

        mstart = ((m-3)*sz2(2)/(sz(1)-3))+0.5;
        mend = ((m-1)*sz2(2)/(sz(1)-3))+0.5;
        nstart = ((n-3)*sz2(2)/(sz(2)-3))+0.5;
        nend = ((n-1)*sz2(2)/(sz(2)-3))+0.5;
        
        xind = find( 1:sz2(2) >= nstart && 1:sz2(2) <= nend);
        yind= find( 1:sz2(1) >= mstart && 1:sz2(1) <= mend);
        distsource = imrecreate(base,dgridx,dgridy);
%         distsource = bwdist(image);
        distmask = bwdist(mask);
        [LXx,LYx] = dLdx(base,dgridx,dgridy);
        [LXy,LYy] = dLdy(base,dgridx,dgridy);
        error = sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end))-distsource(yind(1):yind(end),xind(1):xind(end))).^2))...
            +alpha*sum(sum(LXx(yind(1):yind(end),xind(1):xind(end)).^2+...
            (LXy(yind(1):yind(end),xind(1):xind(end)).^2)));