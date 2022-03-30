%%Preparando dados para inserção no Goalkeeper's Lab

%%Dados Completos

file_full='C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_full.csv';
predata_full = readtable(file_full); 
predata_full(: , 1) = [ ];
data_full = table2array(predata_full);

%%Grupo Controle
file_control='C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Control.csv';
predata_control = readtable(file_control);
predata_control(: , 1) = [ ]; 
predata_control(: , 1) = [ ];
data_control = table2array(predata_control);

%%Grupo LTPB

file_ltpb='C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dataframe_Patient.csv';
predata_ltpb = readtable(file_ltpb);
predata_ltpb(: , 1) = [ ];
predata_ltpb(: , 1) = [ ];
data_ltpb = table2array(predata_ltpb);


%%Lançar software:

Z=data_control;  %arquivo sendo utilizado
[filepath,name,ext] = fileparts(file_ltpb);%Mudar de acordo com o arquivo
pa = 5; %participante que está sendo analisado.

%Presoftware(Z) 


%%Construindo um vetor C com os contextos que apareceram na sequência de
%%cada jogador
% 
% for j= 1:size(Z,1) 
% 
% C1(j)=Z(j,9); %Vetor com a sequencia do batedor para todos os jogadores
% 
% end
% 
% 
% d=1;
% 
% for c=1:(size(Z,1)/1000); %criando uma váriavel para a sequência de cada jogador
% C2{c}=C1(d:d+999);
% 
% d=d+1000;
% end
% 
% % %%% Contruindo média móvel temporal
% for i = 1:size(Z,1);
%   P(i)=Z(i,7);
% 
%    end
%    
% % % Definindo a Cell N composta pelos vetores p equivalentes a média móvel de
% % % cada participante
% 
% i=1;
% 
% for p=1:(size(Z,1)/1000) ;
% u=P(i:i+999);
% N{p}= movmean(u,25);
% 
% i=i+1000;
% 
% end
%%% Construindo Média móvel de acurácia

%Construindo W ,como vetor de erros e acertos
% for i = 1:size(Z,1);
%   
%    if Z(i,8)== Z(i,9);
%        W(i)= 1;    
%    else 
%        W(i)= 0;
%    end
%    
%    
% end


%Definindo a Cell M composta pelos vetores m equivalentes a média móvel de
%cada participante

% i=1;
% 
% for m=1:(size(Z,1)/1000) ;
% w=W(i:i+999);
% 
% M{m}= movmean(w,25);
% 
% i=i+1000;
% 
% end
%% criar lista T com mil 0 
tree_file_address= "C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\files_for_reference\tree_behave12.txt";
[ctx_rtime,ctx_er,ctx_resp,contexts,ctxrnds,ct_pos]=rtanderperctx(data_ltpb,pa,1,1000,tree_file_address,0,12);

T=repmat(0,1,1000);
t=repmat(0,1,1000);
%%loop q itera sobre o arquivo ctx_pos e pra cada posição da linha 4 muda 0 para 1 em T
for k = drange(1:1000)
   if ct_pos(4,k) ~= 0
     T(ct_pos(4,k))=1;
     t(k)=sum(T(1,1:k))/k;
   elseif  ct_pos(4,k) == 0
     t(k)=sum(T(1,1:k))/k;
   end
end

Id=Z(pa*1000 ,10);
space='|';
Name=strcat(num2str(pa),space,num2str(Id),space,name) ;

%%%Construindo o grafico de comparação entre indivíduos do mesmo grupo
% 
%%%Dar "clear" sempre que for rodar um gráfico novo
% 
% x = linspace(1,1000,1000);
% title('Média Móvel de Acurácia - Completo') %Mudar o nome de acordo com o arquivo aberto
% xlabel("Número da Jogada")
% ylabel("Taxa de acerto")
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
% for I= 1:(size(Z,1)/1000) ;
% l = strcat('Participante:T0',num2str(Z(I*1000 ,10)));
% plot(x,M{I},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',l)
% ylim([0 1])
% end
% 
% xline(334,'--','DisplayName','Intervalo 1');
% xline(668,'--','DisplayName','Intervalo 2');
% 
% hold off
% legend show

%Construindo o grafico de análise de indivíduos do grupo (acurácia)


% 
% x = linspace(1,1000,1000);
% title(strcat('Média M. Acurácia participante:', Name))
% 
% xlabel("Número da Jogada")
% 
% set(0,'defaultaxescolororder', [[1 0 0]
%                                 [0 0 1]
%                                 [1 1 0]
%                                 [0 0 0]
%                                 [1 0 1]
%                                 [0 1 1]]);
% 
% yyaxis left
% ac=plot(x,M{pa},'LineWidth',2.5,'MarkerSize',2.5, 'DisplayName', 'Acurácia', 'color', [1 0 0]);
% ylabel( "Taxa de acerto")
% 
% ylim([0 1])
% 
% yyaxis right
% ct=plot(x,t,'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Contextos', 'color', [0 0 1]);
% ylim([0 0.2])
% yticks([0 0.2])
% 
% legend show
% 
% xline(334,'--','DisplayName','Intervalo 1');
% xline(668,'--','DisplayName','Intervalo 2');
% 



%Construindo o grafico de análise de indivíduos do grupo (RTs)

%Dar "clear" sempre que for rodar um gráfico novo

% x = linspace(1,1000,1000);
% 
% title(strcat('Média M. temporal participante:', Name)) %Mudar o nome de acordo com o arquivo aberto
% xlabel("Número da Jogada")
% 
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
% end
% yyaxis left 
% plot(x,N{pa},'LineWidth',2.5,'MarkerSize',2.5,'DisplayName',num2str(pa))
% ylim ([0 5])
% ylabel("RTs")
% 
% yyaxis right 
% ct=plot(x,t,'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Contextos', 'color', [0 0 1]);
% ylim([0 0.2])
% yticks([0:0.05:0.2])
% ylabel("Proporção de contextos infrequentes")
% 
% 
% xline(334,'--','DisplayName','Intervalo 1');
% xline(668,'--','DisplayName','Intervalo 2');
% 
% hold off
% legend show

% Construindo gráficos de análise individual com a linha mostrando os
% contextos

% 
% pa = 1; %participante que está sendo analisado.
% 
% x = linspace(1,1000,1000);
% 
% yyaxis left
% plot(x,N{pa},'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'RT','color', [0 0 1])
% legend show
% 
% yyaxis right
% 
% plot(x,C2{pa},'LineWidth',0.001,'MarkerSize',2.5, 'DisplayName', 'Contextos', 'color', [1 1 0])
% ylim([0 2])
% yticks([0 1 2])
% 
% xline(334,'--','DisplayName','Intervalo 1');
% xline(668,'--','DisplayName','Intervalo 2');

%%% Boxplot de acurácia por bloco - Grupo Controle

for i = 1:size(data_control,1);
  
   if Z(i,8)== Z(i,9);
       W(i)= 1;    
   else 
       W(i)= 0;
   end
   
   
end

a=1;

for par = 1:(size(data_control,1)/1000) ;
A{par}=W(a:a+999); %Cria um vetor para cada participante dizendo em quais posições cada participante acertou ou errou

a=a+1000;

end

%Bloco 1

AC1 = 0;
for par = 1:(size(data_control,1)/1000);
    for k = drange(1:334); %numero de jogadas do bloco
        
        AC1 = AC1 + A{par}(k); %AC1 -> Acurácia do grupo controle no bloco 1. É a soma dos termos contidos no intervalo k para A{par}
    end
    
    MAC1(par) = AC1/334;  %MAC1 é um vetor em que cada termo corresponde a média de acurácia de um participante no primeiro bloco.
    AC1=0;

end
%Bloco 2

AC2 = 0;
for par = 1:(size(data_control,1)/1000);
    for k = drange(335:668); 
        
        AC2 = AC2 + A{par}(k); 
    end
    
    MAC2(par) = AC2/334;  
    AC2=0;
end

%Bloco 3

AC3 = 0;
for par = 1:(size(data_control,1)/1000);
    for k = drange(669:1000); 
        
        AC3 = AC3 + A{par}(k); 
    end
    
    MAC3(par) = AC3/332;  
    AC3=0;
end

%Boxplot

MACT = [MAC1;MAC2;MAC3].'; %ordena dados em uma matriz para que o comando do boxplot possa funcionar.

BMACT = boxplot(MACT); %boxplot mostrando evolução ao longo dos blocos.

title('Média de acurácia de cada participante em cada bloco - Grupo Controle')
ylabel("Acurácia");
xlabel("Bloco")

%%% Boxplot de acurácia por bloco - Grupo LTPB

%Bloco 1

%Bloco 2

%Bloco 3

%%% Boxplot dos RTs por bloco - Grupo Controle

%Bloco 1

%Bloco 2

%Bloco 3

%%% Boxplot dos RTs por bloco - Grupo LTPB

%Bloco 1

%Bloco 2

%Bloco 3
