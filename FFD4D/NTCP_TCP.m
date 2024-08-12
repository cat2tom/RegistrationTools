N = 72;

X = [0:100:(N-1)*100]';

totTCP = [];
for n = 1:11
col1 = num2let((n*3-1));
col2 = num2let((n*3-2));
    location = [col1 '2:' col2 num2str(N+1)];
    data = xlsread('M:\Curve fitting\DVH4B5B7D_APPA.xls','cDVH4B_AP',location); 
    TCP = calcTCP(data(:,1),data(:,2));
    totTCP = [totTCP; TCP];
end