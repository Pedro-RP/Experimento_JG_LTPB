load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/thesis_data_r01/set2_matrix.mat')
load('/home/roberto/Documents/pos-doc/pd_paulo_passos_neuromat/data_repository_10092022/data_files_r02/valid_20092022.mat')

% Options 130,425,491

close all
% definitions
b = 491;
e = b+10;
x = [1:e-b+1];
y = data(b:e,7); 

% plotting
bar(x,y)
range = max(y)+(1/5)*max(y);
ylim([0 range])
hold on

inc = ((range-max(y))/2)/2;
hight_gch = max(y)+inc;
hight_ptch = max(y)+2*inc;
for k = 1:length(x)
    text(k,hight_ptch,num2str(data(b+k-1,9)),'color','b')
    text(k,hight_gch,num2str(data(b+k-1,8)),'color','r')
end
