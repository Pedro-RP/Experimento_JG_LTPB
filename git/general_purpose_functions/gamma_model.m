% [khat, thetahat, x, fest] = gamma_model(X, density_limits, bwid, show)
%
% This function models the data in the vector X as a gamma distribution
% distribution with parameters k and theta.
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
% khat = parameter calculated for the data.
% thetahat = parameter calculated for the data.
% x = vector with density_limits. Can be used for plotting the density
% function.
% fest = density function for x.
% it = number of iterations.
%
% Author: Paulo Passos  date: 26/07/2021

function [khat, thetahat, x, fest, it] = gamma_model(X, density_limits, bwid, show)
     
%     density_limits = [0 30]; bwid = 0.05; show = 1;
%     % Generating gamma sample
%     k = 5;
%     theta = 2;
%     X = gamrnd(k,theta,1000,1);

    % Estimating parameters
    k0 = 10^(-100);
    logmean = sum(log(X),1)/length(X);

    d = 100-k0; it = 0;
    while (d > 10^(-10))&&(it<1000)
    gamahat = logmean - log(mean(X,1)) + log(k0);
    khat = invpsi(gamahat);
    d = abs(khat-k0);
    k0 = khat;
    it = it+1;
    end

    thetahat = mean(X,1)/khat;
    
    x = linspace(density_limits(1),density_limits(2),1000);
    fest = ( (x.^(khat-1)).*exp(-x./thetahat) )/( gamma(khat)*(thetahat^khat) );
    if show == 1
    h = histogram(X,'BinWidth',bwid);
    legend(['N =' num2str(length(X))])
    axis([0 max(X) 0 max(h.Values)])
    yyaxis right
    plot(x,fest,'r','LineWidth',1.5)
    axis([0 max(X) 0 max(fest)])
    legend({['$\Gamma (\hat{ k } = ' num2str(khat,'%.2f') ',\hat{ \theta } = ' num2str(thetahat,'%.2f') ')$']}, 'Interpreter', 'latex')
    end

end