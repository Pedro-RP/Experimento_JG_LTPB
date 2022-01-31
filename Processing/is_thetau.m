% result = is_thetau(tau_est, tau)

% this function compares the estimated tau with the tau that should be
% estimated if learned
%
% INPUT:
% tau_est = a cell containing the contexts from the estimated tau
% tau = the tau that should be estimated if learned
%
% OUTPUT: 
% result = 1 if the estimated tau and tau are equal and 0 otherwise

function result = is_thetau(tau_est, tau)
  
if length(tau) ~= length(tau_est) 
    result = 0;
else
    checking = zeros(1,length(tau));
    for a = 1:length(tau)
       for b = 1: length(tau_est)
           if length(tau{1,a}) == length(tau_est{1,b})
           aux = zeros(1,length(tau{1,a}));
                for c = 1:length(tau{1,a})
                    if tau{1,a}(1,c) == tau_est{1,b}(1,c)
                    aux(1,c) = 1;
                    end
                end
                if sum(aux,2) == length(aux)
                   checking(1,a) = 1; 
                end
           else
           end
       end
    end
    if sum(checking,2) ==  length(checking)
       result = 1;
    else
       result = 0;
    end
end

end