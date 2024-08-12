function [gradgridx,gradgridy,gradgridz] = calcgrad3D2(base,distmask,dgridx,dgridy,dgridz,alpha,beta,fpoints,fpoints2)

%distance transforms of images.
% distmask = bwdist(mask,'quasi-euclidean');
sz = size(dgridx);
sz2 = size(base);
gradgridx = zeros(sz(1),sz(2),sz(3));
gradgridy = zeros(sz(1),sz(2),sz(3));
gradgridz = zeros(sz(1),sz(2),sz(3));
        mstart = (((sz(1)/2)-4)*sz2(1)/(sz(1)-3))+0.5;
        mend = (((sz(1)/2)+1)*sz2(1)/(sz(1)-3))+0.5;
        nstart = (((sz(2)/2)-4)*sz2(2)/(sz(2)-3))+0.5;
        nend = (((sz(2)/2)+1)*sz2(2)/(sz(2)-3))+0.5;
        pstart = (((sz(3)/2)-4)*sz2(3)/(sz(3)-3))+0.5;
        pend = (((sz(3)/2)+1)*sz2(3)/(sz(3)-3))+0.5;
        nspace = round(nend - nstart);
        mspace = round(mend - mstart);
        pspace = round(pend - pstart);

[image1,distsource] = imrecreate3D(base,dgridx,dgridy,dgridz);
clear image1 base
[LXy,LYy,LZy] = dLdy3D(sz2,dgridx,dgridy,dgridz);
[LXx,LYx,LZx] = dLdx3D(sz2,dgridx,dgridy,dgridz);
[LXz,LYz,LZz] = dLdz3D(sz2,dgridx,dgridy,dgridz);
zarray = zeros(1,1,sz2(3));
zarray(:) = 1:sz2(3);
X = repmat(1:sz2(2),[sz2(1),1,sz2(3)]);
Y = repmat((1:sz2(1))',[1,sz2(2),sz2(3)]);
Z = repmat(zarray,[sz2(1),sz2(2),1]);
valuesx = zeros(sz2(1),sz2(2),sz2(3));
valuesy = zeros(sz2(1),sz2(2),sz2(3));
valuesz = zeros(sz2(1),sz2(2),sz2(3));
dLdp = zeros(sz2(1),sz2(2),sz2(3));
for m = 2:sz(1)-1
      mstart = ((m-4)*sz2(1)/(sz(1)-3))+0.5;
      mend = mstart + mspace;
      yind= find( 1:sz2(1) >= mstart & 1:sz2(1) <= mend);
      if ~isempty(yind)
      i = floor(((Y-0.5).*(sz(1)-3)./sz2(1))+2)-1;
    for n = 2:sz(2)-1
        nstart = ((n-4)*sz2(2)/(sz(2)-3))+0.5;
        nend = nstart + nspace;
        xind = find( 1:sz2(2) >= nstart & 1:sz2(2) <= nend);
        if ~isempty(xind)
        j = floor(((X-0.5).*(sz(2)-3)./sz2(2))+2)-1;
      
        for p = 2:sz(3)-1
        pstart = ((p-4)*sz2(3)/(sz(3)-3))+0.5;
        pend = pstart + pspace;
        zind= find( 1:sz2(3) >= pstart & 1:sz2(3) <= pend);
        if ~isempty(zind)&& length(zind) > 1

    
        [FX,FY,FZ] = gradient(distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)));

% sz3 = [yind(end)-yind(1)+1,xind(end)-xind(1)+1,zind(end)-zind(1)+1];

dudx = (sz(2)-3)/sz2(2);
dvdy = (sz(1)-3)/sz2(1);
dwdz = (sz(3)-3)/sz2(3);

        
        
        k = floor(((Z-0.5).*(sz(3)-3)./sz2(3))+2)-1;
        indices = find( m-i >=0 & m-i <=3 & n-j >=0 & n-j <=3 & p-k >=0 & p-k <=3); 

              u = ((X(indices)-0.5).*(sz(2)-3)./sz2(2))+2 - floor(((X(indices)-0.5).*(sz(2)-3)./sz2(2))+2);
              v = ((Y(indices)-0.5).*(sz(1)-3)./sz2(1))+2 - floor(((Y(indices)-0.5).*(sz(1)-3)./sz2(1))+2);
              w = ((Z(indices)-0.5).*(sz(3)-3)./sz2(3))+2 - floor(((Z(indices)-0.5).*(sz(3)-3)./sz2(3))+2);
              a = bspline(u,n-j(indices));
              b = bspline(v,m-i(indices));
              c = bspline(w,p-k(indices));
              d = dbspline(u,n-j(indices));
              e = dbspline(v,m-i(indices));
              f = dbspline(w,p-k(indices));


            valuesx(indices) = d.*b.*c.*dudx;
            valuesy(indices) = a.*e.*c.*dvdy;
            valuesz(indices) = a.*b.*f.*dwdz;
            dLdp(indices) = a.*b.*c;

      
efeat = dferror3D(fpoints,fpoints2,m,n,p,dgridx,dgridy,dgridz,sz2,sz);


        gradgridx(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FX.*dLdp(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))))))+2*alpha*sum(sum(sum((LXx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+...
            (LXy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+ ...
            (LXz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))))) + beta*efeat(2);
        
        gradgridy(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FY.*dLdp(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))))))+2*alpha*sum(sum(sum((LYx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+...
            (LYy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+ (LYz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))))))+ beta*efeat(1);
        
        gradgridz(m,n,p) = -2*sum(sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))-distsource(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))...
            .*(FZ.*dLdp(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))))))+2*alpha*sum(sum(sum((LZx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesx(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+...
          (LZy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesy(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)))+ (LZz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end)).*valuesz(yind(1):yind(end),xind(1):xind(end),zind(1):zind(end))))))+ beta*efeat(3);
        valuesx(:,:,:) = 0;
        valuesy(:,:,:) = 0;
        valuesz(:,:,:) = 0;
        dLdp(:,:,:) = 0;
        end

        end
        end

    end
      end

end
