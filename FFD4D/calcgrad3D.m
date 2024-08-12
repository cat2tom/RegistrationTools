function [gradgridx,gradgridy,gradgridz] = calcgrad3D(base,distmask,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2)

%distance transforms of images.
% distmask = bwdist(mask,'quasi-euclidean');
sz = size(dgridx);
sz2 = size(base);
gradgridx = zeros(sz(1),sz(2),sz(3));
gradgridy = zeros(sz(1),sz(2),sz(3));
gradgridz = zeros(sz(1),sz(2),sz(3));
% sum1 = zeros(sz(1),sz(2));
% sum2 = zeros(sz(1),sz(2));
% sum3 = zeros(sz(1),sz(2));
% sum4 = zeros(sz(1),sz(2));
% sum5 = zeros(sz(1),sz(2));
% sum6 = zeros(sz(1),sz(2));
% sum7 = zeros(sz(1),sz(2));
% alpha = 1;
        mstart = (((sz(1)/2)-6)*sz2(1)/(sz(1)-3))+0.5;
        mend = (((sz(1)/2)+3)*sz2(1)/(sz(1)-3))+0.5;
        nstart = (((sz(2)/2)-6)*sz2(2)/(sz(2)-3))+0.5;
        nend = (((sz(2)/2)+3)*sz2(2)/(sz(2)-3))+0.5;
        pstart = (((sz(3)/2)-6)*sz2(3)/(sz(3)-3))+0.5;
        pend = (((sz(3)/2)+3)*sz2(3)/(sz(3)-3))+0.5;
        nspace = round(nend - nstart);
        mspace = round(mend - mstart);
        pspace = round(pend - pstart);

[image1,distsource] = imrecreate3D(base,dgridx,dgridy,dgridz);
clear image1 base
[LXy,LYy,LZy] = dLdy3D(sz2,dgridx,dgridy,dgridz);
[LXx,LYx,LZx] = dLdx3D(sz2,dgridx,dgridy,dgridz);
[LXz,LYz,LZz] = dLdz3D(sz2,dgridx,dgridy,dgridz);
for m = 2:sz(1)-1
    for n = 2:sz(2)-1
        for p = 2:sz(3)-1

        mstart = ((m-6)*sz2(1)/(sz(1)-3))+0.5;
        mend = mstart + mspace;
        nstart = ((n-6)*sz2(2)/(sz(2)-3))+0.5;
        nend = nstart + nspace;
        pstart = ((p-6)*sz2(3)/(sz(3)-3))+0.5;
        pend = pstart + pspace;
        
        xind = find( 1:sz2(2) >= nstart & 1:sz2(2) <= nend);
        yind= find( 1:sz2(1) >= mstart & 1:sz2(1) <= mend);
        zind= find( 1:sz2(3) >= pstart & 1:sz2(3) <= pend);

if ~isempty(yind) && ~isempty(xind) && ~isempty(xind)
    
        [FX,FY,FZ] = gradient(distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)));
        [dLXdpx] = dLdPx3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);
        [dLYdpy] = dLdPy3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);
        [dLZdpz] = dLdPz3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);
        [valuesx] = ddLdxdPx3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);      
        [valuesy] = ddLdydPy3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);
        [valuesz] = ddLdzdPz3D(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,p,yind(1)-1,xind(1)-1,zind(1)-1);
        efeat = dferror3D(fpoints,fpoints2,m,n,p,dgridx,dgridy,dgridz);
%         sum1(m,n) = length(yind)*length(xind);
%         sum2(m,n) = xind(1)-nstart;
%         sum3(m,n) = sum(sum(dLXdpx));
%         sum4(m,n) = sum(sum(dLYdpy));
%         sum5(m,n) = sum(sum(valuesx));
%         sum6(m,n) = sum(sum(valuesy));
%         sum7(m,n) = 2*alpha*sum(sum((LXx(yind(1):yind(end),xind(1):xind(end)).*valuesx)+...
%             (LXy(yind(1):yind(end),xind(1):xind(end)).*valuesy)));

        gradgridx(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FX.*dLXdpx))))+2*alpha*sum(sum(sum((LXx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx)+...
            (LXy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy)+ ...
            (LXz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz)))) + beta*efeat(2);
        
        gradgridy(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FY.*dLYdpy))))+2*alpha*sum(sum(sum((LYx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx)+...
            (LYy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy)+ (LYz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz))))+ beta*efeat(1);
        
        gradgridz(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FZ.*dLZdpz))))+2*alpha*sum(sum(sum((LZx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx)+...
            (LZy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy)+ (LZz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz))))+ beta*efeat(3);
end
        end
    end
end
