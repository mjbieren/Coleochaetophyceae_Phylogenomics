library("phytools")

#Set your working directory0
setwd("")

tree<-read.newick("SIMPLIFIED_Final_IQ_Tree_Coleo_PMSF_Tax15_Loci2924_PreLGIG4.nwk")
plotTree(tree,fsize=0.8,ftype="i")

# read data (saving first column as row names) aka the table with your setup
x<-read.table("Coleo_Present_Of_Hairs_2.txt", row.names = 1)
# change this into a vector
x<-as.matrix(x)


cols<-setNames(palette()[1:length(unique(x))],sort(unique(x))) # set automatic colors
cols<-c("#FFBE0B", "#8338EC")


tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)
tiplabels(pie=to.matrix(x),piecol=cols,cex=0.2)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=-max(nodeHeights(tree)),fsize=0.8)


#Either you use equal rates (aka no bias) or unequal rates. Be sure to comment out 2/3

#Equal Rates
transitions <- matrix (c(0, 1, 1, 0), nrow=2)

#Unequal Rates uni to multi is harder
#transitions <- matrix (c(0, 2, 1, 0), nrow=2)

#Unequal Rates multi to uni is harder
#transitions <- matrix (c(0, 1, 2, 0), nrow=2)

fitORDERED <- ace(x, tree, type="discrete", model=transitions)

#It is fairly straightforward to overlay these posterior probabilities on the tree:
plotTree(tree,fsize=0.8,ftype="i")

nodelabels(node=1:tree$Nnode+Ntip(tree),
           pie=fitORDERED$lik.anc,piecol=cols,cex=0.5)
tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)

print(fitORDERED$lik.anc)

#Which node is what
plotTree(tree,fsize=0.8,ftype="i",node.numbers=TRUE)
