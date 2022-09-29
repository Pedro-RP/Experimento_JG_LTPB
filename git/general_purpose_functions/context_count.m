% counts =  context_count(contexts,tau_est)
%
% This function returns a vector of one and zeros indicating if the
% contexts in contexts are in tau_est.
%
% INPUT:
% contexts = a line cell with contexts
% tau_est =  a line cell with contexts
%
% OUTPUT:
% counts =  a line vector indicating if the contexts ocurred (1) or not (0)
%
% Author: Paulo Passos Last Modified: 06/01/2021


function counts =  context_count(contexts,tau_est)

counts = zeros(1,length(contexts));
for a = 1:length(contexts)
   for b = 1:length(tau_est)
       if isequal(contexts(1,a),tau_est(1,b))
       counts(1,a) = counts(1,a) +1;    
       end       
   end
end

end