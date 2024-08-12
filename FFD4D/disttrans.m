function distance = disttrans(coords,size)

distance = zeros(size);

for m = 1:size(1)
    for n = 1:size(2)
        distances = sqrt((coords(:,2)-m +1).^2 + (coords(:,1)-n +1).^2);
        distance(m,n) = min(distances);
    end
end