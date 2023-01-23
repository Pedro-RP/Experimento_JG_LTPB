% Setting paths
working_path = '/home/roberto/Documents/Pos-Doc/pd_paulo_passos_neuromat';
working_subpath1 = '/coletas_25102022/coleta_doutorado';
working_subpath2 = '/research_codes';

% Adding paths
addpath(genpath([working_path working_subpath2]))

% Loading data
load([working_path working_subpath1 '/set2_matrix.mat'])
load([working_path '/mixture_models_analysis/data_files/valid_20092022.mat'])

% Script Description:
%
% The following script test if the response times of different fingers have
% different means.

ntrials = 1000;
[ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials,[working_path working_subpath2]);

tau = 7; % set the tree of analysis
t_id = find(tauofid == tau);
srate = zeros(length(t_id),ntrials);
counts_total = zeros(length(t_id),find(trees == tau));
from = 1; till = ntrials;
fromv = 100; tillv = 900;

% Graphical Parameters

limitingr = 1.5;
limitingl = 0;

control = zeros(length(t_id),1);
fingers = cell(length(t_id),3);
rejects = zeros(length(t_id),1);

for a = 1:length(t_id)
   [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, t_id(a), fromv, tillv, [ working_path working_subpath2 '/files_for_reference/tree_behave' num2str(tau) '.txt' ], 0, tau);
   r = 0;
   %
   for b = 1:3
       f = b-1;
       for c = 1:length(contexts)
          for d = 1:length(ctx_resp{c,1})
             if ctx_resp{c,1}(d,1) == f
                if ctx_rtime{c,1}(d,1) < limitingr
                fingers{a,b} = [fingers{a,b} ctx_rtime{c,1}(d,1)];
                else
                r = r+1;
                end
             end
          end
       end
   end
   rejects(a,1) = r;
   control(a,1) = sum(ctx_resp{3,1} == 0,1)+ sum(ctx_resp{4,1} == 0,1) + sum(ctx_resp{2,1} == 1,1) + sum(ctx_resp{5,1} == 1,1);
   control(a,1) = control(a,1)/( length(ctx_resp{3,1})+length(ctx_resp{4,1})+length(ctx_resp{2,1})+length(ctx_resp{5,1}) );   
end

valid = find(valid_p == 1);

finger_mean = zeros(length(t_id),3);

for a = 1:length(t_id)
   for b = 1:3
      finger_mean(a,b) = mean(fingers{a,b}); 
   end
end

boxgroup = [];
boxdata = [];
for b = 1:3
    boxdata = [boxdata; finger_mean(valid,b)];
    boxgroup = [boxgroup; b*ones(length(valid),1)];
end

sbox_varsize(boxgroup, boxdata,  'finger', 'mean response time', '', {'0'; '1';'2'}, 0, 0, [])
set(gca,'FontName','Times New Roman','FontSize',15, 'FontWeight','bold')
ylim([0 2])

[p,tbl,stats] = kruskalwallis(boxdata,boxgroup);