function [ N , ids] = getNeighbors( p, data, eps )
    dists = zeros(size(data,1),1);
    for i = 1:size(data,1)
        dists(i) = dist(p, data(i,:));
    end
    ids = find((dists<eps) .* (dists>0));
    N = data(ids,:);
end

