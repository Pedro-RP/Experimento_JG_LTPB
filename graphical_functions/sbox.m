% sbox(A, x_name, y_name, tit, box_names,sig_dif, acsis, outl)
%
% Draw a boxplot columnwise from the data in the matrix A and 
% present samples around it. Also use komolgorov-smirnov test to verify
% differences between the distributions. If there are diferences between
% the distributions it shows a horizontal bar connecting the two
% distributions.
%
% INPUT:
% A = data matrix with different distributions in each column
% x_name = to name the xlabel
% y_name = to name the ylabel
% tit = to name the title
% box_names = cell structure to name the Ticks
% sig_dif = adjust for betther appearence of the significance identifier
% test = if equal 1, there will be a comparison of the distributions.
% acsis = change axis to the corresponding vector
% outl =  if (1) consider outliers
%
% Author: Paulo Roberto Cabral Passos
% Last Modified: 25/11/2020
% Checked:

function sbox(A, x_name, y_name, tit, box_names, test, sig_dif, acsis, outl)

set(0,'defaultfigurecolor',[1 1 1])
set(0, 'DefaultFigureRenderer', 'painters');

%figure('units','normalized','outerposition',[0 0 1 1])
hold
lw = 2;

A_rect = cell(1,size(A,2));
if outl == 1
    for a = 1:size(A,2)
        A_rect{1,a} = A(isoutlier(A(:,a)) == 0,a);
    end
else
    for a = 1:size(A,2)
        A_rect{1,a} = A(:,a);
    end
end


for a = 1:size(A,2)
    % Drawing the quartils
    q1 = prctile(A_rect{1,a},25);
    q3 = prctile(A_rect{1,a},75);
    x = linspace(a - 0.25,a + 0.25);
    y1 = q1*ones(1,length(x));
    y2 = q3*ones(1,length(x));
    plot(x,y1,'k','LineWidth',2)
    plot(x,y2,'k','LineWidth',2)
    w = linspace(q1,q3);
    x1 = (a-0.25)*ones(1,length(w));
    x2 = (a+0.25)*ones(1,length(w));
    plot(x1,w, 'k','LineWidth',2)
    plot(x2,w, 'k','LineWidth',2)
    % Drawing the Median
    y3 = median(A_rect{1,a})*ones(1,length(x));
    plot(x,y3, 'r','LineWidth',2)
    % Drawing upper whisker
    up_w = max(A_rect{1,a}); % testing
    y = linspace(prctile(A_rect{1,a},75),up_w);
    x = a*ones(1,length(y));
    plot(x,y, 'k','LineWidth',2)
    x = linspace(a - 0.125,a + 0.125);
    y = up_w*ones(1,length(x));
    plot(x,y, 'k','LineWidth',2)
    % Drawing lower whisker
    low_w = min(A_rect{1,a}); % testing
    y = linspace(prctile(A_rect{1,a},25),low_w);
    x = a*ones(1,length(y));
    plot(x,y, 'k','LineWidth',2)
    x = linspace(a - 0.125,a + 0.125);
    y = low_w*ones(1,length(x));
    plot(x,y, 'k','LineWidth',2)
    plot((a + 0.025*randn(1,size(A,1))), A(:,a), 'ob', 'MarkerSize', 5, 'MarkerFaceColor', 'b')
end

if test == 1
    compare = combnk(1:size(A,2),2);
    results = size(compare,1);

    for a = 1:size(compare,1)
       results(a) = kstest2( A_rect{1,compare(a,1)}, A_rect{1,compare(a,2)}  ,'Alpha',0.05);
    end

    n_bars = sum(results);

    border =  max(max(A))+sig_dif;
    for a = 1:length(results)
       if results(a) == 1
          x = linspace(compare(a,1),compare(a,2));
          y = border*ones(1,length(x));
          plot(x,y,'k','LineWidth',1)
          y = linspace(border-sig_dif/2, border);
          x = compare(a,1)*ones(1,length(y));
          plot(x,y,'k','LineWidth',1)
          x = compare(a,2)*ones(1,length(y));
          plot(x,y,'k','LineWidth',1)
          border = border + sig_dif;
       end
    end
end

ax = gca;
ax.XTick = 1:size(A,2);

for t = 1:length(ax.XTick)
    ax.XTickLabel{t,1} = box_names{t,1};
end

xlabel(x_name, 'FontSize',14)
ylabel(y_name, 'FontSize', 14)
title(tit, 'FontSize', 14)
ax.FontSize = 14;

if  length(acsis)> 1
axis([acsis])    
end

end
 

