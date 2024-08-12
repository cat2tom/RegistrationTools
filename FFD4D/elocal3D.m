%elocal3D

%This functions calculates the error for every control grid points based on
%error function outlined in Huang et al. 2006. 

%Daniel Markel PMH 2007

% [1] Huang X., S. Zhang, Y. Wang, D. Metaxas, and D. Samaras, “A hierarchical 
%     framework for high resolution facial expression tracking.”, Proc. Third 
%     IEEE Workshop Articulated and Nonrigid Motion, in conjunction with
%     CVPR ’04, July 2004.


function error = elocal3D(base,distmask,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2)

sz = size(dgridx);
sz2 = size(base);
error = zeros(sz(1),sz(2),sz(3));

        [image1,distsource] = imrecreate3D(base,dgridx,dgridy,dgridz);
        clear image1 base

        [LXx,LYx,LZx] = dLdx3D(sz2,dgridx,dgridy,dgridz);
        [LXy,LYy,LZy] = dLdy3D(sz2,dgridx,dgridy,dgridz);
        [LXz,LYz,LZz] = dLdz3D(sz2,dgridx,dgridy,dgridz);
        mstart = (((sz(1)/2)-4)*sz2(1)/(sz(1)-3))+0.5;
        mend = (((sz(1)/2))*sz2(1)/(sz(1)-3))+0.5;
        nstart = (((sz(2)/2)-4)*sz2(2)/(sz(2)-3))+0.5;
        nend = (((sz(2)/2))*sz2(2)/(sz(2)-3))+0.5;
        pstart = (((sz(3)/2)-4)*sz2(3)/(sz(3)-3))+0.5;
        pend = (((sz(3)/2))*sz2(3)/(sz(3)-3))+0.5;
        nspace = round(nend - nstart);
        mspace = round(mend - mstart);
        pspace = round(pend - pstart);
        efeat = ferror3D(fpoints,fpoints2,dgridx,dgridy,dgridz,sz,sz2);

for m = 2:sz(1)-1
    for n = 2:sz(2)-1
        for p = 2:sz(3)-1
        mstart = ((m-4)*sz2(1)/(sz(1)-3))+0.5;
        mend = mstart + mspace;
        nstart = ((n-4)*sz2(2)/(sz(2)-3))+0.5;
        nend = nstart + nspace;
        pstart = ((p-4)*sz2(3)/(sz(3)-3))+0.5;
        pend = pstart + pspace;

        
        xind = find( 1:sz2(2) > nstart &  1:sz2(2) < nend);
        yind= find( 1:sz2(1) > mstart & 1:sz2(1) < mend);
        zind= find( 1:sz2(3) > pstart & 1:sz2(3) < pend);
        
        
            if isempty(xind)||isempty(yind)||isempty(zind)
                continue
            else
                    error(m,n,p) = sum(sum(sum( ((distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))).^2)))...
                        +alpha*sum(sum(sum(LXx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2+LYx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2 +LZx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2 ...
                        +LXy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2+LYy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2 + LZy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2 ...
                        +LXz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2+LYz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2+LZz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).^2))) + beta*efeat;
            end
        
        end
    end
end