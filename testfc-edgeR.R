library(edgeR)
print("reading")
data_path = 'all.otumat'
data_df = t(read.table(data_path, sep="\t", row.names=1, header=T))
data_df = data_df[2:nrow(data_df), ]

group <- as.factor(sapply(FUN=function(x){substr(x, 1, 2)}, colnames(data_df)))
names(group) <- seq(length=length(group))

print("making dge")
exp_dge <- DGEList(counts=data_df, group=group, genes=rownames(data_df), remove.zeros=T)

design = model.matrix(~0+group)
rownames(design) <- colnames(exp_dge)

print("normalizing")
z <- calcNormFactors(exp_dge, method="TMM")

print("dispersion")
disp <- estimateGLMRobustDisp(z, design=design);
print("testing")
glmt <- glmFit(disp, design=design)

lrt <- glmLRT(glmt, contrast=c(-1, 1))

topTags(lrt)
