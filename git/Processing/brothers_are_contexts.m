% result = brothers_are_contexts(tau_est, w)
%
% This function test if the brothers of w are suffix of contexts that appear
% in the final estimated tree.
%
% INPUT:
% tau_est = estimated tree till now
% w = the context that will be tested
%
% OUTPUT:
% result = 1 if the brothers are sufix of contexts, 0 otherwise.


function result = brothers_are_contexts(tau_est, w)

alphal = 3;

% Determining which are the brothers

brothers = cell(1,alphal-1);
aux = 1;
if length(w) == 1
    for a = 1:alphal 
        if (a-1) ~= w
            brothers{1,aux} = a-1;
            aux = aux+1;
        end
    end
else
    u = w(2:end);
    for a = 1:alphal
        if ~isequal([(a-1) u], w)
           brothers{1,aux} = [(a-1) u];
           aux = aux+1;
        end
    end
end
   
% Testing

for a = 1: length(tau_est)
    for b = 1:length(brothers)
       if length(tau_est{1,a}) > length(brothers{1,b})
          result = ~ insert_s({tau_est{1,a}}, brothers{1,b}); % test of suffix, if it returns 0 it means suffix
          return 
       end
    end
end

result  = 0;
end