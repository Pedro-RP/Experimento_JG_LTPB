% shadedplot(x,y,lcolor,scolor,intitle, inx, iny, acsis)
%
% Return the line plot with shaded area corresponding to the STD.
% x = horizontal axis (ex. evolution in time)
% y = matrix of column vectors. (ex. each column vector contains data of a set in a specific time)
% lcolor = color of the line.
% scolor = color of the shaded area.
% intitle = string with the title of the plot
% inx = string with the x label
% iny = string with the y label
% acsis = boundries of the plot

function shadedplot(x,y,lcolor,scolor,intitle, inx, iny, acsis)


disp = std(y,1,2); %/sqrt(size(y,2));
means = mean(y,2);

lo = means - disp;
hi = means + disp;

hp = patch([x; x(end:-1:1); x(1)], [lo; hi(end:-1:1); lo(1)], 'r');
hold on;
hl = plot(x,means, '.'); % hl = line(x,means);

set(hp, 'facecolor', scolor, 'edgecolor', 'none');
set(hl, 'color', lcolor);
title(intitle)
xlabel(inx)
ylabel(iny)
axis(acsis)

end