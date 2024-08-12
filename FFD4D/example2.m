aviobj = avifile('phantom9.avi','compression','Cinepak'); %open new movie file
% load('C:\Documents and Settings\markeld\Desktop\Matlab_2008a\Patient
% Files\Patient_0010\50%.m','-mat');
load('C:\Documents and Settings\MARKEL\Desktop\FFD4D\Patient Files\Patient_0022\10%.m','-mat');
load('C:\Documents and Settings\MARKEL\Desktop\FFD4D\Patient Files\Patient_0022\10%_to_50%_deform.m','-mat');
dgridx = zeros(16,16,16);
dgridy = zeros(16,16,16);
   
    sz = size(image1);
final = zeros(sz(3),sz(1),25);
for n = 1:25
    dgridx = zeros(16,16,16);
    dgridy = zeros(16,16,16);
    image1 = imrecreate3D3(image1,dgridx,dgridy,dgridz.*n./25);
    final(:,:,n)  = reshape(image1(:,49,:),sz(1),sz(3))';
    load('C:\Documents and Settings\MARKEL\Desktop\FFD4D\Patient Files\Patient_0022\10%.m','-mat');
end
for n = 1:25
    imagesc(final(:,:,n), 'CDataMapping','scaled');
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 25:-1:1
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 1:25
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 25:-1:1
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 1:25
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 25:-1:1
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 1:25
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
for n = 25:-1:1
    imagesc(final(:,:,n));
    colormap bone
f = getframe(gca); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
end
    aviobj = close(aviobj); %save/close the movie