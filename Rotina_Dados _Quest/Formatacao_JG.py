import os
import csv
from operator import index
import numpy as np
import pandas as pd

pd.set_option("display.max_rows", None, "display.max_columns", None) #pra os dados serem escritos além do limite de exibição do python#

# create empty lists
dataframes_list = []
Dset = pd.DataFrame()
Dset_list = []
path=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/dados")
path2=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/processed")
#
# # #gerando a lista com todos os arquivos
# files = os.listdir(path)
# file_count = len(files)
# print(file_count)
# for j in range(file_count):
#     temp_df = pd.read_csv(path +"/"+ files[j])
#     dataframes_list.append(temp_df)
# new_index=list(range(1,1001))
# Dsetwlist=open("dataframe_full.csv",'w')    #cria o arquivo com todos os dados
#
# ##reorganizando e escrevendo as tabelas para ficarem compatíveis às rotinas de análise
# count=0
# for dataset in dataframes_list:
#         count+=1
#         for i in range(dataset.shape[0]):  # Número de linhas
#             aux = list()
#             aux = aux + [1] + [1]
#             aux = aux + [str(dataset.iloc[i, 0])]  # coluna de movimentos
#             aux = aux + [1]  # Coluna step
#             aux = aux + [12]  # 12 é o identificador da árvore
#             aux = aux + [count]  # adicionando identificação alternativa do participante
#             aux = aux + [str(dataset.iloc[i, 3])]  # adicionando coluna de tempos de respostas
#             aux = aux + [str(dataset.iloc[i, 2])]  # adicionando coluna de escolhas dos participantes
#             aux = aux + [str(dataset.iloc[i, 1])]  # adicionando a cadeia do batedor
#             data2set = pd.DataFrame(aux)
#             frames = [Dset, data2set.T]
#             Dset = pd.concat(frames)
#             Dset = Dset.reset_index(drop=True)
# Dset = Dset.set_axis([1,2,3,4,5,6,7,8,9], axis=1, inplace=False)
# Dsetwlist.write(str(Dset))
# Dset_list.append(Dset)
# Dsetwlist.close()
#
# # #criando os arquivos individuais
# df_full = pd.read_csv("dataframe_full.csv" )
# for i in range (file_count):
#     Df_set=df_full[:1000].to_csv(path2 + "/" +files[i],sep=',',index=False,header=False)
#     df_full = df_full.drop(df_full.index[range(1000)])
#     df_full = df_full.drop(df_full.iloc[:, 1:])
# #print(Df_set)
#
#criando os arquivos para os grupos
files_group = os.listdir(path2)
file_Controls = len(files_group)
file_Patients = len(files_group)
#print(files_group)
Controls= ["T014","T021","T022","T024","T027","T028","T030","T033"]
Patients= ["T006","T007","T009","T010","T012","T015","T016","T017"]
dataframes_control = []
dataframes_patient = []
Dset_Control=open("dataframe_Control.csv",'w')    #cria o arquivo com todos Controles
Dset_Patient=open("dataframe_Patient.csv",'w')    #cria o arquivo com todos Pacientes

count1=0
for file in files_group:
    if file[0:4] in Controls:
        count1 += 1
        fl=[file[0:4]]*1000
        ID=pd.DataFrame(fl)
        temp_C = pd.DataFrame(pd.read_csv(path2 + "/" + file,delim_whitespace=True,header=None))
        #temp_C= temp_C.set_axis([1,2,3,4,5,6,7,8,9], axis=1, inplace=False)
        temp_C.iloc[:,6]=count1
        temp_C=pd.concat([temp_C ,ID], axis= 1 ,ignore_index=True)
        Dset_Control.write(temp_C.to_string(header=False)+"\n")




count2 = 0
for file in files_group:
    if file[0:4] in Patients:
        count2 += 1
        fl = [file[0:4]] * 1000
        ID = pd.DataFrame(fl)
        temp_P = pd.DataFrame(pd.read_csv(path2 + "/" + file ,delim_whitespace=True,header=None))
        #temp_P = temp_P.set_axis([1, 2, 3, 4, 5, 6, 7, 8, 9], axis=1, inplace=False)
        temp_P.iloc[:,6] = count2
        temp_P = pd.concat([temp_P, ID], axis=1, ignore_index=True)
        Dset_Patient.write(temp_P.to_string(header=False)+"\n")


print((Dset_Control))

Dset_Control.close()
Dset_Patient.close()
