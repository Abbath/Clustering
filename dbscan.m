function [group, c] = dbscan(data, L_min, kol) 
dsize = size(data,1);
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
c = c - 1;
end

