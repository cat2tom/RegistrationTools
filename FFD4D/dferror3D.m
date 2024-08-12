function efeat = dferror3D(fpoints,fpoints2,m,n,p,dgridx,dgridy,dgridz,sz,sz2)
        


        if size(fpoints) ~= size(fpoints2)
            error('points in one image do not have corresponding feature points in the other');
        end
        
efeat = zeros(1,3);
if ~isempty(fpoints) && ~isempty(fpoints2)
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
            for l = 0:3
                for r = 0:3
               
                    ind = sub2ind(sz2,i+l,j+q,k+r);
                    fpoints(:,1) = fpoints(:,1) + bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*dgridy(ind);
                    fpoints(:,2) = fpoints(:,2) + bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*dgridx(ind);
                    fpoints(:,3) = fpoints(:,3) + bspline2(u,q).*bspline2(v,l).*bspline2(w,r).*dgridz(ind);
                end
            end
        end
        
        loc = find(m-i < 3 & m-i > 0 & n-j < 3 & n-j > 0 & p-k < 3 & p-k > 0);
        if ~isempty(loc);
            
        efeat(1) =sum((fpoints(loc,1) - fpoints2(loc,1)).*bspline(u(loc),m-i(loc)).*bspline(v(loc),n-j(loc)).*bspline(w(loc),p-k(loc)));
        efeat(2) =sum((fpoints(loc,2) - fpoints2(loc,1)).*bspline(u(loc),m-i(loc)).*bspline(v(loc),n-j(loc)).*bspline(w(loc),p-k(loc)));
        efeat(3) =sum((fpoints(loc,3) - fpoints2(loc,3)).*bspline(u(loc),m-i(loc)).*bspline(v(loc),n-j(loc)).*bspline(w(loc),p-k(loc)));
        end
end