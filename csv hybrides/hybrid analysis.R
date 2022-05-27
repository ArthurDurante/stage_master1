setwd("C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv")
getwd()
library("writexl")
library(dplyr)
library(ggplot2)
library(tidyr)

#faire le traitement de l'individu hybride 1 à 7

#hybride 1
hybrid <- read.csv("table_data_Barbushy1.csv")
sorted_hybrid1 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid1,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_1.xlsx")

#hybride 2
hybrid <- read.csv("table_data_Barbushy2.csv")
sorted_hybrid2 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid2,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_2.xlsx")

#hybride 3
hybrid <- read.csv("table_data_Barbushy3.csv")
sorted_hybrid3 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid3,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_3.xlsx")

#hybride 4
hybrid <- read.csv("table_data_Barbushy4.csv")
sorted_hybrid4 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid4,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_4.xlsx")

#hybride 5
hybrid <- read.csv("table_data_Barbushy5.csv")
sorted_hybrid5 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid5,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_5.xlsx")

#hybride 6 
hybrid <- read.csv("table_data_Barbushy6.csv")
sorted_hybrid6 <- data.frame(ENSDARG = hybrid$gene_id,
                             Bb_hits = hybrid$Hits_BBvoskhodv,
                             Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                             multi_hits = hybrid$Hits_MultiSpecies,
                             Dr_hits = hybrid$Hits_drerio_gene_ensembl)
#write_xlsx(sorted_hybrid6,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_6.xlsx")

#hybride 7
hybrid <- read.csv("table_data_Barbushy7.csv")
sorted_hybrid7 <- data.frame(ENSDARG = hybrid$gene_id,
                            Bb_hits = hybrid$Hits_BBvoskhodv,
                            Bm_hits = hybrid$Hits_BMvoskhodvalidated,
                            multi_hits = hybrid$Hits_MultiSpecies,
                            Dr_hits = hybrid$Hits_drerio_gene_ensembl)

#write_xlsx(sorted_hybrid7,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//Hybride_individu_7.xlsx")


#selection des gènes nucléaires des barbaux, et ajout des noms de gènes
dn_ds_nuc_barbus <- read.csv("dN_dS_nuc_barbus.csv", sep = ";",header = FALSE,fileEncoding="UTF-8-BOM",dec=",")
ENSDARG_nuc_barbus <- data.frame(ENSDARG = dn_ds_nuc_barbus$V1)
#write.table(ENSDARG_nuc_barbus, file = "ENSDARG nucléaire barbus.txt",row.names = FALSE, col.names = FALSE, quote = FALSE)

nuc_genes <- read.csv("nuclear_gene_names.csv", sep = ";",header = TRUE,fileEncoding="UTF-8-BOM",dec=",")
nuc_gene_info <- data.frame(do.call("rbind",strsplit(as.character(nuc_genes$Gene.Info)," ",fixed = TRUE)))
nuc_gene_name <- data.frame(ENSDARG = nuc_genes$Input.Value,
                            gene = gsub("]","",as.character(nuc_gene_info$X4)))

#réalisation pour chaque hybride, de la sélection des gènes nucléaires & mitochondriaux de la chaine OXPHOS + ajout de leurs symboles
hybride = list(hybride1 = sorted_hybrid1,
               hybride2 = sorted_hybrid2,
               hybride3 = sorted_hybrid3,
               hybride4 = sorted_hybrid4,
               hybride5 = sorted_hybrid5,
               hybride6 = sorted_hybrid6,
               hybride7 = sorted_hybrid7)

#gènes nucléaires
hybrid_nuc_genes = list(NULL, NULL,NULL, NULL,NULL, NULL,NULL)
for (i in (1:7)){
  hybrid_nuc_genes[[i]] <- merge(nuc_gene_name,hybride[[i]], by = "ENSDARG", all.x = TRUE)
  hybrid_nuc_genes[[i]]$transcript <- "nucléaire"
}

#gènes mitochondriaux
mtc_genes <- read.csv("mtc_gene_names.csv", sep = ";",header = TRUE,fileEncoding="UTF-8-BOM",dec="," )
mtc_gene_info <- data.frame(do.call("rbind",strsplit(as.character(mtc_genes$Gene.Info)," ",fixed = TRUE)))
mtc_gene_name <- data.frame(ENSDARG = mtc_genes$Input.Value,
                            gene = gsub("]","",as.character(mtc_gene_info$X4)))

hybrid_mtc_genes = list(NULL, NULL,NULL, NULL,NULL, NULL,NULL)
for (i in (1:7)){
  hybrid_mtc_genes[[i]] <- merge(mtc_gene_name, hybride[[i]], by = "ENSDARG", all.x = TRUE)
  hybrid_mtc_genes[[i]]$transcript <- "mitochondrie"
}


#tableaux de gènes mtc + nucléaires
hybrid_genes_hits = list(NULL, NULL,NULL, NULL,NULL, NULL,NULL)
for (i in (1:7)){
  hybrid_genes_hits[[i]] <- rbind(hybrid_nuc_genes[[i]],hybrid_mtc_genes[[i]])
  hybrid_genes_hits[[i]]$pourcentage_Bm_hits <- hybrid_genes_hits[[i]]$Bm_hits*100 / (hybrid_genes_hits[[i]]$Bm_hits + hybrid_genes_hits[[i]]$Bb_hits)
  hybrid_genes_hits[[i]]$tri <- 1
  hybrid_genes_hits[[i]]$tri [hybrid_genes_hits[[i]]$ENSDARG == "ENSDARG00000075768"| hybrid_genes_hits[[i]]$ENSDARG == "ENSDARG00000019332"] <- 0
  hybrid_genes_hits[[i]] <- hybrid_genes_hits[[i]][order(hybrid_genes_hits[[i]]$tri),]
  #ggplot(hybrid_genes_hits[[i]],aes(x = hybrid_genes_hits[[i]], y = pourcentage_Bm_hits))+
    geom_tile()
}




#tableau contenant les gènes nucléaires de la chaine OXPHOS + leurs noms de gène

hybride_nuc_genes1 <- hybrid_nuc_genes[[1]]

#création des dataframe de chaque hybride + du dataframe pour la heatmap
hybride_g_hits1 <- data.frame(hybride = "hybride 1",
                              ENSDARG = hybrid_genes_hits[[1]]$ENSDARG,
                              gene = hybrid_genes_hits[[1]]$gene,
                              transcript = hybrid_genes_hits[[1]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[1]]$pourcentage_Bm_hits)

hybride_g_hits2 <- data.frame(hybride = "hybride 2",
                              ENSDARG = hybrid_genes_hits[[2]]$ENSDARG,
                              gene = hybrid_genes_hits[[2]]$gene,
                              transcript = hybrid_genes_hits[[2]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[2]]$pourcentage_Bm_hits)

hybride_g_hits3 <- data.frame(hybride = "hybride 3",
                              ENSDARG = hybrid_genes_hits[[3]]$ENSDARG,
                              gene = hybrid_genes_hits[[3]]$gene,
                              transcript = hybrid_genes_hits[[3]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[3]]$pourcentage_Bm_hits)

hybride_g_hits4 <- data.frame(hybride = "hybride 4",
                              ENSDARG = hybrid_genes_hits[[4]]$ENSDARG,
                              gene = hybrid_genes_hits[[4]]$gene,
                              transcript = hybrid_genes_hits[[4]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[4]]$pourcentage_Bm_hits)

hybride_g_hits5 <- data.frame(hybride = "hybride 5",
                              ENSDARG = hybrid_genes_hits[[5]]$ENSDARG,
                              gene = hybrid_genes_hits[[5]]$gene,
                              transcript = hybrid_genes_hits[[5]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[5]]$pourcentage_Bm_hits)

hybride_g_hits6 <- data.frame(hybride = "hybride 6",
                              ENSDARG = hybrid_genes_hits[[6]]$ENSDARG,
                              gene = hybrid_genes_hits[[6]]$gene,
                              transcript = hybrid_genes_hits[[6]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[6]]$pourcentage_Bm_hits)

hybride_g_hits7 <- data.frame(hybride = "hybride 7",
                              ENSDARG = hybrid_genes_hits[[7]]$ENSDARG,
                              gene = hybrid_genes_hits[[7]]$gene,
                              transcript = hybrid_genes_hits[[7]]$transcript,
                              pourcentage_Bm_hits = hybrid_genes_hits[[7]]$pourcentage_Bm_hits)

HYBRIDE_ALL_HITS <- rbind(hybride_g_hits1,hybride_g_hits2,hybride_g_hits3,hybride_g_hits4,hybride_g_hits5,hybride_g_hits6,hybride_g_hits7)

#---------------------------------------------
kegg_genes <- read.delim("Kegg_danio_genes.txt", header = FALSE)
kegg_genes <- separate(kegg_genes, V1, into = c("KEGG_ID","description"), sep = "^\\S*\\K\\s+")
kegg_genes <- separate(kegg_genes, description, into = c("MODULE","decription"), sep = "^\\S*\\K\\s+")

kegg_ID_ensembl_ID <- read.delim("KEGG_ID_ENSEMBL_ID.txt", header = TRUE)
kegg_ID_ensembl_ID <- data.frame(KEGG_ID = kegg_ID_ensembl_ID$KEGG.Gene.ID,
                                 ENSDARG = kegg_ID_ensembl_ID$Ensembl.Gene.ID)
kegg_ensembl_info <- merge(kegg_genes,kegg_ID_ensembl_ID, by = "KEGG_ID")

kegg_module_complex <- read.delim("KEGG_COMPLEX.txt", header = TRUE)

HYBRID_HITS_INFO_all <- merge (HYBRIDE_ALL_HITS, kegg_ensembl_info, by = "ENSDARG")

HYBRID_HITS_INFO_FINAL<- merge(HYBRID_HITS_INFO_all,kegg_module_complex, by = "MODULE", all.x = TRUE)
HYBRID_HITS_INFO_FINAL$decription <- NULL
HYBRID_HITS_INFO_FINAL$COMPLEX[is.na(HYBRID_HITS_INFO_FINAL$COMPLEX)] <- "Pi-ADP interaction"
HYBRID_HITS_INFO_FINAL <- HYBRID_HITS_INFO_FINAL[order(HYBRID_HITS_INFO_FINAL$COMPLEX,decreasing = FALSE),]
HYBRID_HITS_INFO_FINAL$gene
#---------------------------------------------

#write_xlsx(HYBRID_HITS_INFO_FINAL,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//heatmap_data_table.xlsx")
ggplot(HYBRID_HITS_INFO_FINAL, aes(x=hybride, y = gene,fill = pourcentage_Bm_hits))+
  geom_tile()+
  theme(
    axis.text.y.left = element_text(size = 5)
  )+
  scale_fill_gradientn(colours= c("blue","green","red"))

#-----------------------------------------------------------------------




barbus_pdist_Z <- subset(pdist_Z_graph,allignement == "barbus")
barbus_genes_aggregated <- data.frame(ENSDARG = HYBRID_HITS_INFO_FINAL$ENSDARG,
                            hybride = HYBRID_HITS_INFO_FINAL$hybride,
                            gene = HYBRID_HITS_INFO_FINAL$gene)
barbus_genes_aggregated <- aggregate(. ~ENSDARG, barbus_genes_aggregated, toString)
barbus_genes_aggregated1.0 <- strsplit(barbus_genes_aggregated$gene,split =  ",")
barbus_genes_aggregated1.1 <- data.frame(ENSDARG = rep(barbus_genes_aggregated$ENSDARG, sapply(barbus_genes_aggregated1.0,length)),gene = unlist(barbus_genes_aggregated1.0))
barbus_genes_aggregated1.1 <- barbus_genes_aggregated1.1[!duplicated(barbus_genes_aggregated1.1$ENSDARG),]

barbus_ensdarg_merge_gene <- merge(barbus_pdist_Z, barbus_genes_aggregated1.1, by = "ENSDARG", all.y = TRUE)
barbus_ensdarg_merge_value <- merge(barbus_pdist_Z, barbus_genes_aggregated1.1, by = "ENSDARG", all.x = TRUE)

barbus_ensdarg_merge_final <- data.frame(ENSDARG = barbus_ensdarg_merge_gene$ENSDARG,
                                         pdistance  = barbus_ensdarg_merge_value$pdistance,
                                         Z = barbus_ensdarg_merge_value$Z,
                                         gene = barbus_ensdarg_merge_gene$gene)

heatmap_data <- read.csv("heatmap_data.csv",sep = ";" ,header = FALSE,fileEncoding="UTF-8-BOM")
heatmap_data <- data.frame(complex = heatmap_data$V1,
                           gene = heatmap_data$V2,
                           hybride_1 =heatmap_data$V3,
                           hybride_2 =heatmap_data$V4,
                           hybride_3 =heatmap_data$V5,
                           hybride_4 =heatmap_data$V6,
                           hybride_5 =heatmap_data$V7,
                           hybride_6 =heatmap_data$V8,
                           hybride_7 =heatmap_data$V9)
heatmap_data_values <- merge(heatmap_data,barbus_ensdarg_merge_final, by = "gene", sort = FALSE)
heatmap_data_values <- data.frame(complex = heatmap_data_values$complex,
                                  gene = heatmap_data_values$gene,
                                  hybride_1 = heatmap_data_values$hybride_1,
                                  hybride_2 = heatmap_data_values$hybride_2,
                                  hybride_3 = heatmap_data_values$hybride_3,
                                  hybride_4 = heatmap_data_values$hybride_4,
                                  hybride_5 = heatmap_data_values$hybride_5,
                                  hybride_6 = heatmap_data_values$hybride_6,
                                  hybride_7 = heatmap_data_values$hybride_7,
                                  pdistance = heatmap_data_values$pdistance,
                                  Z = heatmap_data_values$Z)
#write_xlsx(heatmap_data_values,"C:/Users/arthu/Documents/Fac/Master 1 BSG/Stage/barbus_expression/csv//heatmap_data_values.xlsx")
