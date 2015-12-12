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

N = 3;
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
[cl, N] = isodata(data, K, teta_n, teta_c, teta_s, Lmax, l);
figure;
for i = 1:N
   pts = data(cl==i,:);
   plot3(pts(:,1), pts(:,2), pts(:,3), '.'); 
   hold on;
end

[cl,c] = maxmin(data);
figure;
for i = 1:c
   pts = data(cl==i,:);
   plot3(pts(:,1), pts(:,2), pts(:,3), '.'); 
   hold on;
end

data = 100*randn(dsize,n);
data(1:500,:) = data(1:500,:) + 400;
[l,r,cl,c] = optics(data, 90, 3);
figure;
plot(r(l(:,4)));
figure;
for i = 1:c
   pts = l(cl==i,:);
   plot3(pts(:,1), pts(:,2), pts(:,3), '.'); 
   hold on;
end
plot3(l(cl==-1,1),l(cl==-1,2),l(cl==-1,3),'o');
