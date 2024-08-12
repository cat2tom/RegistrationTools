files = dir('M:\4DImage\Glazer4D');
for p = 0:91
    try
    copyfile(['M:\4DImage\Glazer4D\CT.1.2.840.113619.2.108.1627439458.1286.1067286768.' num2str(835+p) '.dcm'],['C:\Glazer_test\Glazer' numbername(p,2) '.dcm']);
    catch
        d = 1;
    end
    end