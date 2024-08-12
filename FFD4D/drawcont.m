%convert contour outline (shape) to 2D dose distribution

function shape = drawcont(shape,dose)

sz = size(shape);

for m = 1:sz(1)
    locations1 = find(shape(m,:) == 1);
    start1 = min(locations1);
    stop1 = max(locations1);
    if m < sz(1)
    if (isempty(find(shape(m,start1:stop1) == 0)) && isempty(find(shape(m+1,:) == 1)))||(isempty(find(shape(m,start1:stop1) == 0)) && isempty(locations2))
    %do nothing
    elseif isempty(find(shape(m,start1:stop1) == 0))
        start1 = start2;
        stop1 = stop2;
    end
    end
    shape(m,start1:stop1) = dose;
    start2 = start1;
    stop2 = stop1;
    locations2 = locations1;
end
