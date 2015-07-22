library(pryr)
setClass("Person",slots=list(name="character",age="numeric"))
father<-new("Person",name="F",age=44)
father
class(father)
otype(father)

setClass("Person",slots=list(name="character",age="numeric"))
setClass("Son",slots=list(father="Person",mother="Person"),contains="Person")
father<-new("Person",name="F",age=44)
mother<-new("Person",name="M",age=39)
son<-new("Son",name="S",age=16,father=father,mother=mother)
son@name
son@age
son@father
slot(son,"mother")

otype(son)
otype(son@name)
otype(son@mother)
isS4(son)
isS4(son@name)
isS4(son@mother)

setClass("Person",slots=list(name="character",age="numeric"))
a<-new("Person",name="a")
a
setClass("Person",slots=list(name="character",age="numeric"),prototype = list(age = 20))
b<-new("Person",name="b")
b

setClass("Person",slots=list(name="character",age="numeric"))
#bad<-new("Person",name="bad",age="abc")
setValidity("Person",function(object) {
  if (object@age <= 0) stop("Age is negative.")
})
#bad2<-new("Person",name="bad",age=-1)

setClass("Person",slots=list(name="character",age="numeric"))
n1<-new("Person",name="n1",age=19);n1
n2<-initialize(n1,name="n2");n2


setClass("Person",slots=list(name="character",age="numeric"))
a<-new("Person",name="a")
a@name
slot(a, "name")
#a$name;
#a[1]
#a[[1]]

work<-function(x) cat(x, "is working")
work('Conan')
setClass("Person",slots=list(name="character",age="numeric"))     # 定义Person对象
setGeneric("work",function(object) standardGeneric("work"))
setMethod("work", signature(object = "Person"), function(object) cat(object@name , "is working") )
a<-new("Person",name="Conan",age=16)
work(a)

ftype(work)
work
showMethods(work)
getMethod("work", "Person")
selectMethod("work", "Person")
existsMethod("work", "Person")
hasMethod("work", "Person")


setClass("Shape",slots=list(name="character"))
setClass("Circle",
   contains="Shape",
   slots=list(radius="numeric"),
   prototype=list(radius = 1)
)
setValidity("Circle",function(object) {
   if (object@radius <= 0) stop("Radius is negative.")
})
c1<-new("Circle",name="c1")
c2<-new("Circle",name="c2",radius=5)
setGeneric("area",function(obj,...) standardGeneric("area"))
setMethod("area","Circle",function(obj,...){
   print("Area Circle Method")
   pi*obj@radius^2
})
area(c1)
area(c2)
setGeneric("circum",function(obj,...) standardGeneric("circum"))
setMethod("circum","Circle",function(obj,...){
   2*pi*obj@radius
})
circum(c1)
circum(c2)

setClass("Ellipse",
   contains="Shape",
   slots=list(radius="numeric"),
   prototype=list(radius=c(1,1))
)
setValidity("Ellipse",function(object) {
   if (length(object@radius) != 2 ) stop("It's not Ellipse.")
   if (length(which(object@radius<=0))>0) stop("Radius is negative.")
})
e1<-new("Ellipse",name="e1")
e2<-new("Ellipse",name="e2",radius=c(5,1))
setMethod("area", "Ellipse",function(obj,...){
   print("Area Ellipse Method")
   pi * prod(obj@radius)
})
area(e1)
area(e2)

setMethod("circum","Ellipse",function(obj,...){
   cat("Ellipse Circum :\n")
   2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
})
circum(e1)
circum(e2)


setClass("Shape",slots=list(name="character"))
setClass("Ellipse",
   contains="Shape",
   slots=list(radius="numeric"),
   prototype=list(radius=c(1,1))
)
setClass("Circle",
   contains="Ellipse",
   slots=list(radius="numeric"),
   prototype=list(radius = 1)
)
setGeneric("area",function(obj,...) standardGeneric("area"))
setMethod("area","Ellipse",function(obj,...){
   cat("Ellipse Area :\n")
   pi * prod(obj@radius)
 })
setMethod("area","Circle",function(obj,...){
   cat("Circle Area :\n")
   pi*obj@radius^2
})
setGeneric("circum",function(obj,...) standardGeneric("circum"))
setMethod("circum","Ellipse",function(obj,...){
   cat("Ellipse Circum :\n")
   2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
})
setMethod("circum","Circle",function(obj,...){
   cat("Circle Circum :\n")
   2*pi*obj@radius
})
e1<-new("Ellipse",name="e1",radius=c(2,5))
c1<-new("Circle",name="c1",radius=2)
area(e1)
circum(e1)
area(c1)
circum(c1)


setClass("Rectangle",
   contains="Shape",
   slots=list(edges="numeric"),
   prototype=list(edges=c(1,1))
)
setClass("Square",
   contains="Rectangle",
   slots=list(edges="numeric"),
   prototype=list(edges=1)
)
setMethod("area","Rectangle",function(obj,...){
   cat("Rectangle Area :\n")
   prod(obj@edges)
})
setMethod("area","Square",function(obj,...){
   cat("Square Area :\n")
   obj@edges^2
})
setMethod("circum","Rectangle",function(obj,...){
   cat("Rectangle Circum :\n")
   2*sum(obj@edges)
})
setMethod("circum","Square",function(obj,...){
   cat("Square Circum :\n")
   4*obj@edges
})
r1<-new("Rectangle",name="r1",edges=c(2,5))
s1<-new("Square",name="s1",edges=2)
area(r1)
area(s1)
circum(r1)
circum(s1)


setClass("Shape",slots=list(name="character",shape="character"))
setGeneric("getShape",function(obj,...) standardGeneric("getShape"))
setMethod("getShape","Shape",function(obj,...){
   cat(obj@shape,"\n")
})
setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1),shape="Ellipse"))
setClass("Circle",contains="Ellipse",slots=list(radius="numeric"),prototype=list(radius = 1,shape="Circle"))
setClass("Rectangle",contains="Shape",slots=list(edges="numeric"),prototype=list(edges=c(1,1),shape="Rectangle"))
setClass("Square",contains="Rectangle",slots=list(edges="numeric"),prototype=list(edges=1,shape="Square"))
s1<-new("Square",name="s1",edges=2, shape="Square")
getShape(s1)




setClass("Shape",slots=list(name="character",shape="character"))
setClass("Ellipse",contains="Shape",slots=list(radius="numeric"),prototype=list(radius=c(1,1),shape="Ellipse"))
setClass("Circle",contains="Ellipse",slots=list(radius="numeric"),prototype=list(radius = 1,shape="Circle"))
setClass("Rectangle",contains="Shape",slots=list(edges="numeric"),prototype=list(edges=c(1,1),shape="Rectangle"))
setClass("Square",contains="Rectangle",slots=list(edges="numeric"),prototype=list(edges=1,shape="Square"))

setGeneric("getShape",function(obj,...) standardGeneric("getShape"))
setMethod("getShape","Shape",function(obj,...){
  cat(obj@shape,"\n")
})

setGeneric("area",function(obj,...) standardGeneric("area"))
setMethod("area","Ellipse",function(obj,...){
  cat("Ellipse Area :\n")
  pi * prod(obj@radius)
})
setMethod("area","Circle",function(obj,...){
  cat("Circle Area :\n")
  pi*obj@radius^2
})
setMethod("area","Rectangle",function(obj,...){
  cat("Rectangle Area :\n")
  prod(obj@edges)
})
setMethod("area","Square",function(obj,...){
  cat("Square Area :\n")
  obj@edges^2
})

setGeneric("circum",function(obj,...) standardGeneric("circum"))
setMethod("circum","Ellipse",function(obj,...){
  cat("Ellipse Circum :\n")
  2*pi*sqrt((obj@radius[1]^2+obj@radius[2]^2)/2)
})
setMethod("circum","Circle",function(obj,...){
  cat("Circle Circum :\n")
  2*pi*obj@radius
})
setMethod("circum","Rectangle",function(obj,...){
  cat("Rectangle Circum :\n")
  2*sum(obj@edges)
})
setMethod("circum","Square",function(obj,...){
  cat("Square Circum :\n")
  4*obj@edges
})

e1<-new("Ellipse",name="e1",radius=c(2,5))
c1<-new("Circle",name="c1",radius=2)

r1<-new("Rectangle",name="r1",edges=c(2,5))
s1<-new("Square",name="s1",edges=2)

area(e1)
area(c1)
circum(e1)
circum(c1)

area(r1)
area(s1)
circum(r1)
circum(s1)



