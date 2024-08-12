[doses3D,sz,xCoord,yCoord,zCoord] = readRTOGDose('C:\Documents and Settings\MARKEL\Desktop\GLAZER\PLAN60%_imrt\RTOG0000');

% sz = size(doses3D);
rez =[abs(yCoord(end)-yCoord(1))/sz(1),(xCoord(end)-xCoord(1))/sz(2),0.25];
[C1,I1] = min(abs(yCoord-(-(35-256)*0.0898-45.999)));
[C2,I2] = min(abs(yCoord-(-(375-256)*0.0898-45.999)));
[C3,I3] = min(abs(xCoord-((12-256)*0.0898+0.001)));
[C4,I4] = min(abs(xCoord-((480-256)*0.0898+0.001)));
[C5,I5] = min(abs(zCoord-((1)*0.25-9.999)));
[C6,I6] = min(abs(zCoord-((92)*0.25-9.999)));
C1 = yCoord(I1);
C2 = yCoord(I2);
C3 = xCoord(I3);
C4 = xCoord(I4);
C5 = zCoord(I5);
C6 = zCoord(I6);
crp = [I1,I2,I3,I4,I5,I6];

doses3D = doses3D(crp(1):crp(2),crp(3):crp(4),crp(5):crp(6));
crp2 = [-(35-256)*0.0898-45.999,-(375-256)*0.0898-45.999,(12-256)*0.0898-0.001,(480-256)*0.0898-0.001,((1)*0.25-9.999),((92)*0.25-9.999)];
sz = size(doses3D);
xinterv = xCoord(2)-xCoord(1);
yinterv = yCoord(2)-yCoord(1);
zinterv = zCoord(2)-zCoord(1);
res2 = [376-35,481-12,93-1];
res1 = [100,100,92];
zarray1 = zeros(1,1,sz(3));
zarray2 = zeros(1,1,res1(3));
zarray1(:) = zCoord(crp(5):crp(6));
zarray2(:) = crp2(5):(0.25*(res2(3)-1)/(res1(3)-1)):crp2(6);
doses3D = interp3(repmat(xCoord(crp(3):crp(4)),[sz(1),1,sz(3)]),repmat((yCoord(crp(1):crp(2)))',[1,sz(2),sz(3)]),repmat(zarray1,[sz(1),sz(2),1]),doses3D,repmat(crp2(3):(0.0898*(res2(2)-1)/(res1(2)-1)):crp2(4),[res1(1),1,res1(3)]),repmat((crp2(1):-(0.0898*(res2(1)-1)/(res1(1)-1)):crp2(2))',[1,res1(2),res1(3)]),repmat(zarray2,[res1(1),res1(2),1]),'linear');

contour = getRTOGcont('C:\Documents and Settings\MARKEL\Desktop\GLAZER\PLAN60%_imrt\RTOG0000','ctv1stdsh',[35,375,12,480]);
DVH = calcDVH(doses3D,contour);