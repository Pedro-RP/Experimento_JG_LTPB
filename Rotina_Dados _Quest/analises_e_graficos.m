%%Preparando dados para inserção no Goalkeeper's Lab

%%Dados Completos
predata_full = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_full.csv'); 
predata_full(: , 1) = [ ];
data_full = table2array(predata_full);

%%Grupo Controle

predata_control = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_control.csv');
predata_control(: , 1) = [ ]; 
predata_control(: , 1) = [ ];
data_control = table2array(predata_control);

%%Grupo LTPB
predata_ltpb = readtable('C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Patient.csv');
predata_ltpb(: , 1) = [ ];
predata_ltpb(: , 1) = [ ];
data_ltpb = table2array(predata_ltpb);


%%Lançar software para grupo Controle:

%Presoftware(data_control)

%%Lançar Software para grupo LTPB:

%Presoftware(data_ltpb)

%%%%Construindo a média móvel

Z=data_full;  %arquivo sendo utilizado

%Construindo W ,como vetor de erros e acertos
for i = 1:size(Z,1);
  
   if Z(i,8)== Z(i,9);
       W(i)= 1;    
   else 
       W(i)= 0;
   end
   
   
end


%Definindo a Cell M composta pelos vetores m equivalentes a média móvel de
%cada participante

i=1;

for m=1:(size(Z,1)/1000) ;
w=W(i:i+999);

M{m}= movmean(w,101);

i=i+1000;

end

%Construindo os graficos

%Dar "clear" sempre que for rodar um gráfico novo

x = linspace(1,1000,1000);
title('Média Móvel de Acurácia - Completo') %Mudar o nome de acordo com o arquivo aberto
xlabel("Número da Jogada")
ylabel("Taxa de acerto")

set(0,'defaultaxescolororder', [[1 0 0]
                                [0 0 1]
                                [1 1 0]
                                [0 0 0]
                                [1 0 1]
                                [0 1 1]]);
                           
set(0,'defaultaxeslinestyleorder',{'-',':','-.'})

hold on
for I= 1:(size(Z,1)/1000) ;
l = num2str(I);
plot(x,M{I},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
ylim([0 1])
end

xline(334,'--','DisplayName','Intervalo 1');
xline(668,'--','DisplayName','Intervalo 2');

hold off
legend show


% %%% Contruindo médio móvel temporal
% for i = 1:size(Z,1);
%   P(i)=Z(i,7);
% %
%    end
%    
% %Definindo a Cell M composta pelos vetores m equivalentes a média móvel de
% %cada participante
% 
% i=1;
% 
% for p=1:(size(Z,1)/1000) ;
% u=P(i:i+999);
% N{p}= movmean(u,101);
% 
% i=i+1000;
% 
% end
% 
% %Construindo os graficos
% 
% %Dar "clear" sempre que for rodar um gráfico novo
% 
% x = linspace(1,1000,1000);
% 
% title('Média Móvel Temporal - Controle') %Mudar o nome de acordo com o arquivo aberto
% xlabel("Número da Jogada")
% ylabel("RTs")
% 
% set(0,'defaultaxescolororder', [[1 0 0]
%                                 [0 0 1]
%                                 [1 1 0]
%                                 [0 0 0]
%                                 [1 0 1]
%                                 [0 1 1]]);
%                            
% set(0,'defaultaxeslinestyleorder',{'-',':','-.'})
% 
% hold on
% for i= 1:(size(Z,1)/1000)
% l = num2str(i);
% plot(x,N{i},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
% ylim ([0 5])
% end
% 
% xline(334,'--','DisplayName','Intervalo 1');
% xline(668,'--','DisplayName','Intervalo 2');
% 
% hold off
% legend show
