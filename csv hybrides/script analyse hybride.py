# -*- coding: utf-8 -*-

from locale import normalize
import pandas as pd
import plotly.express as px
import numpy as np


def script_run (file_input,file_ref,file_output):
    file_i = open(file_input,'r')
    file_r = open(file_ref,'r')
    file_o = open(file_output,'w')
    try :
        hybrid_table_select(file_i,file_r,file_o)
    finally :
        file_i.close()
        file_r.close()
        file_o.close()

def hybrid_table_select(file_i,file_r,file_o):
    table_hybrid = pd.read_csv(file_i) #lecture du fichier contenant les informations des hybrides
    #print(table_hybrid[0:5]) #verification de la lecture
    table_ref = pd.read_csv(file_r,sep="\t",header=None) #lecture du fichier contenant les informations de reference 
    #print(table_ref[0:5]) #verification de la lecture
    dn_ds = pd.Series(table_ref.iloc[:,2].str.replace(r'[][]', '', regex=True)).dropna #selection de la colonne contenant le dN dS, en enlever les bra
    bins = [-20,-16,-14,-10,-8,-4,-1.96,0,1.96,4,8]
    binned_data = pd.cut(dn_ds,bins)
    #print(dn_ds)
    significant = pd.Series(table_ref.iloc[:,3])
    pandas_ref = pd.DataFrame({'dn_ds':dn_ds,'significativité':significant,'binned':binned_data})
    pandas_ds_dn= pandas_ref['binned']
    print(pandas_ds_dn[0:5])
    #figure_dn_ds = px.histogram(pandas_ds_dn,x='dn_ds',title='distribution des dn-ds', nbins=20,histnorm='probability density')
    #figure_dn_ds.show()


    file_o.write("fichier test")


script_run('table_data_Barbushy1.csv','table_ref.csv','fichier test')