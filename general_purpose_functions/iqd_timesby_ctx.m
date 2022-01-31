% [iqd_ctx, n_sample] = iqd_timesby_ctx(data, from, till, tree_file_address, ids, tau_id)
%
% This function returns the interquartil differencence of the response
% times from the participants identified in the list ids given a tree
% identified in tau_id.
%
%
% INPUT:
% data = data matrix from the function building_DataMatrix
% ids = a list of integers identifying the participants
% tree_file_address = file with the structure of tau_id
% from = from which sample of the response times it should pick.
% till = till which sample of the response times it should pick.
% tau_id = identifies which tree you want the sample
% normalize = 1 for normalizing the data.
%
% OUTPUT:
% iqd_ctx = a matrix that contains the interquartil difference of the
% response times of the context identified by the column and participant
% idenfied by the line.
% n_sample = gives for each context how many samples were used for the
% calculation.
% contexts = contexts of the tree
%
% Author: Paulo Roberto Cabral Passos
% Last Modified: 25/11/2020
% Status: Unchecked

function [iqd_ctx, n_sample, contexts] = iqd_timesby_ctx(data, from, till, tree_file_address, ids, tau_id, normalize)


for a = 1:length(ids)
[ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, ids(a), from, till, tree_file_address, 0, tau_id);
    if normalize == 1
       r_times = [];
       for c = 1:length(ctx_rtime)
           r_times = [r_times; ctx_rtime{c,1}]; %#ok<AGROW>
       end
       dnum = max(r_times) - min(r_times);
       num_term = min(r_times);
       for c = 1:length(ctx_rtime)
           ctx_rtime{c,1} = (ctx_rtime{c,1} - num_term)/dnum;
       end
    end
    if a == 1
        iqd_ctx = zeros(length(ids),length(contexts));
    end
    for b = 1:length(contexts)
       iqd_ctx(a,b) = prctile(ctx_rtime{b,1},75) - prctile(ctx_rtime{b,1},25);
    end
end

n_sample = zeros(length(contexts),1);
for a = 1:length(ctx_rtime)
   n_sample(a,1) =  length(ctx_rtime{a,1});
end

end



    
    