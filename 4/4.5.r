#install.packages("R6")
library(R6)
library(pryr)

Person <- R6Class("Person",
  public=list(
    hello = function(){
      print(paste("Hello"))
    }
  )
)
Person
class(Person)
u1<-Person$new()
u1
class(u1)          
otype(Person)
otype(u1)

Person <- R6Class("Person",
  public=list(
    name=NA,
    initialize = function(name){
      self$name <- name
    },
    hello = function(){
      print(paste("Hello",self$name))
    }
  )
)
conan <- Person$new('Conan')
conan$hello()   

Person <- R6Class("Person",
   public=list(
     name=NA,
     initialize = function(name,gender){
       self$name <- name
       private$gender<- gender
   },
     hello = function(){
       print(paste("Hello",self$name))
       private$myGender()
     }
   ),
   private=list(
     gender=NA,
     myGender=function(){
       print(paste(self$name,"is",private$gender))
     }
   )
)
conan <- Person$new('Conan','Male')
conan$hello()

conan$name
conan$gender
conan$myGender()

Person <- R6Class("Person",
   public=list(
     name=NA,
     initialize = function(name,gender){
       self$name <- name
     private$gender<- gender
     },
     hello = function(){
       print(paste("Hello",self$name))
       private$myGender()
     },
     member = function(){
       print(self)
       print(private)
       print(ls(envir=private))
     }
   ),
   private=list(
     gender=NA,
     myGender=function(){
       print(paste(self$name,"is",private$gender))
     }
   )
)
conan <- Person$new('Conan','Male')
conan$member()


Person <- R6Class("Person",
   public = list(
     num = 100
   ),
   active = list(
     active  = function(value) {
       if (missing(value)) return(self$num +10 )
       else self$num <- value/2
     },
     rand = function() rnorm(1)
   )
)
conan <- Person$new()
conan$num
conan$active
conan$active<-100
conan$num
conan$active
#conan$active(100)


Person <- R6Class("Person",
   public=list(
     name=NA,
     initialize = function(name,gender){
       self$name <- name
       private$gender <- gender
     },
     hello = function(){
       print(paste("Hello",self$name))
       private$myGender()
   }
   ),
   private=list(
     gender=NA,
     myGender=function(){
       print(paste(self$name,"is",private$gender))
     }
   )
)
Worker <- R6Class("Worker",
   inherit = Person,
   public=list(
     bye = function(){
       print(paste("bye",self$name))
     }
   )
 )
u1<-Person$new("Conan","Male")
u1$hello()
u2<-Worker$new("Conan","Male")
u2$hello()
u2$bye()

Worker <- R6Class("Worker",
   inherit = Person,
   public=list(
     bye = function(){
       print(paste("bye",self$name))
     }
   ),
   private=list(
     gender=NA,
     myGender=function(){
       print(paste("worker",self$name,"is",private$gender))
     }
   )
)
u2<-Worker$new("Conan","Male")
u2$hello()

Worker <- R6Class("Worker",
   inherit = Person,
   public=list(
     bye = function(){
       print(paste("bye",self$name))
     }
   ),
   private=list(
     gender=NA,
     myGender=function(){
       super$myGender()
       print(paste("worker",self$name,"is",private$gender))
     }
   )
)
u2<-Worker$new("Conan","Male")
u2$hello()


A <- R6Class("A",
  public=list(
    x = NULL
  )
)
B <- R6Class("B",
  public = list(
    a = A$new()
  )
)
b <- B$new()
b$a$x <- 1
b$a$x
b2 <- B$new()
b2$a$x <- 2
b2$a$x
b$a$x
C <- R6Class("C",
  public = list(
    a = NULL,
    initialize = function() {
      a <<- A$new()
    }
  )
)
cc <- C$new()
cc$a$x <- 1
cc$a$x
cc2 <- C$new()
cc2$a$x <- 2
cc2$a$x
cc$a$x


RC <- setRefClass("RC",
   fields = list(x = 'Hello'),
   methods = list(
     getx = function() x,
     setx = function(value) x <<- value
   )
)
rc <- RC$new()
rc$setx(10)
rc$getx()
NR6 <- R6Class("NR6",
   portable = FALSE,
   public = list(
     x = NA,
     getx = function() x,
     setx = function(value) x <<- value
   )
)
np6 <- NR6$new()
np6$setx(10)
np6$getx()
PR6 <- R6Class("PR6",
   portable = TRUE,
   public = list(
    x = NA,
    getx = function() self$x,
    setx = function(value) self$x <- value
   )
)
pr6 <- PR6$new()
pr6$setx(10)
pr6$getx()


A <- R6Class("A",
   public = list(
     x = 1,
     getx = function() x
   )
)
A$set("public", "getx2", function() self$x*2)
s <- A$new()
s
s$getx2()
A$set("public", "x", 10, overwrite = TRUE)
s <- A$new()
s$x
s$getx()
A <- R6Class("A",
  public = list(
    x = 1,
    getx = function() self$x
  )
)
A$set("public", "x", 10, overwrite = TRUE)
s <- A$new()
s$x
s$getx()

A <- R6Class("A",
  public = list(
    x = 1,
    getx = function() self$x
  )
)
a <- A$new()
print(a)
A <- R6Class("A",
    public = list(
      x = 1,
      getx = function() self$x,
      print = function(...) {
        cat("Class <Aof public ", ls(self), " :", sep="")
        cat(ls(self), sep=",")
        invisible(self)
      }
    )
)
a <- A$new()
print(a)


A <- R6Class("A",
  class=TRUE,
  public = list(
    x = 1,
    getx = function() self$x
  )
)
a <- A$new()
class(a)
a
B <- R6Class("B",
   class=FALSE,
   public = list(
     x = 1,
    getx = function() self$x
   )
)
b <- B$new()
class(b)
b
ls(envir=b)
A <- R6Class("A",
   lock=TRUE,
   public = list(
     x = 1
   )
)
s<-A$new()
ls(s)
#s$aa<-11
#rm("x",envir=s)
A <- R6Class("A",
  lock=FALSE,
  public = list(
    x = 1
  )
)
s<-A$new()
ls(s)
s$aa<-11
ls(s)
rm("x",envir=s)
ls(s)



Book <- R6Class("Book",
  private = list(
    title=NA,
    price=NA,
    category=NA
  ),
  public = list(
   initialize = function(title,price,category){
     private$title <- title
     private$price <- price
     private$category <- category
   },
   getPrice=function(){
     private$price
   }
 )
)
R <- R6Class("R",inherit = Book)
Java <- R6Class("JAVA",inherit = Book)
Php <- R6Class("PHP",inherit = Book)
r1<-R$new("R的极客理想-工具篇",59,"R")
r1$getPrice()
j1<-Java$new("Java编程思想",108,"JAVA")
j1$getPrice()
p1<-Java$new("Head First PHP & MySQL",98,"PHP")
p1$getPrice()



Book <- R6Class("Book",
   private = list(
     title=NA,
     price=NA,
     category=NA
   ),
   public = list(
     initialize = function(title,price,category){
       private$title <- title
       private$price <- price
       private$category <- category
     },
     getPrice=function(){
       p<-private$price*self$discount()
       print(paste("Price:",private$price,", Sell out:",p,sep=""))
     },
     discount=function(){
       0.9
     }
   )
)
Java <- R6Class("JAVA",
  inherit = Book,
  public = list(
    discount=function(){
      0.7
    }
  )
)
R <- R6Class("R",
  inherit = Book,
  public = list(
    discount=function(){
      super$discount()*0.7
    }
  )
)
Php <- R6Class("PHP",
  inherit = Book
)
r1<-R$new("R的极客理想-工具篇",59,"R")
r1$getPrice()
j1<-Java$new("Java编程思想",108,"JAVA")
j1$getPrice()
p1<-Php$new("Head First PHP & MySQL",98,"PHP")
p1$getPrice()


