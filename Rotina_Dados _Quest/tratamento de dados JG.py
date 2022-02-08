import os
import pandas as pd
#import matplotlib.pyplot as plt
import numpy as np
from functools import reduce

hold=[]
for i in range(len(os.listdir())-1):
    hold.append(pd.read_csv(os.listdir()[i]))
#print(os.listdir())


#removendo informações desnecessárias:

hold[1]=hold[1].filter(items=["participant_code","Que tratamentos ou medicações você está recebendo para dor?"])
hold[2]=hold[2].filter(items=["participant_code","Escore",'diagnostico'])
hold[3]=hold[3].filter(items=["participant_code",'pontuacaoold'])
hold[4]=hold[4].filter(items=["participant_code",'pontuacaodash1','pontuacaodash2','pontuacaodash3'])
hold[5]=hold[5].filter(items=["participant_code","escore","resultado"])
hold[6]=hold[6].filter(items=['participant_code','Qual o lado da dor após a lesão?'])
hold[7]=hold[7].filter(items=["participant_code","formcgilltotalsens","formcgilltotalfet","formcgilltotalaval","formcgilltotalmisc","formcgillnumtotal","formcgilltotaltotal"])
hold[8]=hold[8].filter(items=['participant_code','Idade',"Data:","DATA da LESÃO:","Qual o LADO da LESÃO?","Teve TRAUMATISMO CRANIOENCEFÁLICO ASSOCIADO à LESÃO?","Já fez alguma CIRURGIA DE PLEXO BRAQUIAL?","Já fez alguma CIRURGIA DE DOR?","Sexo","Escolaridade do participante",])

#print(hold[1])

#renomeando as colunas
for i in range(len(hold)):
        if "participant_code" in hold[i].columns:
               hold[i].rename(columns={'participant_code': 'p_code'}, inplace=True)
        if 'idade'in hold[i].columns:
             hold[i].rename(columns={'idade': 'age'}, inplace=True)
        if 'Idade' in hold[i].columns:
            hold[i].rename(columns={'Idade': 'age'}, inplace=True)
        if 'sexo'in hold[i].columns:
             hold[i].rename(columns={'sexo': 'gender'}, inplace=True)
        if "Que tratamentos ou medicações você está recebendo para dor?"  in hold[i].columns:
             hold[i].rename(columns={"Que tratamentos ou medicações você está recebendo para dor?": 'IBD_MED'}, inplace=True)
        if "Escore"in hold[i].columns:
             hold[i].rename(columns={"Escore": 'DN4_score'}, inplace=True)
        if 'diagnostico'in hold[i].columns:
             hold[i].rename(columns={'diagnostico': 'DN4_diag'}, inplace=True)
        if 'pontuacaoold'in hold[i].columns:
             hold[i].rename(columns={'pontuacaoold': 'LAT_score'}, inplace=True)
        if 'pontuacaodash1'in hold[i].columns:
             hold[i].rename(columns={'pontuacaodash1': 'DASH_score_1'}, inplace=True)
        if 'pontuacaodash2'in hold[i].columns:
             hold[i].rename(columns={'pontuacaodash2': 'DASH_score_2'}, inplace=True)
        if 'pontuacaodash3'in hold[i].columns:
             hold[i].rename(columns={'pontuacaodash3': 'DASH_score_3'}, inplace=True)
        if 'escore'in hold[i].columns:
             hold[i].rename(columns={'escore': 'MEEM_score'}, inplace=True)
        if 'resultado'in hold[i].columns:
             hold[i].rename(columns={'resultado': 'MEEM_result'}, inplace=True)
        if 'Qual o lado da dor após a lesão?'in hold[i].columns:
             hold[i].rename(columns={'Qual o lado da dor após a lesão?': 'ILDOR_side'}, inplace=True)
        if "DATA da LESÃO:"in hold[i].columns:
             hold[i].rename(columns={"DATA da LESÃO:": 'ENTRD_lesion_date'}, inplace=True)
        if "Qual o LADO da LESÃO?"in hold[i].columns:
             hold[i].rename(columns={"Qual o LADO da LESÃO?": 'ENTRD_lesion_side'}, inplace=True)
        if "Teve TRAUMATISMO CRANIOENCEFÁLICO ASSOCIADO à LESÃO?"in hold[i].columns:
             hold[i].rename(columns={"Teve TRAUMATISMO CRANIOENCEFÁLICO ASSOCIADO à LESÃO?":'ENTRD_head_trauma'}, inplace=True)
        if "Já fez alguma CIRURGIA DE PLEXO BRAQUIAL?"in hold[i].columns:
             hold[i].rename(columns={ "Já fez alguma CIRURGIA DE PLEXO BRAQUIAL?": 'ENTRD_arm_surgery'}, inplace=True)
        if "Escolaridade do participante"in hold[i].columns:
            hold[i].rename(columns={"Escolaridade do participante": 'ENTRD_scholarity'}, inplace=True)
        if "Data:" in hold[i].columns:
            hold[i].rename(columns={"Data:":"ENTRD_Date"}, inplace=True)
        if "Já fez alguma CIRURGIA DE DOR?" in hold[i].columns:
            hold[i].rename(columns={"Já fez alguma CIRURGIA DE DOR?": 'ENTRD_pain_surgery'}, inplace=True)


#print(hold)
#formatando os dados
for t in range(len(hold)):
  for i in range(hold[t].shape[0]):
   for j in range(hold[t].shape[1]):
       if isinstance(hold[t].iloc[i,j],str):
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace(',','.')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Masculino', 'M')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Feminino', 'F')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Esquerdo', 'L')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Direito', 'R')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Sim', 'T')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Nao', 'F')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Esquerda', 'L')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('Direita', 'R')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('X', 'missing')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('ZERO', 'R')
           hold[t].iloc[i,j] = hold[t].iloc[i,j].replace('N', 'DNA')

#
# #juntando os dataframes:

df=reduce(lambda left,right: pd.merge(left,right,on= 'p_code', how='outer'), hold)
df=df.drop_duplicates('p_code')
df=df.reset_index(drop='True')
df = df.replace(np.nan, -404 , regex=True) #determina o que aparece no lugar do 'nan'. As linhas de uma mesma coluna devem pertencer ao mesmo tipo, então altere esse parâmetro de acordo.
print(df)



#Selecionando informações

right_handed = (df['LAT_score'] >=0 | (df['LAT_score'] == -404))
left_compromised = df['ENTRD_lesion_side'] == 'L'
cut = right_handed & left_compromised


interest_df = df[cut]
interest_df = interest_df.reset_index(drop=True)
print(interest_df)

#Formando o arquivo final

interest_df.to_csv('sample_cut.csv')

