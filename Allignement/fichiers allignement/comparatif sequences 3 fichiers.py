# -*- coding: utf-8 -*-

  
# Creating a list of filenames
filenames = ['BB.fa', 'BM.fa','Danio.fa']
  
# Open file3 in write mode
with open('pre_allignement.txt', 'w') as outfile:
  
    # Iterate through list
    for names in filenames:
  
        # Open each file in read mode
        with open(names) as infile:
            list_sequences = []
            ensdarg = []
            seq = []
            #lecture de toutes les lignes de tous les fichiers
            for lignes in infile : 

                if (lignes[0] == ">"): #l'identifiant de chaque séquence
                    if lignes != ensdarg :
                        tuple_sequence = (ensdarg,seq)
                        list_sequences.append(tuple_sequence)
                    ensdarg = lignes.rstrip("\n")
                    #print(tuple_sequence) #vérification
                else :
                    seq = lignes.rstrip("\n")
                print(list_sequences) #vérification du contenu des tuples. CA MARCHE !!!!!
                
            #select similar sequences in the files
             
'''
            # read the data from file1,file2,file3 and write it in file4
            outfile.write(infile.read())
  
        # Add '\n' to enter data of file2
        # from next line
        outfile.write("\n")
'''