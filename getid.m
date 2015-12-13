function [ id ] = getid( p, data )
comp=find(~any(bsxfun(@minus, data, p), 2));
id = comp(1);
end

