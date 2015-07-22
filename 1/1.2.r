a<-10;b<-5
a+b;a-b;a*b;a/b
a%%b;a%/%b
abs(-a)
sign(-2:3)

a<-10;b<-5;c<-4
c^b;c^-b;c^(b/10)
exp(1)
exp(3)
sqrt(c)
log2(c)
log10(b)
log(c,base = 2)
log(a,base=exp(1))
log(a^b,base=a)
log(exp(3))

a<-10;b<-5
a==a;a!=b;a>b;a<b;a<=b;a>=c
isTRUE(a)
isTRUE(!a)
identical(1, as.integer(1))
identical(NaN, -NaN)
f <- function(x) x
g <- compiler::cmpfun(f)
identical(f, g)

x<-c(0,1,0,1)
y<-c(0,0,1,1)
x && y;x || y
x & y;x | y
xor(x,y)
xor(x,!y)

ceiling(5.4)
floor(5.8)
trunc(3.9)
round(5.8)
round(5.8833, 2)
signif(5990000,2)

d<-seq(1,10,2);d
max(d);min(d);range(d)
sum(d);mean(d)
weighted.mean(d,rep(1,5))
weighted.mean(d,c(1,1,2,2,2))
prod(1:5)
diff(d)
rank(d)
median(d)
quantile(d)
any(d<5);all(d<5)

factorial(5)
choose(5, 2)
combn(5,2)
for (n in 0:10) print(choose(n, k = 0:n))
choose(5, 2)*factorial(2)

cumsum(1:5)
cumprod(1:5)
e<-seq(-3,3);e
cummin(e)
cummax(e)

x <- c(9:20, 1:5, 3:7, 0:8);x
y<- 1:10;y
intersect(x,y)
union(x,y)
setdiff(x,y)
setequal(x, y)
unique(c(x,y))
which(x %in% y)
which(is.element(x,y))
which(duplicated(x))

sin(0);sin(1);sin(pi/2)
cos(0);cos(1);cos(pi)
tan(0);tan(1);tan(pi)

library(ggplot2)
library(scales)
x<-seq(-2*pi,2*pi,by=0.01)
s1<-data.frame(x,y=sin(x),type=rep('sin',length(x)))
s2<-data.frame(x,y=cos(x),type=rep('cos',length(x)))
s3<-data.frame(x,y=tan(x),type=rep('tan',length(x)))
s4<-data.frame(x,y=1/tan(x),type=rep('cot',length(x)))
s5<-data.frame(x,y=1/cos(x),type=rep('sec',length(x)))
s6<-data.frame(x,y=1/sin(x),type=rep('csc',length(x)))
df<-rbind(s1,s2,s3,s4,s5,s6)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity'))
g<-g+scale_y_continuous(limits=c(-2, 2))
g<-g+scale_x_continuous(breaks=seq(-2*pi,2*pi,by=pi),labels=c("-2*pi","-pi","0","pi","2*pi"))
g

asin(0);asin(1)
acos(0);acos(1)
atan(0);atan(1)

x<-seq(-1,1,by=0.005)
s1<-data.frame(x,y=asin(x),type=rep('arcsin',length(x)))
s2<-data.frame(x,y=acos(x),type=rep('arccos',length(x)))
s3<-data.frame(x,y=atan(x),type=rep('arctan',length(x)))
s4<-data.frame(x,y=1/atan(x),type=rep('arccot',length(x)))
s5<-data.frame(x,y=1/asin(x),type=rep('arcsec',length(x)))
s6<-data.frame(x,y=1/acos(x),type=rep('arccsc',length(x)))
df<-rbind(s1,s2,s3,s4,s5,s6)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity'))
g<-g+scale_y_continuous(limits=c(-2*pi,2*pi),breaks=seq(-2*pi,2*pi,by=pi),labels=c("-2*pi","-pi","0","pi","2*pi"))
g

library(testthat)
a<-5;b<-10
sin(a)^2+cos(a)^2
expect_that(1, equals(sin(a)^2+cos(a)^2))
#expect_that(2, equals(sin(a)^2+cos(a)^2))

expect_that(sin(a)*cos(b)+sin(b)*cos(a),equals(sin(a+b)))
expect_that(sin(a)*cos(b)-sin(b)*cos(a),equals(sin(a-b)))
expect_that(cos(a)*cos(b)-sin(b)*sin(a),equals(cos(a+b)))
expect_that(cos(a)*cos(b)+sin(b)*sin(a),equals(cos(a-b)))
expect_that((tan(a)+tan(b))/(1-tan(a)*tan(b)),equals(tan(a+b)))
expect_that((tan(a)-tan(b))/(1+tan(a)*tan(b)),equals(tan(a-b)))

expect_that(cos(a)^2-sin(a)^2,equals(cos(2*a)))
expect_that(2*cos(a)^2-1,equals(cos(2*a)))
expect_that(1-2*sin(a)^2,equals(cos(2*a)))

expect_that(4*cos(a)^3-3*cos(a),equals(cos(3*a)))
expect_that(-4*sin(a)^3+3*sin(a),equals(sin(3*a)))

expect_that(sqrt((1-cos(a))/2),equals(abs(sin(a/2))))
expect_that(sqrt((1+cos(a))/2),equals(abs(cos(a/2))))
expect_that(sqrt((1-cos(a))/(1+cos(a))),equals(abs(tan(a/2))))
expect_that(abs(sin(a)/(1+cos(a))),equals(abs(tan(a/2))))
expect_that(abs((1-cos(a))/sin(a)),equals(abs(tan(a/2))))

expect_that((sin(a+b)+sin(a-b))/2,equals(sin(a)*cos(b)))
expect_that((sin(a+b)-sin(a-b))/2,equals(cos(a)*sin(b)))
expect_that((cos(a+b)+cos(a-b))/2,equals(cos(a)*cos(b)))
expect_that((cos(a-b)-cos(a+b))/2,equals(sin(a)*sin(b)))

expect_that(sin(a)+sin(b),equals(2*sin((a+b)/2)*cos((a-b)/2)))
expect_that(sin(a)-sin(b),equals(2*cos((a+b)/2)*sin((a-b)/2)))
expect_that(2*cos((a+b)/2)*cos((a-b)/2),equals(cos(a)+cos(b)))
expect_that(-2*sin((a+b)/2)*sin((a-b)/2),equals(cos(a)-cos(b)))

expect_that(sin(2*a),equals(2*tan(a)/(1+tan(a)^2)))
expect_that((1-tan(a)^2)/(1+tan(a)^2),equals(cos(2*a)))
expect_that(2*tan(a)/(1-tan(a)^2),equals(tan(2*a)))

expect_that(sin(a)^2-sin(b)^2,equals(sin(a+b)*sin(a-b)))
expect_that(cos(a)^2-sin(b)^2,equals(cos(a+b)*cos(a-b)))

expect_that((1+cos(2*a))/2,equals(cos(a)^2))
expect_that((1-cos(2*a))/2,equals(sin(a)^2))

expect_that(sqrt(a^2+b^2)*sin(a+atan(b/a)),equals(a*sin(a)+b*cos(a)))


ai<-5+2i;ai
class(ai)
bi<-complex(real=5,imaginary=2);bi
is.complex(bi)
Re(ai)
Im(ai)
Mod(ai)
Arg(ai)
Conj(ai)

a<-5;b<-2;c<-3;d<-4
ai<-complex(real=a,imaginary=b)
bi<-complex(real=c,imaginary=d)

expect_that(complex(real=(a+c),imaginary=(b+d)),equals(ai+bi))
expect_that(complex(real=(a-c),imaginary=(b-d)),equals(ai-bi))
expect_that(complex(real=(a*c-b*d),imaginary=(a*d+b*c)),equals(ai*bi))
expect_that(complex(real=(a*c+b*d),imaginary=(b*c-a*d))/(c^2+d^2),equals(ai/bi))

sqrt(-9)
sqrt(complex(real=-9))

f1 <- function (x, a, b) a*x+b
a<-5;b<-10
result <- uniroot(f1,c(-10,10),a=a,b=b,tol=0.0001)
result$root    

x<-seq(-5,5,by=0.01)
y<-f1(x,a,b)
df<-data.frame(x,y)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red')
g<-g+geom_point(aes(result$root,0),col="red",size=3)
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0)
g<-g+ggtitle(paste("y =",a,"* x +",b))
g

f2 <- function (x, a, b, c) a*x^2+b*x+c
a<-1;b<-5;c<-6
result <- uniroot(f2,c(0,-2),a=a,b=b,c=c,tol=0.0001)
result$root
result <- uniroot(f2,c(-4,-3),a=a,b=b,c=c,tol=0.0001)
result$root
# result <- uniroot(f2,c(-10,0),a=a,b=b,c=c,tol=0.0001)

x<-seq(-5,1,by=0.01)
y<-f2(x,a,b,c)
df<-data.frame(x,y)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red')
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0)
g<-g+ggtitle(paste("y =",a,"* x ^ 2 +",b,"* x +",c))
g

f3 <- function (x, a, b, c,d) a*x^3+b*x^2+c*x+d
a<-1;b<-5;c<-6;d<--11
result <- uniroot(f3,c(-5,5),a=a,b=b,c=c,d=d,tol=0.0001)
result$root

x<-seq(-5,5,by=0.01)
y<-f3(x,a,b,c,d)
df<-data.frame(x,y)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(col='red')
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0)
g<-g+ggtitle(paste("y =",a,"* x ^ 3 +",b,"* x ^2 +",c,"* x + ",d))
g

lf<-matrix(c(3,5,1,2),nrow=2,byrow=TRUE)
rf<-matrix(c(4,1),nrow=2)
result<-solve(lf,rf)
result

fy1<-function(x) (-3*x+4)/5
fy2<-function(x) (-1*x+1)/2
x<-seq(-1,4,by=0.01)
y1<-fy1(x)
y2<-fy2(x)
dy1<-data.frame(x,y=y1,type=paste("y=(-3*x+4)/5"))
dy2<-data.frame(x,y=y2,type=paste("y=(-1*x+1)/2"))
df <- rbind(dy1,dy2)
g<-ggplot(df,aes(x,y))
g<-g+geom_line(aes(colour=type,stat='identity'))
g<-g+geom_hline(yintercept=0)+geom_vline(yintercept=0)
g
