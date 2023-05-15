% Matlab Parameters for graphics
set(0,'defaultfigurecolor',[1 1 1])
set(0, 'DefaultFigureRenderer', 'painters');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('/home/paulocabral/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/thesis_data_r01/set2_matrix.mat')
pathtogit = '/home/paulocabral/Documents/pos-doc/pd_paulo_passos_neuromat/ResearchCodes';
load('/home/paulocabral/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/thesis_data_r01/set2_valid_ids_27112021.mat')

ntrials = 1000;
[ids, vids, tauofid, gametest, trees, treesizes] = data_setaspects(data, ntrials, pathtogit);


tau = 7; % choose the tree
p = 12; % choose the participant
bwid = 0.0775; % choose the bin width


t_id = find(tauofid == tau);
tau_repo1 = cell(length(t_id),treesizes(find(trees==tau))); %#ok<FNDSB>
tau_repo2 = cell(length(t_id),treesizes(find(trees==tau))); %#ok<FNDSB>
counts_total1 = zeros(length(t_id),treesizes(find(trees==tau)));  %#ok<FNDSB>
from = 100; till = 900; 
cond1 = 0; cond2 = 1;
last = 2;

limitingr = 1.5;
limitingl = 0;
for a = 1:length(t_id)
   tree_file_address = [ pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt' ];
   [ctx_rtime, ctx_er, ctx_resp, contexts, ctxrnds, ct_pos] = rtanderperctx(data, t_id(a), from, till, tree_file_address, 0, tau);
   [chain,responses, times] = get_seqandresp(data,tau, ids(a), from, till);
   [ctx_fer,ct_poscell] = lastwas_error(ct_pos, ctx_er, contexts, chain, responses,last);
   for b = 1:treesizes(find(trees == tau)) %#ok<FNDSB>
      % for erros or successes 
      aux1 = find(ctx_fer{b,1} == cond1); % considering success in the the last respons
      aux2 = find(ctx_fer{b,1} == cond2); % considering success in the the last respons      
      tau_repo1{a,b} = ctx_rtime{b,1}(aux1,1); tau_repo2{a,b} = ctx_rtime{b,1}(aux2,1);
      tau_repo1{a,b} = tau_repo1{a,b}(find( (tau_repo1{a,b} <= limitingr)&(tau_repo1{a,b} >= limitingl) ),1); %#ok<FNDSB>
      tau_repo2{a,b} = tau_repo2{a,b}(find( (tau_repo2{a,b} <= limitingr)&(tau_repo2{a,b} >= limitingl) ),1); %#ok<FNDSB>
   end
end




leg = cell(treesizes(find(trees==tau)),1); %#ok<FNDSB>
for a = 1 %1:treesizes(find(trees==tau))
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    yyaxis left
    X1 = tau_repo1{p,a}; X2 = tau_repo2{p,a};
    h1 = histogram(X1,'FaceColor', 'g','EdgeColor', [1 1 1], 'BinWidth',bwid,'LineWidth', 0.001, 'Normalization', 'probability');
    hold on
    h2 = histogram(X2,'FaceColor', [1 0.2 0.3], 'EdgeColor', [1 1 1], 'BinWidth',bwid,'LineWidth', 0.001, 'Normalization', 'probability');
    xlabel('rt (sec.)','FontSize',20) 
    ylabel('normalized frequency','FontSize',20)
    axis([limitingl limitingr 0 max([max(h1.Values) max(h2.Values)]) ])
    set(gca,'FontName','Times New Roman','FontSize',14)
    ax = gca;ax.YAxis(1).Color = 'k';ax.YAxis(2).Color = 'k';
    set(gca,'FontName','Times New Roman','LineWidth', 2.5,'FontSize',28)
    axis square
    
end