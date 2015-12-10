clear all;
close all;
dsize = 1000;
n = 5;
N = 3;
data = 100*randn(dsize,n);
data(1:333,:) = data(1:333,:) + 300;
data(334:666,:) = data(334:666,:) - 300;
centroids = rand(N,n);
cl = zeros(dsize,1);
old_centroids = centroids + 1;
eps = 1e-4;
dists = zeros(1,N); 

while max(abs(old_centroids - centroids)) > eps
for i = 1:dsize
    for j = 1:N
        dists(j) = sqrt(sum((centroids(j,:)-data(i,:)).^2));
    end
    cl(i) = find(dists == min(dists));
end
old_centroids = centroids;
for i = 1:N
    centroids(i,:) = mean(data(cl==i,:));
end
end
for i = 1:N
    plot3(data(cl==i,1), data(cl==i,2), data(cl==i,3),'.');
    hold on;
end
