dx <- deriv(y ~ x^3, "x") ; dx 
mode(dx)
x<-1:2
eval(dx)

dx <- deriv(y ~ sin(x), "x", func= TRUE);dx
mode(dx)
dx(c(pi,4*pi))

dx<-deriv(y~ 3+10*x,"x",func = TRUE)
dx(1)

dx<-deriv(y~x^4,"x",func = TRUE)
dx(2)

dx<-deriv(y~4^x ,"x",func = TRUE)
dx(2)

dx<-deriv(y~exp(1)^x ,"x",func = TRUE)
dx(2)

dx<-deriv(y~log(x),"x",func = TRUE)
dx(2)

dx<-deriv(y~log(x)/log(2),"x",func = TRUE)
dx(3)

dx<-deriv(y~sin(x),"x",func = TRUE)
dx(pi)

dx<-deriv(y~cos(x),"x",func = TRUE)
dx(pi/2)

dx<-deriv(y~tan(x),"x",func = TRUE)
dx(pi/6)

dx<-deriv(y~1/tan(x),"x",func = TRUE)
dx(pi/6)

dx<-deriv(y~asin(x),"x",func = TRUE)
dx(pi/6)

dx<-deriv(y~acos(x),"x",func = TRUE)
dx(pi/8)

dx<-deriv(y~atan(x),"x",func = TRUE)
dx(pi/6)

a<-2
dx<-deriv(y~sin(a*x),"x",func = TRUE)
dx(pi/3)
dx<-deriv(y~a*cos(a*x),"x",func = TRUE)
dx(pi/3)

dx<-deriv3(y~sin(a*x),"x",func = TRUE)
dx(pi/3)

dx<-deriv3(y~a*x^4+b*x^3+x^2+x+c,"x",func=function(x,a=2,b=1,c=3){})
dx(2)

fxy = expression(2*x^2+y+3*x*y^2)
dxy = deriv(fxy, c("x", "y"), func = TRUE)
dxy
dxy(1,1)

fxy = expression(x^y + exp(x * y) + x^2 - 2 * x * y + y^3 + sin(x*y))
dxy = deriv(fxy, c("x", "y"), func = TRUE)
dxy(1,3)
dxy(0,0)






















