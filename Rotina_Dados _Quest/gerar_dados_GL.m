%%%Preparando dados para inserção no Goalkeeper's Lab

%Grupo Controle

predata_control = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Control.csv');
predata_control(: , 1) = [ ]; 
data_control = table2array(predata_control);
data_control(: , 1) = [ ];

%Grupo LTPB

predata_ltpb = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Patient.csv');
predata_ltpb(: , 1) = [ ];
data_ltpb = table2array(predata_ltpb);
data_ltpb(: , 1) = [ ];

%%Lançar software para grupo Controle:

%data = data_control; %o nome da variável tem que ser data para rodar no software
%Presoftware(data)

%%Lançar Software para grupo LTPB:

%data=data_ltpb;
%Presoftware(data)

