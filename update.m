function [ seeds, rdist ] = update( N, p, ids, proc, seeds, rdist, minPts )
coredist = coreDistance(p, N, minPts);
for i = 1:size(N,1)
    if ~proc(ids(i))
        nrd = max([coredist, dist(p,N(i,:))]);
        if rdist(ids(i)) == -1
            rdist(ids(i)) = nrd;
            seeds = insert(N(i,:), nrd, seeds); 
        else
            if nrd < rdist(ids(i))
                rdist(ids(i)) = nrd;
                seeds = moveup(N(i,:), nrd, seeds);
            end
        end
    end
end
end

