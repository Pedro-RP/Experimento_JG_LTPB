import os
import csv
from operator import index
import numpy as np
import pandas as pd


#cria uma nova pasta dentro da pasta do projeto
#os.makedirs('C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/dados/processados', exist_ok=True)


# create empty lists
dataframes_list = []
Dset = pd.DataFrame()
Dset_list = []

#gerando a lista com todos os arquivos
path=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/dados")
path2=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/processed")
files = os.listdir(path)
file_count = len(files)
print(file_count)
for j in range(file_count):
    temp_df = pd.read_csv(path +"/"+ files[j])
    dataframes_list.append(temp_df)
new_index=list(range(1,1001))
pd.set_option("display.max_rows", None, "display.max_columns", None) #pra os dados serem escritos além do limite de exibição do python#

Dsetwlist=open("dataframe_full.csv",'w')    #cria o arquivo com todos os dados
#reorganizando e escrevendo as tabelas para ficarem compatíveis às rotinas de análise
for dataset in dataframes_list:
        for i in range(dataset.shape[0]):  # Número de linhas
            aux = list()
            aux = aux + [1] + [1]
            aux = aux + [str(dataset.iloc[i, 0])]  # coluna de movimentos
            aux = aux + [1]  # Coluna step
            aux = aux + [12]  # 12 é o identificador da árvore
            aux = aux + [1]  # adicionando identificação alternativa do participante
            aux = aux + [str(dataset.iloc[i, 3])]  # adicionando coluna de tempos de respostas
            aux = aux + [str(dataset.iloc[i, 2])]  # adicionando coluna de escolhas dos participantes
            aux = aux + [str(dataset.iloc[i, 1])]  # adicionando a cadeia do batedor
            data2set = pd.DataFrame(aux)
            frames = [Dset, data2set.T]
            Dset = pd.concat(frames)
            Dset = Dset.reset_index(drop=True)
Dset = Dset.set_axis([1,2,3,4,5,6,7,8,9], axis=1, inplace=False)
Dsetwlist.write(str(Dset))
Dset_list.append(Dset)
Dsetwlist.close()

#criando os arquivos individuais
df_full = pd.read_csv("dataframe_full.csv" )
for i in range (file_count):
    #df_full = df_full.reset_index(drop='True')
    Df_set=df_full[:1000].to_csv(path2 + "/" +files[i],sep=',',index=False,header=False)
    df_full = df_full.drop(df_full.index[range(1000)])
    df_full = df_full.reindex(new_index)
    df_full = df_full.drop(df_full.iloc[:, 1:])
    #df_full = df_full.set_axis([1, 2, 3, 4, 5, 6, 7, 8, 9], axis=1, inplace=False)
#print(Df_set)

