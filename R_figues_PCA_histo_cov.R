library(tidyverse)
library(ggplot2)


##create coverage plot
cov <- read.table("/Users/marisa/ISG_Sp_finalproj/coverage_10kb.bed.gz", header=FALSE)

colnames(cov) <- c("chromosome", "start", "end", "mean", "median", "count")

cov$mean <- as.numeric(cov$mean)
cov$median <- as.numeric(cov$median)

ggplot(cov, aes(x=start, y=mean)) + 
  geom_point(size=0.2)

##create pca


pca <- read.table("/Users/marisa/ISG_Sp_finalproj/pca.eigenvec", header=FALSE)
colnames(pca) <- c("FID","IID","PC1","PC2","PC3","PC4")

ggplot(pca, aes(x=PC1, y=PC2)) +
  geom_point(size=3, alpha=0.8) +
  theme_classic() +
  xlab("PC1") +
  ylab("PC2") +
  ggtitle("PCA of SNP Variation")

##Lumpy summary
# read table
sv <- read.table("/Users/marisa/ISG_Sp_finalproj/sv_counts.txt", header=FALSE)

# rename columns
colnames(sv) <- c("sample", "DEL", "DUP", "INV")
# convert to long format
sv_long <- pivot_longer(
  sv,
  cols = c(DEL, DUP, INV),
  names_to = "SVtype",
  values_to = "count"
)

# plot
ggplot(sv_long,
       aes(x=reorder(sample, count),
           y=count,
           fill=SVtype)) +
  geom_bar(stat="identity") +
  coord_flip() +
  theme_bw() +
  labs(
    title="Structural variant counts across A. pullulans isolates",
    x="Isolate",
    y="Number of structural variants"
  )
