% tau_est = removing_branch_how(tau_est,pos,s, cleans)

% After the decision of prunning a branch induced by a string s, this
% function procedes with the prunning according to the actual state of the
% tree. Can be used for cleaning the estimated tree of empty strings.
%
% INPUT:
% tau_est = A cell containing the estimated tree till now.
% pos = positions in tau_est where you find the contexts induced by some 
% string s.  
% s = the string that induces the branch. 
% clean = for cleaning tau est type 1 integer. 
% OUTPUT:
% tau_est = the estimated tree after a prunning instance
%
% Author: Paulo Passos     Last Modified: 04/10/2020

function tau_est = removing_branch_how(tau_est,pos,s, clean)


if clean == 1
    holder = cell(1,1); aux = 1;
    for a = 1:length(tau_est)
        if ~isempty(tau_est{1,a})
           holder{1,aux} = tau_est{1,a};
           aux = aux+1;
        end
    end
    tau_est = holder;
    if (length(tau_est) == 1)&&(isempty(tau_est{1,1}))
    tau_est = [];
    end    
else
    if (length(tau_est)-length(pos)) == 0
        tau_est = [];
    else
        holder = cell(1,length(tau_est)-length(pos));
        aux0 = 1; 
        for c = 1:length(tau_est)
           aux = isempty(find(c == pos,1));
           if aux == 1
           holder{1,aux0} = tau_est{1,c};
           aux0=aux0+1;
           end
        end
        tau_est = holder;
        if insert_s(tau_est,s) == 1; tau_est{1,length(tau_est)+1} = s; end
    end    
end
 

end