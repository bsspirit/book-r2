library(pryr)

e1 <- new.env()
e1
class(e1)
otype(e1)

e1$a <- 10
e1$a
ls()
ls(e1)

environment()
e1 <- new.env()
e1
parent.env(e1)
emptyenv()
baseenv()

search()
.GlobalEnv
parent.frame()

parent.env(e1)
parent.env(environment())
parent.env(baseenv())
#parent.env(emptyenv())

parent.call<-function(e){
   print(e)
   if(is.environment(e) & !identical(emptyenv(),e)){
     parent.call(parent.env(e))
   }
}
parent.call(e1)

x<-10;x
address(x)
x<-11;x
address(x)
e1<-new.env()
e1$x<-20
x;e1$x

f <- e1
e1$a <- 1111
f$a
identical(f,e1)
e1
f

e2 <- new.env(parent = baseenv());e2
parent.call(e2)

x<-1:5
e1 <- new.env()
e1$x<-1
e1$fun<-function(y){
   print('e1::fun')
   x<<-y
}
e1$fun(50)
x
e1$x

e1<-new.env()
is.environment(e1)
environment()
environment(ls)
environmentName(baseenv())
environmentName(environment())
environmentName(e1)
attr(e1,"name")<-"e1"
environmentName(e1)
env.profile(e1)

rm(list=ls())
e1<-new.env()
x<-1:5;y<-2:10
e1$x<-10
ls()
ls(e1)
get("x")
get("x",envir=e1)
get("y",envir=e1)
#get("y",envir=e1,inherits=FALSE)
assign('x',77);x
assign('x',99,envir=e1);e1$x
assign('y',99,envir=e1,inherits=FALSE);
y
e1$y
rm(x,envir=e1)
e1$x
x
ls()
ls(e1)
exists('x')
exists('x',envir=e1)
exists('x',envir=e1,inherits=FALSE)

where(mean)
where("mean")
where("where")
where("x")
where("y")
e1$y
where("y",e1)

