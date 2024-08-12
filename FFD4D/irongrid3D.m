function [gridx,gridy,gridz] = irongrid3D(gridx,gridy,gridz)


sz = size(gridy);
%smooth down
for m = 1:sz(1)-1
       if ~isempty(find((min(gridy(m+1:end,:,:),[],1)<= gridy(m,:,:))~=0, 1))
        if m ==1
           gridy(1,:,:)= min(gridy(m+1:end,:,:),[],1) - abs(min(gridy(m+1:end,:,:),[],1)- min(gridy(m+2:end,:,:),[],1)); 
        else
        sz2 = size(gridy(m+1:end,:,:));
        points = gridy(m+1:end,:,:) - repmat(gridy(m-1,:,:),[sz2(1),1,1]);
        points(points < 0 ) = NaN;
        points(:,min(gridy(m+1:end,:,:),[],1)> gridy(m,:,:)) = NaN;
        points = min(points,[],1);
        gridy(m,~isnan(points))= gridy(m-1,~isnan(points)) + 0.8*points(~isnan(points))';
        end
       end  
end
 %smooth up
for m = sz(1):-1:2
           if ~isempty(find((max(gridy(1:m-1,:,:),[],1)>= gridy(m,:,:))~=0, 1))
        if m ==sz(1)
           gridy(sz(1),:,:)= max(gridy(m-1:end,:,:),[],1) + abs(max(gridy(1:m-1,:,:),[],1)- max(gridy(1:m-2,:,:),[],1)); 
        else
        sz2 = size(gridy(1:m-1,:,:));
        points = -gridy(1:m-1,:,:) + repmat(gridy(m+1,:,:),[sz2(1),1,1]);
        points(points < 0 ) = NaN;
        points(:,max(gridy(1:m-1,:,:),[],1)< gridy(m,:,:)) = NaN;
        points = min(points,[],1);
        gridy(m,~isnan(points))= gridy(m+1,~isnan(points)) - 0.8*points(~isnan(points))';
        end
    end
end
%smooth right
for n = 1:sz(2)-1
       if ~isempty(find((min(gridx(:,n+1:end,:),[],2)<= gridx(:,n,:))~=0, 1))
        if n ==1
           gridx(:,1,:)= min(gridx(:,n+1:end,:),[],2) - abs(min(gridx(:,n+1:end,:),[],2)-min(gridx(:,n+2:end,:),[],2)); 
        else
            sz2 = size(gridx(:,n+1:end,:));
        points = gridx(:,n+1:end,:) - repmat(gridx(:,n-1,:),[1,sz2(2),1]);
        points(points < 0 ) = NaN;
        ind = repmat(min(gridx(:,n+1:end,:),[],2)> gridx(:,n,:),[1,sz2(2),1]);
        points(ind) = NaN;
        points = min(points,[],2);
        ind = ~isnan(points);
        ind2 = zeros(sz);
        ind2(:,n,:) = ind;
        ind3 = zeros(sz);
        ind3(:,n-1,:) = ind;
        gridx(ind2== 1)= gridx(ind3==1) + 0.8*points(ind==1);
        end
      end
end
 %smooth left
for n = sz(2):-1:2
    if ~isempty(find((max(gridx(:,1:n-1,:),[],2)>= gridx(:,n,:))~=0, 1))
        if n ==sz(2)
           gridx(:,sz(2))= max(gridx(:,1:n-1,:),[],2) +abs(max(gridx(:,1:n-1,:),[],2) - max(gridx(:,1:n-2,:),[],2)); 
        else
        sz2 = size(gridx(:,1:n-1,:));
        points = -gridx(:,1:n-1,:) + repmat(gridx(:,n+1,:),[1,sz2(2),1]);
        points(points < 0 ) = NaN;
        ind = repmat(max(gridx(:,1:n-1,:),[],2)< gridx(:,n,:),[1,sz2(2),1]);
        points(ind) = NaN;
        points = min(points,[],2);
        ind = ~isnan(points);
        ind2 = zeros(sz);
        ind2(:,n,:) = ind;
        ind3 = zeros(sz);
        ind3(:,n+1,:) = ind;
        gridx(ind2== 1)= gridx(ind3==1) - 0.8*points(ind==1);
        end
    end
end
%smooth back
for p = 1:sz(3)-1
       if ~isempty(find((min(gridz(:,:,p+1:end),[],3)<= gridz(:,:,p))~=0, 1))
        if p ==1
           gridz(:,:,1)= min(gridz(:,:,p+1:end),[],3) - abs(min(gridz(:,:,p+1:end),[],3)-min(gridz(:,:,p+2:end),[],3)); 
        else
            sz2 = size(gridz(:,:,p+1:end));
        if size(sz2)<3
            sz2 = [sz2,1];
        end
        points = gridz(:,:,p+1:end) - repmat(gridz(:,:,p-1),[1,1,sz2(3)]);
        points(points < 0 ) = NaN;
        ind = repmat(min(gridz(:,:,p+1:end),[],3)> gridz(:,:,p),[1,1,sz2(3)]);
        points(ind) = NaN;
        points = min(points,[],3);
        ind = ~isnan(points);
        ind2 = zeros(sz);
        ind2(:,:,p) = ind;
        ind3 = zeros(sz);
        ind3(:,:,p-1) = ind;
        gridz(ind2== 1)= gridz(ind3==1) + 0.8*points(ind==1);
        end
      end
end
 %smooth forward
for p = sz(3):-1:2
    if ~isempty(find((max(gridz(:,:,1:p-1),[],3)>= gridz(:,:,p))~=0, 1))
        if p ==sz(3)
           gridz(:,:,sz(3))= max(gridz(:,:,1:p-1),[],3) +abs(max(gridz(:,:,1:p-1),[],3) - max(gridz(:,:,1:p-2),[],3)); 
        else
        sz2 = size(gridz(:,:,1:p-1));
        if size(sz2)<3
            sz2 = [sz2,1];
        end
        points = -gridz(:,:,1:p-1) + repmat(gridz(:,:,p+1),[1,1,sz2(3)]);
        points(points < 0 ) = NaN;
        ind = repmat(max(gridz(:,:,1:p-1),[],3)< gridz(:,:,p),[1,1,sz2(3)]);
        points(ind) = NaN;
        points = min(points,[],3);
        ind = ~isnan(points);
        ind2 = zeros(sz);
        ind2(:,:,p) = ind;
        ind3 = zeros(sz);
        ind3(:,:,p+1) = ind;
        gridz(ind2== 1)= gridz(ind3==1) - 0.8*points(ind==1);
        end
    end
end