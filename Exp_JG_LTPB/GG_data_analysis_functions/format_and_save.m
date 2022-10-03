% format_and_save(file_path, file_name, directory_path)
%
% This function selects the dataframes generated from the "Formatacao_JG"
% pyhton routine and adjusts them to the matlab template, which is ideal
% for working with the Goalkeeper Game data in matlab. The function will then save
% the datasets to a directory of your chosing.  
% Note thas this function needs only to be used once with each new dataset. When working with a
% previous dataset, you only need to open the data saved in the directory
% that you choose when using this function. This will load the data
% directly into matlab .
%
% INPUT:
% file_path = path to a dataframe generated with the "Formatacao_JG"
% routine.
% Example:'C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Exp_JG_LTPB\dataframe_full.csv'.
%
% file_name = the name of the data file that will be created. This argument
% accepts these parameters as input:
% data_full -> for the dataframe with data from boths groups combined
% (dataframe_full).
% data_control -> for the dataframe with data from the control group
% (dataframe_Control).
% data_LTPB -> for the dataframe with data from the LTPB group
% (dataframe_Patient) .
%
% directory_path = the directory in which the formated data will be saved.
% Example: 'C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Exp_JG_LTPB\GGxLTPB_gamedata\'
%
%03/10/2022 by Pedro R. Pinheiro

function format_and_save(file_path, file_name, directory_path)

predata = readtable(file_path);

if file_name == "data_control"
    data_control = table2array(predata);
    save(append(directory_path,file_name,'.mat'), 'data_control');

elseif file_name == "data_LTPB"
    data_LTPB = table2array(predata);
    save(append(directory_path,file_name,'.mat'), 'data_LTPB');

elseif file_name == "data_full"
    data_full = table2array(predata);
    save(append(directory_path,file_name,'.mat'), 'data_full');
end
end
