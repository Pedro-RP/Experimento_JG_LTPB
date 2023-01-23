% Simulations for testing the function:

pathtogit = '/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/research_codes';
addpath(genpath(pathtogit))
tau = 7;
tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt'];
[contexts, PM,~ , ~] = build_treePM (tree_file_address);
num = 200; % defining the number of elements in the chain
chain = gentau_seq ([0 1 2], contexts, PM, num);

figure
subplot(1,2,1)
rts = gen_rts(partition, chain, 0.3, 1);
alphal = 3;
subplot(1,2,2)
[tau_est] = tauest_RT(alphal, rts, chain, 1);
