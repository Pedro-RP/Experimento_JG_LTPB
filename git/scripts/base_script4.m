% Distance histogram

alphabet = [0 1 2]; height = 5;
pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/ResearchCodes'; tau = 7;
tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt' ];
[contexts, PM,~ , ~] = build_treePM (tree_file_address);
tree_a = contexts;

load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/simulation_data/tau7_trees_of_size5_or_less.mat');
simplified_set = string_set;
D = zeros( size(elements,1), 1 );
for t = 1:size(elements,1)
    tree_b = simplified_set(find(elements(t,:) == 1)); %#ok<FNDSB>
    D(t,1) = balding_distance(tree_a, tree_b, alphabet, height);
end
close all
set(0, 'DefaultFigureRenderer', 'painters')
set(0, 'DefaultFigureColor', [1 1 1] )
subplot(1,3,1)
h = histogram(D, 'BinWidth', 0.05, 'FaceColor', [0 0 0], 'LineWidth', 1.25);
h.Orientation = 'horizontal';
title('Possible distances')
xlabel('number of trees')
ylabel('d(\tau, \tau_{k})')
xlim([0 20])
set(gca, 'FontName', 'Times', 'fontsize',14)

% Calculating the distances from the data
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_15042023/thesis_data_r01/set2_estimated_trees_of_valid.mat');

subplot(1,3,[2 3])
hold on
D_data = zeros( size(est_trees,1), size(est_trees,2) );
for ep = 1:size(est_trees,2)
    for t = 1:size(est_trees,1)
        tree_b = est_trees{t,ep};
        D_data(t,ep) = balding_distance(tree_a, tree_b, alphabet, height);    
    end
end

% group_id = []; data = [];
% for g = 1:size(est_trees,2)
%     group_id = [group_id; g*ones(size(est_trees,1),1)];
%     data = [data; D_data(:,g)];
% end

sbox_varsize(group_id, data,  'epochs', '$d(\tau, \hat{ \tau })$', '', {'1st epoch'; '2nd epoch'; '3rd epoch'}, 0, 0, [])
ylim(h.BinLimits)