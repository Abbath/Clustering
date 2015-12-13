function [ ] = plotres( data, cl, c, n, t )
switch n
    case 3
        figure('Name',t);
        for i = 1:c
            plot3(data(cl==i,1),data(cl==i,2),data(cl==i,3),'.');
            hold on;
        end
        plot3(data(cl==-1,1),data(cl==-1,2),data(cl==-1,3),'o');
    case 2
        figure('Name',t);
        for i = 1:c
            plot(data(cl==i,1),data(cl==i,2),'.');
            hold on;
        end
        plot(data(cl==-1,1),data(cl==-1,2),'o');
    otherwise
end

