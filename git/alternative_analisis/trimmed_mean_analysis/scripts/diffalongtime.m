% Setting Paths
working_path = '/home/roberto/Documents/Pos-Doc/pd_paulo_passos_neuromat';
working_subpath1 = [working_path '/mixture_models_analysis'];
working_subpath2 = [working_path '/trimmed_mean_analysis'];

% Adding Paths
addpath(genpath(working_path))

% Loading Data
load([working_subpath1 '/data_files/valid_20092022.mat'])
load([working_subpath2 '/data_files/article_data_111022.mat'])


WhpwayA = zeros(sum(valid_p),2);
WhpwayB = zeros(sum(valid_p),2);

WlpwayA = zeros(sum(valid_p),2);
WlpwayB = zeros(sum(valid_p),2);

wayhp = [5 4];
waylp = [2 3];

block = data_block(:,1,:)-data_block(:,2,:);
blockw0 = data_blockw0(:,1,:) - data_blockw0(:,2,:);


subplot(2,2,1)
data_v = []; group_v = [];
aux_v = block(:,1,wayhp(2)) - block(:,1,wayhp(1));
data_v = [data_v ; aux_v]; group_v = [group_v ; 1*ones(length(aux_v),1)];
aux_v = block(:,1,wayhp(2)) - blockw0(:,1,1);
data_v = [data_v ; aux_v]; group_v = [group_v ; 2*ones(length(aux_v),1)];

sbox_conection(group_v, data_v,  '$w_{j} - w_{j-1}$', '$\Delta$', 'w_{2} to w_{21} to w_{0}(resp. with 1)', {'';''}, 0, 0, [])

subplot(2,2,2)
data_v = []; group_v = [];
aux_v = block(:,1,wayhp(2)) - block(:,1,wayhp(1));
data_v = [data_v ; aux_v]; group_v = [group_v ; 1*ones(length(aux_v),1)];
aux_v = block(:,1,wayhp(2)) - blockw0(:,1,2);
data_v = [data_v ; aux_v]; group_v = [group_v ; 2*ones(length(aux_v),1)];

sbox_conection(group_v, data_v,  '$w_{j} - w_{j-1}$', '$\Delta$', 'w_{2} to w_{21} to w_{0}(resp. with 2)', {'';''}, 0, 0, [])

subplot(2,2,3)
data_v = []; group_v = [];
aux_v = block(:,1,waylp(2)) - block(:,1,waylp(1));
data_v = [data_v ; aux_v]; group_v = [group_v ; 1*ones(length(aux_v),1)];
aux_v = block(:,1,waylp(2)) - blockw0(:,1,1);
data_v = [data_v ; aux_v]; group_v = [group_v ; 2*ones(length(aux_v),1)];

sbox_conection(group_v, data_v,  '$w_{j} - w_{j-1}$', '$\Delta$', 'w_{01} to w_{11} to w_{0}(resp. with 1)', {'';''}, 0, 0, [])

subplot(2,2,4)
data_v = []; group_v = [];
aux_v = block(:,1,waylp(2)) - block(:,1,waylp(1));
data_v = [data_v ; aux_v]; group_v = [group_v ; 1*ones(length(aux_v),1)];
aux_v = block(:,1,waylp(2)) - blockw0(:,1,2);
data_v = [data_v ; aux_v]; group_v = [group_v ; 2*ones(length(aux_v),1)];

sbox_conection(group_v, data_v,  '$w_{j} - w_{j-1}$', '$\Delta$', 'w_{01} to w_{11} to w_{0}(resp. with 2)', {'';''}, 0, 0, [])






