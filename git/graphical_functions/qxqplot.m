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
    plot(linspace(min([Qx, Qnx]),max([Qx, Qnx])),linspace(min([Qx, Qnx]),max([Qx, Qnx])),'--r','LineWidth',1)
    xlim([min([Qx, Qnx]) max([Qx, Qnx])])
    ylim([min([Qx, Qnx]) max([Qx, Qnx])])
    h = gca;
    h.YTick = h.XTick;
    %grid on
    xlabel('$Q_{obs}$','Interpreter','latex','FontSize',13)
    ylabel('$Q_{exp}$','Interpreter','latex','FontSize',13)
    axis square
end