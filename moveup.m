function [ seeds ] = moveup( p, nrd, seeds)
last = size(seeds, 2);
if isempty(seeds)
    seeds = insert(p, nrd, seeds);
    return
end
for i = 1:size(seeds, 1);
    if prod(seeds(i, 1:last - 1) == p)
        seeds(i, :) = [];
        break;
    end
end
seeds = insert(p, nrd, seeds);
end

