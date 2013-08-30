library("zoo")
through.dat <- read.csv("throughput.csv", header=F, sep=",")
times <- through.dat[,1]
operations <- through.dat[,2]
ops <- through.dat[,3]
latencyUpdate <- through.dat[,4]
latencyRead <- through.dat[,5]
operations.zoo <- zoo(operations, order.by=times)
ops.zoo <- zoo(ops, order.by=times)
latencyUpdate.zoo <- zoo(latencyUpdate, order.by=times)
latencyRead.zoo <- zoo(latencyRead, order.by=times)
png("throughput.png", width=1920)
par(mfrow=c(1,4))
plot(operations.zoo, xlab="Time (in sec)", ylab="Operations", main="Number of Operations")
plot(ops.zoo, xlab="Time (in sec)", ylab="ops/sec", main="Operations per second")
plot(latencyUpdate.zoo, xlab="Time (in sec)", ylab="Latency (in us)", main="Latency for Updates in us")
plot(latencyRead.zoo, xlab="Time (in sec)", ylab="Latency (in us)", main="Latency for Reads in us")
dev.off()
