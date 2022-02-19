%%%Preparando dados para inserção no Goalkeeper's Lab

%%Grupo Controle

predata_control = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Control.csv');
predata_control(: , 1) = [ ]; 
predata_control(: , 1) = [ ];
predata_control(: , 10) = [ ];
data_control = table2array(predata_control);


%%Grupo LTPB

predata_ltpb = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Patient.csv');
predata_ltpb(: , 1) = [ ];
predata_ltpb(: , 1) = [ ];
predata_ltpb(: , 10) = [ ];
data_ltpb = table2array(predata_ltpb);


%%Lançar software para grupo Controle:

%Presoftware(data_control)

%%Lançar Software para grupo LTPB:

%Presoftware(data_ltpb)

