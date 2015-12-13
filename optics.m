function [ list, rdist, group, gid ] = optics( data, eps, minPts, minSize )
[dsize, n] = size(data);
rdist = -1 * ones(dsize, 1);
proc = zeros(dsize, 1);
list = [];
for i = 1:dsize
    if proc(i)
        continue;
    else
        [N, ids] = getNeighbors(data(i, :), data, eps);
        proc(i) = 1;
        list = [data(i, :), i; list];
        if coreDistance(data(i, :), N, minPts) ~= -1
            seeds = [];
            [seeds, rdist] = update(N, data(i, :), ids, proc, seeds, rdist, minPts);
            for j = 1:size(seeds, 1)
                [NN, ids] = getNeighbors(seeds(j, 1:n), data, eps);
                proc(getid(seeds(j, 1:n), data)) = 1;
                list = [seeds(j, 1:n), getid(seeds(j, 1:n), data); list];
                if coreDistance(seeds(j, 1:n), NN, minPts) ~= -1
                    [seeds, rdist] = update(NN, seeds(j, 1:n), ids, proc, seeds, rdist, minPts);
                end
            end
        end
    end
end
group = -1*ones(size(list, 1), 1);
gid = 1;
counter = 0;
tmp = rdist(list(:, n + 1));
for i = 2:size(tmp, 1)
    if tmp(i) <= tmp(i - 1)
        counter  = counter + 1;
    else
        if counter > minSize
            for j = i:-1:i+1-counter
                group(list(j, n + 1)) = gid;
            end
            gid = gid + 1;
        end
        counter = 0;
    end
end
end

