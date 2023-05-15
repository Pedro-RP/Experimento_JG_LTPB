% [string_set, velements] = build_verticetree(alphabet, tree, height)
%
% the function returns the vertice tree from the tree.
%
% INPUT:
% alphabet = vector with the alphabet of the tree
% tree = row cell with the contexts of the tree
% height = maximum height to be considered in the string_set of the
% vertices
%
% OUTPUT:
% string_set = row cell with all possible vertices in a tree of the given
% height
% velements = vector of zeros(absent) and ones (present) corresponding to
% the vertices in the string_set.
%
% author: Paulo Roberto Cabral Passos   date: 17/04/2023

function [string_set, velements] = build_verticetree(alphabet, tree, height)

string_set = full_tree_with_vertices(alphabet, height);
velements = zeros(1,length(string_set));

    for w = 1:length(tree)
        w_next = tree{1,w};
        for s = 1:length(string_set)
            if isequal(tree{1,w},string_set{1,s})
               while ~isempty(w_next)
                      for ws = 1:length(string_set)
                          if isequal(string_set{1,ws},w_next)
                             velements(1,ws) = 1;
                          end
                      end
                      w_next = gen_imsufix(w_next);
               end   
            end
        end
    end



end