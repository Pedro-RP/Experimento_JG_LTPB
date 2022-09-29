% tau_est = clean_zerocounts(tau_est, pos, count)
%
% This function remove from a branch of tau_est the non-ocurring contexts
%
% INPUT:
% tau_est = estimated tree till now
% pos = positions of the contexts of a branch.
% count = a vector with the occurence count of each branch
%
% OUTPUT:
% tau_est = tau_est after removing the non-occurring contexts.

function tau_est = clean_zerocounts(tau_est, pos, count)

if find(count == 0)
pos0 =  pos(1,find(count == 0)); %#ok<FNDSB> Those which have count equal zero.
holder = cell(1,length(tau_est)-length(pos0));
aux0 = 1; 
    for c = 1:length(tau_est)
       aux = isempty(find(c == pos0,1));
       if aux == 1
       holder{1,aux0} = tau_est{1,c};
       aux0=aux0+1;
       end
    end
tau_est = holder;


end