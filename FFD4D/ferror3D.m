function efeat = ferror3D(fpoints,fpoints2,dgridx,dgridy,dgridz,sz2,sz)
if ~isempty(fpoints)
    try
        i = floor(((fpoints(:,2)-0.5).*(sz2(1)-3)./sz(1))+2)-1;
            catch
                      d = 1;
                  end
        j = floor(((fpoints(:,1)-0.5).*(sz2(2)-3)./sz(2))+2)-1;
        k = floor(((fpoints(:,3)-0.5).*(sz2(3)-3)./sz(3))+2)-1;
        u = ((fpoints(:,2)-0.5).*(sz2(2)-3)./sz(2))+2 - floor(((fpoints(:,2)-0.5).*(sz2(2)-3)./sz(2))+2);
        v = ((fpoints(:,1)-0.5).*(sz2(1)-3)./sz(1))+2 - floor(((fpoints(:,1)-0.5).*(sz2(1)-3)./sz(1))+2);
        w = ((fpoints(:,3)-0.5).*(sz2(3)-3)./sz(3))+2 - floor(((fpoints(:,3)-0.5).*(sz2(3)-3)./sz(3))+2);
        for q = 0:3
            a = bspline2(u,q);
            for l = 0:3
                b = bspline2(v,l);
                for r = 0:3
                  c = bspline2(w,r);
%                   try
                    ind = sub2ind(sz2,i+l,j+q,k+r);
%                   catch
%                       d = 1;
%                   end
                    fpoints(:,1) = fpoints(:,1) + a.*b.*c.*dgridy(ind);
                    fpoints(:,2) = fpoints(:,2) + a.*b.*c.*dgridx(ind);
                    fpoints(:,3) = fpoints(:,3) + a.*b.*c.*dgridz(ind);
                end
            end
        end
                
        efeat = sum(sum((fpoints - fpoints2).^2));
else
    efeat = 0;
end