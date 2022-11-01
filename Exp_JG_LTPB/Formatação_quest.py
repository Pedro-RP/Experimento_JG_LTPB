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
path=("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/dados")
path2=("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest")
path3=("C:/Users/Pedro_R/Desktop/Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest_final")
quest_list=open(path3+ "/" +"dataquest_full.csv",'w')
files = os.listdir(path)
file_count = len(files)
#print(file_count)
files2 = os.listdir(path2)

# #abrindo os arquivos do questionários
temp_AVAL = pd.read_csv(path2 + "/" + files2[0],engine="c",sep=",",encoding="UTF-8")
temp_questJG = pd.read_csv(path2 + "/" + files2[1])

#formatando as colunas dos dois aquivos
temp_questJG = temp_questJG.drop(temp_questJG.index[15])
temp_questJG = temp_questJG.drop(temp_questJG.index[4])
temp_questJG.rename(columns={"Código de acesso":"Codigo_de_acesso"},inplace = True)
temp_ID= list(temp_questJG["Codigo_de_acesso"])
temp_AVAL=temp_AVAL.assign(Codigo_de_acesso=temp_ID)

#excluindo todas as colunas com "tempo" dos dados de Avaliação
column_del="Tempo"
for column in temp_questJG.columns:
    if column_del in column:
        temp_questJG = temp_questJG.drop(columns=[column])

# print(temp_AVAL)
# print(temp_questJG)

#juntando os questionários
temp_questFull=temp_AVAL.set_index("Codigo_de_acesso").join(temp_questJG.set_index("Codigo_de_acesso"),lsuffix='_caller', rsuffix='_other',sort="True")
temp_questFull=temp_questFull.drop(columns=["Nome"])

print(temp_questFull.axes[0][0])
temp_questFull.to_csv("C:/Users/Pedro_R/Deskto/\Projeto/Code_exp_ltpb/Exp_JG_LTPB/quest_final/Data_questFull.csv",na_rep="NaN",index="True")
#print(temp_questFull.columns[-1]) list(temp_questFull.columns).index(temp_questFull.columns[-1]