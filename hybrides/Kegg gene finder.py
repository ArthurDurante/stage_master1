# -*- coding: utf-8 -*-

import re


def Kegg_converter (file_input,file_output) :
    file_i = open(file_input,'r')
    file_o = open(file_output,'w')
    try :
        Kegg_genes (file_i,file_o)
    finally :
        file_i.close()
        file_o.close()

def Kegg_genes (file_i,file_o):
    for line in file_i:
        if line != "":
            gene_type = line.split()
            gene = gene_type[0]
            file_o.write(gene+"\n")



Kegg_converter('KEGG Danio rerio Oxidative phosphorylation.txt','gene list.txt')






























'''
import re
#pattern = (r'^[a-z]*+\:+[0-9]*')


def Kegg_converter (file_input) :
    file_i = open(file_input,'r')
    #file_o = open(file_output,'w')
    try :
        Kegg_genes (file_i)
    finally :
        file_i.close()
        #file_o.close()

def Kegg_genes (file_i):
    for line in file_i :
        if line [0] == 'dre':
            gene_types = line.split()
            print(gene_types[0])


Kegg_converter('KEGG Danio rerio Oxidative phosphorylation.txt')
'''