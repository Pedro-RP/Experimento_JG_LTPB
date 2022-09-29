% [] = qxqplot(X_obs, X_exp, q)
%
% This function provides the qqplot for the data given the sample observed 
% the sample from the hypothetized distribution.
%
% INPUT:
% X_obs = vector with the sample observed
% X_exp = vector with the sample from the hypothetized distribution
% q = number of quantiles.
%
% Author: Paulo Roberto Cabral Passos  Last Modified:  30/06/2021

function qxqplot(X_obs,X_exp,q)
    Qx = quantile(X_obs,q);Qnx = quantile(X_exp,q);
    plot(Qx, Qnx,'o','MarkerFaceColor','k','MarkerEdgeColor','k')
    hold on
    plot(linspace(0,max([Qx, Qnx])),linspace(0,max([Qx, Qnx])),'--r','LineWidth',1)
    xlim([0 max([Qx, Qnx])])
    ylim([0 max([Qx, Qnx])])
    h = gca;
    h.YTick = h.XTick;
    %grid on
    xlabel('quant. observed')
    ylabel('quant. expected')
    axis square
end