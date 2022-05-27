# -*- coding: utf-8 -*-

import pandas as pd
import csv



with open('Danio ENSDARG.csv', 'r') as file:
    reader = csv.reader(file)
    ensdarg = []
    for row in reader:
        liste = row[0]
        #print(liste)
        ensdarg = liste.rsplit(";")
        print(ensdarg[1])