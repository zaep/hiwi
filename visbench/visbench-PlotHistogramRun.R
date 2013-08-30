csvDatRead <- read.csv(file='runDataRead', header=F)
csvDatUpdate <- read.csv(file='runDataUpdate', header=F)
dataRead <- csvDatRead[,3]
dataUpdate <- csvDatUpdate[,3]
png(file='YCSBPlotRun.png', width=960)
par(mfrow=c(1,2))
barplot(dataRead, main="Read", names.arg=csvDatRead[,2], xlab="Latency in ms")
barplot(dataUpdate, main="Update", names.arg=csvDatUpdate[,2], xlab="Latency in ms")
dev.off()
