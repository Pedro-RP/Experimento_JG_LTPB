% result = insert_s(tau_est, s)
%
% This function returns 1 if the string s should be inserted in tau_est
% and 0 otherwise. It performs a suffix test.
%
% INPUT:
% s = the string that induces a terminal branch
% tau_est = cell containing the contexts of the estimated tree
%
% OUTPUT:
% result = see the description above
%
% author: Paulo Cabral Last Modified: 15/06/2020

function result = insert_s(tau_est, s)

for a = 1:length(tau_est)
    u = tau_est{1,a};
    if length(u)> length(s)
    aux = u(1,length(u)-length(s)+1: end) == s;
        if (sum(aux,2)/length(s)) == 1
        result = 0;
        return;
        end
    end
end

result = 1;
end

