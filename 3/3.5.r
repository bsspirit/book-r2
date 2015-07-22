version

type.convert(c('abc','bcd'))
type.convert(c(as.double(1.12121221111),'1.121'))

num<-read.table(file="num.csv",sep=",")
num
class(num)
class(num$V1)

Rdiff('num.csv','num2.csv',useDiff = FALSE)

is.na(c(1, NA))
any(is.na(c(1, NA)))
anyNA(c(1, NA))

is.unsorted(1:10)
is.unsorted(sample(1:10))

f1 <- function(x) (121 - x^2)/(x^2+1)
f2 <- function(x) exp(-x)*(x - 12)
try(uniroot(f1, c(0,10)))
try(uniroot(f2, c(0, 2)))
str(uniroot(f1, c(0,10),extendInt="yes"))
str(uniroot(f2, c(0,2), extendInt="yes"))

ff<-gl(3,1, labels=LETTERS[3:1])
switch(ff[1], A = "I am A", B="Bb..", C=" is C")
switch(as.character(ff[1]), A = "I am A", B="Bb..", C=" is C")

x<-1:12;x
x+5
!x
dim(x) <- c(3,4);x 

cols<-colorRampPalette(c(rgb(0,0,1,1), rgb(1,0,1,0)), alpha = TRUE)
filled.contour(volcano,color.palette =cols,asp = 1)

letters
object.size(letters)
format(object.size(letters), units = "auto")

dir("C:/Program Files/R/R-3.1.0/doc")

combn(letters[1:4], 2)
combn(factor(letters[1:4]), 2)

snapshot<-fileSnapshot()
snapshot
writeBin(3L:4L,"a.txt")t
changedFiles(snapshot)

make.names(c("a b","a.b", "a-b"))
make.names(c("a b","a.b", "a-b"), unique = TRUE)

x<-1222222222222221.323232
cospi(x)
cos(pi*x)

t1 <- round(abs(rt(10, df = 1.8)),1)
t2 <- round(abs(rt(10, df = 1.4)),1)
print.table(table(t1,t2),zero.print = ".")

head(OlsonNames())
Sys.timezone()

a<-rnorm(1000000,-100,100000)
head(a)
system.time(as.factor(a))

x <- 1:100000000
system.time(fft(x))

file.copy("a.txt","b.txt",copy.date=TRUE)
file.copy("a.txt","c.txt",copy.date=FALSE)

dnorm(rnorm(10,0,100))

fit3 <- arima(presidents, c(3, 0, 0))
mod <- fit3$model
pr <- KalmanForecast(4, mod, TRUE)
mod <- attr(pr, "mod")    #

zz <- textConnection(LETTERS)
readLines(zz, 2)
pushBack(c("aa", "bb"), zz)
pushBackLength(zz)
readLines(zz, 1)
pushBackLength(zz)
readLines(zz, 1)
readLines(zz, 1)
close(zz)

a<-list(a=1,b=2)
b<-list()
b[['a']]<-1
b[['b']]<-2
all.equal.list(a,b)
b[['a']]<-4
all.equal.list(a,b, use.names=TRUE)

all.equal.numeric(1:10,1:5)

seq(today,today+365,by="quarter")
seq(today,today+365,by="2 months")

# file.path(c("c://abc\\000\\llj/jkh","c:/abc/a","d:\\bcd"))

agrepl("laysy", c("1 lazy", "1", "1 LAZY"), max = 2)

capabilities("fifo")

x<-sample(1:650,1e7,replace=TRUE)
system.time(o1<-sort.list(x))
system.time(o2<-sort.list(x,method="radix"))
all.equal(o1,o2)

sunsp.1 <- window(sunspot.month, end=c(1752, 12))
m <- .preformat.ts(sunsp.1)
print(m)

df<-data.frame(1:5)
df[0,]
df[1,]

m<-matrix(sample(100,100,replace=TRUE),10);m
hc1<-hclust(dist(m), method="ward.D");hc1
hc2<-hclust(dist(m), method="ward.D2");hc2
plot(hc1)
plot(hc2)

head(sunspot.month)
head(sunspot.year)

ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
summary(lm.D9)

suppressWarnings(summary(lm.D9)$cov.unscaled)

w<-women;w
attach(w)
height
attach(women)

library(tools)
buildVignette

as.integer(2000000000)+as.integer(2000000000)

dev.new()
dev.new(noRStudioGD=TRUE)

d<-data.frame(a=1:10,b=10:1)
saveRDS(d, "d.rds")
d2<-readRDS("d.rds")
d2

pi
pi<<-3.2

install.packages("plyr", repos = "http://cran.rstudio.com/")

options("warnPartialMatchDollar")
options(warnPartialMatchDollar = TRUE)
options("warnPartialMatchDollar")
df <- data.frame(ab=1:4,cd=1:4)
rownames(df) <- paste0(letters[1:4],"a")
df$a
df["a",]

search()
package?plyr
package?pryr

help(package="zoo")
??zoo

promptImport(cat)


