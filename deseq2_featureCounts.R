# read in count matrix
countData <- read.csv("C:/Users/13145/OneDrive/Desktop/BCB 5250/all_featureCountx.Rmatrix.txt", header=T, row.names=1, sep="\t") 
dim(countData)
head(countData) 

# basic QC
barplot(colSums(countData)*1e-6,
        names=colnames(countData),
        ylab="Library size (millions)")

# load library
library(DESeq2)

# create experiment labels (two conditions)
colData <- DataFrame(condition=factor(c("male","male","female", "female", "male", "female", "female", "male", "male", "female", "male", "female")))

# create DESeq input matrix
dds <- DESeqDataSetFromMatrix(countData, colData, formula(~ condition))

# run DEseq
dds <- DESeq(dds)

# visualize differentially expressed genes
plotMA(dds)

# get differentially expressed genes
res <- results(dds)

# order by BH adjusted p-value
resOrdered <- res[order(res$padj),]

# top of ordered matrix
head(resOrdered)

# how many differentially expressed genes ? FDR=10%, |fold-change|>2 (up and down)
# get differentially expressed gene matrix
sig <- resOrdered[!is.na(resOrdered$padj) &
                    resOrdered$padj<0.10 &
                    abs(resOrdered$log2FoldChange)>=0.8,]

# top of the differentially expressed genes
head(sig)

# how to create a heat map
# select genes
selected <- rownames(sig);selected


# load libraries for the heat map
library("RColorBrewer")
library("gplots")

# colors of the heat map
hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100) ## hmcol <- heat.colors

selected_counts <- counts(dds,normalized=TRUE)[rownames(dds) %in% selected,]

selected_counts_matrix <- matrix(selected_counts)


# heatmap
heatmap.2(log2(selected_counts + 1),
           col = hmcol, scale="row",
           Rowv = TRUE, Colv = FALSE,
           dendrogram="row",
           trace="none",
           margin=c(6, 8), cexRow=0.5, cexCol=1, keysize=1 )






colData <- DataFrame(condition=factor(c("YRI","YRI","YRI", "GBR", "GBR", "YRI", "GBR", "GBR", "GBR", "GBR", "YRI", "YRI")))


# create DESeq input matrix
dds <- DESeqDataSetFromMatrix(countData, colData, formula(~ condition))

# run DEseq
dds <- DESeq(dds)

# visualize differentially expressed genes
plotMA(dds)

# get differentially expressed genes
res <- results(dds)

# order by BH adjusted p-value
resOrdered <- res[order(res$padj),]

# top of ordered matrix
head(resOrdered)

# how many differentially expressed genes ? FDR=10%, |fold-change|>2 (up and down)
# get differentially expressed gene matrix
sig <- resOrdered[!is.na(resOrdered$padj) &
                    resOrdered$padj<0.10 &
                    abs(resOrdered$log2FoldChange)>=1,]

# top of the differentially expressed genes
head(sig)


# how to create a heat map
# select genes
selected <- rownames(sig);selected

# colors of the heat map
hmcol <- colorRampPalette(brewer.pal(9, "GnBu"))(100) ## hmcol <- heat.colors

selected_counts <- counts(dds,normalized=TRUE)[rownames(dds) %in% selected,]
# heatmap
heatmap.2(log2(selected_counts + 1),
           col = hmcol, scale="row",
           Rowv = TRUE, Colv = FALSE,
           dendrogram="row",
           trace="none",
           margin=c(6, 8), cexRow=0.5, cexCol=1, keysize=1 )


     