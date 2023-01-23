% Setting Paths
working_path = '/home/roberto/Documents/Pos-Doc/pd_paulo_passos_neuromat';
working_subpath1 = [working_path '/mixture_models_analysis'];
working_subpath2 = [working_path '/trimmed_mean_analysis'];

% Adding Paths
addpath(genpath(working_path))

% Loading Data
load([working_subpath1 '/data_files/valid_20092022.mat'])
load([working_subpath2 '/mixture_models_analysis/data_files/article_data_111022.mat'])

% Script Description:
%
% The following script stores the trimmed mean of the distribution of
% response times in two 3 dimensional matrices. 
%
% data_block = contains the data for each context except w=0
% data_block0 = contains the data for context w = 0;
%
% It also produces the ordered table of the trimmed means

contexts = {'0','01', '11', '21', '2'};
data_block = zeros(sum(valid_p),2,length(contexts));
data_blockw0 = zeros(sum(valid_p),2,2); % Here the 3rd dimension is the finger 1 and finger 2 respectively. 

% For making painel 2 illustration 
% group_id2 = [ 1*ones(sum(valid_p,1),1) ; 2*ones(sum(valid_p,1),1); 3*ones(sum(valid_p,1),1)];
% data_v3 = [];


% Proceeding for data_block
p_z_stat = zeros(5,2);
tails = {'both','left','left','right','right'};
for ctx = 1:5

data_v = zeros(sum(valid_p)*2,1);
group_id = [ ones(sum(valid_p),1); 2*ones(sum(valid_p),1)]; 
aux = 1; npart = 31;
for cond = 1:2
    aux2 = 1;
    for p = 1:npart
        if valid_p(p)== 1
          if cond == 1
              data_v(aux) = trimmean(repo_comp{ctx,1,p},5);
              data_block(aux2,1,ctx) = data_v(aux);
          else
              data_v(aux) = trimmean(repo_comp{ctx,2,p},5);
              data_block(aux2,2,ctx) = data_v(aux);
          end
        aux = aux+1;
        aux2 = aux2+1;
        end
    end
end

data_v2 = zeros(sum(valid_p,1),1);
for a = 1:sum(valid_p,1)
    data_v2(a) = data_v(sum(valid_p)+a)-data_v(a);    
end

[p,stat1,stat2] = signrank(data_v2,zeros(sum(valid_p),1),'tail',tails{ctx});
p_z_stat(ctx,1) = p;
p_z_stat(ctx,2) = stat2.zval;
% Uncomment the lines bellow for visualization
% figure
% sbox_varsize(group_id, data_v,'', '', ['w = ' num2str(contexts{1,ctx})], {'S'; 'F'}, 0, 0, [])
% figure
% sbox_varsize(ones(sum(valid_p,1),1), data_v2,  '', '', ['p = ' num2str(p)], {''}, 0, 0, [])
% for making painel 2 illustration
%     if ctx == 5
%     data_v3 = [data_v2; data_v3];    
%     elseif ctx == 4
%     data_v3 = [data_v2; data_v3];
%     elseif ctx == 3
%     data_v3 = [data_v3; data_v2];    
%     else 
%     end
end

% For making painel 2 illustration
% figure
% sbox_varsize(group_id2,data_v3,'','','',{'';''},0,0,[])

% Proceeding for making the table of ordered trimed mean

matrix_tab = zeros(sum(valid_p),5);
matrix_order = zeros(sum(valid_p),5);
aux = 1;
for a = 1:length(valid_p)
    holder = zeros(1,5);
    if valid_p(a)==1
        for ct = 1:5
                holder(1,ct) = trimmean([repo_comp{ct,1,a} ; repo_comp{ct,2,a}],5);   
        end
        matrix_tab(aux,:) = holder;
        [~,I] = sort(holder);
        for d = 1:length(holder)
            matrix_order(aux,d) = find(I == d);
        end
        aux = aux+1;
    end
end

matrix_counts = zeros(5,5);

for c = 1:5
   for b= 1:5
      matrix_counts(c,b) = sum( matrix_order(:,c) == b ); 
   end
end

% Proceeding for making a latex table with cell2latextable

% Total trimmed mean table

tab = cell(sum(valid_p),length(contexts));

for ctx = 1:length(contexts)
    aux = 0;
    for v = 1:length(valid_p)
       if valid_p(v) == 1
          aux = aux + 1;
          aux_data = trimmean( [repo_comp{ctx,1,v} ; repo_comp{ctx,2,v}], 5 );
          tab{aux,ctx} = num2str(aux_data, '%.3f');
       end
    end    
end

[table_latex] = cell2latextable(tab);

% Trimmed mean table

tab = cell(22,11);
aux = 1;

for ctx = 1:5
    for cond = 1:2
        aux = aux + 1;
        for v = 1:size(data_blockw0,1)
           tab{v,aux} = num2str(data_block(v,cond,ctx), '%.3f');
        end
    end
end

for v = 1:22
   tab{v,1} = num2str(v, '%d');
end

[table_latex] = cell2latextable(tab);

% Matrix counts table

tab = cell(5,6);
for l = 1:5
    for c = 1:6
        if c <= 5
           tab{l,c} = num2str(matrix_counts(l,c), '%.3f');
        else
           tab{l,c} = num2str( sum(  [1:5].*matrix_counts(l,:)*(1/sum( matrix_counts(l,:) ))  ) , '%.3f');
        end
    end
end

[table_latex] = cell2latextable(tab);
