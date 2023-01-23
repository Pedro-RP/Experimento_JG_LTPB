load('/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/MatlabScripts/Git/data_files/response_time_analysis/2setMAT.mat')
pathtogit = '/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/MatlabScripts/Git';

ntrials = 1000;
[ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials,pathtogit);


% parameters settings

tau = 7; % Here you choose the tree
t_id = find(tauofid == tau);

lastbyctx = [3 1 2 2 1];
repo_comp = cell(5,2,length(t_id)); ex_comp = cell(2,2,length(t_id));

w_bar = waitbar(0,'Gathering Data');
for lup1 = 1:length(lastbyctx)
    tau_repo1 = cell(length(t_id),treesizes(find(trees==tau))); tau_repo2 = cell(length(t_id),treesizes(find(trees==tau))); %#ok<FNDSB>
    % 1st AMEND
    ex_repo1 = cell(length(t_id),2); ex_repo2 = cell(length(t_id),2);
    % END of 1st AMEND
    counts_total1 = zeros(length(t_id),treesizes(find(trees==tau)));  %#ok<FNDSB>
    from = 100; till = 900; % Ended here
    cond1 = 0; cond2 = 1;
    last = lastbyctx(lup1);
    limitingr = 1.5;
    limitingl = 0;
    for a = 1:length(t_id)
       tree_file_address = ['/home/roberto/Documents/Dr. Fisiologia/Jogo do Goleiro/MatlabScripts/Git/files_for_reference/tree_behave' num2str(tau) '.txt' ];
       [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, t_id(a), from, till, tree_file_address, 0, tau);
       [chain,responses, times] = get_seqandresp(data,tau, ids(a), from, till);
       % 2nd AMEND
       % zero means reponse 1, 1 response 2 in the discriminator variable
       w0resps = length( find( ct_pos(1,:) ~= 0 ) );
       discriminator = zeros( length(ctx_rtime{1,1}) , 1);
       for c = 1:w0resps
           if responses(ct_pos(1,c)+1, 1) == 2
              discriminator(c,1) = 1; % 1 marks the most likely 
           end
       end
       % END OF THE 2nd AMEND
       [ctx_fer,ct_poscell] = lastwas_error(ct_pos, ctx_er, contexts, chain, responses,last);
       for b = 1:treesizes(find(trees == tau)) %#ok<FNDSB>
          % for erros or successes 
          %aux = find(ctx_er{b,1} == 1); % considering success in the present response
          aux1 = find(ctx_fer{b,1} == cond1); % considering success in the the last response
          aux2 = find(ctx_fer{b,1} == cond2); % considering failure in the the last response
          % 3rd AMEND
          if b == 1
              if length(discriminator) ~= ctx_fer{b,1}
                 discriminator = discriminator(1:length(ctx_fer{b,1}),1); 
              end
          aux1b1 = find( (ctx_fer{b,1}  == cond1)&( discriminator == 0) );
          aux1b2 = find( (ctx_fer{b,1}  == cond1)&( discriminator == 1) );
          aux2b1 = find( (ctx_fer{b,1}  == cond2)&( discriminator == 0) );
          aux2b2 = find( (ctx_fer{b,1}  == cond2)&( discriminator == 1) );
          end
          % END OF 3rd AMEND
          %aux = [1:length(ctx_er{b,1})]; % considering all responses;
          tau_repo1{a,b} = ctx_rtime{b,1}(aux1,1); tau_repo2{a,b} = ctx_rtime{b,1}(aux2,1);
          % 3rd AMEND
          if b == 1
          ex_repo1{a,1} = ctx_rtime{b,1}(aux1b1,1); ex_repo1{a,2} = ctx_rtime{b,1}(aux1b2,1);
          ex_repo2{a,1} = ctx_rtime{b,1}(aux2b1,1); ex_repo2{a,2} = ctx_rtime{b,1}(aux2b2,1);
          % imposing the time limits
          ex_repo1{a,1} = ex_repo1{a,1}(find( (ex_repo1{a,1} <= limitingr)&(ex_repo1{a,1} >= limitingl) ),1); %#ok<FNDSB>
          ex_repo1{a,2} = ex_repo1{a,2}(find( (ex_repo1{a,2} <= limitingr)&(ex_repo1{a,2} >= limitingl) ),1); %#ok<FNDSB>
          ex_repo2{a,1} = ex_repo2{a,1}(find( (ex_repo2{a,1} <= limitingr)&(ex_repo2{a,1} >= limitingl) ),1); %#ok<FNDSB>
          ex_repo2{a,2} = ex_repo2{a,2}(find( (ex_repo2{a,2} <= limitingr)&(ex_repo2{a,2} >= limitingl) ),1); %#ok<FNDSB>
          end
          % END OF 3rd AMEND
          tau_repo1{a,b} = tau_repo1{a,b}(find( (tau_repo1{a,b} <= limitingr)&(tau_repo1{a,b} >= limitingl) ),1); %#ok<FNDSB>
          tau_repo2{a,b} = tau_repo2{a,b}(find( (tau_repo2{a,b} <= limitingr)&(tau_repo2{a,b} >= limitingl) ),1); %#ok<FNDSB>
       end
       
    end

    for lup2 = 1:length(t_id)
        repo_comp{lup1,1,lup2} = tau_repo1{lup2,lup1};
        repo_comp{lup1,2,lup2} = tau_repo2{lup2,lup1};
        % 4th AMEND
        if lup1 == 1
           % 1st dim = resp, 2nd dim = right/wrong and 3rd = partiipant
           ex_comp{1,1,lup2} = ex_repo1{lup2,1}; ex_comp{2,1,lup2} = ex_repo1{lup2,2};  
           ex_comp{1,2,lup2} = ex_repo2{lup2,1}; ex_comp{2,2,lup2} = ex_repo2{lup2,2};
        end
        % END of 4th AMEND
    end   
    waitbar(lup1/length(lastbyctx),w_bar,'Gathering Data');
end
close(w_bar)
