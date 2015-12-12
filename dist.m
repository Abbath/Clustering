function [ d ] = dist( x, y )
d = sqrt(sum((x-y).^2));
end

