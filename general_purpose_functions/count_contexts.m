% [ct_posi, ct_pose, ctx_count] = count_contexts(contexts, chain)
%
% This function counts the number of contexts in a chain
% contexts =  cell with the contexts.
% chain = is the chain in which the contexts will be counted
% ctx_count = the counting of the contexts ordered in correspondence with
% the contexts cell.
% ct_posi = matrix with the starting position of every occurence (column) of the
% context (line), organized on the same order as contexts
% ct_pose = matrix with the ending position of every occurence (column) of the
% context (line), organized on the same order as contexts
% of the context;


function [ct_posi, ct_pose, ctx_count] = count_contexts(contexts, chain)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = size(contexts,2);

ctx_count = zeros(N,1);

S = length(chain);
ct_posi = zeros(S,S);
ct_pose = zeros(S,S);

for a = 1: N
    lc = length(contexts{1,a}); aux = contexts{1,a};
    b = lc;
    d = 1;dc = 1;
    while b < S
        ul = b;
        ll = b-lc+1; 
        if strcmp(num2str(chain(1, ll:ul)), num2str(aux)) 
        ctx_count(a,1) = ctx_count(a,1)+1;
        ct_posi(a,dc) = d; ct_pose(a,dc) = b;dc = dc+1;
        end
    d = d+1;    
    b = b+1;    
    end    
end



end

