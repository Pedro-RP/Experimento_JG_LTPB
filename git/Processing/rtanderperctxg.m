% [gctxtime, gctxer, gctxresp, contexts, ctxrnds, ct_pos] = rtanderperctxg(data, tau, from, till, cidinmat, show) 
%
% this function provides the response times for each context of the
% requested tree.
%
% Input
% data: organized data as in responsetimeandresponses
% from: starting at the play
% till: ending in the play
% tau: number that identifies the tree
% show: (1) indicates plotting and (0) not plotting the behaviour of the
% response time
% cidinmat: ids to be considered
%
% Output:
% gctxtime: cells with the response time of all participants organized by context (cell type)
% gctxer: cells with the error of all participants organized by context (cell type)
% contexts: contexts of the evaluated tree.
% ctxrnds: for each context indicate if the response is deterministic (0)
% or not
% ct_pos: a column cell containing at each entry the information about at
% wich positions a context appeared.
%
% Author: Paulo Roberto Cabral Passos Last Modified: 21/04/2020


function [gctxtime, gctxer, gctxresp, contexts, ctxrnds, ct_pos] = rtanderperctxg(data, tau, from, till, cidinmat, show) 

% trees:

tau1 = {0 , 2 , [0 1], [1 1]};
tau2 = {0 , 2, [0 0 1], [1 0 1], [2 0 1], [1 1]};
tau3 = {[ 0 0], [1 0], [2 0], 1, [0 2], [1 2], [2 2]};
tau4 = {0 , [0 1] , [2 1], 2};
tau5 = {2, [2 1], [2 0], [1 0], [0 1], [2 0 0], [1 0 0], [0 0 0]};
tau6 = {2 , [2 1], [2 0], [1 1], [1 0], [0 1], [0 0]};

% randomness

tau1rnd = [0 , 0, 1, 0];
tau2rnd = [1, 0, 0, 0, 0, 0];
tau3rnd = [0, 0, 0, 1, 0, 0, 0];
tau4rnd = [1, 0, 0, 1];
tau5rnd = [1, 0, 0, 1, 0, 1, 0, 0];
tau6rnd = [1, 1, 1, 0, 0, 0, 0];

eval(['contexts = tau' num2str(tau) ';'])
eval(['ctxrnds = tau' num2str(tau) 'rnd;'])

nid = max(data(:,6));

gctxtime = cell(length(contexts),1);
gctxer = cell(length(contexts),1);
gctxresp = cell(length(contexts),1);

for a = 1:nid
   pass = 0;
   [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds,ct_pos] = rtanderperctx(data, a, from, till, tau, 0);
    for c = 1:length(contexts)
        pass = isempty(ctx_rtime{c,1});
        if pass == 1
            break;
        end
    end
   pass = isempty(find(cidinmat == a)); 
   if pass == 0
       for b = 1: length(contexts)   
       gctxtime{b,1} = [gctxtime{b,1} ctx_rtime{b,1}];
       gctxer{b,1} = [gctxer{b,1} ctx_er{b,1}];
       gctxresp{b,1} = [gctxresp{b,1} ctx_resp{b,1}];
       end       
   end
end

% Add a plotting option

ccode = 'rmbgyc';

max_t = 0;



if show == 1
figure
    for b = 1:length(contexts)
        max_tree = mean(mean(gctxtime{b,1}))+3*std(std(gctxtime{b,1})); 
        if max_tree > max_t
           max_t = max_tree; 
        end
    end
    for a = 1:length(contexts)
        subplot(3,3,a)
        shadedplot([1:size(gctxtime{a,1},1)]',gctxtime{a,1},ccode(1,tau),[0.75 0.75 0.75], num2str(contexts{1,a}), 'ocorrência', 'tempo (seg.)', [1 size(gctxtime{a,1},1) 0 max_t])
    end
end

% You should implment the plotting option resuming the error behaviour
% latter. (Pending)

end


% % OLDER VERSION FOR BACKUP
% 
% % [gctxtime, gctxer, contexts, ctxrnds] = rtanderperctxg(data, tau, from, till, cidinmat, show)
% %
% % this function provides the response times for each context of the
% % requested tree.
% %
% % Input
% % data: organized data as in responsetimeandresponses
% % from: starting at the play
% % till: ending in the play
% % tau: number that identifies the tree
% % show: (1) indicates plotting and (0) not plotting the behaviour of the
% % response time
% % cidinmat: ids to be considered
% %
% % Output:
% % gctxtime: cells with the response time of all participants organized by context (cell type)
% % gctxer: cells with the error of all participants organized by context (cell type)
% % contexts: contexts of the evaluated tree.
% % ctxrnds: for each context indicate if the response is deterministic (0)
% % or not
% 
% 
% function [gctxtime, gctxer, contexts, ctxrnds] = rtanderperctxg(data, tau, from, till, cidinmat, show) %#ok<STOUT>
% 
% % trees:
% 
% tau1 = {0 , 2 , [0 1], [1 1]};
% tau2 = {0 , 2, [0 0 1], [1 0 1], [2 0 1], [1 1]};
% tau3 = {[ 0 0], [1 0], [2 0], 1, [0 2], [1 2], [2 2]};
% tau4 = {0 , [0 1] , [2 1], 2};
% tau5 = {2, [2 1], [2 0], [1 0], [0 1], [2 0 0], [1 0 0], [0 0 0]};
% tau6 = {2 , [2 1], [2 0], [1 1], [1 0], [0 1], [0 0]};
% 
% % randomness
% 
% tau1rnd = [0 , 0, 1, 0];
% tau2rnd = [1, 0, 0, 0, 0, 0];
% tau3rnd = [0, 0, 0, 1, 0, 0, 0];
% tau4rnd = [1, 0, 0, 1];
% tau5rnd = [1, 0, 0, 1, 0, 1, 0, 0];
% tau6rnd = [1, 1, 1, 0, 0, 0, 0];
% 
% eval(['contexts = tau' num2str(tau) ';'])
% eval(['ctxrnds = tau' num2str(tau) 'rnd;'])
% 
% nid = max(data(:,6));
% 
% gctxtime = cell(length(contexts),1);
% gctxer = cell(length(contexts),1);
% 
% for a = 1:nid
%    pass = 0;
%    [ctx_rtime, ctx_er, contexts, ctxrnds] = rtanderperctx(data, a, from, till, tau, 0);
%     for c = 1:length(contexts)
%         pass = isempty(ctx_rtime{c,1});
%         if pass == 1
%             break;
%         end
%     end
%    pass = isempty(find(cidinmat == a)); 
%    if pass == 0
%        for b = 1: length(contexts)   
%        gctxtime{b,1} = [gctxtime{b,1} ctx_rtime{b,1}];
%        gctxer{b,1} = [gctxer{b,1} ctx_er{b,1}];
%        end       
%    end
% end
% 
% % Add a plotting option
% 
% ccode = 'rmbgyc';
% 
% max_t = 0;
% 
% 
% 
% if show == 1
% figure
%     for b = 1:length(contexts)
%         max_tree = mean(mean(gctxtime{b,1}))+3*std(std(gctxtime{b,1})); 
%         if max_tree > max_t
%            max_t = max_tree; 
%         end
%     end
%     for a = 1:length(contexts)
%         subplot(3,3,a)
%         shadedplot([1:size(gctxtime{a,1},1)]',gctxtime{a,1},ccode(1,tau),[0.75 0.75 0.75], num2str(contexts{1,a}), 'ocorrência', 'tempo (seg.)', [1 size(gctxtime{a,1},1) 0 max_t])
%     end
% end
% 
% % You should implment the plotting option resuming the error behaviour
% % latter. (Pending)
% 
% end