if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install(ask=FALSE)
BiocManager::install(c("edgeR","gplots","ggplot2"), ask=FALSE)
