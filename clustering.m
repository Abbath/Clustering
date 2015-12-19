n = 3;
%Input data 1000 3-dimentional samples
dsize = 1000;
data = 100*rand(dsize, n);
data(1:500,:) = data(1:500, :) + 200;
data(500:600,:) = data(500:600, :) + 300;
[group, c] = dbscan(data, 40, 3);
plotres(data, group, c, n, 'dbscan');

N = 3;
[cl] = kmeans(data, N, 1e-5);
plotres(data, cl, N, n, 'kmeans');

K = 15;
teta_n = 1;
teta_c = 20;
l = 200;
L = l;
Lmax = 1;
teta_s = 1;
[cl, N] = isodata(data, K, teta_n, teta_c, teta_s, Lmax, l);
plotres(data, cl, N, n, 'isodata');

[cl,c] = maxmin(data);
plotres(data, cl, c, n, 'maxmin');

data = 100*randn(dsize, n);
data(1:500,:) = data(1:500, :) + 400;
[l, r, cl, c] = optics(data, 90, 3, 25);
figure;
plot(r(l(:, 4)));
plotres(l, cl, c, n, 'optics');
