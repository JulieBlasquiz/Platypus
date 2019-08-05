library(ggfortify)

X = read.table("mean_het_ind_X.txt", header=FALSE)
Y = read.table("mean_miss_ind_Y.txt", header=FALSE)

sexe <- c("F","M","M","M","F","F","M","F","F","F","F","F","F","F","M","F","F","F","F","F","M","M","M","M","M","M","M","M","M","M","F","M","M","F","M","M","M","M","M","F","F","M","M","F","M","M","F","M","M","M","F","F","M","F","F","F","M","F")
Sexe = as.factor(sexe)
Sexe = as.integer(Sexe)

groups <- c("TAS (TAS)","NQLD (NQLD)","Wingecarribee (CNSW)","NQLD (NQLD)","NQLD (NQLD)","NQLD (NQLD)","TAS (TAS)","Wingecarribee (CNSW)","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Wingecarribee (CNSW)","Wingecarribee (CNSW)","Shoalhaven","Shoalhaven","Shoalhaven","Wingecarribee (CNSW)","Barnard (NNSW)","Shoalhaven","Shoalhaven","Barnard (NNSW)","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Shoalhaven","Wingecarribee (CNSW)","TAS (TAS)","NQLD (NQLD)","Shoalhaven","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","Barnard (NNSW)","TAS (TAS)","TAS (TAS)","TAS (TAS)","NA","NQLD (NQLD)","NQLD (NQLD)","NQLD (NQLD)","NA","NA","NA","NQLD (NQLD)")
groups = as.factor(groups)
colour = as.integer(groups)
Populations = factor(colour)

table <- data.frame(X,Y)

pdf(file = "Sex chromosome analysis.pdf")
ggplot(data = table, aes(table[,2],table[,4])) + geom_point(data = table, mapping = aes(table[,2],table[,4], col=Populations, shape=Sexe)) + scale_continuous_identity(aesthetics = 'shape', guide = 'legend', breaks=c(1,2)) + labs(x = "X contig homozygosity") + labs(y = "Y contig call rate") + ggtitle("Proportion of homozygous genotypes on the X contig \n vs proportion of non missing genotypes on the Y contig") 
dev.off()