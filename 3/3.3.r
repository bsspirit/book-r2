y <- 1
f1 <- function(x) x + y
environment(f1)
f2 <- function(x){
   f1()+y
}
environment(f2)

e <- new.env()
e$g <- function() 1
e$g
e$g()

e$f <- function() {
   function () 1
}
e$f
e$f()
e$f()()        

environment(e$g)
environment(e$f)
environment(e$f())
parent.env(environment(e$f()))

g <- function(x) {
   if (!exists("a", inherits = FALSE)) {
       a<-1
   }
   a<-a+x
   a
}
g(10)
g(10)

g <- function(x) {
   message("Runtime function")
   print(environment())
   if (!exists("a", inherits = FALSE)) {
       a<-1
   }
   a<-a+x
   a
}
g(10)
g(10)

h <- function() {
   x <- 5
   function() {
       x
   }
}
r1 <- h()
x <- 10
r1()

h <- function() {
   x <- 10
   x <<- 5
   function() {
       x
   }
}
r1 <- h()
r1()
x

x<-5
fun1<-function(){
   print("fun1")
   print(environment())
   x<-1
   function() {
     print("funX")
     print(environment())
     x+15
   }
}
fun2<-function(){
   print("fun2")
   print(environment())
   x<-2
   fun1()
}
f2<-fun2()
fx<-f2()
fx
