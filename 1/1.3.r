S<-1:5
x<-sample(S,1);x
y<-runif(10,0,1);y

S<-c(1,2,3,7,21)
mean(S)

S<-c(1,2,3,7,21)
var(S)
sum((S-mean(S))^2)/(length(S)-1)

S<-c(1,2,3,7,21)
sd(S)

S<-c(1,2,3,3,3,7,7,7,7,9,10,21)
names(which.max(table(S)))

S<-c(2,3,3,3,7,7,7,7,9,10,21)
min(S)
which.min(S)

S<-c(2,3,3,3,7,7,7,7,9,10,21)
max(S)
which.max(S)

S<-c(1,2,3,4,5)
median(S)

S<-c(1,2,3,4,5,6,7,8,9)
quantile(S)
fivenum(S)

S<-c(1,2,3,4,5,6,7,8,9)
summary(S)

X<-c(1,2,3,4)
Y<-c(5,6,7,8)
cov(X,Y)

X<-c(1,2,3,4)
Y<-c(5,7,8,9)
cor(X,Y)

S<-c(1,2,3,4,5)
mean(S)

S<-c(1,2,3,4,5)
var(S)

library(PerformanceAnalytics)
S<-rnorm(10000)
skewness(S)
hist(S,breaks=100)
kurtosis(S)

x=as.data.frame(matrix(rnorm(10),ncol=2));X
cov(x)

choose(4,2)/2^4
pbinom(5000, 10000, 0.5)

if (!require(animation)) install.packages("animation")
library(animation)
ani.options(interval = 0.1, nmax = 100)
par(mar = c(4, 4, 1, 0.5))
clt.ani()
