% *% Boxplot de RTs por bloco para os dois grupos*

% for i = 1:size(ZC,1);
%    
%     T(i)= ZC(i,7);
%    
%    
% end
% 
% a=1;
% 
% for par = 1:(size(ZC,1)/1000) ;
% A{par}=T(a:a+999); 
% 
% a=a+1000;
% 
% end
% 
% %Bloco 1-controle
% 
% AC1 = 0;
% for par = 1:(size(ZC,1)/1000);
%     for k = drange(1:334); %numero de jogadas do bloco
%         
%         AC1 = AC1 + A{par}(k); %AC1 -> Acurácia do grupo controle no bloco 1. É a soma dos termos contidos no intervalo k para A{par}
%     end
%     
%     MAC1(par) = AC1/334;  %MAC1 é um vetor em que cada termo corresponde a média de acurácia de um participante no primeiro bloco.
%     AC1=0;
% 
% end
% %Bloco 2-controle
% 
% AC2 = 0;
% for par = 1:(size(ZC,1)/1000);
%     for k = drange(335:668); 
%         
%         AC2 = AC2 + A{par}(k); 
%     end
%     
%     MAC2(par) = AC2/334;  
%     AC2=0;
% end
% 
% %Bloco 3-controle
% 
% AC3 = 0;
% for par = 1:(size(ZC,1)/1000);
%     for k = drange(669:1000); 
%         
%         AC3 = AC3 + A{par}(k); 
%     end
%     
%     MAC3(par) = AC3/332;  
%     AC3=0;
% end
% 
% for i = 1:size(ZL,1);
%     
%     T2(i)= ZL(i,7);
% end     
% a=1;
% 
% for par = 1:(size(ZL,1)/1000) ;
% A{par}=T2(a:a+999); %Cria um vetor para cada participante contendo seus tempos de resposta
% 
% 
% a=a+1000;
% 
% end
% %Bloco 1-ltpb
% 
% AC4 = 0;
% for par = 1:(size(ZL,1)/1000);
%     for k = drange(1:334); %numero de jogadas do bloco
%         
%         AC4 = AC4 + A{par}(k); %AC4 -> tempos do grupo controle no bloco 1. É a soma dos termos contidos no intervalo k para A{par}
%     end
%     
%     MAC4(par) = AC4/334;  %MAC1 é um vetor em que cada termo corresponde a média de tempos de um participante no primeiro bloco.
%     AC4=0;
% 
% end
% %Bloco 2-ltpb
% 
% AC5 = 0;
% for par = 1:(size(ZL,1)/1000);
%     for k = drange(335:668); 
%         
%         AC5 = AC5 + A{par}(k); 
%     end
%     
%     MAC5(par) = AC5/334;  
%     AC5=0;
% end
% 
% %Bloco 3-ltpb
% 
% AC6 = 0;
% for par = 1:(size(ZL,1)/1000);
%     for k = drange(669:1000); 
%         
%         AC6 = AC6 + A{par}(k); 
%     end
%     
%     MAC6(par) = AC6/332;  
%     AC6=0;
% end
% 
% %Boxplot
% TMA=[MAC1 MAC4];
% TMB=[MAC2 MAC5];
% TMC=[MAC3 MAC6];
% MACT2 = [TMA TMB TMC]; %ordena dados em uma matriz para que o comando do boxplot possa funcionar.
% 
% grp =[zeros(1,7),ones(1,8),2*ones(1,7),3*ones(1,8),4*ones(1,7),5*ones(1,8)]; %grouping variable. Para casos em que as colunas que estamos comparando não tem o mesmo número de individuos, colocamos tudo em uma linha e usamos essa notação pra discernir quais valores são de quais grupos. Valores iguais pertencem ao mesmo grupo. Um valor para cada coluna.
% %o segundo argumento das funções ímpares é o número de partcipantes no
% %grupo controle e o segundo argumento das funções pares é o número de
% %participantes do grupo LTPB
% 
% BMACT2 = boxplot(MACT2,grp); %boxplot mostrando evolução ao longo dos blocos.
% 
% title(strcat('Distribuição dos tempos de resposta dos grupos em cada bloco'));
% ylabel("Tempos");
% ylim([0 2.5])
% yticks([0:0.2:2.5])
% xticks([1 2 3 4 5 6])
% xticklabels({'1° Bloco - Controle','1° Bloco - LTPB', '2° Bloco - Controle', '2° Bloco - LTPB','3° Bloco - Controle', '3° Bloco - LTPB'})
% xline(2.5)
% xline(4.5)
% 
% grp2=[zeros(1,7),ones(1,8)];
% 
% %comparação entre grupos bloco 1
% CxL1=kruskalwallis(TMA, grp2);
% % 
% % %comparação entre grupos bloco 2
% % CxL2=kruskalwallis(TMB,grp2);%2
% % % 
% % %comparação entre grupos bloco 3
% % CxL3=kruskalwallis(TMC, grp2);%3
% % 
% % grp3 = [zeros(1,7),ones(1,7)];
% % TMD=[MAC1 MAC3];%comparação grupo controle bloco 1&3
% % C1xC3 = kruskalwallis(TMD, grp3);%4
% % 
% % grp4 = [zeros(1,8),ones(1,8)];
% % TME=[MAC4 MAC6];
% % L1xL3=kruskalwallis(TME, grp4); %5
% 
% Media_temporal_total_c = (MAC1 + MAC2 + MAC3)/3;
% Media_temporal_total_L = (MAC4 + MAC5 + MAC6)/3;
% 
% 
% TMF = [Media_temporal_total_c Media_temporal_total_L];
% % CTxLT = kruskalwallis(TMF, grp2);
% 
% 
%

