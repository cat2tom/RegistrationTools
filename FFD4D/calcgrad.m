function [gradgridx,gradgridy] = calcgrad(base,mask,dgridx,dgridy,alpha)

%distance transforms of images.
distmask = bwdist(mask);
% distbase = bwdist(base);
sz = size(dgridx);
sz2 = size(base);
gradgridx = zeros(sz(1),sz(2));
gradgridy = zeros(sz(1),sz(2));
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
        nspace = round(nend - nstart);
        mspace = round(mend - mstart);
% nspace = 5;
% mspace = 5;
[image1,distsource] = imrecreate(base,dgridx,dgridy);
[LXy,LYy] = dLdy(base,dgridx,dgridy);
[LXx,LYx] = dLdx(base,dgridx,dgridy);
for m = 2:sz(1)-1
    for n = 2:sz(2)-1
%         mstart = ((m-3)*sz2(2)/(sz(1)-3))+0.5;
%         mend = ((m-1)*sz2(2)/(sz(1)-3))+0.5;
%         nstart = ((n-3)*sz2(2)/(sz(2)-3))+0.5;
%         nend = ((n-1)*sz2(2)/(sz(2)-3))+0.5;;
        mstart = ((m-6)*sz2(1)/(sz(1)-3))+0.5;
        mend = mstart + mspace;
        nstart = ((n-6)*sz2(2)/(sz(2)-3))+0.5;
        nend = nstart + nspace;
        
        xind = find( 1:sz2(2) >= nstart & 1:sz2(2) <= nend);
        yind= find( 1:sz2(1) >= mstart & 1:sz2(1) <= mend);
%         if length(yind) > 5 
%             yind = yind(1:5);
%         end
%         if length(xind) > 5
%             xind = xind(1:5);
%         end
if ~isempty(yind) && ~isempty(xind)
    try
        [FX,FY] = gradient(distsource(yind(1):yind(end),xind(1):xind(end)));
    catch
        d = 1;
    end
        [dLXdpx] = dLdPx(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,yind(1)-1,xind(1)-1);
        [dLYdpy] = dLdPy(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,yind(1)-1,xind(1)-1);
        [valuesx] = ddLdxdPx(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,yind(1)-1,xind(1)-1);      
        [valuesy] = ddLdydPy(base(yind(1):yind(end),xind(1):xind(end)),sz,sz2,m,n,yind(1)-1,xind(1)-1);
        
%         sum1(m,n) = length(yind)*length(xind);
%         sum2(m,n) = xind(1)-nstart;
%         sum3(m,n) = sum(sum(dLXdpx));
%         sum4(m,n) = sum(sum(dLYdpy));
%         sum5(m,n) = sum(sum(valuesx));
%         sum6(m,n) = sum(sum(valuesy));
%         sum7(m,n) = 2*alpha*sum(sum((LXx(yind(1):yind(end),xind(1):xind(end)).*valuesx)+...
%             (LXy(yind(1):yind(end),xind(1):xind(end)).*valuesy)));

        gradgridx(m,n) = -2*sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end))-distsource(yind(1):yind(end),xind(1):xind(end)))...
            .*(FX.*dLXdpx)))+2*alpha*sum(sum((LXx(yind(1):yind(end),xind(1):xind(end)).*valuesx)+...
            (LXy(yind(1):yind(end),xind(1):xind(end)).*valuesy)));
        
        
        gradgridy(m,n) = -2*sum(sum( (distmask(yind(1):yind(end),xind(1):xind(end))-distsource(yind(1):yind(end),xind(1):xind(end)))...
            .*(FY.*dLYdpy)))+2*alpha*sum(sum((LYx(yind(1):yind(end),xind(1):xind(end)).*valuesx)+...
            (LYy(yind(1):yind(end),xind(1):xind(end)).*valuesy)));
end
    end
end
d = 1;