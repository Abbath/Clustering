function [ seeds ] = insert( p, nrd, seeds )
last = size(seeds, 2);
if isempty(seeds)
    seeds = [p, nrd];
    return;
end
vec = seeds(:, last);
idxs = find(vec > nrd);
if isempty(idxs)
    seeds = [seeds; p, nrd];
else
    idx = idxs(1);
    seeds = [seeds(1:idx - 1, :); p, nrd; seeds(idx:end, :)];
end
end

