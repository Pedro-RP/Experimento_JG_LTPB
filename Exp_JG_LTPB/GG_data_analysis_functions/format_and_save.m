
function [outputArg1,outputArg2] = format_and_save(file_path, data_name)

file_path = 'C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Exp_JG_LTPB\dataframe_full.csv';

predata = readtable(file_path);
data = table2array(predata);

save(data_name, 'data');
end