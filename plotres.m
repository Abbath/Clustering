function [ ] = plotres( data, cl, c, n, t )
h = colormap(jet(c));
switch n
    case 3
        figure('Name',t);
        plot3(data(cl==1,1),data(cl==1,2),data(cl==1,3),'.', 'Color', h(1, :));
        hold on;
        for i = 2:c
            plot3(data(cl==i,1),data(cl==i,2),data(cl==i,3),'.', 'Color', h(i, :));
        end
        plot3(data(cl==-1,1),data(cl==-1,2),data(cl==-1,3),'o');
    case 2
        figure('Name',t);
        plot(data(cl==1,1),data(cl==1,2),'.', 'Color', h(1, :));
        hold on;
        for i = 2:c
            plot(data(cl==i,1),data(cl==i,2),'.', 'Color', h(i, :));
        end
        plot(data(cl==-1,1),data(cl==-1,2),'o');
    otherwise
end

