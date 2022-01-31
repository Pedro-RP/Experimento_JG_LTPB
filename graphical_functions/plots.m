% l  = plots(x,y,alpha,mcolor,color)
%
% This function performs a plot wiht mean (line) and standard error 
% (shaded area)
%
% INPUT:
%
% x = a line vector defining the x axis
% y = a matrix of line vectors
% mcolor = color of the mean
% color = color of the shaded area
%
% OUTPUT:
% l = handle of the line plot. Necessary for legends.
%
% Author: Paulo Roberto Cabral Passos; Last modified: 17/04/2020

function l  = plots(x,y,alpha,mcolor,color)



N = length(x);

ym = mean(y,1);
se = std(y,1)/sqrt(size(y,1));

yu = ym+se;

yl = ym-se;


for a = 1:length(ym)-1
X = [x(a), x(a), x(a+1), x(a+1)];
Y = [yl(a), yu(a), yu(a+1), yl(a+1)];
patch(X,Y, color,'EdgeColor',color,'FaceAlpha',alpha, 'EdgeAlpha', alpha/40)
end

hold on

l = stem(x,ym, mcolor,'.');

end