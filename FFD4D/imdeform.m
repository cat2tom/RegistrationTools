function [image1,dgridx1,dgridy1,dgridx2,dgridy2,dgridx3,dgridy3] = imdeform(image1,image2)


sz = size(image1);
M = round(sz(1)/15);
N = round(sz(2)/15);
dgridx1 = zeros(M,N);
dgridy1 = zeros(M,N);
dgridx2 = zeros(round(M*1.5),round(N*1.5));
dgridy2 = zeros(round(M*1.5),round(N*1.5));
dgridx3 = zeros(M*2,N*2);
dgridy3 = zeros(M*2,N*2);
% gamma1 = zeros(M,N);

iterations = 2;
% for m = 1:M
%     for n = 1:N
%         gridx(m,n) =((n-2)*sz(2)/(N-3)) + 0.5;
%         gridy(m,n) = ((m-2)*sz(1)/(M-3)) +0.5;
%     end
% end

error = elocal(image1,image2,dgridx1,dgridy1,0.4);
for j = 1:iterations
    
    tic
    [gradgridx,gradgridy] = calcgrad(image1,image2,dgridx1,dgridy1,1.4);
    toc
    dist = bwdist(image1);
%     gamma1(:,:) = (((M/sz(2) + N/sz(1)))/(max(max(gradgridx))+max(max(gradgridy))/2)); %proportionality constant to determine the step size.
%     gamma2 = gamma1;
gradgridx = gradgridx./max(max(abs(gradgridx)));
gradgridy = gradgridy./max(max(abs(gradgridy)));
gamma1 = 3*(max(max(dist))-0.5)*(((N+M)/2)-3)/(sz(1)+sz(2)/2);
gamma2 = gamma1;

% for m = 1:M
%     for n = 1:N
        k = 1;
        while k <= 10
        dgridx1 = dgridx1 + gamma2.*gradgridx;
        dgridy1 = dgridy1 + gamma2.*gradgridy;
    
        errorloc = elocal(image1,image2,dgridx1,dgridy1,1.4);
        
%         loc = find(errorloc > error);
%         if ~isempty(loc)
%             k = k+1;
%             dgridx(loc) = dgridx(loc) - gamma2(loc).*gradgridx(loc);
%             dgridy(loc) = dgridy(loc) - gamma2(loc).*gradgridy(loc);
%             gamma2(loc) = gamma2(loc)./2;
%         else
%             gamma2 = gamma1;
%             break
%         end
        if sum(sum(errorloc))>= sum(sum(error))
            k = k+1;
            dgridx1 = dgridx1 - gamma2.*gradgridx;
            dgridy1 = dgridy1 - gamma2.*gradgridy;
            gamma2= gamma2./1.5;
%         else
%             gamma2 = gamma1;
%             break
        end
        
end
end
[image1,imagedist] = imrecreate(image1,dgridx1,dgridy1);
% [x,y] = find(image1 > 0);
% image1 = imrest([x,y],coords,image1,dgridx,dgridy);      

% gamma1 = zeros(M*2,N*2);
error = elocal(image1,image2,dgridx2,dgridy2,1.4);

for j = 1:iterations
    
    tic
    [gradgridx,gradgridy] = calcgrad(image1,image2,dgridx2,dgridy2,0.4);
    toc
%     gamma1(:,:) = (((M*2/sz(2) + N*2/sz(1)))/(max(max(gradgridx))+max(max(gradgridy))/2)); %proportionality constant to determine the step size.
%     gamma2 = gamma1;
gamma1 = (max(max(dist))-0.5)*(((N+M)*1.5/2)-3)/(sz(1)+sz(2)/2);
gamma2 = gamma1;
gradgridx = gradgridx./max(max(abs(gradgridx)));
gradgridy = gradgridy./max(max(abs(gradgridy)));
% for m = 1:M
%     for n = 1:N
        k = 1;
        while k <= 5
        dgridx2 = dgridx2 + gamma2.*gradgridx;
        dgridy2 = dgridy2 + gamma2.*gradgridy;
        
        errorloc = elocal(image1,image2,dgridx2,dgridy2,1.4);
        
%         loc = find(errorloc > error);
%         if ~isempty(loc)
%             k = k+1;
%             dgridx(loc) = dgridx(loc) - gamma2(loc).*gradgridx(loc);
%             dgridy(loc) = dgridy(loc) - gamma2(loc).*gradgridy(loc);
%             gamma2(loc) = gamma2(loc)./2;
%         else
%             gamma2 = gamma1;
%             break
%         end
        if sum(sum(errorloc))>= sum(sum(error))
            k = k+1;
            dgridx2 = dgridx2 - gamma2.*gradgridx;
            dgridy2 = dgridy2 - gamma2.*gradgridy;
            gamma2= gamma2./1.5;
%         else
%             gamma2 = gamma1;
%             break
        end
        
end
end
[image1,imagedist] = imrecreate(image1,dgridx2,dgridy2);
% [x,y] = find(image1 > 0);
% image1 = imrest([x,y],coords,image1,dgridx,dgridy);  

% gamma1 = zeros(M*4,N*4);
error = elocal(image1,image2,dgridx3,dgridy3,4);
for j = 1:iterations
    
    tic
    [gradgridx,gradgridy] = calcgrad(image1,image2,dgridx3,dgridy3,1.4);
    toc
%     gamma1(:,:) = (((M*4/sz(2) + N*4/sz(1)))/(max(max(gradgridx))+max(max(gradgridy))/2)); %proportionality constant to determine the step size.
%     gamma2 = gamma1;
gamma1 = (max(max(dist))-0.5)*(((N+M))-3)/(sz(1)+sz(2)/2);
gamma2 = gamma1;
gradgridx = gradgridx./max(max(abs(gradgridx)));
gradgridy = gradgridy./max(max(abs(gradgridy)));
% for m = 1:M
%     for n = 1:N
        k = 1;
        while k <= 5
        dgridx3 = dgridx3 + gamma2.*gradgridx;
        dgridy3 = dgridy3 + gamma2.*gradgridy;
        
        errorloc = elocal(image1,image2,dgridx3,dgridy3,1.4);
        
%         loc = find(errorloc > error);
%         if ~isempty(loc)
%             k = k+1;
%             dgridx(loc) = dgridx(loc) - gamma2(loc).*gradgridx(loc);
%             dgridy(loc) = dgridy(loc) - gamma2(loc).*gradgridy(loc);
%             gamma2(loc) = gamma2(loc)./2;
%         else
%             gamma2 = gamma1;
%             break
%         end
        if sum(sum(errorloc))>= sum(sum(error))
            k = k+1;
            dgridx3 = dgridx3 - gamma2.*gradgridx;
            dgridy3 = dgridy3 - gamma2.*gradgridy;
            gamma2= gamma2./1.5;
%         else
%             gamma2 = gamma1;
%             break
        end
        
end
end
[image1,imagedist] = imrecreate(image1,dgridx3,dgridy3);
% image1 = imrest(coords,sz);   

