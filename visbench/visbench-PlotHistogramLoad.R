csvDatInsert <- read.csv(file="loadData", header=F)
dataInsert <- csvDatInsert[,3]
png(file="YCSBPlotInsert.png")
barplot(dataInsert, main="Histogram of Insert Latency", xlab="Latency in ms",names.arg=csvDatInsert[,2], ylab="Operations")
dev.off()
