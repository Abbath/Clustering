clear all;
close all;
dsize = 1000;
n = 3;
data = 100*randn(dsize,n);
data(1:500,:) = data(1:500,:) + 200;
data(500:600,:) = data(500:600,:) + 300;
L_min = 40;
kol = 3;
L = zeros(dsize, dsize);
rez = zeros(dsize,1);
marked = zeros(dsize,1);
group = zeros(dsize,1);
for i = 1:dsize
    for j = 1:dsize
        L(i,j) = sqrt(sum((data(i,:)-data(j,:)).^2)) <= L_min;
        if L(i,j)
            rez(i) = rez(i) + 1;
        end
    end
end
c = 1;
for i = 1:dsize
   if ~marked(i)
       if rez(i) < kol
           marked(i) = 1;
           group(i) = -1;
       else
           uvec = group;
           group(i) = c;
           while sum(uvec ~= group)
               uvec = group;
               for j = 1:dsize
                   if group(j) == c && marked(j) == 0
                       if rez(i) < kol
                           marked(j) = 1;
                           group(j) = -1;
                       else
                           marked(j) = 1;
                           for k = 1:dsize
                               if L(j,k) > 0
                                   group(k) = c; 
                               end
                           end
                       end
                   end
               end
           end
           c = c + 1;
       end
   else
       continue
   end
end
for i = 1:c-1
    plot3(data(group==i,1),data(group==i,2),data(group==i,3),'.');
    hold on;
end
plot3(data(group==-1,1),data(group==-1,2),data(group==-1,3),'o');
