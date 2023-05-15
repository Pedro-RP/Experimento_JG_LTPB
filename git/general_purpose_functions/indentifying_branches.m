% labeled_brothers = indentifying_branches(full_tree)
%
% The function identifies with branches of the function
% full_tree_with_vertices are labeled_brothers of each other.
%
% INPUT:
% full_tree = full_tree output of the function full_tree_with_vertices.
% height = integer that indicates the height of the full tree.
%
% OUTPUT:
% labeled_brothers = vector of integers that identifies which strings are
% labeled_brothers in full_tree.
%
% Author: Paulo Roberto Cabral Passos Date: 10/04/23


function labeled_brothers = indentifying_branches(full_tree, height)

l = length(full_tree);
level = height-1;
labeled_brothers = zeros(1,l);

while level ~= 0
      for a = 1:l
          for b = 1:l
             if b ~= a
                if length(full_tree{1,b}) == ( length(full_tree{1,a})+1 )
                   if sufix_test(full_tree{1,a}, full_tree{1,b})
                      labeled_brothers(1,b) = a; 
                   end
                end
             end
          end
      end
      level = level-1;
end

labeled_brothers = labeled_brothers + 1;

end