% imsufix = gen_imsufix(child)
%
% Generates the imediate sufix of a vector.
%
% INPUT:
% child = vector of integers
%
% OUTPUT:
% imsufix = imediate sufix of the vector 
%
% Author: Paulo Roberto Cabral Passos Date: 10/04/23


function imsufix = gen_imsufix(child)
    if length(child) > 1
       imsufix = child(1,2:end);
    else
       imsufix = [];
    end
end