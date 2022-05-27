# -*- coding: utf-8 -*-

import pandas as pd



def run_script (file_input):
    file_i = open(file_input, "r")
    try:
        info_seq = sequences(file_i)
    finally:
        file_i.close()
    return info_seq

def sequences(file_i):
    
    list_sequences = []
    ensdarg = []
    seq = []
    merge = []
    for lines in file_i :
        if (lines[0] == '>'):
            if lines != ensdarg :
                tuple_sequence = (ensdarg,seq)
                list_sequences.append(tuple_sequence)
            ensdarg = lines.rstrip('\n')
            #print(ensdarg) #vérification
            #print(tuple_sequence) #verification
        else :
            sequences = lines.rstrip('\n\r')
            merge.append(sequences)
            seq = ''.join(merge)
            #print(seq) #vérification
        tuple_sequence = (ensdarg,seq)
        list_sequences.append(tuple_sequence)
        print(list_sequences)

    




results = run_script('Danio.fa')








'''
filename = ['Danio.fa']

def Danio_file(filename):
# Open file3 in write mode
    with open('no_dup Danio.fa', 'w') as outfile:
    
        # Iterate through list
        for names in filename:
    
            # Open each file in read mode
            with open(names) as infile:
                list_sequences = []
                ensdarg = []
                seq = []
                merge = []
                #lecture de toutes les lignes de tous les fichiers et 
                for lignes in infile : 

    #---------------------------------------------------------------------------------------------------------------------------
                    #création de tuples contenant chaque ensdarg et la séquence correspondante

                    if (lignes[0] == ">"): #l'identifiant de chaque séquence
                        if lignes != ensdarg :
                            tuple_sequence = (ensdarg,seq)
                            list_sequences.append(tuple_sequence)
                        ensdarg = lignes.rstrip("\n")
                        print(tuple_sequence) #vérification
                    else :
                        sequences = lignes.rstrip("\n\r")
                        merge.append(sequences)
                        seq = ''.join(merge)
                        #print(seq) #vérification
                    #print(list_sequences) #vérification du contenu des tuples. CA MARCHE !!!!!
#---------------------------------------------------------------------------------------------------------------------------
                #création d'un dataframe contenant toutes les infos prise précedemment
'''