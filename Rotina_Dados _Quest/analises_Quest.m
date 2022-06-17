f_control='C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\Quests_Control.csv';
d_control = readcell(f_control);
Q_control=d_control(1:9,1:10);
f_ltpb='C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\Quests_LTPB.csv';
d_ltpb = readcell(f_ltpb);
Q_ltpb=d_ltpb(1:9,1:12);

%%
[filepath,name,ext] = fileparts(f_ltpb);%Mudar de acordo com o arquivo
pa = 8;
%%
%Compara��o idades (Willcoxon test)

% [age_p,age_h]= ranksum(cell2mat(Q_control(2:9,3)),cell2mat(Q_ltpb(2:9,3)))

%%
%compara��o cogtel(Willcoxon test)

[cogtel_p,cogtel_h]= ranksum(cell2mat(Q_control(2:9,8)),cell2mat(Q_ltpb(3:9,8))) %excluindo P002


%%
%compara��o lateralidade(Willcoxon test)
% 
% [lat_p,lat_h]= ranksum(cell2mat(Q_control(2:9,9)),cell2mat(Q_ltpb(2:9,9)))
% 
% 
% 
% %%
% %compara�ao familiaridade(chi-squared)
% cfam_m = 0;
% cfam_a = 0;
% cfam_n = 0;
% lfam_m = 0;
% lfam_a = 0;
% lfam_n = 0;
% for i =drange(1:9) ;
%     if  isequal(Q_control(i,7),{'Muita'  }) 
%         cfam_m = cfam_m + 1;
%     elseif  isequal(Q_control(i,7),{'Alguma' })    
%         cfam_a = cfam_a + 1 ;
%     elseif isequal(Q_control(i,7),{'Nenhuma'})   
%         cfam_n = cfam_n + 1;
%     end
% end
% Cfam_freq=[cfam_m,cfam_a,cfam_n];%ocorrencia de respostas muita, alguma e nenhuma
% Cfam_chi=chi2gof(Cfam_freq)
% 
% for i =drange(1:9) ;
%     if  isequal(Q_ltpb(i,7),{'Muita'  }) 
%         lfam_m = lfam_m + 1;
%     elseif  isequal(Q_ltpb(i,7),{'Alguma' })    
%         lfam_a = lfam_a + 1 ;
%     elseif isequal(Q_ltpb(i,7),{'Nenhuma'})   
%         lfam_n = lfam_n + 1;
%     end
% end
% Lfam_freq=[lfam_m,lfam_a,lfam_n];
% Lfam_chi=chi2gof(Lfam_freq)
% [tbl,chi2stat,pval] = crosstab(Cfam_freq,Lfam_freq)
% 
% 
% %%
% %compara�ao escolaridade(chi-squared)
% cesc_em = 0;
% cesc_es = 0;
% cesc_pos = 0;
% lesc_em = 0;
% lesc_es = 0;
% lesc_pos = 0;
% for i =drange(1:9) ;
%     if  isequal(Q_control(i,5),{'Ensino médio completo'  }) 
%         cesc_em = cesc_em + 1;
%     elseif  isequal(Q_control(i,5),{'Ensino superior completo'})    
%        cesc_es =cesc_es + 1 ;
%     elseif isequal(Q_control(i,5),{'Pós-graduação'        })   
%         cesc_pos = cesc_pos + 1;
%     end
% end
% Cesc_freq=[cesc_em,cesc_es,cesc_pos];%ocorrencia de respostas muita, alguma e nenhuma
% Cesc_chi=chi2gof(Cesc_freq)
% for i =drange(1:9) ;
%     if  isequal(Q_ltpb(i,5),{'Ensino médio completo'  }) 
%         lesc_em = lesc_em + 1;
%     elseif  isequal(Q_ltpb(i,5),{'Ensino superior completo'})    
%         lesc_es = lesc_es + 1 ;
%     elseif isequal(Q_ltpb(i,5),{'Pós-graduação'        })   
%         lesc_pos = lesc_pos + 1;
%     end
% end
% Lesc_freq=[lesc_em,lesc_es,lesc_pos];
% Lesc_chi=chi2gof(Lesc_freq)
% [tbl,chi2stat,pval] = crosstab(Cesc_freq,Lesc_freq)
% 

%%% Correla��o Severidade de Dor x RTs globais m�dios (Rodar
%%% analises_e_graficos.m antes)

Severidade = cell2mat(Q_ltpb(3:9,10));

MTTT = Media_temporal_total_L.'; %Transposi��o da m�dia temporal total_L

RTxS = [MTTT Severidade];
% 
% [R,PValue] = corrplot(RTxS)
% 
% %%% Correla��o Interferencia da Dor x RTs globais m�dios (Rodar
% %%% analises_e_graficos.m antes)
% 

Interferencia = cell2mat(Q_ltpb(3:9,11));

RTxI = [MTTT Interferencia];

[R,PValue] = corrplot(RTxI)