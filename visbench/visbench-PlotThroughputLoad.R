library("zoo")
through.dat <- read.csv("throughput.csv", header=F, sep=",")
times <- through.dat[,1]
operations <- through.dat[,2]
ops <- through.dat[,3]
latency <- through.dat[,4]
operations.zoo <- zoo(operations, order.by=times)
ops.zoo <- zoo(ops, order.by=times)
latency.zoo <- zoo(latency, order.by=times)
png("throughput.png", width=1440)
par(mfrow=c(1,3))
plot(operations.zoo, xlab="Time (in sec)", ylab="Operations", main="Number of Operations")
plot(ops.zoo, xlab="Time (in sec)", ylab="ops/sec", main="Operations per second")
plot(latency.zoo, xlab="Time (in sec)", ylab="Latency (in us)", main="Latency in us")
dev.off()
