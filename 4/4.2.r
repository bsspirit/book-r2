library(pryr)

x<-1
attr(x,'class')<-'foo'
x
class(x)
otype(x)

y <- structure(2, class = "foo")
y
class(y)
otype(y)

x<-1
attr(x,'class')<- c("foo", "bar")
class(x)
otype(x)

teacher <- function(x, ...) UseMethod("teacher")
ftype(teacher)
teacher.lecture <- function(x) print("讲课")
teacher.assignment <- function(x) print("布置作业")
teacher.correcting <- function(x) print("批改作业")
teacher.default<-function(x) print("你不是teacher")

a<-'teacher'
attr(a,'class') <- 'lecture'
teacher(a)
teacher.lecture()
teacher.lecture(a)
teacher()

teacher
methods(teacher)
methods(generic.function=predict)
methods(class=lm)
getAnywhere(teacher.lecture)
#predict.ppr
getAnywhere("predict.ppr")
getS3method("predict", "ppr")

node <- function(x) UseMethod("node", x)
node.default <- function(x) "Default node"
node.father <- function(x) c("father")
node.son <- function(x) c("son", NextMethod())
n1 <- structure(1, class = c("father"))
node(n1)
n2 <- structure(1, class = c("son", "father"))
node(n2)

mean
ftype(mean)
ftype(t)
ftype(plot)

a <- 1
class(a)
f1 <- function(x) {
 a <- 2
 UseMethod("f1")
}
f1.numeric <- function(x) a
f1(a)
f1(99)
f1.character <- function(x) paste("char", x)
f1("a")
