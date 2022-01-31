% mode_tau = mode_cutbranch(mode_tau, estimations)


function mode_tau = mode_cutbranch(s,pos, mode_tau, retrieved_ctx, ctxcount)

% for a = 1:length(pos)
% disp(['Prunning Procedure on ' num2str(mode_tau{1,pos(1,a)}) ])
% end

sind = cell(1,length(pos));
for a = 1:length(pos)
sind{1,a} = mode_tau{1,pos(1,a)};
end

[k, found] = caseforcut(mode_tau,pos , retrieved_ctx, ctxcount);

% Case 1: all induced strings occured 

if (sum(found) == length(pos))
% disp('Case 1')
    if k == 0
        if brother_suffofacontext(mode_tau, mode_tau{1,pos(1,1)}, 3)
            % disp('subcase 1.1')
            if find(found == 0)
            mode_tau = clean_nonest(mode_tau, pos, found);
            end
        else
            % disp('subcase 1.2')
            mode_tau = removing_branch_how(mode_tau,pos,s,0);
        end
    end
end

% Caso 2: no ocurrence of any induced strings (SOLVED)

if isempty(find(found == 1)) %#ok<EFIND>
% disp('Case 2')
    mode_tau = removing_branch_how(mode_tau,pos,s,0);
end


% Case 3: Just one of the induced strings occurred

if sum(found) == 1 
% disp('Case 3')    
posx =  pos(1,find(found ~= 0)); %#ok<FNDSB>
        if brother_suffofacontext(mode_tau, mode_tau{1,posx}, 3)
            % disp('subcase 3.1')
            if find(found == 0)
            mode_tau = clean_nonest(mode_tau, pos, found);
            end
        else
            % disp('subcase 3.2')
            mode_tau = removing_branch_how(mode_tau,pos,s,0);
        end
end

% Case 4 : At least 2 of the induced strings occurred

if ( sum(found) >= 2 )&&( sum(found) < (length(pos)) )
   % disp('Case 4')
   % Replacing the ones that were not found
    sind = cell(1,length(pos)); auxpos = [];
    for a = 1:length(pos)
        if found(1,a) == 0
        mode_tau{1,pos(1,a)} = [];
        else
        auxpos = [auxpos pos(1,a)]; sind{1,a} = mode_tau{1,pos(1,a)}; %#ok<AGROW>
        end
    end
    pos = auxpos;
    % Then choosing if it should be prunned
    % Option 1
    jump = 0;
    for a = 1:length(pos)
        if brother_suffofacontext(mode_tau, mode_tau{1,pos(a)}, 3)
           jump = 1;
        end
    end
    if jump == 0
        if k == 0
        mode_tau = removing_branch_how(mode_tau,pos,s,0); 
        end        
    end
end
    

% Cleaning
mode_tau = removing_branch_how(mode_tau,[],[], 1);

end


