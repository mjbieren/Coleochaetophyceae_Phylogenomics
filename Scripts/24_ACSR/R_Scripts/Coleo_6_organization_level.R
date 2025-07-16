library("phytools")

#Set your working directory
setwd("")

tree<-read.newick("SIMPLIFIED_Final_IQ_Tree_Coleo_PMSF_Tax15_Loci2924_PreLGIG4.nwk")
plotTree(tree,fsize=0.8,ftype="i")

# read data (saving first column as row names) aka the table with your setup
x<-read.table("Coleo_6_organization_level.txt", row.names = 1)
# change this into a vector
x<-as.matrix(x)


cols<-setNames(palette()[1:length(unique(x))],sort(unique(x))) # set automatic colors

cols<-c("#E40303", "#FFB3c1", "#FFED00","#03e403","#1A00FF", "#DD00FF", "#00bdd6")
# match tips with states
tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)

#Equal Rates
#7 rates
#0,1,1,1,1,1,1,
#1,0,1,1,1,1,1,
#1,1,0,1,1,1,1,
#1,1,1,0,1,1,1,
#1,1,1,1,0,1,1,
#1,1,1,1,1,0,1,
#1,1,1,1,1,1,0
transitions <- matrix(c(0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0), nrow=7)
fitORDERED <- ace(x, tree, type="discrete", model=transitions)



#It is fairly straightforward to overlay these posterior probabilities on the tree:
plotTree(tree,fsize=0.8,ftype="i")

nodelabels(node=1:tree$Nnode+Ntip(tree),
           pie=fitORDERED$lik.anc,piecol=cols,cex=0.5)
tiplabels(pie=to.matrix(x,sort(unique(x))),piecol=cols,cex=0.2)



#Get probability
#Print probability
print(fitORDERED$lik.anc)

#Which node is what
plotTree(tree,fsize=0.8,ftype="i",node.numbers=TRUE)
