% [beta_0, beta_1, Px] = regression_to_logit(x,y)
%
% This function performs a regression to the logistic function given the
% predictor x, a vector, and the predicted y, also a vector. The values are
% normalized to upperl

% Author: Paulo Roberto Cabral Passos Last Modified: 05/08/2020



function [beta_0, beta_1, Px] = regression_to_logit(x,y,upperl)

y = y/max(upperl);
Fy = -log((1-y)./y);
yy = Fy(find(isinf(Fy) == 0)); %#ok<FNDSB>
xx = x(find(isinf(Fy) == 0)); %#ok<FNDSB>
[beta_0, beta_1,~, ~, ~, ~] = slinearwithpear(xx,yy, 0.05);
Px = zeros(1,length(x));
    for a = 1:length(x)
    Px(a) = (1/(1+exp(-(beta_0+beta_1*x(a)))));
    end

end



% % The code bellow illustrates how the function works
% 
% close all
% 
% x = [-10:0.1:20];
% y = zeros(1,length(x));
% for a = 1:length(x)
%     y(a) = 100*(1/(1+exp(-(2 + 3*x(a)))));
% end
% 
% y = y/max(y);
% 
% plot(x,y,'o','MarkerFace','red')
% 
% Y = -log((1-y)./y);
% 
% subplot(1,3,1)
% plot(x,y)
% subplot(1,3,2)
% plot(x,Y)
% 
% yy = Y(find(isinf(Y) == 0));
% xx = x(find(isinf(Y) == 0));
% 
% [alfa, beta,r, tcrit, tcalc, p] = slinearwithpear(xx,yy, 0.05);
% 
% z = zeros(1,length(x));
% for a = 1:length(x)
% z(a) = (1/(1+exp(-(alfa+beta*x(a)))));
% end
% 
% subplot(1,3,3)
% plot(x,y,'o--')
% hold on
% plot(x,z,'r')
