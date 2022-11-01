from __future__ import division
import os
import csv
from operator import index
import numpy as np
import pandas as pd
from Formatacao_JG import ID
pd.set_option("display.max_rows", None, "display.max_columns", None)
#pd.options.display.float_format = "{:,.2f}".format
Dq_Full=pd.read_csv("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest_final/Data_questFull.csv")

#criando um monte de contador pras escalas
IBD_interference=0
IBD_interference_atv=0
prosp_mem=0
verb_flu=0
lat_D=0
lat_E=0
Ql=0
Final_quest=pd.DataFrame([])
P_list=["P010","P011","P012","P013","P015","P021", 'P006','P001', 'P025']
C_list = ['C001', 'C005', 'C006', 'C007', 'C008', 'C009', 'C011']
Data_LTPB=pd.DataFrame([])
Data_CTRL=pd.DataFrame([])

#iterando sobre cada linha e coluna do grafico
for i in Dq_Full.axes[0]:
    shortverb_mem = 0
    work_mem = 0
    ind_rac = 0
    longverb_mem = 0
    IBD_interference = 0
    IBD_interference_atv = 0
    lat_D = 0
    lat_E = 0
    Ql = 0
    for col in Dq_Full.columns:
        if col == "IBDJG1":
            if Dq_Full.loc[i,col]=="NaN":
                IBD_pain="NaN"
            else :
                IBD_pain = Dq_Full.loc[i, "IBDJG1"]
        elif col == "IBDJG2pt2":
            if Dq_Full.loc[i, col] != "NaN" or Dq_Full.loc[i, col] != "0":
                IBD_region=Dq_Full.loc[i,"IBDJG2pt2"]
            else:
                IBD_region = "NaN"
        elif col =="IBDJG3[SQ001]":
            if Dq_Full.loc[i, col] == "NaN":
                IBD_severity="NaN"
            else:
                IBD_severity= Dq_Full.loc[i, "IBDJG5[SQ001]"]
        elif col =="IBDJG7":
            if Dq_Full.loc[i, col] == "NaN" or Dq_Full.loc[i, col] == "0" :
                IBD_med="NaN"
            else:
                IBD_med=Dq_Full.loc[i, col]
        elif col =="IBDJG9[SQ001]":
            if Dq_Full.loc[i, col] == "NaN":
                IBD_interference ="NaN"
                IBD_interference_atv ="NaN"
            else:
                IBD_interference=(Dq_Full.loc[i, "IBDJG9[SQ001]"]+ Dq_Full.loc[i, "IBDJG9[SQ002]"]+ \
                              Dq_Full.loc[i, "IBDJG9[SQ003]"]+ Dq_Full.loc[i, "IBDJG9[SQ004]"]+ \
                              Dq_Full.loc[i, "IBDJG9[SQ005]"]+ Dq_Full.loc[i, "IBDJG9[SQ006]"]+ \
                              Dq_Full.loc[i, "IBDJG9[SQ007]"])/7
                IBD_interference_atv = (Dq_Full.loc[i, "IBDJG9[SQ001]"]+ Dq_Full.loc[i, "IBDJG9[SQ003]"]+\
                                    Dq_Full.loc[i, "IBDJG9[SQ004]"]+ Dq_Full.loc[i, "IBDJG9[SQ006]"])/4
        elif col =="IBDJG10[SQ001]":
            init_pain=Dq_Full.loc[i,"IBDJG10[SQ001]"]
            fin_pain= Dq_Full.loc[i,"IBDJG11[SQ001]"]
        #elif col == "IBDJG11[SQ001]":
        #elif col == "IBDJG12":
        #elif col == "IBDJG13[SQ001]":
        elif col == "SHORTVERBMEM[SQ001]":
            for t in Dq_Full.loc[i,"SHORTVERBMEM[SQ001]":"SHORTVERBMEM[SQ008]"]:
                if t == "sim (resposta correta)":
                    shortverb_mem +=1
        elif col =="WORKMEM[SQ001]":
            for f in Dq_Full.loc[i, "WORKMEM[SQ001]":"WORKMEM[SQ012]"]:
                if f == "sim (resposta correta)":
                    work_mem += 1
        elif col == "VERBFLU1[SQ001]":
            verb_flu= Dq_Full.loc[i,"VERBFLU1[SQ001]"] + Dq_Full.loc[i,"VERBFLU2[SQ002]"]
        elif col == "VERBFLU2[SQ001]":
            prosp_mem=Dq_Full.loc[i,"VERBFLU2[SQ001]"]
        elif col == "INDRAC[SQ001]":
            for R3 in Dq_Full.loc[i, "INDRAC[SQ001]":"INDRAC[SQ008]"]:
                if R3 == "sim (resposta correta)":
                    ind_rac += 1
        elif col == "LONGVERBMEM[SQ001]":
            for R3 in Dq_Full.loc[i, "LONGVERBMEM[SQ001]":"LONGVERBMEM[SQ008]"]:
                if R3 == "sim (resposta correta)":
                    longverb_mem += 1
        elif col == 'Qual a sua Idade ?':
            age=Dq_Full.loc[i, col]
        elif col == 'Qual o seu Sexo?':
            gender=Dq_Full.loc[i, col]
        elif col == 'Escolaridade':
            scholarity=Dq_Full.loc[i, col]
        elif col == 'Qual a sua Preferência manual ?':
            rel_handeness=Dq_Full.loc[i, col]
        elif col == 'Você tem experiência com computador ou jogos eletrônicos?':
            game_fam=Dq_Full.loc[i, col]
    for col2 in range(list(Dq_Full.columns).index(Dq_Full.columns[69]),list(Dq_Full.columns).index(Dq_Full.columns[-1]) + 1):
            if "[Escala 1]" in (Dq_Full.columns[col2]):
                if Dq_Full.iloc[i,col2] == "++":
                    lat_E +=2
                elif Dq_Full.iloc[i,col2] =="+":
                    lat_E +=1
            elif "[Escala 2]" in (Dq_Full.columns[col2]):
                if Dq_Full.iloc[i,col2] == "++":
                    lat_D +=2
                elif Dq_Full.iloc[i,col2] =="+":
                    lat_D +=1
            try:
                Ql=round((float(lat_D - lat_E)/float(lat_D + lat_E))*100)
            except ZeroDivisionError:
                Ql=0
    CT_Total=(7.2* prosp_mem)+(1* shortverb_mem)+(0.9* longverb_mem)+(0.8*work_mem)+(0.2*verb_flu)+(1.7*ind_rac)
    Final_series =pd.DataFrame(data={"LS_code": [Dq_Full.loc[i, "Codigo_de_acesso"]], "Game_code": [Dq_Full.loc[i, "IDLTPB[SQ002]"]],\
                                     "age": [age], "gender": [gender], "escolaridade": [scholarity],\
                                     "lat": [rel_handeness],"familiaridade": [game_fam], "dor no dia": [IBD_pain], \
                                     "região da dor": [IBD_region],"severidade": [IBD_severity], "medicação": [IBD_med],\
                                     "interferencia": [IBD_interference], "interferencia atividades": [IBD_interference_atv],\
                                     "dor pre jogo": [init_pain], "dor pos jogo": [fin_pain],"prospmem": [prosp_mem], \
                                     "shorverbmem": [shortverb_mem], "workmem": [work_mem], "verbflu": [verb_flu],\
                                     "indrac": [ind_rac], "longverbmem": [longverb_mem],"Total_COGTEL":[CT_Total],"Q_Lat":[Ql]})

    Final_quest=pd.concat([Final_quest,Final_series])
    #print(Final_series)

# separando os grupos
    if Final_quest.iloc[i, 0] in P_list:
        Data_LTPB=pd.concat([Data_LTPB, Final_series])
        #print(Data_LTPB)

    elif Final_quest.iloc[i, 0] in C_list:
        Data_CTRL=pd.concat([Data_CTRL,Final_series])
        #print(Data_CTRL)
    #print(Dq_Full.loc[0, "Codigo_de_acesso"])
    #print(Final_quest.iloc[i,0])


Data_LTPB.to_csv("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest_final/Data_quest_LTPB.csv",index=False)
Data_CTRL.to_csv("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest_final/Data_quest_CTRL.csv",index=False)