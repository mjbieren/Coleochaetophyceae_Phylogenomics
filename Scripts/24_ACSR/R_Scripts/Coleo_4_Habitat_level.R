library("phytools")

#Set your working directory0
setwd("")

tree<-read.newick("SIMPLIFIED_Final_IQ_Tree_Coleo_PMSF_Tax15_Loci2924_PreLGIG4.nwk")
plotTree(tree,fsize=0.8,ftype="i")

# read data (saving first column as row names) aka the table with your setup
x<-read.table("Coleo_Habitat_4.txt", row.names = 1)
# change this into a vector
x<-as.matrix(x)


cols<-setNames(palette()[1:length(unique(x))],sort(unique(x))) # set automatic colors

cols<-c("#caf0f8", "#0077b6", "#06d6a0", "#780000")
# match tips with states
tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)

#Equal Rates
transitions <- matrix(c(0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0), nrow=4)
fitORDERED <- ace(x, tree, type="discrete", model=transitions)

#It is fairly straightforward to overlay these posterior probabilities on the tree:
plotTree(tree,fsize=0.8,ftype="i")

nodelabels(node=1:tree$Nnode+Ntip(tree),
           pie=fitORDERED$lik.anc,piecol=cols,cex=0.5)
tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)


print(fitORDERED$lik.anc)

#Which node is what
plotTree(tree,fsize=0.8,ftype="i",node.numbers=TRUE)
