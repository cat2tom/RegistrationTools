function [gridx,gridy] = irongrid(gridx,gridy)

sz = size(gridx);
%smooth down
for m = 1:sz(1)-1
       if ~isempty(find((min(gridy(m+1:end,:),[],1)<= gridy(m,:))~=0, 1))
        if m ==1
           gridy(1,:)= min(gridy(m+1:end,:),[],1) - abs(min(gridy(m+1:end,:),[],1)- min(gridy(m+2:end,:),[],1)); 
        else
            sz2 = size(gridy(m+1:end,:));
        points = gridy(m+1:end,:) - repmat(gridy(m-1,:),[sz2(1),1]);
        points(points < 0 ) = NaN;
        points(:,min(gridy(m+1:end,:),[],1)> gridy(m,:)) = NaN;
        points = min(points,[],1);
        gridy(m,~isnan(points))= gridy(m-1,~isnan(points)) + 0.8*points(~isnan(points));
        end
       end  
end
 %smooth up
for m = sz(1):-1:2
    if ~isempty(find((max(gridy(1:m-1,:),[],1)>= gridy(m,:))~=0, 1))
        if m ==sz(1)
           gridy(sz(1),:)= max(gridy(1:m-1,:),[],1) + abs(max(gridy(1:m-1,:),[],1)-max(gridy(1:m-2,:),[],1)); 
        else
            sz2 = size(gridy(1:m-1,:));
        points = -gridy(1:m-1,:) + repmat(gridy(m+1,:),[sz2(1),1]);
        points(points < 0 ) = NaN;
        points(:,max(gridy(1:m-1,:),[],1)< gridy(m,:)) = NaN;
        points = min(points,[],1);
        gridy(m,~isnan(points))= gridy(m+1,~isnan(points)) - 0.8*points(~isnan(points));
        end
    end
end
%smooth right
for n = 1:sz(2)-1
       if ~isempty(find((min(gridx(:,n+1:end),[],2)<= gridx(:,n))~=0, 1))
        if n ==1
           gridx(:,1)= min(gridx(:,n+1:end),[],2) - abs(min(gridx(:,n+1:end),[],2)-min(gridx(:,n+2:end),[],2)); 
        else
            sz2 = size(gridx(:,n+1:end));
        points = gridx(:,n+1:end) - repmat(gridx(:,n-1),[1,sz2(2)]);
        points(points < 0 ) = NaN;
        points((min(gridx(:,n+1:end),[],2)> gridx(:,n)),:) = NaN;
        points = min(points,[],2);
        gridx(~isnan(points),n)= gridx(~isnan(points),n-1) + 0.8*points(~isnan(points));
        end
      end
end
 %smooth left
for n = sz(2):-1:2
    if ~isempty(find((max(gridx(:,1:n-1),[],2)>= gridx(:,n))~=0, 1))
        if n ==sz(2)
           gridx(:,sz(2))= max(gridx(:,1:n-1),[],2) +abs(max(gridx(:,1:n-1),[],2) - max(gridx(:,1:n-2),[],2)); 
        else
            sz2 = size(gridx(:,1:n-1));
        points = -gridx(:,1:n-1) + repmat(gridx(:,n+1),[1,sz2(2)]);
        points(points < 0 ) = NaN;
        points((max(gridx(:,1:n-1),[],2)< gridx(:,n)),:) = NaN;
        points = min(points,[],2);
        gridx(~isnan(points),n)= gridx(~isnan(points),n+1) - 0.8*points(~isnan(points));
        end
    end
end

% old code
%     for n = 1:sz(2)
%     if ~isempty(gridy(1:m-1,n)> gridy(m,n))
%         if m ==sz(1)
%            gridy(sz(1),n)= max(gridy(1:m-1,n)) + 1; 
%         else
%         points = -gridy(1:m-1,n) + gridy(m+1,n);
%         points(points < 0) = [];
%         gridy(m,n)= gridy(m+1,n) - 0.8*min(points);
%         end
%     end
%     end