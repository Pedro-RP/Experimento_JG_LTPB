% [past_series] = past_contexts(numpast, contexts, place, interval, ct_pos)
%
% This function returns the past contexts that occurred before each
% occurrence of the contexts;
%
% INPUT:
% numpast = and integer, indicates how many contexts you want from the past
% for each occurence.
% contexts = a line cell structure containing at each cell one of the
% contexts of the tree.
% place = indicates from which value you want to start atributing values to
% each context.
% interval = indicates the interval between the values that indicates each
% context.
% ct_pos = a matrix containig in each line the occurences a a context.
%
% OUTPUT:
% past_series = a cell structure containing at each cell a matrix of column
% at which the column index i idicates which context a appeared i symbols
% before that occurence.
%
% Author: Paulo Roberto Cabral Passos Last Modified: 22/04/2020

function [past_series] = past_contexts(numpast, contexts, place, interval, ct_pos)




past_series = cell(1,1);
for w = 1:length(contexts)
    oc_series = ct_pos(w,ct_pos(w,:) ~= 0)';
    past_series{w,1} = zeros(length(oc_series),numpast);
    for p = 1:numpast
    wseries = zeros(length(oc_series) ,1);
        for o = 1:length(oc_series) 
        pos = oc_series(o,1);
        f = 0;
            for ww = 1:length(contexts)
            ww_series = ct_pos(ww,ct_pos(ww,:) ~= 0)';
            f = find(ww_series == (pos-p),1);
                if f ~= 0
                    wseries(o,1) = ww*interval+place;
                    break
                end
            end
        end
    past_series{w,1}(:,p) = wseries;    
    end
end




end

