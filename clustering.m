n = 3;
dsize = 1000;
data = 100*randn(dsize,n);
data(1:500,:) = data(1:500,:) + 200;
data(500:600,:) = data(500:600,:) + 300;
[group, c] = dbscan(data, 40, 3);
for i = 1:c
    plot3(data(group==i,1),data(group==i,2),data(group==i,3),'.');
    hold on;
end
plot3(data(group==-1,1),data(group==-1,2),data(group==-1,3),'o');

dsize = 1000;
n = 5;
N = 3;
data = 100*randn(dsize,n);
data(1:333,:) = data(1:333,:) + 300;
data(334:666,:) = data(334:666,:) - 300;
[cl] = kmeans(data, N, 1e-5);
figure;
for i = 1:N
    plot3(data(cl==i,1), data(cl==i,2), data(cl==i,3),'.');
    hold on;
end

K = 15;
teta_n = 1;
teta_c = 20;
l = 200;
L = l;
Lmax = 1;
teta_s = 1;
dsize = 1000;
n = 3;
points = 100*randn(dsize,n);
points(1:333,:) = points(1:333,:) + 300;
points(334:666,:) = points(334:666,:) - 300;
[cl, N] = isodata(points, K, teta_n, teta_c, teta_s, Lmax, l);
figure;
for i = 1:N
   pts = points(cl==i,:);
   plot3(pts(:,1), pts(:,2), pts(:,3), '.'); 
   hold on;
end