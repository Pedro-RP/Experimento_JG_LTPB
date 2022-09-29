% mode_tau = clean_nonest(mode_tau, pos, found)
%
% This function remove from a branch of tau_est the non-happening contexts
%
% INPUT:
% mode_tau = estimated tree till now
% pos = positions of the contexts of a branch.
% found = a vector with the telling if the context happens along the
% estimation or not
%
% OUTPUT:
% mode_tau = mode_tau after removing the non-happening contexts.

function mode_tau = clean_nonest(mode_tau, pos, found)

if find(found == 0)
pos0 =  pos(1,find(found == 0)); %#ok<FNDSB> Those that doesn't appear
holder = cell(1,length(mode_tau)-length(pos0));
aux0 = 1;
    for c = 1:length(mode_tau)
       aux = isempty(find(c == pos0,1));
       if aux == 1
       holder{1,aux0} = mode_tau{1,c};
       aux0=aux0+1;
       end
    end
mode_tau = holder;

end