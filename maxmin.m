function [ group, c ] = maxmin( data )
tic;
data1 = data;
cl(1, :) = data(1, :);
data = data(2:end, :);
[dsize, ~] = size(data);
dists = zeros(dsize - 1, 1);
for i = 1:dsize
    dists(i) = dist(cl, data(i, :));
end
idx = dists==max(dists);
cl(2, :) = data(idx, :);
data(idx, :) = [];
c = 2;
L = dist(cl(1, :), cl(2, :));
while 1
    dists = zeros(c, dsize - c);
    mins = zeros(1, dsize - c);
    mx = 0;
    idx = 1;
    for i = 1:dsize-c
        mins(i) = dist(data(i, :), cl(1, :));
        for j = 1:c
            dists(j, i) = dist(cl(j, :), data(i, :));
            if dists(j, i) < mins(i)
                mins(i) = dists(j, i);
            end
            if mins(i) > mx
                mx = mins(i);
                idx = i;
            end
        end
    end
    if mx > 0.5 * L
        cl = [cl; data(idx, :)];
        data(idx, :) = [];
        L = (L * c - 1 + mx) / c;
        c = c + 1;
    else
        break;
    end
end
group = zeros(size(data1, 1), 1);
for i = 1:dsize
    dists = zeros(c, 1);
    for j = 1:c
        dists(j) = dist(cl(j, :), data1(i, :));
    end
    group(i) = find(dists == min(dists));
end
toc;
end

