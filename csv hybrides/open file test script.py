import pandas as pd


with open('table_data_Barbushy1.csv','r') as file_i :
    table = pd.read_csv(file_i)
    print(table[1:5])
