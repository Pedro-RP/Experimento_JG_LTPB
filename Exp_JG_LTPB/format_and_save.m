
function format_and_save(file_path, data_name)

predata = readtable(file_path);
data = table2array(predata);
save(append('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Exp_JG_LTPB\GGxLTPB_gamedata\',data_name,'.mat'), 'data');

end
