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

files = os.listdir(path)
file_count = len(files)
print(file_count)
files2 = os.listdir(path2)
file_count2 = len(files2)

for j in range(file_count2):
    temp_df = pd.read_csv(path2 +"/"+ files2[j])
    dataframes_list.append(temp_df)

quest_list=open("dataquest_full.csv",'w')