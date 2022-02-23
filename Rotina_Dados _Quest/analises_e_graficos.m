%%%Preparando dados para inser��o no Goalkeeper's Lab

%%Dados Completos
predata_full = readtable('C:\Users\Numec\Documents\GitHub\main\Rotina_Dados _Quest\dataframe_full.csv'); 
predata_full(: , 1) = [ ];
data_full = table2array(predata_full);

%%Grupo Controle

predata_control = readtable('C:\Users\Numec\Documents\GitHub\main\Rotina_Dados _Quest\dataframe_Control.csv');
predata_control(: , 1) = [ ]; 
predata_control(: , 1) = [ ];
data_control = table2array(predata_control);

%%Grupo LTPB
predata_ltpb = readtable('C:\Users\Numec\Documents\GitHub\main\Rotina_Dados _Quest\dataframe_Patient.csv');
predata_ltpb(: , 1) = [ ];
predata_ltpb(: , 1) = [ ];
data_ltpb = table2array(predata_ltpb);


%%Lan�ar software para grupo Controle:

%Presoftware(data_control)

%%Lan�ar Software para grupo LTPB:

%Presoftware(data_ltpb)

%%%%Construindo a m�dia m�vel

Z=data_ltpb;  %arquivo sendo utilizado

%Construindo W ,como vetor de erros e acertos
for i = 1:size(Z,1);
  
   if Z(i,8)== Z(i,9);
       W(i)= 1;    
   else 
       W(i)= 0;
   end
   
   
end


%Definindo a Cell M composta pelos vetores m equivalentes a m�dia m�vel de
%cada participante

i=1;

for m=1:(size(Z,1)/1000) ;
w=W(i:i+999);

M{m}= movmean(w,101);

i=i+1000;

end

%Construindo os graficos

%Dar "clear" sempre que for rodar um gr�fico novo

x = linspace(1,1000,1000);
yticks(0:0.1:1);
title('M�dia M�vel de Acur�cia - ltpb') %Mudar o nome de acordo com o arquivo aberto
xlabel("N�mero da Jogada")
ylabel("RTs")

hold on
for I= 1:(size(Z,1)/1000) ;
l = num2str(I);
plot(x,M{I},'LineWidth',2,'MarkerSize',2,'DisplayName',l)
ylim([0 1])
end

hold off
legend show


% %%% Contruindo m�dio m�vel temporal
% for i = 1:size(Z,1);
%   P(i)=Z(i,7);
% %
%    end
%    
% %Definindo a Cell M composta pelos vetores m equivalentes a m�dia m�vel de
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
% %Dar "clear" sempre que for rodar um gr�fico novo
% 
% x = linspace(1,1000,1000);
% 
% title('M�dia M�vel Temporal - Full') %Mudar o nome de acordo com o arquivo aberto
% xlabel("N�mero da Jogada")
% ylabel("RTs")
% 
% hold on
% for i= 1:(size(Z,1)/1000)
% l = num2str(i);
% plot(x,N{i},'LineWidth',2,'MarkerSize',2,'DisplayName',l)
% ylim ([0 5])
% end
% hold off
% legend show
