function [cl, N] = isodata(data, K, teta_n, teta_c, teta_s, Lmax, l)
tic;
%one
L = l;
[dsize, n] = size(data);
N = 1;
cl = zeros(dsize, 1);
centroids = zeros(N, n);
number = -2 .* ones(N, 1);
%two
while l
    dists = zeros(1, N);
    for i = 1:dsize
        for j = 1:N
            dists(j) = dist(centroids(j, :), data(i, :));
        end
        cl(i) = find(dists == min(dists));
    end
    %three
    i = 1;
    while i <= N
        if size(cl(cl == i), 1) < teta_n
            cl(cl == i) = 0;
            cl(cl > i) = cl(cl > i)-1;
            centroids(i, :) = [];
            number(i) = [];
            number(number > i) = number(number > i) - 1;
            N = N - 1;
        else
            i = i + 1;
        end
    end
    %four
    for i = 1:N
        centroids(i, :) = mean(data(cl == i, :));
    end
    %five
    d = zeros(N, 1);
    for i = 1:N
        pts = data(cl == i, :);
        for j = 1:size(pts, 1)
            d(i) = d(i) + dist(pts(j, :), centroids(i, :));
        end
        if ~isempty(pts)
            d(i) = d(i) / size(pts, 1);
        end
    end
    %six
    D = 0;
    for i = 1:N
        D = D + d(i) * size(data(cl == i, :), 1);
    end
    D = D / size(data, 1);
    %seven
    if ~l
        teta_c = 0;
    elseif N <= K/2 && ~(l == L || N >= K*2)
        %eight
        sigma = zeros(N, n);
        for i = 1:N
            pts = data(cl == i, :);
            for j = 1:size(pts, 1)
                sigma(i, :) = sigma(i, :) + (centroids(i, :) - pts(j, :)) .^ 2;
            end
            if ~isempty(pts)
                sigma(i, :) = sqrt(sigma(i, :) ./ size(pts, 1));
            end
        end
        %nine
        max_sigma = zeros(N, 2);
        for i = 1:N
            max_sigma(i, 2) = max(sigma(i, :));
            ix = find(sigma(i, :) == max_sigma(i, 2));
            max_sigma(i, 1) = ix(1);
        end
        %ten
        split = 0;
        add = 0;
        i = 1;
        msl = N;
        while i <= msl
            if max_sigma(i, 2) > teta_s && ((d(i) > D && size(data(cl == i + add, :), 1) > 2*(teta_n + 1)) || N <= K / 2 )
                centroids(i + add, max_sigma(i, 1)) = centroids(i + add, max_sigma(i, 1)) + 0.5  * max_sigma(i, 2);
                t = centroids(i + add, :);
                t(max_sigma(i, 1)) = t(max_sigma(i, 1)) - 0.5 * max_sigma(i, 2);
                centroids = [centroids(1:i-1, :); t; centroids(i:N, :)];
                N = N + 1;
                split = 1;
                add = add + 1;
            end
            i = i + 1;
        end
        if split
            number = (1:N)';
            cl = zeros(dsize, 1);
            l = l - 1;
            continue
        end
    end
    %eleven
    distances = [];
    for i = 1:N
        for j = i+1:N
            if sqrt(sum((centroids(i, :)-centroids(j, :)) .^ 2)) < teta_c
                tmp = [i j dist(centroids(i, :), centroids(j, :))];
                distances = [distances; tmp];
            end
        end
    end
    %twelve
    if ~isempty(distances)
        [~, order] = sort(distances(:, 3));
        distances = distances(order, :);
    end
    %thirteen
    empty = zeros(1, n);
    l = l - 1;
    if ~isempty(distances)
        le = size(distances, 1);
        if Lmax < le
            le = Lmax;
        end
        for i = 1:le
            fst = distances(i, 1);
            snd = distances(i, 2);
            flen = size(data(cl==fst, :), 1);
            slen = size(data(cl==snd, :), 1);
            cl1 = (centroids(fst, :) .* flen + centroids(fst, :) .* snd) ./ (flen + slen);
            if number(snd) ~= -1 && number(fst) ~= -2
                centroids(snd, :) = cl1;
                centroids(fst, :) = empty;
                number(snd) = -1;
                number(fst) = -2;
            end
        end
        i = 1;
        while i <= N
            if l
                cl(cl == i) = 0;
            end
            if number(i) == -2
                centroids(i, :) = [];
                cl(cl > i) = cl(cl > i) - 1;
                number(i) = [];
                N = N - 1;
                i = i - 1;
            else
                number(i) = i;
            end
            i = i + 1;
        end
    end
    %fourteen
    if ~l
        break
    end
end
toc;
end