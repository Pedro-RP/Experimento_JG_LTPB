% [mu, sigma, x, fest] = normal_model(X, density_limits, bwid, show)
%
% This function models the data in the vector X as a normal distribution
% distribution with parameters mu and sigma.
%
% INPUT:
%
% X = data column vector;
% density_limits = vector with first entry representing the lower limit of
% the density function that will be calculated and the second entry
% representing the upper limit;
% bwid = bin width for the histogram;
% show = 1 for plotting the density function;
%
% OUTPUT:
%
% mu = parameter calculated for the data.
% sigma = parameter calculated for the data.
% x = vector with density_limits. Can be used for plotting the density
% function.
% fest = density function for x.
%
% Author: Paulo Passos  date: 11/06/2021

function [mu, sigma, x, fest] = normal_model(X, density_limits, bwid, show)

    mu = mean(X);
    sigma = sqrt(var(X)); % sigma = sqrt(var(X,1));
    x = linspace(density_limits(1),density_limits(2),1000);
    fest = (1/(sigma*sqrt(2*pi)))*exp(- (1/2)*( ((x - mu).^2)./(sigma.^2) ) );
    if show == 1
    h = histogram(X,'BinWidth',bwid);
    legend(['N =' num2str(length(X))])
    axis([0 max(X) 0 max(h.Values)])
    yyaxis right
    plot(x,fest,'r','LineWidth',1.5)
    axis([0 max(X) 0 max(fest)])
    legend({['$N(\hat{ \mu} = ' num2str(mu) ',\hat{ \sigma } = ' num2str(sigma) '))$']}, 'Interpreter', 'latex')
    end

end