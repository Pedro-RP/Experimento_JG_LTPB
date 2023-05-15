% data_summary = erroreffectpropagation_analysis(data, subgroup, reatribute, pathtogit, tau ...
%    , from, till, limit_range, steps)
% This function returns the response times after succeses and failures
% setting the number of steps before in each context.
%
% data = (matrix) data matrix;
% subgroup = (integer) defined in the 12th column of the data matrix. If there is
% only one group in the data matrix, you can set all values of the column
% to 1 and attribute 1 to the variable.
% pathtogit = (string) path to ResearchCodes.
% tau =  (integer) number atributed to the tree in files_for_reference.
% from = (integer) from trial _ of the experiment
% till = (integer) till trial _ of the experiment
% limit_range = (line vector) times from <left input> till <right input>
% steps = (line vector) steps before to be considered according to the
% context Obs. see exemple after function definition.
%
% Author: Paulo Passos  Date: 25/04/2023


function data_summary = erroreffectpropagation_analysis(data, subgroup, reatribute, pathtogit, tau ...
    , from, till, limit_range, steps)

% choosing the group of analysis
cut = find(data(:,12) == subgroup);
data = data(cut,:); %#ok<FNDSB>

if reatribute == 1
   a_aux = min(data(:,6));
   b_aux = 1;
   for a = 1:size(data,1)
       if data(a,6) == a_aux; data(a,6) = b_aux;
       else; a_aux = data(a,6);
           b_aux = b_aux + 1; data(a,6) = b_aux;
       end
   end
end

ntrials = max(data(:,3));
disp('Printing data set aspects:')
[ids, ~, tauofid, ~, trees, treesizes] = data_setaspects(data, ntrials, pathtogit);

ids_in_tau = find(tauofid == tau);
num_ids = length(ids_in_tau); num_ctx = treesizes(find(trees == tau));  %#ok<FNDSB>

% Defining the repositories:
srate = zeros(length(ids_in_tau),1);
tau_repoT = cell(num_ids,num_ctx); counts_repoT = zeros(num_ids,num_ctx);
tau_repoS = cell(num_ids,num_ctx); counts_repoS = zeros(num_ids,num_ctx);
tau_repoF = cell(num_ids,num_ctx); counts_repoF = zeros(num_ids,num_ctx);

limitingl = limit_range(1); limitingr = limit_range(2);
wbar = waitbar(0,'Calculating, please wait');

    for sit = 1:3
    
        for a = 1:length(ids_in_tau)
               % Collecting participant's data
               tree_file_address = [ pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt' ];
               [ctx_rtime, ctx_er, ~, contexts, ~, ct_pos] = rtanderperctx(data, ids_in_tau(a), from, till, tree_file_address, 0, tau);
               % Collecting the participant's success rate
               [chain,responses, ~] = get_seqandresp(data,tau, ids(a), 1, ntrials);
               srate(a,1) = sum(chain == responses)/length(chain);
               % 
               [chain,responses, ~] = get_seqandresp(data,tau, ids(a), from, till);
           for b = 1:num_ctx
                  [ctx_fer, ~] = lastwas_error(ct_pos, ctx_er, contexts, chain, responses,steps(b)); 
              if sit == 1 % The case of repository containing all the responses
                  aux = [1:length(ctx_er{b,1})]; %#ok<NBRAK>
                  tau_repoT{a,b} = ctx_rtime{b,1}(aux,1);
                  tau_repoT{a,b} = tau_repoT{a,b}(find( (tau_repoT{a,b} <= limitingr)&(tau_repoT{a,b} >= limitingl) ),1); %#ok<FNDSB>
                  counts_repoT(a,b) = length(tau_repoT{a,b});
              elseif sit == 2  % The case of repository containing successes in the indicated previous step
                  aux = find(ctx_fer{b,1} == 0); 
                  tau_repoS{a,b} = ctx_rtime{b,1}(aux,1); %#ok<FNDSB>
                  tau_repoS{a,b} = tau_repoS{a,b}(find( (tau_repoS{a,b} <= limitingr)&(tau_repoS{a,b} >= limitingl) ),1); %#ok<FNDSB>
                  counts_repoS(a,b) = length(tau_repoS{a,b});
              else % The case of repository containing failure in the indicated previous step
                  aux = find(ctx_fer{b,1} == 1); 
                  tau_repoF{a,b} = ctx_rtime{b,1}(aux,1); %#ok<FNDSB>
                  tau_repoF{a,b} = tau_repoF{a,b}(find( (tau_repoF{a,b} <= limitingr)&(tau_repoF{a,b} >= limitingl) ),1); %#ok<FNDSB>
                  counts_repoF(a,b) = length(tau_repoF{a,b});
              end
           end
        end    
        waitbar(sit/3,wbar)
    end
close(wbar)
% Creating the final structure

data_summary.total_repository = tau_repoT;
data_summary.successes_repository = tau_repoS;
data_summary.failures_repository = tau_repoF;

data_summary.total_count_repository = counts_repoT;
data_summary.successes_count_repository = counts_repoS;
data_summary.failures_count_repository = counts_repoF;
data_summary.success_rate = srate;

end

% Example:
%
% Look at the differences in response times of the context w= 2 after
% sucesses and failures the last time w = 0 took place.
%
% Setting parameters for the function:
% steps = [3 1 2 2 1]; 
% data(:, [10 11 12])  = 1;
% subgroup = 1;
% reatribute = 1;
% tau = 7;
% from = 1; till = 1000; limit_range = [0 1.5];

% data_summary = posterror_slowing(data, subgroup, reatribute, pathtogit, tau ...
%    , from, till, limit_range, steps);
% 
% choosing participant number 8
%
% p = 8;
% box_data = [data_summary.failures_repository{p,5}; data_summary.successes_repository{p,5}];
% group_data = [ones(length(data_summary.failures_repository{p,5}),1)...
%     ; 2*ones(length(data_summary.successes_repository{p,5}),1)];

% boxplot(box_data, group_data)
% The boxplot on the left is associated with the failures and on the right associated with the successes. 