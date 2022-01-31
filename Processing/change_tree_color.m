% change_tree_color(color)
%
% This function changes the color of the tree to the one indicated by
% color. For example: chage_tree_color('r'), change the color to red.

function change_tree_color(color)

linesh = findobj(gca, 'Type', 'line');
nlines = length(linesh);
for a = 1:nlines
   linesh(a,1).Color = color; 
end

end