% [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, id, from, till, tree_file_address, show, tau) 
%
% This function provides the response times, errors for each context of the
% requested tree of a given subject.
%
% Input
% data: organized data as in responsetimeandresponses
% id: alternative id of the participant
% from: starting at the play
% till: ending in the play
% tree_file_address: adress with the tree information
% show: (1) indicates plotting and (0) not plotting
% tau = number that identifies the tree in the experiment
%
% Output:
% ctx_rtime: cells with the response time organized by context (cell type)
% ctx_er: cells with the error organized by context (cell type)
% ctx_resp: cells with the responses organized by context (cell type)
% contexts: contexts of the evaluated tree.
% ctxrnds: for each context indicate if the response is deterministic (0)
% or not
% ct_pos: a column cell containing at each entry the information about at
% wich positions a context appeared.
%
% Author: Paulo Roberto Cabral Passos Last Modified: 21/04/2020

function [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx_v2(data, id, from, till, tree_file_address, show, tau, contexts) 

% Gathering Tree information

[~, ~, tresp, ctxrnds] = build_treePM(tree_file_address);

start = 0;
for a = 1: size(data,1)
    if (data(a,3) == 1)&&((data(a,6) == id)&&(data(a,5) == tau))
        start = a;
    end
end

start = start + from -1;
%disp(['starting at:' num2str(start)])

if start == 0
   ctx_rtime = cell(length(contexts),1); 
   ctx_er = cell(length(contexts),1);
   ctx_resp = cell(length(contexts),1);
   ct_pos = [];
   return;
else
    over = start + (till-from); 
    %disp(['ending at:' num2str(over)])
    % Feeding count_contexts

    chain = data(start:over, 9);
    response = data(start:over, 8);
    time = data(start:over,7);

    [~,ct_pos, ctx_count] = count_contexts(contexts, chain');

    % Dividing response times per context

    ctx_rtime = cell(length(contexts),1); % for the storage of the response time per context
    ctx_er = cell(length(contexts),1); % for the storage of the error per context
    ctx_resp = cell(length(contexts),1); % for the storage of the response
    
    er = 0;
    for a = 1:length(contexts)
       auxr_ctx = [];
       auxe_ctx = [];
       auxresp_ctx = [];
       for b = 1:size(ct_pos,2)
           if (ct_pos(a,b) ~= 0)&&(ct_pos(a,b) ~= 102)
           auxr_ctx = [auxr_ctx; time(ct_pos(a,b)+1,1)]; %#ok<AGROW>
           auxresp_ctx = [auxresp_ctx; response(ct_pos(a,b)+1,1)]; %#ok<AGROW>
           er = response(ct_pos(a,b)+1,1)~= chain(ct_pos(a,b)+1,1);
           auxe_ctx = [auxe_ctx; er]; %#ok<AGROW>
           end
       end
       ctx_rtime{a,1} = auxr_ctx;
       ctx_er{a,1} = auxe_ctx;
       ctx_resp{a,1} = auxresp_ctx;
    end

    if show == 1
        % PLOTTING

        % Defining parameters for the axis:

        aux = []; aux2 = [];
        for a = 1:length(contexts)
           aux = [aux; ctx_rtime{a,1}];      %#ok<AGROW>
           aux2 = [aux2; length(ctx_rtime{a,1})]; %#ok<AGROW>
        end

        max_t = mean(aux)+3*std(aux); 
        max_trial = max(aux2);
        lines = 3;
        columns = 3;

        ccode = 'rmbgyc';

        figure
        for a = 1:length(contexts)
            subplot(lines,columns,a)
            plot(1:length(ctx_rtime{a,1}), ctx_rtime{a,1}, ccode(1,tau))
            axis([1 size(ctx_rtime{a,1},1) 0 max_t]) %axis([0 max_trial 0 max_t])
            xlabel('ocorrência')
            ylabel('tempo (seg.)')
            title(num2str(contexts{1,a}))
        end
        
        figure
        for a = 1:length(contexts)
            subplot(lines,columns,a)
            plot(1:length(ctx_er{a,1}), ctx_er{a,1}, ccode(1,tau))
            axis([1 size(ctx_er{a,1},1) 0 max_t]) %axis([0 max_trial 0 max_t])
            xlabel('ocorrência')
            ylabel('error')
            title(num2str(contexts{1,a}))
        end
        
    end
end



end

