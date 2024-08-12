function dgrid2 = refgrid(dgrid,M,N);

sz = size(M);
dgrid2 = cell(sz(1),sz(2));
for m = 1:sz(1)
    for n = 1:sz(2)        
        dgrid2{m,n} = dgrid{M(m,n),N(m,n)};
    end
end