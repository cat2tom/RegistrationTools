function volume = recalcvol(sz,dgridx,dgridy,dgridz)

%shed padding
dgridx(1,:,:)=[]; dgridx(end,:,:) =[]; dgridx(:,1,:) = []; dgridx(:,end,:) = []; dgridx(:,:,1) = []; dgridx(:,:,end) =[];
dgridy(1,:,:)=[]; dgridy(end,:,:) =[]; dgridy(:,1,:) = []; dgridy(:,end,:) = []; dgridy(:,:,1) = []; dgridy(:,:,end) =[];
dgridz(1,:,:)=[]; dgridz(end,:,:) =[]; dgridz(:,1,:) = []; dgridz(:,end,:) = []; dgridz(:,:,1) = []; dgridz(:,:,end) =[];

%calculate P 
sz = sz+1;
res1 = size(dgridx);
zarray1 = zeros(1,1,res1(3));
zarray2 = zeros(1,1,sz(3));
zarray1(:) = 1:res1(3);
zarray2(:) = 1:(res1(3)-1)/(sz(3)-1):res1(3);

dgridx = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridx,repmat(1:(res1(2)-1)/(sz(2)-1):res1(2),[sz(1),1,sz(3)]),repmat((1:(res1(1)-1)/(sz(1)-1):res1(1))',[1,sz(2),sz(3)]),repmat(zarray2,[sz(1),sz(2),1]),'linear');
dgridy = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridy,repmat(1:(res1(2)-1)/(sz(2)-1):res1(2),[sz(1),1,sz(3)]),repmat((1:(res1(1)-1)/(sz(1)-1):res1(1))',[1,sz(2),sz(3)]),repmat(zarray2,[sz(1),sz(2),1]),'linear');
dgridz = interp3(repmat(1:res1(2),[res1(1),1,res1(3)]),repmat((1:res1(1))',[1,res1(2),res1(3)]),repmat(zarray1,[res1(1),res1(2),1]),dgridz,repmat(1:(res1(2)-1)/(sz(2)-1):res1(2),[sz(1),1,sz(3)]),repmat((1:(res1(1)-1)/(sz(1)-1):res1(1))',[1,sz(2),sz(3)]),repmat(zarray2,[sz(1),sz(2),1]),'linear');

% for t = 2:res1(3)-1
%     [dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1)] = amvd3D(sz,res1,[sz(1),sz(2),3],dgridx(:,:,t-1:t+1),dgridy(:,:,t-1:t+1),dgridz(:,:,t-1:t+1));
% end 



zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
X = repmat(1:sz(2),[sz(1),1,sz(3)])+ dgridx -0.5;
Y = repmat((1:sz(1))',[1,sz(2),sz(3)])+ dgridy -0.5;
Z = repmat(zarray,[sz(1),sz(2),1])+ dgridz -0.5;

% [X,Y,Z] = irongrid3D(X,Y,Z);
clear dgridx dgridy dgridz;
%Voxels centre coordinates
sz = sz-1;
zarray = zeros(1,1,sz(3));
zarray(:) = 1:sz(3);
centerx = repmat(1:sz(2),[sz(1),1,sz(3)]);
centery = repmat((1:sz(1))',[1,sz(2),sz(3)]);
centerz = repmat(zarray,[sz(1),sz(2),1]);

volume = zeros(sz(1),sz(2),sz(3));
%going layer by layer in the Z-axis
for n = 1:sz(3)

%calculating tetrahedron vectors
vectorsx = -cat(3,X(2:end,1:end-1,n)-centerx(:,:,n),X(2:end,1:end-1,n+1)-centerx(:,:,n),X(2:end,2:end,n+1)-centerx(:,:,n),...
            X(2:end,2:end,n)-centerx(:,:,n),X(1:end-1,1:end-1,n)-centerx(:,:,n),X(1:end-1,1:end-1,n+1)-centerx(:,:,n),...
            X(1:end-1,2:end,n+1)-centerx(:,:,n),X(1:end-1,2:end,n)-centerx(:,:,n));
vectorsy = -cat(3,Y(2:end,1:end-1,n)-centery(:,:,n),Y(2:end,1:end-1,n+1)-centery(:,:,n),Y(2:end,2:end,n+1)-centery(:,:,n),...
            Y(2:end,2:end,n)-centery(:,:,n),Y(1:end-1,1:end-1,n)-centery(:,:,n),Y(1:end-1,1:end-1,n+1)-centery(:,:,n),...
            Y(1:end-1,2:end,n+1)-centery(:,:,n),Y(1:end-1,2:end,n)-centery(:,:,n));
vectorsz = -cat(3,Z(2:end,1:end-1,n)-centerz(:,:,n),Z(2:end,1:end-1,n+1)-centerz(:,:,n),Z(2:end,2:end,n+1)-centerz(:,:,n),...
            Z(2:end,2:end,n)-centerz(:,:,n),Z(1:end-1,1:end-1,n)-centerz(:,:,n),Z(1:end-1,1:end-1,n+1)-centerz(:,:,n),...
            Z(1:end-1,2:end,n+1)-centerz(:,:,n),Z(1:end-1,2:end,n)-centerz(:,:,n));
%calculate the 12 tetrahedron volumes for each voxel.        
volumes = (1/6)*cat(3,vectorsx(:,:,4).*(vectorsy(:,:,2).*vectorsz(:,:,1) - vectorsy(:,:,1).*vectorsz(:,:,2)) - vectorsy(:,:,4).*(vectorsx(:,:,2).*vectorsz(:,:,1) - vectorsx(:,:,1).*vectorsz(:,:,2)) + vectorsz(:,:,4).*(vectorsx(:,:,2).*vectorsy(:,:,1) - vectorsx(:,:,1).*vectorsy(:,:,2)),...
                      vectorsx(:,:,3).*(vectorsy(:,:,4).*vectorsz(:,:,2) - vectorsy(:,:,2).*vectorsz(:,:,4)) - vectorsy(:,:,3).*(vectorsx(:,:,4).*vectorsz(:,:,2) - vectorsx(:,:,2).*vectorsz(:,:,4)) + vectorsz(:,:,3).*(vectorsx(:,:,4).*vectorsy(:,:,2) - vectorsx(:,:,2).*vectorsy(:,:,4)),...
                      vectorsx(:,:,4).*(vectorsy(:,:,8).*vectorsz(:,:,1) - vectorsy(:,:,1).*vectorsz(:,:,8)) - vectorsy(:,:,4).*(vectorsx(:,:,8).*vectorsz(:,:,1) - vectorsx(:,:,1).*vectorsz(:,:,8)) + vectorsz(:,:,4).*(vectorsx(:,:,8).*vectorsy(:,:,1) - vectorsx(:,:,1).*vectorsy(:,:,8)),...
                      vectorsx(:,:,8).*(vectorsy(:,:,5).*vectorsz(:,:,1) - vectorsy(:,:,1).*vectorsz(:,:,5)) - vectorsy(:,:,8).*(vectorsx(:,:,5).*vectorsz(:,:,1) - vectorsx(:,:,1).*vectorsz(:,:,5)) + vectorsz(:,:,8).*(vectorsx(:,:,5).*vectorsy(:,:,1) - vectorsx(:,:,1).*vectorsy(:,:,5)),...
                      vectorsx(:,:,3).*(vectorsy(:,:,4).*vectorsz(:,:,8) - vectorsy(:,:,8).*vectorsz(:,:,4)) - vectorsy(:,:,3).*(vectorsx(:,:,4).*vectorsz(:,:,8) - vectorsx(:,:,8).*vectorsz(:,:,4)) + vectorsz(:,:,3).*(vectorsx(:,:,4).*vectorsy(:,:,8) - vectorsx(:,:,8).*vectorsy(:,:,4)),...
                      vectorsx(:,:,3).*(vectorsy(:,:,7).*vectorsz(:,:,8) - vectorsy(:,:,8).*vectorsz(:,:,7)) - vectorsy(:,:,3).*(vectorsx(:,:,7).*vectorsz(:,:,8) - vectorsx(:,:,8).*vectorsz(:,:,7)) + vectorsz(:,:,3).*(vectorsx(:,:,7).*vectorsy(:,:,8) - vectorsx(:,:,8).*vectorsy(:,:,7)),...
                      vectorsx(:,:,7).*(vectorsy(:,:,8).*vectorsz(:,:,5) - vectorsy(:,:,5).*vectorsz(:,:,8)) - vectorsy(:,:,7).*(vectorsx(:,:,8).*vectorsz(:,:,5) - vectorsx(:,:,5).*vectorsz(:,:,8)) + vectorsz(:,:,7).*(vectorsx(:,:,8).*vectorsy(:,:,5) - vectorsx(:,:,5).*vectorsy(:,:,8)),...
                      vectorsx(:,:,7).*(vectorsy(:,:,6).*vectorsz(:,:,5) - vectorsy(:,:,5).*vectorsz(:,:,6)) - vectorsy(:,:,7).*(vectorsx(:,:,6).*vectorsz(:,:,5) - vectorsx(:,:,5).*vectorsz(:,:,6)) + vectorsz(:,:,7).*(vectorsx(:,:,6).*vectorsy(:,:,5) - vectorsx(:,:,5).*vectorsy(:,:,6)),...
                      vectorsx(:,:,3).*(vectorsy(:,:,7).*vectorsz(:,:,6) - vectorsy(:,:,6).*vectorsz(:,:,7)) - vectorsy(:,:,3).*(vectorsx(:,:,7).*vectorsz(:,:,6) - vectorsx(:,:,6).*vectorsz(:,:,7)) + vectorsz(:,:,3).*(vectorsx(:,:,7).*vectorsy(:,:,6) - vectorsx(:,:,6).*vectorsy(:,:,7)),...
                      vectorsx(:,:,3).*(vectorsy(:,:,2).*vectorsz(:,:,6) - vectorsy(:,:,6).*vectorsz(:,:,2)) - vectorsy(:,:,3).*(vectorsx(:,:,2).*vectorsz(:,:,6) - vectorsx(:,:,6).*vectorsz(:,:,2)) + vectorsz(:,:,3).*(vectorsx(:,:,2).*vectorsy(:,:,6) - vectorsx(:,:,6).*vectorsy(:,:,2)),...
                      vectorsx(:,:,6).*(vectorsy(:,:,2).*vectorsz(:,:,1) - vectorsy(:,:,1).*vectorsz(:,:,2)) - vectorsy(:,:,6).*(vectorsx(:,:,2).*vectorsz(:,:,1) - vectorsx(:,:,1).*vectorsz(:,:,2)) + vectorsz(:,:,6).*(vectorsx(:,:,2).*vectorsy(:,:,1) - vectorsx(:,:,1).*vectorsy(:,:,2)),...
                      vectorsx(:,:,6).*(vectorsy(:,:,5).*vectorsz(:,:,1) - vectorsy(:,:,1).*vectorsz(:,:,5)) - vectorsy(:,:,6).*(vectorsx(:,:,5).*vectorsz(:,:,1) - vectorsx(:,:,1).*vectorsz(:,:,5)) + vectorsz(:,:,6).*(vectorsx(:,:,5).*vectorsy(:,:,1) - vectorsx(:,:,1).*vectorsy(:,:,5)));
%sum for total voxel volume
volumes = sum(abs(volumes),3);
volume(:,:,n) = volumes;
end

