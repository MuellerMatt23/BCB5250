# Matt Mueller
# 04-18-2024
# PCA Lab
# BCB 5250

library("factoextra")
library("FactoMineR")
library(ggpubr)
library(RColorBrewer)

data <- read.csv("C:/Users/13145/Downloads/data.csv", row.names=1)

pca.data <- PCA(data[,-1], scale.unit = TRUE, graph = FALSE)

fviz_eig(pca.data, addlabels = TRUE, ylim = c(0, 70))
# Q1 81.7 

fviz_pca_var(pca.data, col.var = "cos2",
             gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"),
             repel = TRUE)

pca.data <- PCA(t(data[,-1]), scale.unit = TRUE, graph = FALSE)

fviz_pca_ind(pca.data, col.ind = "cos2", 
             gradient.cols = c("#FFCC00", "#CC9933", "#660033", "#330033"), 
             repel = TRUE)


a <- fviz_pca_ind(pca.data, col.ind="cos2", 
                  gradient.cols=c("#FFCC00", "#CC9933", "#660033", "#330033"),
                                  repel=TRUE)
ggpar(a, 
      title = "Principal Component Analysis",
      xlab = "PC1", ylab = "PC2",
      legend.title = "Cos2", legend.position = "top",
      ggtheme = theme_minimal())

pca.data <- PCA(data[,-1], scale.unit = TRUE,ncp = 2, graph = FALSE)

data$lineage <- as.factor(data$lineage)

nb.cols <- 3

mycolors <- colorRampPalette(brewer.pal(3, "Set1"))(nb.cols)

a <- fviz_pca_ind(pca.data, col.ind=data$lineage,
                  palette = mycolors, addEllipses = TRUE)

ggpar(a, 
      title = "Principal Component Analysis",
      xlab = "PC1", ylab = "PC2",
      legend.title = "Cell Type", legend.position = "top",
      ggtheme = theme_minimal())

# EPI cells - DPPA5, IFITM1, MT1X, UPP1
# PE cells - APOA1
# TE cells - S100A16, KRT8, KRT18
# If these genes are highly expressed in an unknown cell type, we can
# conclude that the expression profile of the unknown cell matches the
# expression profile of the known cell type. Therefore, we can infer the cell 
# type of the unknown cell by its expression profile.




