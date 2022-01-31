% [rt, chain] = data_for_simulation(tree_file_address, numtrials, alfa, s)
%
% This function generates a stochastic chain of tau and a simulated
% response time chain associated with it.
%
% INPUT:
%
% tree_file_address = file with the structure of the tree.
% numtrials = length of the chain
% alpha = the rt(w) ~ N(i*alpha, s), here i is a integer different for each
% context and s the standard deviantion.
% s = standard deviation of rt(w) ~ N(i*alpha, s)
%
% OUTPUT:
% rt = the response time chain
% chain = the stochastic chain


function [rt, chain] = data_for_simulation(tree_file_address, numtrials, alfa, s)

[contexts, PM, ~, ~] = build_treePM (tree_file_address);
   
if have_tmt(tree_file_address) == 1
[TMT, table,freq] = anytransition_mt(contexts, PM);
chain = stochastic_chain(contexts,TMT,freq, numtrials);  
else
chain = [];
    while isempty(chain)
    chain = without_TMT(tree_file_address,numtrials);
    end
end
[ct_posi, ct_pose, ctx_count] = count_contexts(contexts, chain);


rt = zeros(1,length(chain));
rt_dist = cell(1,length(contexts));
for a = 1: length(contexts)
ocur = ctx_count(a,1);
   for b = 1:ocur
      rt(ct_pose(a,b)+1) = a*alfa + s*randn(1); % define how close the distributions are.
      rt_dist{1,a} = [rt_dist{1,a}; rt(ct_pose(a,b)+1) ];
   end
end


end

% BACK-UP
% 
% % [rt, chain] = data_for_simulation(tau, alphal, ind, pind, numtrials, no_tmt)
% %
% % This function generates a stochastic chain of tau and a simulated
% % response time chain associated with it.
% %
% % INPUT:
% %
% % tau = cell with the contexts of tau
% % alphal = length of the alphabet
% % ind = indices of the probability matrix that are different from zero.
% % matrix with dimensions (M,2) where M is the number of entries in the
% % probability matrix with values different of zero.
% % pind = line vector with the M values of the probability matrix that are
% % different of zero.
% % numtrials = length of the chain
% % no_tmt = should be 1 if the tau doesn't have transition matrix
% %
% % OUTPUT:
% % rt = the response time chain
% % chain = the stochastic chain
% 
% 
% function [rt, chain] = data_for_simulation(tau, alphal, ind, pind, numtrials, no_tmt)
% 
%     % Generating a response_time chain for the simulation
% 
% %     tau = {0, [0 1], [1 1], 2};
% % 
% %     ind = [1,2; 2,2; 2,3; 3,1; 4,1];
% %     pind = [1, 0.25, 0.75, 1, 1];
% 
%     % The info above will be parameters
% 
%     PM = zeros(size(tau,2),alphal);
%         for a = 1:size(ind,1)
%             PM(ind(a,1),ind(a,2)) = pind(1,a);
%         end
%     if no_tmt == 0    
%     [TMT, table,freq] = anytransition_mt(tau, PM);
%     chain = stochastic_chain(tau,TMT,freq, numtrials);  
%     else
%     chain = [];
%         while isempty(chain)
%         chain = without_TMT(tau,ind, pind, numtrials, alphal);
%         end
%     end
%     [ct_posi, ct_pose, ctx_count] = count_contexts(tau, chain);
% 
% 
%     rt = zeros(1,length(chain));
%     rt_dist = cell(1,length(tau));
%         for a = 1: length(tau)
%           ocur = ctx_count(a,1);
%               for b = 1:ocur
%                  rt(ct_pose(a,b)+1) = a*5 + randn(1);
%                  rt_dist{1,a} = [rt_dist{1,a}; rt(ct_pose(a,b)+1) ];
%               end
%         end
% 
% show = 0;        
% if show == 1
%    for a = 1:length(tau)
%    histogram(rt_dist{1,a})
%    hold all
%    end
% end
% 
% end