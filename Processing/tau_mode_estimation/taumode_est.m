% [mode_tau] = taumode_est(alphal, estimated_trees, L, show)

% INPUT:
% alphal = length of the alphabet of the sequence
% estimated_trees = a line cell containing for each entry, a cell with the
% estimated tree for a subject.
% L = length for start testing.

function [mode_tau] = taumode_est(alphal, estimated_trees, L, show, exclude_root)
    
    holder = cell(1,1); aux_add = 1;
    for a = 1:length(estimated_trees) 
        if ~isempty(estimated_trees{1,a})
           holder{1,aux_add} = estimated_trees{1,a};
           aux_add = aux_add+1;
        end
    end
    estimated_trees = holder;
    
    if exclude_root == 1
        holder = cell(1,1);aux_add = 1;
        for a = 1:length(estimated_trees)
            if  ~isequal(estimated_trees{1,a}, {[0],[1],[2]})
            holder{1,aux_add} = estimated_trees{1,a};
            aux_add = aux_add+1;
            end
        end 
        estimated_trees = holder;
    end
    
    [unique, count, whichtree] = unique_trees(estimated_trees);
    [retrieved_ctx, ctxcount] = ctx_estcount(unique, count);
    display(retrieved_ctx)
    
    % Importing the functions for the graphical representation

    addpath('/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/Scripts Noslen');
    addpath('/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/Scripts Noslen/EstimateContextTree');
    addpath('/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/Scripts Noslen/DrawContextTree');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A = zeros(1,alphal);
    for a = 1:alphal
        A(1,a) = a-1;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    perm = permwithrep(A,L);

    mode_tau = cell(1,length(A)^L);

    for a = 1:size(perm,1)
    mode_tau{1,a} = perm(a,:);
    end
    
    % showing the mode_tau before prunning
    % if show == 1
    %   figure
    %   draw_contexttree(mode_tau, A)
    % end

    for h = 1:L
        if (L-h) == 0 % Visiting the root branch.
            perm = [];
            branchs = 1;
        else
            perm = permwithrep(A,L-h);
            branchs = size(perm,1);
        end
        % Finding the leafs of the branch
        for a = 1:branchs
           pos = []; 
           for b = 1:length(mode_tau)
                if (branchs == 1)&&(L-h == 0) % visiting the root branch
                    if length(mode_tau{1,b}) == 1 
                            pos = [pos b]; %#ok<AGROW> No need for compatibilization test
                    end                    
                else
                    if(length(mode_tau{1,b}) == (length(perm(a,:))+1))
                        aux = sum(perm(a,:) == mode_tau{1,b}(2:end),2)/length(perm(a,:)); % Testing if it is from the branch
                        if  aux == 1
                            pos = [pos b]; %#ok<AGROW>
                        end
                    end    
                end
           end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Pruning Procedure
            if ~isempty(pos)
                if isempty(perm) % Root branch
                    mode_tau = mode_cutbranch(perm,pos, mode_tau, retrieved_ctx, ctxcount); 
                else % Other branches
                    mode_tau = mode_cutbranch(perm(a,:),pos, mode_tau, retrieved_ctx, ctxcount);
                end
            end
        end
    end
    
    if show == 1
    figure
    draw_contexttree(mode_tau, A)
    end
end