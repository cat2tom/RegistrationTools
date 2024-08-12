for  n = 1:25
    if n <10
        number = sprintf(['0' num2str(n)]);
    else
        number = num2str(n);
    end
    path = sprintf(['C:\shapes\Cube\cube' number '.dcm']);
    dicomwrite(square(:,:,n),path);
end