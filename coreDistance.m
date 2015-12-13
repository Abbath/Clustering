function [ cd ] = coreDistance( p, N, minPts )
if size(N, 1) < minPts
    cd = -1;
else
    dists = zeros(size(N)); 
    for i = 1:size(N, 1)
        dists(i) = dist(p, N(i, :));
    end
    sort(dists);
    cd = dists(minPts);
end

