% result = permwithrep(v,k)
%
% This function returns all permutations of the v elments, with repetition,
% taken k at a time.
%
% INPUT:
%
% v = a line vector of integers containing the elements that will be permu-
% tated.
% k = the number of elements taken for each permutation.
%
% OUTPUT:
%
% result = a matrix containing the permutations at each row.
%
% Author: Paulo Passos Last Modified: 22/05/2020


function result = permwithrep(v,k)

n = length(v); 

counters = ones(1,k);
result = zeros(n^k,k);
for a = 1:(n^k)
   for b = 1:k 
	result(a,(k+1)-b)= v(1, counters(1,(k+1)-b));
   end
   for c = 1:k
       if c == 1
        counters(1,(k+1)-c) = counters(1,(k+1)-c)+1;    
       else
           if counters(1,(k+2)-c) > n
           counters(1,(k+2)-c) = 1;
           counters(1,(k+1)-c) = counters(1,(k+1)-c)+1; 
           end  
       end
   end
end


end
