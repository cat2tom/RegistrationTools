function outline = autoseg(image,type)

sz = size(image);
outline = zeros(sz(1),sz(2),sz(3));

switch type
    case{'b'}
       for n = 1:sz(3)
            contour = image(:,:,n);
            contour(contour <1150) = 0;
            contour = bwmorph(contour,'clean');
            contour = bwmorph(contour,'close');
            contour(contour ~=0) =1;
            outline(:,:,n) = outline(:,:,n) + double(contour);
        end
    case{'sl'}
        for n = 1:sz(3)
            contour = edge(image(:,:,n),'canny',[0.024,0.14]);
            contour = bwmorph(contour,'close');
            contour = bwmorph(contour,'clean');
            outline(:,:,n) = double(contour);
        end
    case{'bsl'}
        for n = 1:sz(3)
            contour = edge(image(:,:,n),'canny',[0.024,0.14]);
            contour = bwmorph(contour,'close');
            contour = bwmorph(contour,'clean');
            outline(:,:,n) = double(contour);
            contour = image(:,:,n);
            contour(contour <1150) = 0;
            contour = bwmorph(contour,'clean');
            contour = bwmorph(contour,'close');
            contour(contour ~=0) =1;
            outline(:,:,n) = outline(:,:,n) + double(contour);
        end
end