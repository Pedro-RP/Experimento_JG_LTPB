% Simulations for testing the function:

pathtogit = 'C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\git';
addpath(genpath(pathtogit))
tau = 12;
tree_file_address = [pathtogit '/files_for_reference/tree_behave' num2str(tau) '.txt'];
[contexts, PM,~ , ~] = build_treePM (tree_file_address);
num = 1000; % defining the number of elements in the chain
chain = gentau_seq ([0 1 2], contexts, PM, num);

figure
subplot(1,2,1)
rts = gen_rts(partition, chain, 0.3, 1);
alphal = 3;
subplot(1,2,2)
