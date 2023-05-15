% full_tree = full_tree_with_vertices(alphabet, height)
%
% The function returns a full tree with vertices as described in Balding
% 2009.
%
% INPUT:
% alphabet = a vector with the elements of the alphabet.
% height = integer that indicates the height of the tree.
%
% OUTPUT:
% full_tree = a cell containing the strings of the trees.
%
% Author: Paulo Roberto Cabral Passos Date: 10/04/23


function full_tree = full_tree_with_vertices(alphabet, height)

size_aux = 0;
    for a = 1:height
        size_aux = size_aux + length(alphabet)^a;
    end

full_tree = cell(1,size_aux); aux = 1;
    for h = 1:height
        new_strings = permwithrep(alphabet, h);
        for k = 1:size(new_strings,1)
            full_tree{1,aux} = new_strings(k,:);
            aux = aux+1;
        end
    end

end