% d = balding_distance(tree_a,tree_b, alphabet, height)
%
% This function computes the distance between to trees according to Balding
% et al. Limit theorems for sequences of random trees. 2009.
%
% INPUT:
% tree_a = row cell containing the contexts of tree A.
% tree_b = row cell containing the contexts of tree B.
% alphabet = row vector containing the alphabet of the trees.
% height = maximum tree height across the trees.
%
% OUTPUT:
% d = balding distance. 

function d = balding_distance(tree_a,tree_b, alphabet, height)

[~, velements_a] = build_verticetree(alphabet, tree_a, height);
[string_set, velements_b] = build_verticetree(alphabet, tree_b, height);

z = round(length(alphabet)^(-3/2),3);

d = 0;
for s = 1:length(string_set)
    d = d + abs( velements_a(s)-velements_b(s) )*z^( length(string_set{1,s}) );
end

end