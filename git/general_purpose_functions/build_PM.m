% PM  = build_PM(contexts, prob_vec, A)
%
% This function builds the probability matrix PM from the set of contexts and
% a vector of probability measures. Probability measures must be ordered
% according to the list of contexts.
%
% for exemple, run the function with the data bellow:
%
% contexts = {[0], [0,1], [1,1], [2]};
% prob_vec = [0 1 0 0 0.2 0.8 1 0 0 1 0 0];
% A = [0, 1, 2];

function PM  = build_PM(contexts, prob_vec, A)

PM = zeros(length(contexts),length(A));

k = 1;
for a = 1:size(PM,1)
   for b = 1:size(PM,2) 
   PM(a,b) = prob_vec(k);
   k = k+1;
   end
end

end



