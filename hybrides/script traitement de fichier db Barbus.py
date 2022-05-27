# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np


def script_run (file_input,file_output,file_Danio): #boucle qui vérifie la fichier et qui fait tourner la fonction
    file_i = open(file_input, "r") #lecture basique qu'on modifie avec la lecture csv juste en dessous
    file_fa = open(file_output,"w") #ecriture du fichier
    file_ref = open(file_Danio,'r')
    try :
        csv_dataframe(file_i,file_ref,file_fa)
    finally :
        file_i.close()
        file_fa.close()


def csv_dataframe(file_i,file_ref,file_fa):
    

    ref_genes = pd.read_csv(file_ref, sep=';',names= ["Kegg_id","Ensembl_id"]) #tableau contenant les identifiants des gènes
    #print(ref_genes)
    
    raw_dataframe = pd.read_csv(file_i,header=[0]) #tableur basique contenant toutes les infos du fichier csv, la 1ère ligne du csv étant le header du tableur
    fined_dataframe = raw_dataframe[["gene_id", "gene_name","transcript_sequence"]]  #refaire un dataframe qui ne prend que les colonnes qui nous interessent
    #print(fined_dataframe)

    ensdarg = ref_genes['Ensembl_id'] #seulement les identifiants ENSDARG d'assembl
    #print(ensdarg)
    filt = (fined_dataframe["gene_id"].isin(ensdarg)) #tableau boléen avec "True" si la valeure du fined_dataframe est dans les ensdarg, "False" si il ne l'est pas
    filtered_df = fined_dataframe[filt] #filtration du dataframe en correlant le dableau boléen avec le tableau affiné
    #print(filtered_df) #verification (CA MARCHE!)

    
    filtered_df['seq_length'] = filtered_df['transcript_sequence'].str.len() #enlever les duplicats des endarg en prennant que la sequence la plus grande
    #print(filtered_df)
    no_dup_df = filtered_df.sort_values('seq_length').drop_duplicates('gene_id', keep='last')
    #print(no_dup_df)

    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #pour faire un fichier excel à partir du dataframe pandas

    #writer = pd.ExcelWriter('longest ensdarg for each mtc gene phospho oxy.xlsx') #création d'un tableau excel
    #no_dup_df.to_excel(writer,index=False)
    #writer.close()
    
    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #écriture du fichier

    for seq in range(len(no_dup_df)):
        ensdarg_seq = (no_dup_df.iloc[seq,0]) #chaque ensdarg de chaque séquence
        sequences = (no_dup_df.iloc[seq,2]) #chaque séquence séparée
        file_fa.write(">" + ensdarg_seq + "_Barbus_barbus"+ "\n" + sequences + "\n")


#---------------------------------------------------------------------------------------------------------------------------------------------------------
#dire, dans l'ordre : quel fichier contient les infos à traiter
#                     comment on veux que le nouveau fichier s'appelle
#                     le nom du fichier de référence contenant les ensdarg de l'espèce de ref

script_run("BB.csv","BB.fa",'Danio ENSDARG.csv')


#---------------------------------------------------------------------------------------------------------------------------------------------------------


