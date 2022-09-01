import os
import csv
from operator import index
import numpy as np
import pandas as pd


pd.set_option("display.max_rows", None, "display.max_columns", None) #pra os dados serem escritos além do limite de exibição do python#

# create empty lists
dataframes_list = []
Dset = pd.DataFrame()
path=(r"C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\dados")
path2=(r"C:\Users\Pedro_R\Desktop\Projeto\Code_exp_ltpb\Rotina_Dados _Quest\processed")
#
 # #Gerando a lista com todos os arquivos
files = os.listdir(path)
file_count = len(files)
#print(file_count)
for j in range(file_count):
    temp_df = pd.read_csv(path +"/"+ files[j])
    dataframes_list.append(temp_df)
new_index=list(range(1,1001))

 ##reorganizando e escrevendo as tabelas para ficarem compatíveis às rotinas de análise
count=0
for dataset in dataframes_list:
        count+=1
        for i in range(dataset.shape[0]):  # Número de linhas
            aux = list()
            aux = aux + [1] + [1]
            aux = aux + [str(dataset.iloc[i, 0])]  # coluna de movimentos
            aux = aux + [1]  # Coluna step
            aux = aux + [12]  # 12 é o identificador da árvore
            aux = aux + [count]  # adicionando identificação alternativa do participante
            aux = aux + [str(dataset.iloc[i, 3])]  # adicionando coluna de tempos de respostas
            aux = aux + [str(dataset.iloc[i, 2])]  # adicionando coluna de escolhas dos participantes
            aux = aux + [str(dataset.iloc[i, 1])]  # adicionando a cadeia do batedor
            data2set = pd.DataFrame(aux)
            frames = [Dset, data2set.T]
            Dset = pd.concat(frames)
            Dset = Dset.reset_index(drop=True)


Dset = Dset.set_axis([1,2,3,4,5,6,7,8,9], axis=1, inplace=False)
Dset.to_csv('dataframe_full.csv', index=False, header = False)

 ## #criando os arquivos individuais

df_full = pd.read_csv("dataframe_full.csv",header=None)
c=0

for i in range (file_count):
    Df_set = df_full.iloc[c:c+1000,:].to_csv(path2 + "/" + files[i], sep=',', index=False, header=False)
    c=c+1000

#criando os arquivos para os grupos

files_group = os.listdir(path2)
file_Controls = len(files_group)
file_Patients = len(files_group)
#print(files_group)
Controls= ["T014","T021","T022","T024","T027","T028","T030","T033"] #mudar aqui caso seja necessário remover algum participante das análises posteriores.
Patients= ["T006","T009","T010","T012","T015","T016","T017"]    #mudar aqui caso seja necessário remover algum participante das análises posteriores.
dataframes_control = []
dataframes_patient = []

Dset_Control = pd.DataFrame()
Dset_Patient = pd.DataFrame()
#Dset_Control=open("dataframe_Control.csv",'w')    #cria o arquivo com todos Controles
#Dset_Patient=open("dataframe_Patient.csv",'w')    #cria o arquivo com todos Pacientes

count1=0
for file in files_group:
    if file[0:4] in Controls:
        count1 += 1
        fl=[float(file[1:4])]*1000
        ID=pd.DataFrame(fl)
        temp_C = pd.DataFrame(pd.read_csv(path2 + "/" + file, header=None))
        temp_C= temp_C.set_axis([1,2,3,4,5,6,7,8,9], axis=1)
        temp_C.iloc[:, 5] = count1
        temp_C=pd.concat([temp_C ,ID], axis= 1 ,ignore_index=True)
        frames_C = [Dset_Control, temp_C]
        Dset_Control = pd.concat(frames_C)
        Dset_Control = Dset_Control.reset_index(drop=True)







count2 = 0
for file in files_group:
    if file[0:4] in Patients:
        count2 += 1
        fl =[float(file[1:4])] * 1000
        ID = pd.DataFrame(fl)
        temp_P = pd.DataFrame(pd.read_csv(path2 + "/" + file,header=None))
        temp_P = temp_P.set_axis([1, 2, 3, 4, 5, 6, 7, 8, 9], axis=1)
        temp_P.iloc[:, 5] = count2
        temp_P = pd.concat([temp_P, ID], axis=1, ignore_index=True)
        frames_P = [Dset_Patient, temp_P]
        Dset_Patient = pd.concat(frames_P)
        Dset_Patient = Dset_Patient.reset_index(drop=True)



    #print(file[0:4])

Dset_Control.to_csv('dataframe_Control.csv', index=False, header = False)
Dset_Patient.to_csv('dataframe_Patient.csv', index=False, header = False)



