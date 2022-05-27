library(ggplot2)
library(grid)
library(dplyr)
library(tidyr)
library(stringr)

#set directory
getwd()
setwd("C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/dn-ds & pdist/csv files")

#données dn-ds généraux
dn_ds_graph <- read.csv("dn_ds_tt_graph.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec = ",")
dn_ds_tt <- read.csv("dN_dS - total.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec =",")
dn_ds_mtc <- read.csv("dN_dS - mtc.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
dn_ds_nuc <- read.csv("dN_dS - nuc.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")

#assemblage des données dn-ds généraux
dn_mtc <- data.frame(groupe = 'gènes mitochondriaux', value = dn_ds_mtc$V3)
dn_nuc <- data.frame(groupe = "gènes nucléaires", value = dn_ds_nuc$V3)
assembled_data <- rbind(dn_mtc,dn_nuc)

#données dn-ds barbus mitochondrial et nucléaire
dn_ds_mtc_barbus <- read.csv("dN_dS_mtc_barbus.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
dn_ds_nuc_barbus <- read.csv("dN_dS_nuc_barbus.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")

#assemblage des données dn-ds barbus
dn_mtc_barbus <- data.frame(groupe = 'gènes mitochondriaux',ENSDARG = dn_ds_mtc_barbus$V1 , value = dn_ds_mtc_barbus$V3)
dn_nuc_barbus <- data.frame(groupe = "gènes nucléaires",ENSDARG = dn_ds_nuc_barbus$V1 ,value = dn_ds_nuc_barbus$V3)
assembled_barbus <- rbind(dn_mtc_barbus,dn_nuc_barbus)



#Turn your 'treatment' column into a character vector
dn_ds_graph$V1 <- as.character(dn_ds_graph$V1)
#Then turn it back into a factor with the levels in the correct order
dn_ds_graph$V1 <- factor(dn_ds_graph$V1, levels=unique(dn_ds_graph$V1))

sélect_nat <- c("sélection positive","neutralité","sélection négative")



#histograms
ggplot(data = dn_ds_graph,aes(x=x1, y=y1))+
  theme_bw()+
  xlab("score Z")+
  ylab("nombre de valeurs")+
  geom_col(aes(V1,V2),fill = 'steelblue')+
  geom_text(aes(V1,V2,label = V2), vjust = 1.5, colour = "black")+
  geom_line(aes(as.numeric(V1),V2), color='darkorchid4',size = 1)+
  geom_vline(xintercept= 9.5, colour = "red",size = 1)+
  geom_vline(xintercept= 12.5, colour = "red",size = 1)

#box plots cyprinidae
means <- aggregate(value ~  groupe, assembled_data, mean)

ggplot(assembled_data, aes(x=groupe,y=value,fill=groupe))+
  geom_boxplot()+
  xlab(" ")+
  ylab("score Z")+
  stat_summary(fun=mean, colour="darkred", geom="point", 
               shape=18, size=3, show.legend=FALSE) + 
  geom_text(data = means, aes(label = round(value,4), y = round(value,4) +0.9), color = "black")

#box plots barbus
means <- aggregate(value ~  groupe, assembled_barbus, mean)

ggplot(assembled_barbus, aes(x=groupe,y=value,fill=groupe))+
  geom_boxplot()+
  xlab(" ")+
  ylab("score Z")+
  stat_summary(fun=mean, colour="darkred", geom="point", 
               shape=18, size=3, show.legend=FALSE) + 
  geom_text(data = means, aes(label = round(value,4), y = round(value,4) +0.9), color = "black")


#tableau des gènes mitochondriaux du barbus
genes <- read.csv("Barbus gene symbols.csv", sep = ";",header = TRUE,fileEncoding="UTF-8-BOM",dec=",")
gene_info <- data.frame(do.call("rbind",strsplit(as.character(genes$Gene.Info)," ",fixed = TRUE)))
gene_name <- data.frame(ENSDARG = genes$Input.Value,gene = gsub("]","",as.character(gene_info$X4)))

dn_ds_for_mtc_genes <- data.frame(ENSDARG = dn_ds_mtc_barbus$V1, Z = dn_ds_mtc_barbus$V3)
MTC_barbus_info <- merge(dn_ds_for_mtc_genes,gene_name, by = "ENSDARG")
MTC_barbus <- data.frame(ENSDARG = MTC_barbus_info$ENSDARG, 
                              gene_symbol = MTC_barbus_info$gene, 
                              Z = MTC_barbus_info$Z)

#ajout des p-distances dans le tableau
pdist_mtc_barbus <- read.csv("pdist_mtc_barbus.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM")
pdist_mtc_barbus$pdistance <- (pdist_mtc_barbus$V3)
MTC_barbus <- data.frame(allignement = "Barbus",
                         ENSDARG = MTC_barbus$ENSDARG,
                         gene_symbol = MTC_barbus$gene_symbol,
                         Z = MTC_barbus$Z,
                         pdistance = pdist_mtc_barbus$pdistance)

#tableau des gènes mitochondriaux cyprinidae
dn_ds_mtc_cypri <- read.csv("dN_dS_mtc_cypri.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
pdist_mtc_cypri <- read.csv("pdist_mtc_cypri.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=".")

pdistance_cypri <- (pdist_mtc_cypri$V3)

MTC_cypri <- data.frame(allignement = "cyprinidae",
                        ENSDARG = dn_ds_mtc_cypri$V1, 
                        gene_symbol = "NA", 
                        Z = dn_ds_mtc_cypri$V3, 
                        pdistance = pdistance_cypri)


#graphique de distribution pdistance par rapport à Z des gènes de OXPHOS entre les barbus vs chez les cyprinidae
pdist_tt_dr_others <- read.csv("pdist_tt_dr_others.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=".")
pdist_dr_others <- data.frame(allignement = "cyprinidae",
                              ENSDARG1 = pdist_tt_dr_others$V1,
                              ENSDARG2 = pdist_tt_dr_others$V2,
                              pdistance = pdist_tt_dr_others$V3)
pdist_tt_barbus <- read.csv("pdist_tt_bb_bm.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=".")
pdist_bb_bm <- data.frame(allignement = "barbus",
                          ENSDARG1 = pdist_tt_barbus$V1,
                          ENSDARG2 = pdist_tt_barbus$V2,
                          pdistance = pdist_tt_barbus$V3)
Z_tt_dr <- read.csv("Z_tt_dr_others.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
Z_tt_dr_data <- data.frame(ENSDARG1 = Z_tt_dr$V1,
                           ENSDARG2 = Z_tt_dr$V2,
                           Z = Z_tt_dr$V3)
Z_tt_barbus <- read.csv("Z_tt_bb_bm.csv",sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
Z_tt_bb_bm_data <- data.frame(ENSDARG1 = Z_tt_barbus$V1,
                           ENSDARG2 = Z_tt_barbus$V2,
                           Z = Z_tt_barbus$V3)

pdist_general <- rbind(pdist_bb_bm,pdist_dr_others)
Z_general <- rbind(Z_tt_bb_bm_data,Z_tt_dr_data)

pdist_graph <- merge(pdist_general,Z_general,by = c("ENSDARG1","ENSDARG2"), all.x = TRUE)
Z_graph <- merge(pdist_general,Z_general,by = c("ENSDARG1","ENSDARG2"), all.y = TRUE)

pdist_Z_graph <- data.frame(ENSDARG = substr(pdist_graph$ENSDARG1,1,19),
                            allignement = pdist_graph$allignement,
                            pdistance = pdist_graph$pdistance,
                            Z = Z_graph$Z)

outlier1 <- "ENSDARG00000075768"
outlier2 <- "ENSDARG00000019332"

pdist_Z_graph <- pdist_Z_graph[!grepl(outlier1,pdist_Z_graph$ENSDARG),]
pdist_Z_graph <- pdist_Z_graph[!grepl(outlier2,pdist_Z_graph$ENSDARG),]

#graphique pdistance  vs taux de mutation normalisé Z
ggplot(pdist_Z_graph,aes(y = Z, group = allignement))+
  geom_smooth(data=subset(pdist_Z_graph,allignement == "barbus"),aes(x=pdistance, colour = "barbus - meridionalis"), method = "loess",formula=y~x, fill = "red", alpha = 0.2)+
  geom_point(data=subset(pdist_Z_graph,allignement == "barbus"),aes(x=pdistance), col = "red", alpha = 0.4, shape = 17)+
  geom_smooth(data=subset(pdist_Z_graph,allignement == "cyprinidae"),aes(x=pdistance, colour = " cyprinidae"), method = "loess",formula=y~x, fill = "blue", alpha = 0.2)+
  scale_y_continuous(name="score Z", sec.axis=sec_axis(~.,breaks = c(1.96,-1.96)))+
  scale_color_manual(name = "alignement", values = c("blue","red"))+
  theme(
    axis.title.x.bottom= element_text(size = 12),
    axis.title.y.left = element_text(size = 12)
  )+
  ylab("valeur Z")+
  geom_hline(yintercept = -1.96, color = "black", size = 1)+
  geom_hline(yintercept = 1.96, color = "black", size = 1)
  
pearson_test_pZ_BM <- cor.test(pdist_bb_bm$pdistance,Z_tt_bb_bm_data$Z,method = "pearson")
pearson_test_pZ_BM
pearson_test_pZ_Dr <- cor.test(pdist_dr_others$pdistance,Z_tt_dr_data$Z,method = "pearson")
pearson_test_pZ_Dr


#distribution des Z et pdistance des gènes mitochondriaux


MTC_barbus_sorted <- MTC_barbus[order(MTC_barbus$Z),]


ggplot(MTC_barbus_sorted,aes(x = reorder(gene_symbol,Z)))+
  geom_point(aes(y = Z),col="red")+
  geom_point(aes(y=pdistance*100),position = "identity",col="blue")+
  scale_y_continuous(name = "score Z", breaks = c(1,0.5,0,-2.5,-5,-7.5,-9.5), sec.axis = sec_axis(~., breaks = c(1,0.5,0,-2.5,-5,-7.5,-9.5),name="p-distance(x100)"))+
  xlab("gènes")+
  geom_hline(yintercept = 0, color = "black", size = 1.5)+
  theme(
    axis.title.y.left = element_text(color="red", size = 15),
    axis.text.y.left = element_text(color="red"),
    axis.title.y.right = element_text(color="blue", size = 15),
    axis.text.y.right = element_text(color="blue"),
    axis.title.x.bottom = element_text(size = 15)
  )

pearson_test_MTC_genes <- cor.test(MTC_barbus_sorted$Z,MTC_barbus_sorted$pdistance,method = "pearson")
pearson_test_MTC_genes

