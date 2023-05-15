% variable = generating_subtrees()
%
% Description
%
% INPUT:
% input1 = description
% input2 = description
%
% OUTPUT:
% output1 = description 
%
% Author: Paulo Roberto Cabral Passos Date: 10/04/23

function [tree_list, elements] = generating_subtrees(labeled_brothers, full_tree)

branch_comb = permwithrep([0 1], max(labeled_brothers));
tree_list = zeros( size(branch_comb,1), 1 );
elements = zeros( size(branch_comb,1), length(full_tree) );
wbar = waitbar(0, 'Computing the number of trees...please wait.');
for bc = 1:size(branch_comb,1)
    % picking a branch combination
    aux_list = branch_comb(bc,:);
    for a = 1:length(aux_list)
        if aux_list(1,a) == 1
           for w = 1:size(labeled_brothers,2)
               if labeled_brothers(1,w) == a
                  elements(bc,w) = 1;
               end
           end
        end
    end
    tree_aux = full_tree(find(elements(bc,:) == 1)); %#ok<FNDSB>
    
    % checking if the branch combination is a tree
    istree = isthisatree(tree_aux);
    tree_list(bc,1) = istree;
    waitbar( bc/size(branch_comb,1), wbar)
end
close(wbar)


end