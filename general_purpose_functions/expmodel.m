% [lambda, x, fest] = expmodel(X, density_limits, bwid , show)
%
% This function models the data in the vector X as a exponeltial
% distribution with parameter lambda.
%
% INPUT:
%
% X = data column vector;
% density_limits = vector with first entry representing the lower limit of
% the density function that will be calculated and the second entry
% representing the upper limit;
% bwid = histogram bin width
% show = 1 for plotting the density function;
%
% OUTPUT:
%
% lambda = parameter calculated for the data.
% x = vector with density_limits. Can be used for plotting the density
% function.
% fest = density function for x.
%
% Author: Paulo Passos  date: 11/06/2021

function [lambda, x, fest] = expmodel(X, density_limits, bwid , show)
    lambda = 1/mean(X);
    x = linspace(density_limits(1),density_limits(2),50000);
    fest = lambda*exp(-lambda*x);
    if show == 1
    h = histogram(X,'BinWidth',bwid);
    legend(['N =' num2str(length(X))])
    axis([0 max(X) 0 max(h.Values)])
    yyaxis right
    plot(x,fest,'r','LineWidth',1.5)
    axis([0 max(X) 0 max(fest)])
    legend({['$ \mathcal{E} (\hat{ \lambda} = ' num2str(lambda) ')$']}, 'Interpreter', 'latex')
    end
end