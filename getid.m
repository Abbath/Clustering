function [ id ] = getid( p, data )
id = -1;
for i = 1:size(data,1)
    if prod(data(i,:)==p)
        id = i;
        break;
    end
end
end

