# install.packages(pryr)  
# library(devtools)
# install_github("pryr")
library(pryr)

f(x + y)
f(x + y)(1, 10)
f(x, y = 2, x + y)
f(x, y = 2, x + y)(1)
f({y <- runif(1); x + y})(3)

f <- function(x) x + 3
f
f(12)
g <- make_function(alist(x = ), quote(x + 3))
g
g(12)

compact1 <- function(x) Filter(Negate(is.null), x)
compact1
compact2 <- partial(Filter, Negate(is.null))
compact2
f1 <- function(){runif(rpois(1, 5))}
f1()
f1()
f2 <- partial(runif, n = rpois(1, 5))
f2()
f2()

x <- quote(a + b)
class(x)
substitute(x, list(a = 1, b = 2)) 
substitute(a+b, list(a = 1, b = 2))
substitute_q(x, list(a = 1, b = 2))
eval(substitute_q(x, list(a = 1, b = 2)))

a <- 1
b <- 2
substitute(a + b)
subs(a + b)

otype(1:10)
otype(c('a','d'))
otype(list(c('a'),data.frame()))
otype(data.frame())
x <- 1
attr(x,'class')<-'foo'
is.object(x)
otype(x)
setClass("Person",slots=list(name="character",age="numeric"))
alice<-new("Person",name="Alice",age=40)
isS4(alice)
otype(alice)
Account<-setRefClass("Account")
a<-Account$new()
class(a)
is.object(a)
isS4(a)
otype(a)

ftype(`%in%`)
ftype(sum)
ftype(writeLines)
ftype(unlist)
ftype(t.data.frame)
ftype(t.test)
setGeneric("union")
setMethod("union",c(x="data.frame",y="data.frame"),function(x, y){unique(rbind (x, y))})
ftype(union)
Account<-setRefClass("Account",
  fields=list(balance="numeric"),
  methods=list(
  withdraw=function(x){balance<<-balance-x},
  deposit=function(x){balance<<-balance+x})
)
a<-Account$new(balance=100)
a$deposit(100)
ftype(a$deposit)

x <- 1:10
typename(x)
refs(x)
address(x)
z <- list(1:10)
typename(z)
delayedAssign("a", 1 + 2)
typename(a)
a
typename(a)
b<-3
typename(b)

a<-1:3;a
address(a)
track_a <- track_copy(a)
track_a()
a[3] <- 3L
address(a)
track_a()
a[3]<-3
address(a)
track_a()

power <- function(exp) {
    function(x) x ^ exp
}
square <- power(2)
cube <- power(3)
square
unenclose(square)
square(3)

examples <- list(
    quote(a <- 5),
    alist(a = 1, c = a),
    function(a = 1) a * 10,
    expression(a <- 1, a, f(a), f(a = a))
)
examples
a_to_b <- function(x) {
    if (is.name(x) && identical(x, quote(a))) return(quote(b))
    x
}
modify_lang(examples, a_to_b)

y <- 2
dots(x = 1, y, z = )
class(dots(x = 1, y, z = ))
str(dots(x = 1, y, z = ))
named_dots(x = 1, y, z =)
class(named_dots(x = 1, y, z =))
str(named_dots(x = 1, y, z =))

find_funs("package:base", fun_calls, "match.fun", fixed = TRUE)
Map
find_funs("package:stats", fun_args, "^FUN$")
ave

x <- 1
where("x")
where("t.test")
t.test
where("mean")
where("where")

ls() 
rls() 

adder <- function(x) function(y) function(z) x + y + z
add2 <- adder(2)
add2
add3<-add2(3)
add3
parenv(add3)
parenv(add2)

call_tree(quote(f(x, 1, g(), h(i()))))
call_tree(quote(if (TRUE) 3 else 4))
call_tree(expression(1, 2, 3))    

ast(f(x, 1, g(), h(i())))          
ast(if (TRUE) 3 else 4)     
ast(function(a = 1, b = 2) {a + b})
ast(f()()())           

x <- 10
is_promise(x)
(function(x) is_promise(x))(x = 10)

f <- function(x) {
   uneval(x)
}
f(a + b)
class(f(a+b))
f(1 + 4)
delayedAssign("x", 1 + 4)
uneval(x)
x
delayedAssign("x", {
   for(i in 1:3)
       cat("yippee!\n")
   10
})
x

x %<a-% runif(1)
x
x
y %<c-% 4 + 2
y
z %<d-% (a + b)
a <- 10
b <- 100
z
a <- 1
rebind("a", 2)
#rebind("ccc", 2)
a<<-2
a
#rm(ccc)
#ccc
ccc<<-2
ccc

