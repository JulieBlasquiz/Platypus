# Aout 2019
# Julie Blasquiz
# Profil contig (het, cov et miss)

library(ggplot2)
library(scales)

library("data.table")
freadf <- function(...) return(as.data.frame(fread(...)))

femelle=freadf("coverage_norep_PASS_Y_femelle.txt",sep=" ")
male=freadf("coverage_norep_PASS_Y_male.txt",sep=" ")

contig <- c(male[,1],femelle[,1])
freq <- c(male[,2],femelle[,2])
sexe <- c(male[,3],femelle[,3])

fichier <- data.frame(contig,freq,sexe)

pdf("Y_coverage_norep_PASS.pdf")
ggplot(data=fichier, aes(x=fichier$contig,y=fichier$freq,fill=factor(fichier$sexe))) + geom_bar(position="dodge",stat="identity") + coord_flip() + ggtitle("Contig Y") + xlab("") + ylab("Coverage")
dev.off()