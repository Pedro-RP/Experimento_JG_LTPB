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

#gerando a lista com todos os arquivos
path=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/dados")
path2=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/quest")
path3=("C:/Users/Numec/Documents/GitHub/main/Rotina_Dados _Quest/quest_final")
quest_list=open(path3+ "/" +"dataquest_full.csv",'w')
files = os.listdir(path)
file_count = len(files)
print(file_count)
files2 = os.listdir(path2)
#abrindo os arquivos do questionários
temp_AVAL = pd.read_csv(path2 + "/" + files2[0])
temp_questJG = pd.read_csv(path2 + "/" + files2[1])
#formatando as colunas dos dois aquivos
temp_questJG = temp_questJG.drop(temp_questJG.index[15])
temp_questJG = temp_questJG.drop(temp_questJG.index[4])
#temp_AVAL = temp_AVAL.drop(columns=["IDLTPB[SQ001]"])
temp_ID= list(temp_questJG["Código de acesso"])
temp_AVAL=temp_AVAL.assign(ID=temp_ID)
#excluindo todas as colunas com "tempo" dos dados de Avaliação
column_del="Tempo"
for column in temp_questJG.columns:
    if column_del in column:
        temp_questJG = temp_questJG.drop(columns=[column])


print(temp_AVAL)
#print(temp_questJG)