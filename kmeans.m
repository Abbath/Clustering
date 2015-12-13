function [cl] = kmeans(data, N, eps)
tic;
[dsize, n] = size(data);
centroids = rand(N, n);
cl = zeros(dsize, 1);
old_centroids = centroids + 1;
dists = zeros(1, N); 
while max(abs(old_centroids - centroids)) > eps
for i = 1:dsize
    for j = 1:N
        dists(j) = sqrt(sum((centroids(j, :)-data(i, :)) .^ 2));
    end
    cl(i) = find(dists == min(dists));
end
old_centroids = centroids;
for i = 1:N
    centroids(i, :) = mean(data(cl == i, :));
end
end
toc;
end

