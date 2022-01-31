% [uhat, sigmahat, x, fest] = lognormal_model(X, density_limits, bwid, show)
%
% This function models the data in the vector X as a lognormal distribution
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
% uhat = parameter calculated for the data.
% sigmahat = parameter calculated for the data.
% x = vector with density_limits. Can be used for plotting the density
% function.
% fest = density function for x.
%
% Author: Paulo Passos  date: 26/07/2021

function [uhat, sigmahat, x, fest] = lognormal_model(X, density_limits, bwid, show)
     
%      density_limits = [0 100]; bwid = 0.05; show = 1;
% %     % Generating gamma sample
%       u = 3;
%       sigma = 1;
%       X = lognrnd(u,sigma,1000,1);


    % Estimating parameters
    uhat = sum(log(X),1)/length(X);
    sigmahat = sqrt(sum( (log(X)- uhat).^2,1 )/length(X));
    
    x = linspace(density_limits(1),density_limits(2),1000);
    fest = (1./(x*sigmahat*sqrt(2*pi)));
    fest = fest.*exp( -( (log(x)-uhat).^2 )./( 2*(sigmahat^2) ) );
    if show == 1
    h = histogram(X,'BinWidth',bwid);
    legend(['N =' num2str(length(X))])
    axis([0 max(X) 0 max(h.Values)])
    yyaxis right
    plot(x,fest,'r','LineWidth',1.5)
    axis([0 max(X) 0 max(fest)])
    legend({['$Log-N (\mu{ k } = ' num2str(uhat,'%.2f') ',\hat{ \sigma } = ' num2str(sigmahat,'%.2f') ')$']}, 'Interpreter', 'latex')
    end

end