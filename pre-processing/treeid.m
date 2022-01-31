% trees = treeid(data1a4)
%
% "This function is part of the routine for analyzing Goalkeeper's game
% data"
%
% This function receive the arguments:
%
% data1a4 = matrix containing in the 1st column the group, the day in the
% 2nd column, the cell number in the 3rd and the step in the 4th
% column.
%
% Then returns:
%
% tree_pcell = vector containing the tree for each cell. 
%
% author: Paulo Roberto Cabral Passos.
% Last Modification: 18/07/2019


function trees = treeid(data1a4)

cnum = length(data1a4);
trees = zeros(cnum,1);

for a = 1:cnum
 data1a4(a,4) = data1a4(a,4)-1;
 aux = data1a4(a,1)+data1a4(a,4)-1;
 if data1a4(a,4) ~= 0
     if aux>6
        trees(a,1) = rem(aux,6);
     else
        trees(a,1) = aux;
     end
 end
end


end