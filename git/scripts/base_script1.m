% estimating the context trees for response times

pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/research_codes';
addpath(genpath(pathtogit))

% loading data

load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/data_files_r02/valid_20092022.mat')
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/thesis_data_r01/set2_matrix.mat')


% processing
est_trees = cell(sum(valid_p),1);
aux = 1; wbar = waitbar(0,'Processing data, please wait...');
for a = 1:length(valid_p)
   if valid_p(a) == 1
      [rt, chain] = get_rtimes(data, a, 101, 900, 7);
      [tau_est] = tauest_RT(3, rt', chain', 0);
      est_trees{aux,1} = tau_est;
      aux = aux+1;
      waitbar(a/sum(valid_p), wbar,'Processing data, please wait...')
   end
end

% calculating the mode trees

[mode_tau_full] = taumode_est(3, est_trees_full', floor(log10(1000)/log10(3)), 0, 0);
[mode_tau] = taumode_est(3, est_trees_full', floor(log10(1000)/log10(3)), 0, 0);

close all
% preparing the figures
set(0, 'DefaultFigureRenderer', 'painters')
set(0, 'DefaultFigureColor', [1 1 1] )
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/data_files_r04/estimated_trees27032023.mat')


fig_trees = figure;
for p = 19:22 %length(est_trees)
    w = p-18;
    subplot(3,3,w)
    title(['p' num2str(p)])
    tree = est_trees{p,1};
    draw_contexttree(tree, [0 1 2], [0 0 0])
    lines = findobj('Type','line');
    texts = findobj('Type','text');
    for l = 1:length(lines)
       lines(l).LineWidth = 3;
    end
    for t = 1:length(texts)
       if length(texts(t).String) > 4
          texts(t).FontSize = 8;
       elseif length(texts(t).String) > 3
       else
          texts(t).FontSize = 12;
       end
    end
end

% generating the methods figure
subplot(2,3,1)
adm_tree1 = {[1 1 0], [2 1 0], [0 1], [1 1], [2 1], [2]}; %#ok<NBRAK>
adm_tree2 = {[1 0], [0 1], [1 1], [2 1], [2]}; %#ok<NBRAK>
adm_tree3 = {[0], [0 1], [1 1], [2 1], [2]}; %#ok<NBRAK>
adm_tree4 = {[1 1 0], [2 1 0], [0 1], [1 1], [2 1], [2]}; %#ok<NBRAK>

for sub = 1:4
    eval(['adm_tree = adm_tree' num2str(sub) ';'])
    if sub == 4
       aux_sub = sub+1;
       subplot(2,3,aux_sub)
    else
       aux_sub = sub;
       subplot(2,3,aux_sub) 
    end
    
    draw_contexttree(adm_tree, [0 1 2], [0 0 0])
    lines = findobj('Type','line');
    texts = findobj('Type','text');
    for l = 1:length(lines)
       lines(l).LineWidth = 3;
    end
    for t = 1:length(texts)
       if length(texts(t).String) > 4
          texts(t).FontSize = 8;
       elseif length(texts(t).String) > 3
       else
          texts(t).FontSize = 12;
       end
    end
end


% example prunning

[rt, chain] = get_rtimes(data, 10, 101, 900, 7);
contexts = {[1 1 0], [2 1 0]};
[ct_posi, ct_pose, ctx_count] = count_contexts(contexts, chain');
set_110 = rt(find(ct_pose(1,:) ~= 0)+1,1); set_110 = set_110(find(set_110 < 1.5));
set_210 = rt(find(ct_pose(2,:) ~= 0)+1,1); set_210 = set_210(find(set_210 < 1.5));
sbox_varsize([ones(1,length(set_110)) 2*ones(1,length(set_210))]', [set_110 ; set_210],  'strings', 'response times', '', {'110';'210'}, 0, 0, [])
CA = gca;
CA.XTickLabel = {'110'; '210'}; 

